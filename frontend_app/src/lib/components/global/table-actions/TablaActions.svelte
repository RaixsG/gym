<script>
    import { modalStore } from "../../../../store/modal";
    import { createEventDispatcher } from 'svelte';

    const dispatch = createEventDispatcher();

    // Data
    export let headers = [];
    export let data = [];
    console.log(data)

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
    const editarDato = (id) => {
        let user = paginatedData.find((user) => user.id === id);
        console.log(paginatedData);
        modalStore.set({ showModal: true , component: "EditClient", data: user });
    };

    const eliminarDato = (id) => {
        if (window.confirm("¿Estas seguro de eliminar este dato?")) {
            console.log("Eliminar Dato", id);
            data = data.filter(item => item.id !== id);
            dispatch("delete", id);
        }
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
                    <button class="buttons-actions_icons" on:click={() => editarDato(row.id)}>
                        <i class='bx bx-pencil' ></i>
                    </button>
                    <button class="buttons-actions_icons" on:click={()=> eliminarDato(row.id)}>
                        <i class='bx bx-x-circle' ></i>
                    </button>
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
        table-layout: fixed;
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
        display: grid;
        grid-template-columns: 1fr 1fr;
    }

    .data-center {
        text-align: center;
    }

    .buttons-actions_icons {
        display: flex;
        justify-content: center;
        align-items: center;
    }
    
</style>
