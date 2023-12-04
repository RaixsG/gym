import dayjs from 'dayjs';
import { PrismaClient } from '@prisma/client';
import { Router } from 'express';

const router = Router();
const prisma = new PrismaClient();

// Todas las inscripciones
router.get('/inscripciones', async (_, res) => {
    const allInscripciones = await prisma.inscripciones.findMany();
    res.json(allInscripciones);
});

// Crear una inscripcion
router.post('/inscripciones/create', async (req, res) => {
    const { ID_cliente, ID_enseña_en, fecha_inscripcion, ID_membresia } = req.body;

    // Verificar que todos los campos esten completos
    if (!ID_cliente || !ID_enseña_en || !fecha_inscripcion || !ID_membresia) {
        return res.status(400).json({ error: 'Falta uno o más campos requeridos' });
    }

    // Verificar que el cliente existe
    const cliente = await prisma.clientes.findUnique({ where: { ID_cliente: ID_cliente } });
    if (!cliente) return res.status(400).json({ error: 'El cliente no existe' });

    // Verificamos que el cliente no este inscrito
    const clienteInscrito = await prisma.inscripciones.findFirst({ where: { ID_cliente: ID_cliente } });
    // Verificamos que el cliente no sea miembro
    const clienteMiembro = await prisma.miembros.findFirst({ where: { ID_cliente: ID_cliente } });

    // Si el cliente ya esta inscrito o es miembro, no se puede crear la inscripción
    if (clienteInscrito || clienteMiembro) return res.status(400).json({ error: 'El cliente ya esta inscrito' });

    // Formateamos la fecha
    const fecha_actual = dayjs(fecha_inscripcion).toISOString();

    // Verificar que el horario existe
    const enseña_en = await prisma.ense_a_en.findUnique({ where: { ID_ense_a_en: ID_enseña_en } });
    // Verificar que la membresia exista
    const membresia = await prisma.membresias.findUnique({ where: { ID_membresia: ID_membresia } });

    if (enseña_en, membresia) {
        // Creamos la inscripción
        const inscripcion = await prisma.inscripciones.create({
            data: {
                fecha_inscripcion: fecha_actual,
                clientes: {
                    connect: {
                        ID_cliente,
                    },
                },
                ense_a_en: {
                    connect: {
                        ID_ense_a_en: ID_enseña_en,
                    },
                }
            },
        });

        // Con la inscripción creada, creamos el miembro
        const membresia = await prisma.miembros.create({
            data: {
                estado_inscripcion: true,
                fecha_vencimiento: dayjs().toISOString(),
                membresias: {
                    connect: {
                        ID_membresia,
                    },
                },
                clientes: {
                    connect: {
                        ID_cliente,
                    },
                },
            },
        });


        res.status(201).json({
            inscription: inscripcion,
            member: membresia,
        });
    } else {
        if (!cliente) return res.status(400).json({ error: 'El cliente no existe' });
        if (!enseña_en) return res.status(400).json({ error: 'El horario no existe' });
        if (!membresia) return res.status(400).json({ error: 'La membresia no existe' });
    }
});


// Traer todos los cliente que esten inscritos y sean miembros ✅
router.get('/inscripciones/miembros', async (_, res) => {
    const clientesInscritos = await prisma.clientes.findMany({
        where: {
            inscripciones: { some: {} },
            miembros: { some: {} },
        },
        include: {
            miembros: {
                include: {
                    pago_membresias: true,
                },
            },
            inscripciones: true,
        },
    });

    const clientesDatosTotales = clientesInscritos.map(cliente => {
        const fechaInscripcion = dayjs(cliente.inscripciones.fecha_inscripcion);
        const fechaVencimiento = fechaInscripcion.add(30, 'day').toISOString();
        return {
            ...cliente,
            inscripciones: {
                ...cliente.inscripciones,
                day: dayjs(),
                fecha_vencimiento: fechaVencimiento,
            },
        };
    });

    res.status(200).json(clientesDatosTotales);
});

export default router;