<script>
    import axios from "axios";
    import { modalStore } from "../../../../store/modal.js";
    import { onMount } from "svelte";

    const cerrarModal = () => {
        modalStore.set({ showModal: false, data: null });
    };

    export let recargar;
    // ENTRADA DE DATOS
    let instructores = [];
    // **INSTRUCTORES CON HORAIO**
    const getInstructoresHorarios = () => {
        const url = "http://localhost:3000/api/ense_a_en";
        axios
            .get(url)
            .then((response) => {
                const filter = response.data;
                instructores = filter.map((item) => {
                    return {
                        id: item.id,
                        horario: item.turno,
                        instructor: item.nombre,
                        idInstructor: item.idInstructor,
                    };
                });
            })
            .catch((error) =>
                console.log(
                    `Error en la peticion de Instructores: ${JSON.stringify(
                        error,
                    )}`,
                ),
            );
    };


    // ***** HORARIOS *****
    let dataHorarios = [];
    const getHorarios = () => {
        const urlHorario = 'http://localhost:3000/api/horarios';
        axios
            .get(urlHorario)
            .then((response) => {
                dataHorarios = response.data;
            })
            .catch((error) => {
                alert(`Error en la peticion de clientes: ${JSON.stringify(error)}`)
            })
    }

    // ***** MODIFICAR HORARIO *****
    let horarioInstructorSeleccionado = null;
    let horarioNuevo = null;
    const modificarHorario = () => {
            let id = horarioInstructorSeleccionado;
            let horario = horarioNuevo;
            let instructor = instructores.find((instructor) => instructor.id === id);
    
            const url = `http://localhost:3000/api/ense_a_en/edit/${id}`;
            axios
                .put(url, {
                    ID_instructor: instructor.idInstructor,
                    ID_horario: horario,
                })
                .then((res) => {
                    alert("Horario del Modificado");
                    modalStore.set({ showModal: false, data: null });
                    console.log("EXITO");
                    getInstructoresHorarios();
                    recargar();
                })
                .catch((err) => {
                    alert("Error al modificar el horario");
                    console.log(JSON.stringify(err));
                });
    }

    onMount(() => {
        getInstructoresHorarios();
        getHorarios();
    });
</script>

<form method="dialog" on:submit={modificarHorario}>
    <h1>Modificando horario de Instructor</h1>
    <label>
        Selecciona un Instructor:
        <select bind:value={horarioInstructorSeleccionado}>
            <option>-- Selecciona un Instructor --</option>
            {#each instructores as instructor (instructor.id)}
                <option value={instructor.id}>{instructor.instructor} || Horario Actual: {instructor.horario}</option>
            {/each}
        </select>
    </label>
    <strong>Cambiar horario a:</strong>
    <label>
        Horario:
        <select bind:value={horarioNuevo}>
            <option>-- Seleciona un Horario --</option>
            {#each dataHorarios as horario (horario.ID_horario)}
                <option value={horario.ID_horario}>{horario.turno}</option>
            {/each}
        </select>
    </label>
    <div class="buttons">
        <button type="submit">Modificar Horario</button>
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

    select{
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
