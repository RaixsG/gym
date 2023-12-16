import { PrismaClient } from "@prisma/client";
import { Router } from "express";
import dayjs from "dayjs";

const router = Router();
const prisma = new PrismaClient();

router.get('/instructores', async (_, res) => {
    const allInstructores = await prisma.instructores.findMany();
    res.json(allInstructores);
});

// Crear un instructor ✅
router.post('/instructores/create', async (req, res) => {
    const { nombre, apellido, direccion, telefono, email, fecha_nacimiento, especializacion, foto_instructor } = req.body;
    if (!nombre || !apellido || !direccion || !telefono || !email || !fecha_nacimiento || !especializacion) {
        return res.status(400).json({ error: 'Falta uno o más campos requeridos' });
    };
    const instructor = await prisma.instructores.create({
        data: {
            nombre,
            apellido,
            direccion,
            telefono,
            email,
            fecha_nacimiento: new Date(fecha_nacimiento).toISOString(),
            especializacion,
            foto_instructor,
        },
    });
    res.json(instructor);
});

// Editar un instructor
router.put('/instructor/edit/:id', async (req, res) => {
    const { id } = req.params;
    const { nombre, apellido, direccion, telefono, email, fecha_nacimiento, especializacion, foto_instructor } = req.body;
    if (!id) {
        return res.status(400).json({error: 'Falta el ID del instructor' });
    }

    // Crear un objeto con los datos a actualizar
    let data = {};
    if (nombre) data.nombre = nombre;
    if (apellido) data.apellido = apellido;
    if (direccion) data.direccion = direccion;
    if (telefono) data.telefono = telefono;
    if (email) data.email = email;
    if (fecha_nacimiento) data.fecha_nacimiento = fecha_nacimiento;
    if (especializacion) data.especializacion = especializacion;
    if (foto_instructor) data.foto_instructor = foto_instructor;

    const instructoActualizado = await prisma.instructores.update({
        where: {
            ID_instructor: parseInt(id)
        },
        data,
    });

    if (instructoActualizado) {
        res.json(instructoActualizado);
    } else {
        res.status(404).json({ error: 'Instructor no encontrado' });
    }

});

router.delete('/instructor/delete/:id', async (req, res) => {
    const { id } = req.params;
    if (!id) {
        return res.status(400).json({ error: 'Falta el ID del Instructor' });
    }

    const instructorEliminado = await prisma.instructores.delete({
        where: {
            ID_instructor: parseInt(id),
        },
    });

    if (instructorEliminado) {
        res.status(200).json(instructorEliminado);
    } else {
        res.status(404).json({ error: 'Instructor no encontrado' });
    }

})

export default router;