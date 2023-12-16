<script>
    import { onMount } from "svelte";
    import { error } from "@sveltejs/kit";
    import axios from "axios";
    import dayjs from "dayjs";
    import utc from "dayjs/plugin/utc";
    import { modalStore } from "../../store/modal";

    dayjs.extend(utc);

    // Components
    import {
        AddClient,
        EditClient,
        InscribirCliente,
    } from "$lib/components/elementsRoutes/clients";
    import TablaActions from "$lib/components/global/table-actions/TablaActions.svelte";

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

    
    let headers = [
        "ID",
        "Nombre",
        "Apellido",
        "Dirección",
        "Teléfono",
        "Correo electrónico",
        "Fecha de nacimiento",
    ];

    let clients = [];
    const addClient = (client) => clients = [ ...clients, client ];

    // Endpoint
    function getTodosClientes() {
        const url = "http://localhost:3000/api/clientes/sininscripcion";
        axios
            .get(url)
            .then((response) => {
                const filter = response.data;
                clients = filter.map((item) => {
                    let fecha = dayjs
                        .utc(item.fecha_nacimiento)
                        .format("DD/MM/YYYY");
                    let id = item.ID_cliente;
                    return {
                        id: id,
                        nombre: item.nombre,
                        apellido: item.apellido,
                        direccion: item.direccion,
                        telefono: item.telefono,
                        correo: item.email,
                        fecha_nacimiento: fecha,
                    };
                });
            })
            .catch((error) =>
                alert(
                    `Error en la peticion de clientes: ${JSON.stringify(
                        error,
                    )}`,
                ),
            );
    }

    const handleDelete = (id) => {
        let idEliminar = id.detail;
        console.log("ID Eliminar", idEliminar);
        const url = `http://localhost:3000/api/clientes/delete/${idEliminar}`;
        axios
            .delete(url)
            .then((res) => {
                console.log("EXITO");
            })
            .catch((err) => {
                console.log(JSON.stringify(err));
            });
    };

    function recargar () {
        getTodosClientes();
    };

    onMount(() => {
        getTodosClientes();
    });
</script>

<div class="contend">
    <article class={`${showModal ? "dialog-activate" : ""}`}>
        <h1>Clientes</h1>
        <section class="contend-table">
            <div class="buttons">
                <button
                    class="button-add"
                    on:click={() =>
                        modalStore.set({
                            showModal: true,
                            component: "AddClient",
                        })}
                    >Agregar Nuevo Cliente
                </button>
                <button
                    class="button-add"
                    on:click={() =>
                        modalStore.set({
                            showModal: true,
                            component: "InscribirCliente",
                            data: clients,
                        })}
                    >Inscribir Cliente
                </button>
            </div>
            <TablaActions on:delete={handleDelete} {headers} data={clients} />
        </section>
    </article>
    {#if showModal}
        <dialog>
            {#if component === "AddClient"}
                <AddClient { addClient } />
            {:else if component === "EditClient"}
                <EditClient {recargar} />
            {:else if component === "InscribirCliente"}
                <InscribirCliente {recargar} />
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

    .buttons {
        display: flex;
        flex-direction: row;
    }
</style>
