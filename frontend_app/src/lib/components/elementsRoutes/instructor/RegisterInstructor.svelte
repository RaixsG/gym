<script>
    import axios from "axios";
    import { modalStore } from "../../../../store/modal.js";
    import { get } from "svelte/store";
    import { onMount } from "svelte";

    const cerrarModal = () => {
        modalStore.set({ showModal: false, data: null });
    };

    export let recargar;

    let data = get(modalStore).data;
    // ENTRADA DE DATOS
    let instructores = data; //Lista de todos los instructores

    let instructorSeleccionado = null;
    let busqueda = '';

    $: instructoresFiltrados = instructores.filter(cliente => {
        return cliente.nombre.toLowerCase().includes(busqueda.toLowerCase());
    });

    let horarioSeleccionado = null;

    
    const createInscripcion = () => {
        let instructor = instructores.find(c => c.id === instructorSeleccionado);
        let horario = dataHorario.find(d => d.id === horarioSeleccionado);

        if (!instructor) {
            alert('No se ha seleccionado un instructor');
            return;
        }

        const url = "http://localhost:3000/api/ense_a_en/create";
        axios
            .post(url, {
                ID_instructor: instructor.id,
                ID_horario: horario.id,
            })
            .then(res => {
                console.log('EXITO');
                alert('Inscripción agregado con éxito');
                cerrarModal();
                recargar();
            })
            .catch(err => {
                console.log(JSON.stringify(err));
            });
    };

    // **HORARIO**
    let dataHorario = '';
    const getHorarios = () => {
        const urlHorario = 'http://localhost:3000/api/horarios';
        axios
            .get(urlHorario)
            .then((response) => {
                const filter = response.data;
                dataHorario = filter.map((item) => {
                    let horaInicio = item.hora_inicio;
                    return {
                        id: item.ID_horario,
                        horaInicio,
                        horaFin: item.hora_finalizacion,
                        turno: item.turno,
                    }
                })
            })
            .catch((error) => {
                alert(`Error en la peticion de clientes: ${JSON.stringify(error)}`)
            })
    }

    onMount(() => {
        getHorarios();
    })
</script>

<form method="dialog" on:submit={createInscripcion}>
    <h1>Registrando Inscripción Horario</h1>
    <label>
        Buscar Instructor:
        <input 
            type="search"
            bind:value={busqueda}
        />
    </label>
    <label>
        Seleccionar Instructor:
        <select bind:value={instructorSeleccionado}>
            <option value="">-- Selecciona un Instructor --</option>
            {#each instructoresFiltrados as cliente (cliente.id)}
                <option value={cliente.id}>{cliente.nombre}</option>
            {/each}
        </select>
    </label>
    <label>
        Horario:
        <select bind:value={horarioSeleccionado}>
            <option>-- Seleciona un Horario --</option>
            {#each dataHorario as horario (horario.id) }
                <option value={horario.id}>{horario.turno}</option>
            {/each}
        </select>
    </label>
    <div class="buttons">
        <button type="submit">Inscribir</button>
        <button type="button" on:click={cerrarModal}>Cancelar</button>
    </div>
</form>

<style>
    form {
        position: relative;
        width: 100%;
        margin: 0 auto;
        background-color: var(--sidebar-color);
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
        transition: var(--tran-02);
        color: var(--text-color);
    }

    h1 {
        text-align: center;
        margin-bottom: 20px;
    }

    label {
        display: block;
        margin-bottom: 10px;
    }

    input[type="search"],
    select,
    input[type="date"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    button[type="submit"],
    button[type="button"] {
        color: white;
        border: none;
        border-radius: 5px;
        padding: 10px 15px;
        cursor: pointer;
        color: var(--text-color);
        transition: var(--tran-02);
    }

    select:focus {
        background-color: var(--primary-color);
        color: white;
    }

    button[type="submit"]:hover,
    button[type="button"]:hover {
        background-color: var(--primary-color);
        color: white;
    }

    .buttons {
        display: flex;
        justify-content: space-between;
    }

</style>
