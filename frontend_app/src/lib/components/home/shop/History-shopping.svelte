<script>
    import Graphics from "$lib/components/global/Graphics.svelte";
    import Tabla from "$lib/components/global/table/Tabla.svelte";
    
    let headers = ['Nombre', 'Correo electrónico', 'Teléfono'];
    let data = [
        {Nombre: 'Juan', 'Correo electrónico': 'juan@example.com', Teléfono: '123-456-7890'},
        {Nombre: 'Ana', 'Correo electrónico': 'ana@example.com', Teléfono: '098-765-4321'},
    ];

</script>

<section>
    <h2>Ventas recientes</h2>
    <Tabla { headers } { data } />
    <h2>Prodcutos más Vendidos</h2>
    <Graphics />
</section>

<style>
    
</style>