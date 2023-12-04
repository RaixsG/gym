import { PrismaClient } from '@prisma/client';
import { Router } from 'express';
import dayjs from 'dayjs';

const router = Router();
const prisma = new PrismaClient();

// Todos los horarios
router.get('/horarios', async (_, res) => {
    const allHorarios = await prisma.horarios.findMany();
    res.json(allHorarios);
});

// Crear un horario
router.post('/horarios/create', async (req, res) => {
    const { hora_inicio, hora_finalizacion, turno } = req.body;
    if (!hora_inicio || !hora_finalizacion || !turno) {
        return res.status(400).json({ error: 'Falta uno o más campos requeridos' });
    };

    const time_inicio = new Date(`1970-01-01T${hora_inicio}:00.000Z`);
    const time_fin = new Date(`1970-01-01T${hora_finalizacion}:00.000Z`);

    const horario = await prisma.horarios.create({
        data: {
            hora_inicio: time_inicio,
            hora_finalizacion: time_fin,
            turno,
        },
    });
    res.status(200).json({
        id: horario.ID_horario,
        horario_inicio: horario.hora_inicio,
        horario_fin: horario.hora_finalizacion,
        turno: horario.turno,
    });
});

export default router;