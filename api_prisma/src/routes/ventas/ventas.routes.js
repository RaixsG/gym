import dayjs from 'dayjs';
import { PrismaClient } from '@prisma/client';
import { Router } from 'express';


const router = Router();
const prisma = new PrismaClient();

// Traer todos las ventas
router.get('/ventas', async (_, res) => {
    const allVentas = await prisma.venta.findMany();
    res.json(allVentas);
});

// Ultimas 10 ventas
router.get('/ventas/ultimas10', async (_, res) => {
    const ultimas10Ventas = await prisma.venta.findMany({
        take: 10,
        orderBy: {
            ID_venta: 'desc',
        },
        include: {
            detalles_venta: {
                select: {
                    cantidad: true,
                    productos: {
                        select: {
                            nombre_producto: true,
                            precio: true,
                        },
                    },
                },
            },
        },
    });
    res.json(ultimas10Ventas);
});

// Ultimas ventas dinamicas
router.get('/ventas/dinamic/', async (_, res) => {
    const ultimas10Ventas = await prisma.venta.findMany({
        take: 20,
        orderBy: {
            ID_venta: 'desc',
        },
        include: {
            detalles_venta: {
                select: {
                    cantidad: true,
                    productos: {
                        select: {
                            nombre_producto: true,
                            precio: true,
                        },
                    },
                },
            },
        },
    });
    res.json({
        recibe: ultimas10Ventas.map((item) => {
            let nombre_producto = item.detalles_venta.map((item) => item.productos.nombre_producto);
            let precio = item.detalles_venta.map((item) => item.productos.precio);
            let cantidad = item.detalles_venta.map((item) => item.cantidad);
            let precio_total = item.detalles_venta.map((item) => item.productos.precio * item.cantidad);
            return {
                id_venta: item.ID_venta,
                nombre_producto: nombre_producto[0],
                precio: precio[0],
                cantidad: cantidad[0],
                precio_total: precio_total[0],
                fecha_pago: dayjs(item.fecha_pago).format('DD/MM/YYYY'),
                metodo_pago: item.metodo_pago,
                id_cliente: item.ID_cliente,
            }
        })
    });
});

router.get('/ventas/productosMasVendidos', async (_, res) => {
    const detallesVentas = await prisma.detalles_venta.findMany({
        include: {
            productos: true
        }
    });

    const productosMasVendidos = detallesVentas.reduce((acc, detalle) => {
        const producto = detalle.productos.nombre_producto;
        const cantidad = detalle.cantidad;

        if (!acc[producto]) {
            acc[producto] = cantidad;
        } else {
            acc[producto] += cantidad;
        }

        return acc;
    }, {});

    const productosArray = Object.entries(productosMasVendidos).map(([nombre_producto, cantidad]) => ({ nombre_producto, cantidad }));

    res.json(productosArray);
});

// Ruta buscar producto por ID
router.get('/productofind/:id', async (req, res) => {
    const { id } = req.params;
    const producto = await prisma.productos.findUnique({ where: { ID_producto: parseInt(id) } })
    if (producto) {
        res.status(201).json({
            producto,
        })
    } else {
        res.status(201).json({
            error: 'No se encontró el producto',
        })
    }
});

// Ruta crear venta
router.post('/ventas/create', async (req, res) => {
    const { metodo_pago, ID_cliente, productos } = req.body;
    const metodos_pago = ["efectivo", "tarjeta"];
    const metodo_existente = metodos_pago.includes(metodo_pago);
    if (metodo_pago && ID_cliente && productos && typeof productos === 'object' && productos.length) {
        const datos_productos = await Promise.all(productos.map(async producto =>
            await prisma.productos.findUnique({ where: { ID_producto: producto.id } })
        ));
        const cliente = await prisma.clientes.findUnique({ where: { ID_cliente: ID_cliente } });
        if (datos_productos.length && cliente && metodo_existente) {
            // GUARDAMOS LOS DATOS DE LA VENTA
            const newVenta = await prisma.venta.create({
                data: {
                    fecha_pago: dayjs(),
                    metodo_pago,
                    clientes: {
                        connect: {
                            ID_cliente,
                        },
                    },
                },
            });
            // GENERAMOS LOS DETALLES DE LA VENTA
            const obtener_cantidad = (id_producto) => {
                return productos.find(producto => id_producto === producto.id).quantity;
            };
            await prisma.detalles_venta.createMany({
                data: datos_productos.map(datos_producto => ({
                    ID_producto: datos_producto.ID_producto,
                    cantidad: obtener_cantidad(datos_producto.ID_producto),
                    ID_venta: newVenta.ID_venta,
                }))
            })
            const precio_total = () => {
                let precio_total = 0;
                datos_productos.forEach(producto => precio_total = precio_total + producto.precio * obtener_cantidad(producto.ID_producto));
                return precio_total;
            };
            let total_vendidos = productos.map(producto => producto.quantity).reduce((acc, quant) => acc + quant, 0);
            productos.forEach(async producto => {
                const producto_encontrado = await prisma.productos.findUnique({
                    where: {
                        ID_producto: producto.id,
                    }
                });
                await prisma.productos.update({
                    where: {
                        ID_producto: producto_encontrado.ID_producto,
                    },
                    data: {
                        cantidad_stock: producto_encontrado.cantidad_stock - producto.quantity,
                    },
                })
            });
            res.status(201).json({
                sale: newVenta,
                recipe: {
                    productos: datos_productos.map((producto, index) => ({
                        index: index + 1,
                        name: producto.nombre_producto,
                        price: producto.precio,
                    })),
                    productos_vendidos: total_vendidos,
                    precio_total: precio_total(),
                },
            });
        } else {
            if (!datos_productos.length) res.status(404).json({ error: 'No se encontraron los productos correspondientes a los ID' })
            if (!metodo_existente) res.status(400).json({ error: 'Ingrese un método de pago correcto' })
            if (!cliente) res.status(404).json({ error: 'El cliente no existe' })
        }
    } else res.status(400).json({ error: 'Faltan dátos para generar la venta' });
});

// REALIZAR PAGO DE MEMBRESIA
router.post('/pago_membresias', async (req, res) => {
    const { cantidad, metodo_pago, ID_miembro } = req.body;
    // Verificar que todos los campos esten completos
    if (!cantidad || !metodo_pago || !ID_miembro) (
        res.status(400).json({ error: 'Falta uno o más campos requeridos' })
    );
    // Verificar que el metodo de pago sea valido
    const metodos_pago = ["efectivo", "tarjeta"];
    const metodo_existente = metodos_pago.includes(metodo_pago);
    if (!metodo_existente) (
        res.status(400).json({ error: 'Ingrese un método de pago correcto' })
    );
    // Verificar que el miembro existe
    const miembro = await prisma.miembros.findUnique({ where: { ID_miembro, } });
    if (!miembro) (
        res.status(404).json({ error: 'Miembro no encontrado' })
    );
    // Verificar el estado de inscripción del miembro
    if (miembro.estado_inscripcion === false) (
        res.status(400).json({ error: 'El miembro no está activo' })
    );
    // Crear el pago_membresias
    const nuevoPago = await prisma.pago_membresias.create({
        data: {
            fecha_pago: dayjs(),
            cantidad: parseInt(cantidad),
            metodo_pago,
            ID_miembro,
        },
    });
    const membresia_data = await prisma.membresias.findUnique({ where: { ID_membresia: miembro.ID_membresia } })
    const vencimiento_actualizado = await prisma.miembros.update({
        where: { ID_miembro },
        data: {
            fecha_vencimiento: dayjs(miembro.fecha_vencimiento).add(cantidad, 'month').toISOString(),
        }
    })
    if (!membresia_data) (
        res.status(404).json({ error: 'Ocurrió un error obteniendo los detalles de la membresía' })
    )
    res.status(200).json({
        data: nuevoPago,
        detalles: {
            membresia_detalles: membresia_data,
            meses: cantidad,
            precio_total: membresia_data.precio * cantidad,
            vencimiento: vencimiento_actualizado,
        }
    });
});

// Pago de membresias
router.get('/membresias/pagadas', async (_, res) => {
    const pagos = await prisma.pago_membresias.findMany({
        include: {
            miembros: true,
        },
    });

    // obtenemos los clientes para luego buscar su inscripcion
    const clientes = await prisma.clientes.findMany({
        include: {
            miembros: true,
        },
    });

    // Obetenemos todo los horarios
    const horarios = await prisma.horarios.findMany({
        select: {
            ID_horario: true,
            turno: true,
        },
    });

    // Obtenemos la inscripcion mediante el ID del cliente
    const inscripcion = await prisma.inscripciones.findMany({
        where: {
            ID_cliente: clientes[0].ID_cliente,
        },
        select: {
            ID_inscripcion: true,
            fecha_inscripcion: true,
            ID_ense_a_en: true,
        }
    })

    const dataMiembro = await prisma.miembros.findUnique({
        where: {
            ID_miembro: pagos[0].ID_miembro,
        },
        include: {
            clientes: {
                select: {
                    nombre: true,
                    apellido: true,
                    telefono: true,
                },
            },
            membresias: true,
        },
    })
    res.status(200).json({
        dataMiembro,
        pagos,
        inscripcion,
        horario: horarios.find(horario => horario.ID_horario === inscripcion[0].ID_ense_a_en),
    });
});

export default router;