<script>
    import axios from "axios";
    import { modalStore } from "../../../../store/modal.js";
    import { get } from "svelte/store";

    const cerrarModal = () => {
        modalStore.set({ showModal: false });
    };

    export let recargar;

    // Busqueda de miembros
    let busqueda = "";
    let data = get(modalStore).data;
    let miembros = data;

    $: miembrosFiltrados = miembros.filter((miembro) => {
        return miembro.nombre.toLowerCase().includes(busqueda.toLowerCase());
    });

    // ENTRADA DE DATOS
    let miembroSeleccionado = null;
    let cantidad = null;
    let metodoPagoSeleccionado = null;

    const pagarMembresia = () => {
        const url = "http://localhost:3000/api/pago_membresias";
        const body = {
            ID_miembro: miembroSeleccionado,
            cantidad: cantidad,
            metodo_pago: metodoPagoSeleccionado,
        };
        axios
            .post(url, body)
            .then((response) => {
                // console.log(response.data);
                cerrarModal();
                recargar();
            })
            .catch((error) => {
                console.log(error);
            });
    };

</script>

<form method="dialog" on:submit={pagarMembresia}>
    <h1>Renovar Membresia</h1>
    <label>
        Buscar Cliente:
        <input type="search" bind:value={busqueda} />
    </label>
    <label>
        Miembro:
        <select bind:value={miembroSeleccionado}>
            <option value={null} disabled>-- Selecciona un miembro --</option>
            {#each miembrosFiltrados as miembro (miembro.id)}
                <option value={miembro.id}>{miembro.nombre}</option>
            {/each}
        </select>
    </label>
    <label>
        Cantidad:
        <input
            type="number"
            required
            on:change={(e) => (cantidad = e.target.value)}
        />
    </label>
    <label>
        Metodo de Pago
        <select bind:value={metodoPagoSeleccionado}>
            <option value={null} selected>-- Selecciona una Opción --</option>
            <option value="efectivo">Efectivo</option>
            <option value="tarjeta">Tarjeta</option>
        </select>
    </label>
    <div class="buttons">
        <button type="submit">Pagar</button>
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
    option,
    input[type="number"] {
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
