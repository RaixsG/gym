<script>
    import Tabla from "$lib/components/global/table/Tabla.svelte";
    import BarGraphics from "$lib/components/global/Bar-graphics.svelte";
    import { onMount } from "svelte";
    import axios from "axios";
    import dayjs from "dayjs";

    let data = [];
    
    // Endpoints
    function getInscripcionesUltimoMes() {
        const url = "http://localhost:3000/api/inscripciones/miembros";
        axios.get(url)
            .then((response) => {
                const filter = response.data;
                data = filter.map((item) => {
                    return {
                        id: item.ID_cliente,
                        nombre: item.nombre,
                        estado: item.miembros.map((item) => item.estado_inscripcion),
                        fecha: dayjs(item.inscripciones[0].fecha_inscripcion).format("DD/MM/YYYY"),
                    };
                });
            })
            .catch((error) => console.log(`Error en la peticion de inscripciones: ${JSON.stringify(error)}`));
    };

    let headers = ['ID', 'Nombre', 'Estado', 'Fecha de registro'];

    onMount(() => {
        getInscripcionesUltimoMes();
    });

</script>

<section class="total">
    <h2>Clientes en el Ultimo Mes</h2>
    <Tabla { headers } { data } />
    <h2>Clientes por Mes</h2>
    <div>
        <BarGraphics />
    </div>
</section>

<style>
    .total {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
    }

    div {
        padding: 5px;
        width: 100%;
        /* height: 400px; */
        background-color: var(--primary-color-light);
    }
</style>