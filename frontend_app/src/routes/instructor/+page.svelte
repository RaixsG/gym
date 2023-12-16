<script>
    import { onMount } from "svelte";
    import { error } from "@sveltejs/kit";
    import { modalStore } from "../../store/modal";
    import axios from "axios";
    import dayjs from "dayjs";
    import utc from "dayjs/plugin/utc";
    dayjs.extend(utc);

    // Components
    import {
        AddInstructor,
        EditInstructor,
        RegisterInstructor,
        EditRegisterInstructor
    } from "$lib/components/elementsRoutes/instructor";
    import TablaActions from "$lib/components/global/table-actions/TablaActions.svelte";
    import Tabla from "$lib/components/global/table/Tabla.svelte";

    // Protected route
    let status;
    export function load(e) {
        if (status === "unauth") {
            return error(401, "Unauthorized");
        }
    }

    // **Modal**
    let showModal = false;
    let component = null;
    modalStore.subscribe((state) => {
        showModal = state.showModal;
        component = state.component;
    });

    // ***** INSTRUCTORES *****
    const url = "http://localhost:3000/api/instructores";
    let headers = [
        "ID",
        "Nombre",
        "Apellido",
        "Dirección",
        "Teléfono",
        "Correo electrónico",
        "Fecha de nacimiento",
        "Especialización",
        "Foto",
    ];
    let data = [];
    const addInstructor = (instructor) => data = [ ...data, instructor ];

    // Endpoint
    function getTodosInstructores() {
        axios
            .get(url)
            .then((response) => {
                const filter = response.data;
                data = filter.map((item) => {
                    let fecha = dayjs
                        .utc(item.fecha_nacimiento)
                        .format("YYYY-MM-DD");
                    let foto = null;
                    if (item.foto_instructor === null) {
                        foto = "Sin Foto";
                    }
                    let id = item.ID_instructor;
                    return {
                        id: id,
                        nombre: item.nombre,
                        apellido: item.apellido,
                        direccion: item.direccion,
                        telefono: item.telefono,
                        correo: item.email,
                        fecha_nacimiento: fecha,
                        especializacion: item.especializacion,
                        foto: foto,
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
    }

    const handleDelete = (id) => {
        let idEliminar = id.detail;
        const url = `http://localhost:3000/api/instructor/delete/${idEliminar}`;
        axios
            .delete(url, {
                headers: {
                    ID_instructor: idEliminar,
                },
            })
            .then((res) => {
                console.log("EXITO");
            })
            .catch((err) => {
                console.log(JSON.stringify(err));
            });
    }

    // ***** INSTRUCTORES CON HORARIOS *****
    let headersHorario = [
        'ID',
        'Horario',
        'Instructor'
    ];
    let dataHorario = [];
    // Endpoint
    const getInstructoresHorarios = () => {
        const url = "http://localhost:3000/api/ense_a_en";
        axios
            .get(url)
            .then((response) => {
                const filter = response.data;
                dataHorario = filter.map((item) => {
                    return {
                        id: item.id,
                        horario: item.turno,
                        instructor: item.nombre
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

    function recargar () {
        getTodosInstructores();
        getInstructoresHorarios();
    }

    onMount(() => {
        getTodosInstructores();
        getInstructoresHorarios();
    });
</script>

<div class="contend">
    <article class={`${showModal ? "dialog-activate" : ""}`}>
        <h1>Instructores</h1>
        <section class="contend-table">
            <div class="buttons">
                <button
                class="button-add"
                on:click={() =>
                    modalStore.set({
                        showModal: true,
                        component: "AddInstructor",
                    })}
                >Agregar Nuevo Instructor
            </button>
            <button
                class="button-add"
                on:click={() =>
                    modalStore.set({
                        showModal: true,
                        component: "RegisterInstructor",
                        data: data,
                    })}
                >Registrar Instructor a Horario
            </button>
            </div>
            <TablaActions on:delete={handleDelete} {headers} {data} />
        </section>
        <h1>Instructores con Horarios</h1>
        <section class="contend-table">
            <div class="buttons">
                <button
                class="button-add"
                on:click={() =>
                    modalStore.set({
                        showModal: true,
                        component: "EditRegister"
                    })}
                >Modificar horario de Instructor
            </button>
            </div>
            <Tabla headers={headersHorario} data={dataHorario} />
        </section>
    </article>
    {#if showModal}
        <dialog>
            {#if component === "AddInstructor"}
                <AddInstructor {recargar} { addInstructor } />
            {:else if component === "EditClient"}
                <EditInstructor {recargar} />
            {:else if component === "RegisterInstructor"}
                <RegisterInstructor {recargar} />
            {:else if component === "EditRegister"}
                <EditRegisterInstructor {recargar} />
            {/if}
        </dialog>
    {/if}
</div>

<style>
    .contend {
        z-index: -1;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;

        top: 0;
        left: 0;

        width: 100%;
        height: 100vh;
        max-height: 100%;

        /* background-color: var(--sidebar-color); */
        color: var(--text-color);
    }

    article {
        width: 90%;
        height: 100%;
    }

    h1 {
        display: flex;
        justify-content: center;
        padding-top: 20px;

        font-size: 2rem;
    }

    .contend-table {
        position: relative;
        display: flex;
        flex-direction: column;

        height: auto;
    }

    .button-add {
        width: 150px;
        display: flex;
        justify-content: flex-start;
    }

    dialog {
        position: absolute;
        z-index: 1;
        top: 15%;
        left: 50%;
        transform: translateX(-50%);

        display: flex;
        flex-direction: column;
        border-radius: 5px;

        background-color: var(--sidebar-color);
    }

    .dialog-activate {
        filter: blur(5px);
    }

    button {
        margin: 10px;
        padding: 5px;
        border-radius: 5px;
        color: var(--text-color);
        cursor: pointer;
    }

    button:hover {
        background-color: var(--primary-color);
        color: white;
    }

    button:disabled {
        background-color: var(--text-color);
        cursor: default;
    }

    .buttons {
        display: flex;
        flex-direction: row;
    }
</style>
