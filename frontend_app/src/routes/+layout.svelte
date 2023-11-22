<script>
    import { theme } from "../store/theme";
    import "../styles.css";
    import Dashboard from "$lib/components/dashboard/Dashboard.svelte";
    import { onMount } from "svelte";
    import { appStatus } from '$stores';

    let isHidden = false;
    const handleHidden = () => isHidden = !isHidden;

    const checkLocalStorage = () => {
        const localAppStatus = localStorage.getItem("appStatus");
        if (localAppStatus) {
            appStatus.set(localAppStatus);
        } else {
            appStatus.set('unauth');
        };
    }

    onMount(() => {
        checkLocalStorage();
    })

    let status;
    appStatus.subscribe(state => status = state);

    $: console.log(`App status is now: ${status}`);

</script>

<div
    class="app"
    class:dark={$theme === "Dark"}
>
    <slot />
    {#if status === 'auth'}
        <Dashboard {isHidden} {handleHidden} />
    {/if}
</div>

<style>
    .app {
        padding-left: 88px;
    }
    .dark {
        /* ====Colors==== */
        --body-color: #18191a;
        --sidebar-color: #242526;
        --primary-color: #3a3b3c;
        --primary-color-light: #3a3b3c;
        --toggle-color: #fff;
        --text-color: #ccc;
    }
</style>
