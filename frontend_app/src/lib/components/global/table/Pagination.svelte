<script>
    export let currentPage = 1;
    export let totalPages = 1;
    
    function prevPage() {
        if (currentPage > 1) {
            currentPage--;
        }
    }
    
    function nextPage() {
        if (currentPage < totalPages) {
            currentPage++;
        }
    }
</script>

<button on:click={prevPage} disabled={currentPage === 1}>Anterior</button>
<span>Página {currentPage} de {totalPages}</span>
<button on:click={nextPage} disabled={currentPage === totalPages}>Siguiente</button>
