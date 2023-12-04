<script>
    import Tabla from "$lib/components/global/table/Tabla.svelte";
    import { onMount } from "svelte";
    import axios from "axios";

    let headers = [
        'ID',
        'Nombre',
        'Turno'
    ];
    let data = [];

    const getHorarios = () => {
        const url = 'http://localhost:3000/api/ense_a_en';
        axios
            .get(url)
            .then((response) => {
                const filter = response.data;
                data = filter.map((item) => {
                    return {
                        id: item.id,
                        nombre: item.nombre,
                        turno: item.turno,
                    }
                })
            })
            .catch((err) => {
                console.log(JSON.stringify(err));
            });
    };

    onMount(() => {
        getHorarios();
    });

</script>

<section class="instructor">
    <h2>Horario Instructores</h2>
    <Tabla { headers } { data } />
</section>