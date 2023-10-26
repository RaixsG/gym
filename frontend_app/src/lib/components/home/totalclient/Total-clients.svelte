<script>
    import Tabla from "$lib/components/global/table/Tabla.svelte";
    import BarGraphics from "$lib/components/global/Bar-graphics.svelte";

    let headers = ['N° Cliente', 'Nombre', 'Estado', 'Fecha de registro'];
    let data = [
        {"N° Cliente": 1, Nombre: "Prueba 1", Estado: "Activo","Fecha de registro": "01/01/2021"},
        {"N° Cliente": 2,Nombre: "Prueba 2",Estado: "Activo","Fecha de registro": "01/01/2021"},
        {"N° Cliente": 3,Nombre: "Prueba 3",Estado: "Activo","Fecha de registro": "01/01/2021"},
        {"N° Cliente": 4,Nombre: "Prueba 3",Estado: "Activo","Fecha de registro": "01/01/2021"},
        {"N° Cliente": 5,Nombre: "Prueba 3",Estado: "Activo","Fecha de registro": "01/02/2021"},
        {"N° Cliente": 6,Nombre: "Prueba 3",Estado: "Activo","Fecha de registro": "01/02/2021"},
        {"N° Cliente": 7,Nombre: "Prueba 3",Estado: "Activo","Fecha de registro": "01/02/2021"},
        {"N° Cliente": 8,Nombre: "Prueba 3",Estado: "Activo","Fecha de registro": "01/02/2021"},
        {"N° Cliente": 9,Nombre: "Prueba 3",Estado: "Activo","Fecha de registro": "01/03/2021"},
        {
            "N° Cliente": 10,
            Nombre: "Prueba 3",
            Estado: "Activo",
            "Fecha de registro": "01/03/2021",
        },
        {
            "N° Cliente": 11,
            Nombre: "Prueba 3",
            Estado: "Activo",
            "Fecha de registro": "01/03/2021",
        },
        {
            "N° Cliente": 12,
            Nombre: "Prueba 3",
            Estado: "Activo",
            "Fecha de registro": "01/03/2021",
        },
        {
            "N° Cliente": 13,
            Nombre: "Prueba 3",
            Estado: "Activo",
            "Fecha de registro": "01/03/2021",
        },
        {
            "N° Cliente": 14,
            Nombre: "Prueba 3",
            Estado: "Activo",
            "Fecha de registro": "01/04/2021",
        },
        {
            "N° Cliente": 15,
            Nombre: "Prueba 3",
            Estado: "Activo",
            "Fecha de registro": "01/04/2021",
        },
        {
            "N° Cliente": 16,
            Nombre: "Prueba 3",
            Estado: "Activo",
            "Fecha de registro": "01/04/2021",
        },
        {
            "N° Cliente": 17,
            Nombre: "Prueba 3",
            Estado: "Activo",
            "Fecha de registro": "01/05/2021",
        },
        {
            "N° Cliente": 18,
            Nombre: "Prueba 3",
            Estado: "Activo",
            "Fecha de registro": "01/05/2021",
        },
        {
            "N° Cliente": 19,
            Nombre: "Prueba 3",
            Estado: "Activo",
            "Fecha de registro": "01/05/2021",
        },
        {
            "N° Cliente": 20,
            Nombre: "Prueba 3",
            Estado: "Activo",
            "Fecha de registro": "01/06/2021",
        },
        {
            "N° Cliente": 21,
            Nombre: "Prueba 3",
            Estado: "Activo",
            "Fecha de registro": "01/06/2021",
        },
        {
            "N° Cliente": 22,
            Nombre: "Prueba 3",
            Estado: "Activo",
            "Fecha de registro": "01/06/2021",
        },
        {
            "N° Cliente": 23,
            Nombre: "Prueba 3",
            Estado: "Activo",
            "Fecha de registro": "01/07/2021",
        },
        {
            "N° Cliente": 24,
            Nombre: "Prueba 3",
            Estado: "Activo",
            "Fecha de registro": "01/07/2021",
        },
    ];

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