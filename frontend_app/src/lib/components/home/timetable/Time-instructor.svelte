<script>
    import Tabla from "$lib/components/global/table/Tabla.svelte";

    let headers = ['Nombre', 'Horas', 'Turno'];
    let data = [
        {Nombre: 'Juan', Horas: '8:00 - 10:00', Turno: 'Mañana'},
        {Nombre: 'Ana', Horas: '10:00 - 12:00', Turno: 'Mañana'},
    ]

</script>

<section class="instructor">
    <h2>Horario Instructores</h2>
    <Tabla { headers } { data } />
</section>