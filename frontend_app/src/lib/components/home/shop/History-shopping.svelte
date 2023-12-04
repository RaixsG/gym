<script>
    import Graphics from "$lib/components/global/Graphics.svelte";
    import Tabla from "$lib/components/global/table/Tabla.svelte";
    import axios from "axios";
    import { onMount } from "svelte";

    let headers = ["ID", "Producto", "Precio", "Cantidad"];
    let ultimasVentas = [];

    // EndPoint
    const getVentasEnd = () => {
        const url = "http://localhost:3000/api/ventas/ultimas10";
        axios
            .get(url)
            .then((response) => {
                const filter = response.data;
                ultimasVentas = filter.map((item) => {
                    return {
                        id: item.ID_venta,
                        nombre_producto: item.detalles_venta.map(
                            (nombreProducto) => nombreProducto.productos.nombre_producto
                        ),
                        precio: item.detalles_venta.map(
                            (precio) => precio.productos.precio
                        ),
                        cantidad: item.detalles_venta.map(
                            (cantidad) => cantidad.cantidad
                        ),
                    };
                });
            })
            .catch((err) => {
                console.log(JSON.stringify(err));
            });
    };

    onMount(() => {
        getVentasEnd();
    });
</script>

<section>
    <h2>Ventas recientes</h2>
    <Tabla {headers} data={ultimasVentas} />
    <h2>Productos totales más Vendidos</h2>
    <Graphics />
</section>

<style>
    section {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
    }
</style>
