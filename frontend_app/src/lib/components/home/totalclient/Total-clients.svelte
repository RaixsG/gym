<script>
    import Tabla from "$lib/components/global/table/Tabla.svelte";
    import BarGraphics from "$lib/components/global/Bar-graphics.svelte";
    import { onMount } from "svelte";
    import axios from "axios";

    const url = "http://localhost:3000/api/inscripciones/ultimosmes";
    let data = [];

    // Endpoints
    function getInscripcionesUltimoMes() {
        axios.get(url)
            .then((response) => { console.log(response.data); data = response.data})
            .catch((error) => console.log(`Error en la peticion de inscripciones: ${JSON.stringify(error)}`));
    };

    let headers = ['N° Cliente', 'Nombre', 'Estado', 'Fecha de registro'];

    onMount(() => {
        getInscripcionesUltimoMes();
    });

</script>

<section class="total">
    <h2>Clientes en el Ultimo Mes</h2>
    <Tabla { headers } { data } />
    <h2>Clientes por Mes</h2>
    <div>
        <BarGraphics { data } />
    </div>
</section>

<style>
    .total {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        justify-content: center;
        /* width: 100%; */
    }

    div {
        padding: 5px;
        width: 100%;
        /* height: 400px; */
        background-color: var(--primary-color-light);
    }
</style>