<script>
    import { modalStore } from "../../../../store/modal";

    // Data
    export let headers = [];
    export let data = [];
    export let deleteProduct;

    const eliminarCliente = (id) => {
        // confirm("¿Estás seguro de eliminar este producto?");
        deleteProduct(id);
    };

</script>

<table>
    <thead>
        <tr>
            {#each headers as header}
                <th>{header}</th>
            {/each}
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        {#each data as row}
            <tr>
                {#each Object.values(row) as cell}
                    <td class="data-center">{cell}</td>
                {/each}
                <td class="buttons-actions">
                    <button class="buttons-actions_icons" on:click={() => eliminarCliente(row.id)}>
                        <i class='bx bx-x-circle' ></i>
                    </button>
                </td>
            </tr>
        {/each}
    </tbody>
</table>
<div>
    <button type="submit" class="button-add" on:click={
        modalStore.set({
            showModal: true,
            component: "RegistrarPedido",
            data: data,
        })
    }>
        Fichar Pedido
    </button>
</div>

<style>
    button {
        margin: 10px;
        padding: 5px;
        border-radius: 5px;
        border: 1px solid var(--text-color);
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

    table {
        position: relative;
        width: 100%;
        border-collapse: collapse;
        transition: var(--tran-02);
        table-layout: fixed;
    }

    th,
    td {
        border: 1px solid var(--text-color);
        padding: 8px;
    }

    th {
        background-color: var(--primary-color);
        color: white;
    }

    tr:nth-child(even) {
        background-color: var(--sidebar-color);
    }

    .buttons-actions {
        display: flex;
        justify-content: center;
    }

    .data-center {
        text-align: center;
    }

    .buttons-actions_icons {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .button-add {
        margin-left: 0;
        display: flex;
        justify-content: flex-end;
    }
    
</style>
