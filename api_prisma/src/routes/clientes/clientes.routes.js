import dayjs from 'dayjs';
import { PrismaClient } from '@prisma/client';
import { Router } from 'express';

const router = Router();
const prisma = new PrismaClient();

// Traer todos los clientes ✅
router.get('/clientes', async (_, res) => {
    const allClientes = await prisma.clientes.findMany();
    res.json(allClientes);
});

//  Clientes ultimos mes actualmente ✅ (Con datos filtrados a mostrar)
router.get('/inscripciones/ultimosmes', async (_, res) => {
    const primer_dia_mes = dayjs().startOf('month').format('YYYY-MM-DD');
    const inscripcionesUltimoMes = await prisma.inscripciones.findMany({
        where: {
            fecha_inscripcion: new Date(primer_dia_mes).toISOString(),
        },
        select: {
            ID_cliente: true,
            clientes: {
                select: {
                    ID_cliente: true,
                    nombre: true,
                    telefono: true,
                }
            },
        }
    });
    res.json(inscripcionesUltimoMes);
});

// Crear un cliente ✅
router.post('/clientes/create', async (req, res) => {
    const { nombre, apellido, direccion, telefono, email, fecha_nacimiento } = req.body;
    if (!nombre || !apellido || !direccion || !telefono || !email || !fecha_nacimiento) {
        return res.status(400).json({ error: 'Falta uno o más campos requeridos' });
    };
    const cliente = await prisma.clientes.create({
        data: {
            nombre,
            apellido,
            direccion,
            telefono,
            email,
            fecha_nacimiento: new Date(fecha_nacimiento).toISOString(),
        },
    });
    res.json(cliente);
});

// Traer un cliente por ID ✅
router.get('/clientes/:id', async (req, res) => {
    const { id } = req.params;

    if (!id) {
        return res.status(400).json({ error: 'Falta el ID del cliente' });
    }

    const cliente = await prisma.clientes.findUnique({
        where: {
            ID_cliente: parseInt(id)
        }
    });
    if (cliente) {
        res.json(cliente);
    } else {
        res.status(404).json({ error: 'Cliente no encontrado' });
    }

});

// Editar datos de cliente ✅
router.put('/clientes/edit/:id', async (req, res) => {
    const { id } = req.params;
    const { nombre, apellido, direccion, telefono, email, fecha_nacimiento } = req.body;
    if (!id) {
        return res.status(400).json({ error: 'Falta el ID del cliente' });
    }
    // Crear un objeto con los datos a actualizar
    let data = {};
    if (nombre) data.nombre = nombre;
    if (apellido) data.apellido = apellido;
    if (direccion) data.direccion = direccion;
    if (telefono) data.telefono = telefono;
    if (email) data.email = email;
    if (fecha_nacimiento) data.fecha_nacimiento = fecha_nacimiento;

    const clienteActualizado = await prisma.clientes.update({
        where: { ID_cliente: Number(id) },
        data,
    });

    if (clienteActualizado) {
        res.json(clienteActualizado);
    } else {
        res.status(404).json({ error: 'Cliente no encontrado' });
    }
});

// Eliminar un cliente ✅
router.delete('/clientes/delete/:id', async (req, res) => {
    const { id } = req.params;
    if (!id) {
        return res.status(400).json({ error: 'Falta el ID del cliente' });
    }
    const inscripcionEliminada = await prisma.inscripciones.deleteMany({
        where: {
            ID_cliente: parseInt(id),
        },
    });
    const clienteEliminado = await prisma.clientes.delete({
        where: { 
            ID_cliente: parseInt(id),
        },
    });
    if (clienteEliminado && inscripcionEliminada) {
        res.status(200).json(clienteEliminado);
        res.status(200).json(inscripcionEliminada);
    } else {
        res.status(404).json({ error: 'Cliente no encontrado' });
    }
});

export default router;