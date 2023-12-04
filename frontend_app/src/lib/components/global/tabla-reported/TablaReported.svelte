<script>
    import jsPDF from 'jspdf';
    import autoTable from 'jspdf-autotable';

    // Data
    export let headers = [];
    export let data = [];

    function generarReporte() {
        const doc = new jsPDF();
        autoTable(doc, { html: '#reportTable' });
        doc.save('report.pdf');
        history.back();
    }
</script>

<button on:click={generarReporte}>Generar Reporte</button>

<table id="reportTable">
    <thead>
        <tr>
            {#each headers as header}
                <th>{header}</th>
            {/each}
        </tr>
    </thead>
    <tbody>
        {#each data as row}
            <tr>
                {#each Object.values(row) as cell}
                    <td class="data-center">{cell}</td>
                {/each}
            </tr>
        {/each}
    </tbody>
</table>