import { PrismaClient } from '@prisma/client';
import { Router } from 'express';

const router = Router();
const prisma = new PrismaClient();

// traer todos los productos
router.get('/productos', async(_, res) => {
    const allProductos = await prisma.productos.findMany();
    res.status(200).json(allProductos);
})

// traer producto por ID
router.get('/productos/:id', async(req, res) => {
    const { id } = req.params;
    console.log(typeof id)
    if (typeof id === 'string') {
        const product = await prisma.productos.findUnique({
            where: { ID_producto: parseInt(id) },
        });
        if (product) res.status(200).json(product);
        else res.status(404).json({ error: `No se ha encontrado el producto con el id ${id}` });
    } else {
        res.status(400).json({ error: 'Tiene que enviar un ID válido' });
    };
})

// crear nuevo producto
router.post('/productos/create', async (req, res) => {
    const { nombre_producto, descripcion, precio, cantidad_stock } = req.body;
    if (nombre_producto || descripcion || precio || cantidad_stock) {
        const producto ={
            nombre_producto,
            descripcion,
            precio: parseFloat(precio),
            cantidad_stock: parseInt(cantidad_stock),
        }
        await prisma.productos.create({ data: producto});
        res.status(201).json(producto);
    } else {
        res.status(400).json({ error: 'Falta uno o más campos requeridos' });
    };
})

// editar un producto
router.put('/productos/edit/:id', async (req, res) => {
    const { id } = req.params;
    if (!id) {
        return res.status(404).json({ error: 'Falta el ID del producto' });
    }
    const { nombre_producto, descripcion, precio, cantidad_stock } = req.body;

    let data = {};
    // Crear un objeto con los datos actualizar
    if (nombre_producto) data.nombre_producto = nombre_producto;
    if (descripcion) data.descripcion = descripcion;
    if (precio) data.precio = precio;
    if (cantidad_stock) data.cantidad_stock = cantidad_stock;

    const producto_actualizado = await prisma.productos.update({
        where: { ID_producto: Number(id) },
        data,
    });

    if (producto_actualizado) {
        res.json(producto_actualizado);
    } else {
        res.status(404).json({ error: 'Producto no encontrado' });
    }

});

// Eliminar un producto
router.delete('/productos/delete/:id', async (req, res) => {
    const { id } = req.params;
    if (!id) {
        return res.status(400).json({ error: 'Falta el ID del producto' });
    }

    const productoEliminado = await prisma.productos.delete({
        where: {
            ID_producto: parseInt(id),
        },
    });

    if (productoEliminado) {
        res.json(productoEliminado);
    } else {
        res.status(404).json({ error: 'Producto no encontrado' });
    }
});

export default router;