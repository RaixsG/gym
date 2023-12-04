import { PrismaClient } from '@prisma/client';
import { Router } from 'express';

const router = Router();
const prisma = new PrismaClient();

// Todos los Horarios disponibles con Instructores
router.get('/ense_a_en', async (_, res) => {
    const allHorarioInstructores = await prisma.ense_a_en.findMany({
        include: {
            instructores: true,
            horarios: true,
        }
    });
    res.json(allHorarioInstructores.map(item => {
        return {
            id: item.ID_ense_a_en,
            turno: item.horarios.turno,
            nombre: item.instructores.nombre,
            idInstructor: item.instructores.ID_instructor
        }}
    ));
});

// Crear un horario para un instructor
router.post('/ense_a_en/create', async (req, res) => {
    const { ID_instructor, ID_horario } = req.body;

    // Verificar que el instructor existe
    const instructor = await prisma.instructores.findUnique({ where: { ID_instructor: ID_instructor } });
    if (!instructor) {
        return res.status(400).json({ error: 'El instructor no existe' });
    }

    // Verificar que el horario existe
    const horario = await prisma.horarios.findUnique({ where: { ID_horario: ID_horario } });
    if (!horario) {
        return res.status(400).json({ error: 'El horario no existe' });
    }

    // Crear el horario para el instructor
    const horarioInstructor = await prisma.ense_a_en.create({
        data: {
            instructores: {
                connect: {
                    ID_instructor,
                },
            },
            horarios: {
                connect: {
                    ID_horario,
                },
            }
        },
    });
    res.status(201).json(horarioInstructor);
});

// EDITAR horario de un instructor
router.put('/ense_a_en/edit/:id', async (req, res) => {
    const { id } = req.params;
    // Verificar que el ID existe
    if (!id) {
        return res.status(404).json({ error: 'Falta el ID' });
    }
    
    // Verificar que el ID del instructor y del horario existen
    const { ID_instructor, ID_horario } = req.body;
    if (!ID_instructor || !ID_horario) {
        return res.status(400).json({ error: 'Falta uno o más campos requeridos' });
    }

    // Verificar que el instructor existe
    const instructor = await prisma.instructores.findUnique({
        where: {
            ID_instructor: Number(ID_instructor),
        },
    });
    if (!instructor) {
        return res.status(400).json({ error: 'El instructor no existe' });
    }

    // Verificar que el horario existe
    const horario = await prisma.horarios.findUnique({
        where: {
            ID_horario: Number(ID_horario),
        },
    });
    if (!horario) {
        return res.status(400).json({ error: 'El horario no existe' });
    }

    // Crear un objeto con los datos a actualizar
    let data = {};
    if (ID_instructor) data.ID_instructor = ID_instructor;
    if (ID_horario) data.ID_horario = ID_horario;

    // Editar el horario del instructor
    const horarioInstructor = await prisma.ense_a_en.update({
        where: { ID_ense_a_en: Number(id) },
        data: {
            instructores: {
                connect: {
                    ID_instructor: Number(ID_instructor),
                },
            },
            horarios: {
                connect: {
                    ID_horario: Number(ID_horario),
                },
            }
        },
    });
    res.status(201).json(horarioInstructor);
});

export default router;