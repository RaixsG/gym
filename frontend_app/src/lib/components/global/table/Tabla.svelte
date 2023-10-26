<script>
    export let headers = [];
    export let data = [];

    let currentPage = 1;
    const pageSize = 10;

    $: paginatedData = data.slice((currentPage - 1) * pageSize, currentPage * pageSize);

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

</script>


<table>
    <thead>
        <tr>
            {#each headers as header}
                <th>{header}</th>
            {/each}
        </tr>
    </thead>
    <tbody>
        {#each paginatedData as row}
            <tr>
                {#each Object.values(row) as cell}
                    <td>{cell}</td>
                {/each}
            </tr>
        {/each}
    </tbody>
    <tfoot>
        <tr>
            {#each headers as header}
                <th>{header}</th>
            {/each}
        </tr>
    </tfoot>
</table>
<div>
    <button on:click={prevPage} disabled={currentPage === 1}>Anterior</button>
    <button on:click={nextPage} disabled={currentPage * pageSize >= data.length}>Siguiente</button>
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
        /* background-color: var(--primary-color); */
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
        width: 100%;
        border-collapse: collapse;
    }

    tfoot {
        filter: opacity(0.5);
    }

    th, td {
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

</style>