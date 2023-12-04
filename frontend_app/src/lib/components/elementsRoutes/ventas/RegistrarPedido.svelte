<script>
    import { onMount } from "svelte";
    import { get } from "svelte/store";
    import { modalStore } from "../../../../store/modal.js";
    import axios from "axios";

    const cerrarModal = () => {
        modalStore.set({ showModal: false });
    };

    let productos = get(modalStore).data;
    console.log(productos);

    let idClienteSeleccionado = null;
    let metodoPagoSeleccionado = null;

    // ENDPOINTS CLIENTES
    let clients = [];
    const getClients = () => {
        const url = "http://localhost:3000/api/clientes";
        axios
            .get(url)
            .then(({ data: response }) => {
                clients = response.map((client) => ({
                    id: client.ID_cliente,
                    name: `${client.nombre} ${client.apellido}`,
                }));
            })
            .catch((error) => {
                console.log(error);
            });
    };

    const sendSale = () => {
        const url = "http://localhost:3000/api/ventas/create";
        const body = {
            metodo_pago: metodoPagoSeleccionado,
            ID_cliente: idClienteSeleccionado,
            productos: productos.map(producto => ({
                id: producto.ID_producto,
                quantity: 1,
            }))
        }
        axios
            .post(url, body)
            .then(({ data: response}) => {
                console.log(JSON.stringify(response))
                cerrarModal();
            })
            .catch(err => console.log(err));
    }
    onMount(getClients);
</script>

<form method="dialog" on:submit={sendSale}>
    <h1>Detalles de Venta</h1>
    <label>
        Cliente:
        <select bind:value={idClienteSeleccionado}>
            <option value={null}>-- Selecciona un Cliente --</option>
            {#each clients as client (client.id)}
                <option value={client.id}>{client.name}</option>
            {/each}
        </select>
    </label>
    <label>
        Metodo de pago:
        <select bind:value={metodoPagoSeleccionado}>
            <option value={null}>-- Selecciona un Metodo de Pago --</option>
            <option value="efectivo">Efectivo</option>
            <option value="tarjeta">Tarjeta</option>
        </select>
    </label>
    <div class="buttons">
        <button type="submit">Confirmar Venta</button>
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

    select {
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
