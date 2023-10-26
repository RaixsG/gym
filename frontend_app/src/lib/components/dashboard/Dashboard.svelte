<script>
    //Imports
    import {
        Header,
        Search,
        ListSections,
        Logout,
        Mode,
    } from "./elements";
    export let isHidden;
    export let handleHidden;
</script>

<!--HTML-->
<button
    class={`background ${!isHidden ? "background-active" : ""}`}
    on:click={handleHidden}
/>
<section class={`${!isHidden ? "" : "hidden"}`}>
    <Header {handleHidden} />
    <nav class="menu-container">
        <div>
            <Search />
            <ListSections />
        </div>
        <div>
            <Logout />
            <Mode />
        </div>
    </nav>
</section>

<style>
    /* SIDEBAR GENERAL */
    section {
        height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 30;
        height: 100%;
        width: 250px;
        padding: 10px 14px;
        background: var(--sidebar-color);
        transition: var(--tran-05);
    }

    .background {
        position: absolute;
        width: 100vw;
        height: 100vh;
        left: 0;
        top: 0;
        z-index: 20;
        background-color: transparent;
        pointer-events: none;
        transition: background-color .2s;
    }

    .background-active {
        background-color: #00000050;
        pointer-events: all;
    }

    /* SIDEBAR MENU */
    .menu-container {
        height: calc(100% - 85px);
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        margin-top: 40px;
    }
    
    /* SIDEVAR CLOSED */
    section.hidden {
        width: 88px;
    }
    
</style>
