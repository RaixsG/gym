<script>
    // IMPORTS
    import HistoryShopping from "$lib/components/home/shop/History-shopping.svelte";
    import TimeInstructor from "$lib/components/home/timetable/Time-instructor.svelte";
    import TotalClients from "$lib/components/home/totalclient/Total-clients.svelte";
</script>

<div>
    <h1>Personal-VIP</h1>
    <article>
        <HistoryShopping />
        <TimeInstructor />        
        <TotalClients />
    </article>
</div>

<style>
    div {
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: var(--sidebar-color);
        color: var(--text-color);
    }

    h1 {
        display: flex;
        justify-content: center;
        padding-top: 20px;
    }

    article {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 2rem;
        padding: 2rem;
    }

</style>
