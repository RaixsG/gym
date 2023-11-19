<script>
    import { onMount } from "svelte";
    import { modalStore } from "../../store/modal";
    import axios from "axios";

    // Components
    import {
        AddInstructor,
        EditInstructor,
    } from '$lib/components/elementsRoutes/instructor';
    import TablaActions from "$lib/components/global/table-actions/TablaActions.svelte";

    // **Modal**
    let showModal = false;
    let component = null;
    modalStore.subscribe((state) => {
        showModal = state.showModal;
        component = state.component;
    });

    const url = "http://localhost:3000/api/instructores";
    let headers = [
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

    // Endpoint
    function getTodosInstructores() {
        axios
            .get(url)
            .then((response) => {
                const filter = response.data;
                data = filter.map((item) => {
                    return {
                        nombre: item.nombre,
                        apellido: item.apellido,
                        direccion: item.direccion,
                        telefono: item.telefono,
                        correo: item.email,
                        fecha_nacimiento: item.fecha_nacimiento,
                        especializacion: item.especializacion,
                        foto: item.foto_instructor,
                    };
                });
            })
            .catch((error) =>
                console.log(
                    `Error en la peticion de clientes: ${JSON.stringify(error)}`
                )
            );
    }

    onMount(() => {
        getTodosInstructores();
    });
</script>

<div class="contend">
    <article class={`${showModal ? "dialog-activate" : ""}`}>
        <h1>Instructores</h1>
        <section class="contend-table">
            <button
                class="button-add"
                on:click={() =>
                    modalStore.set({ showModal: true, component: "AddInstructor" })}
                >Agregar Nuevo Instructor
            </button>
            <TablaActions {headers} {data} />
        </section>
    </article>
    {#if showModal}
        <dialog>
            {#if component === "AddInstructor"}
                <AddInstructor />
            {:else if component === "EditClient"}
                <EditInstructor />
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

        background-color: var(--sidebar-color);
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

        height: 500px;
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
</style>
