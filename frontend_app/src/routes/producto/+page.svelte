<script>
    import { onMount } from "svelte";
    import { error } from "@sveltejs/kit";
    import axios from "axios";
    import dayjs from "dayjs";
    import utc from "dayjs/plugin/utc";
    import { modalStore } from "../../store/modal";

    dayjs.extend(utc);
    
    // Componentes
    import { 
        AddProducto,
        EditProducto
    } from '$lib/components/elementsRoutes/productos'
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

    const url = "http://localhost:3000/api/productos";

    let headers = [
        "Id Producto",
        "Nombre Producto",
        "Descripción",
        "Precio",
        "Cantidad Stock"
    ];
    let data = [];

    // EndPoint
    function getTodosProductos() {
        axios
            .get(url)
            .then((response) => {
                const filter = response.data;
                data = filter.map((item) => {
                    return {
                        id: item.ID_producto,
                        nombre_producto: item.nombre_producto,
                        descripcion: item.descripcion,
                        precio: item.precio,
                        cantidad: item.cantidad_stock,
                    };
                });
            })
            .catch((error) => 
                console.log(
                    `Error en la petición de productos: ${JSON.stringify(
                        error,
                    )}`,
                ),
            );
    }

    const handleDelete = (id) => {
        let idEliminar = id.detail;
        console.log("ID Eliminar", idEliminar);
        const url = `http://localhost:3000/api/productos/delete/${idEliminar}`;
        axios
            .delete(url, {
                headers: {
                    ID_producto: idEliminar,
                },
            })
            .then((res) => {
                console.log("EXITO");
            })
            .catch((err) => {
                console.log(JSON.stringify(err));
            });
    };

    function recargar () {
        getTodosProductos();
    }

    onMount(() => {
        getTodosProductos();
    })
    
</script>

<div class="contend">
    <article class={`${showModal ? "dialog-activate" : ""}`}>
        <h1>Productos</h1>
        <section class="contend-table">
            <button
                class="button-add"
                on:click={() =>
                    modalStore.set({ showModal: true, component: "AddProducto" })}
                >Agregar Nuevo Producto
            </button>
            <TablaActions on:delete={handleDelete} {headers} {data} />
        </section>
    </article>
    {#if showModal}
        <dialog>
            {#if component === "AddProducto"}
                <AddProducto {recargar} />
            {:else if component === "EditClient"}
                <EditProducto {recargar} />
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
</style>

