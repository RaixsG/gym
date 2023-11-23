<script>
    import { modalStore } from "../../../../store/modal";

    // Data
    export let headers = [];
    export let data = [];

    // Paginación
    let currentPage = 1;
    const pageSize = 15;
    $: paginatedData = data.slice(
        (currentPage - 1) * pageSize,
        currentPage * pageSize
    );
    function nextPage() {
        if (currentPage * pageSize < data.length) {
            currentPage++;
        }
    }
    function prevPage() {
        if (currentPage > 1) {
            currentPage--;
        }
    }

    // **ACCIONS BUTTONS**
    const editarCliente = (id) => {
        let user = paginatedData.find((user) => user.id === id);
        console.log(user);
        modalStore.set({ showModal: true , component: "EditClient" });
        console.log("Editar Cliente");
    };

    const eliminarCliente = () => {
        console.log("Eliminar Cliente");
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
        {#each paginatedData as row}
            <tr>
                {#each Object.values(row) as cell}
                    <td class="data-center">{cell}</td>
                {/each}
                <td class="buttons-actions">
                    <button on:click={editarCliente(row.id)}>Edit</button>
                    <button on:click={eliminarCliente}>Delete</button>
                </td>
            </tr>
        {/each}
    </tbody>
    <tfoot>
        <tr>
            {#each headers as header}
                <th>{header}</th>
            {/each}
            <th>Acciones</th>
        </tr>
    </tfoot>
</table>
<div>
    <button on:click={prevPage} disabled={currentPage === 1}>
        Anterior
    </button>
    <button 
        on:click={nextPage}
        disabled={currentPage * pageSize >= data.length}>
        Siguiente
    </button>
</div>

<style>
    div {
        display: flex;
        align-items: center;
    }

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
    }

    tfoot {
        filter: opacity(0.5);
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
    
</style>
