<script>
    import AddClient from "./elements/AddClient.svelte";
    import Tabla from "$lib/components/global/table/Tabla.svelte";

    let headers = ['Nombre', 'Apellido', 'Dirección', 'Teléfono', 'Correo electrónico', 'Fecha de nacimiento'];

    let data = [
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},
        {'Nombre': "Ale", 'Apellido': "Linares", 'Dirección':"Calle 1", 'Teléfono':123456789, 'Correo electrónico': "correo@corre.com", 'Fecha de nacimiento': "01/01/2000"},

    ]
</script>

<div>
    <article>
        <section>
            <h1>Client</h1>
            <AddClient />
        </section>
        <section class="tabla">
            <Tabla {headers} {data} />
        </section>
    </article>
</div>

<style>
    div {
        display: flex;
        justify-content: center;
        align-items: center;

        top: 0;
        left: 0;

        width: 100%;
        height: 100vh;
        max-height: 100%;

        background-color: var(--sidebar-color);
        color: var(--text-color);
    }

    article {
        display: grid;
        grid-template-areas: "formulario tabla";

        width: 100%;
        height: 100%;
        padding: 15px;
    }

    section {
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
    }

    h1 {
        display: flex;
        justify-content: center;
        padding-top: 20px;
    }



</style>
