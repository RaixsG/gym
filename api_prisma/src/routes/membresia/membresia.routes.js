import { PrismaClient } from '@prisma/client';
import { Router } from 'express';

const router = Router();
const prisma = new PrismaClient();

router.get('/membresia', async(_, res) => {
    const allMembresia = await prisma.membresias.findMany();
    res.json(allMembresia);
});

// Crear un membresia ✅
router.post('/membresia/create', async (req, res) => {
    const { nombre_membresia, precio, beneficios } = req.body;
    if ( !nombre_membresia || !precio || !beneficios ) {
        return res.status(400).json({ error: 'Falta uno o más campos requeridos' });
    };
    const membresia = await prisma.membresias.create({
        data: {
            nombre_membresia,
            precio,
            beneficios,
        },
    });
    res.json(membresia);
});

// Actualizar membresia
router.put('/membresia/edit/:id', async (req, res) => {
    const { id } = req.params;
    if (!id) {
        return res.status(404).json({ error: 'Falta el ID de la membresia' });
    }
    const { nombre_membresia, precio, beneficios } = req.body;
    const membresia = await prisma.membresias.update({
        where: { ID_membresia: Number(id) },
        data: {
            nombre_membresia,
            precio,
            beneficios,
        },
    });
    res.json(membresia);
});

// Eliminar membresia
router.delete('/membresia/delete/:id', async (req, res) => {
    const { id } = req.params;
    if (!id) {
        return res.status(404).json({ error: 'Falta el ID de la membresia' });
    }

    const membresiaEliminada = await prisma.membresias.delete({
        where: {
            ID_membresia: parseInt(id),
        },
    });
    if (membresiaEliminada) {
        res.status(200).json(membresiaEliminada);
    } else {
        res.status(404).json({ error: 'Instructor no encontrado' });
    }
})

export default router;