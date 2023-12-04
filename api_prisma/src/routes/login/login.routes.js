import { PrismaClient } from '@prisma/client';
import { Router } from 'express';

const router = Router();
const prisma = new PrismaClient();

// Funcion para buscar al usuario
const buscarUsuario = async (usuario) => {
    try {
        const login = await prisma.users.findUnique({
            where: {
                username: usuario,
            },
        });
        return login;
    } catch (error) {
        console.error(error);
        throw error;
    }
};

// comparar contraseña
const compararPassword = (userData, password) => {
    const match = userData.password === password;
    console.log(match);
    return match;
};

router.post('/login', async (req, res) => {
    const { usuario, password } = req.body;
    if (!usuario || !password) {
        return res.status(400).json({ error: 'Falta uno o más campos requeridos' });
    };
    
    try {
        const login = await buscarUsuario(usuario);
        if (!login) {
            return res.status(404).json({ error: 'Usuario no encontrado' });
        };
        const match = compararPassword(login, password);
        if (match) {
            res.status(202).json({
                code: 1,
                message: 'Éxito',
                user: login,
            })
        } else {
            res.status(401).json({
                code: 2,
                message: 'Contraseña incorrecta',
            });
        }
    } catch (error) {
        res.status(500).json({ error: 'Error del servidor' });
    }
});

export default router;
