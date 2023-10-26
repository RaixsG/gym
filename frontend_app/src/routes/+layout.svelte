<script>
    import { theme } from "../store/theme";
    import "../styles.css";
    import Dashboard from "$lib/components/dashboard/Dashboard.svelte";

    let isHidden = false;
    const handleHidden = () => isHidden = !isHidden;
</script>

<div
    class="app"
    class:dark={$theme === "Dark"}
>
    <slot />
    <Dashboard {isHidden} {handleHidden} />
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
