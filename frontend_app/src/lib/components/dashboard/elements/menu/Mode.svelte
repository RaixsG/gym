<script>
    import { theme } from '../../../../../store/theme';

    function toggleTheme() {
        // Cambia el valor del store a 'dark' si es 'light', y viceversa
        theme.update(value => value === 'Light' ? 'Dark' : 'Light');
    }

</script>

<li class="theme_selector-container">
    <div class="theme_icon-container">
        {#if $theme === "Dark"}
            <i class="bx bx-moon theme_icon moon" />
        {:else}
            <i class="bx bx-sun theme_icon sun" />
        {/if}
    </div>
    {#if $theme === "Dark"}
        <p>Dark Mode</p>
    {:else}
        <p>Light Mode</p>
    {/if}
    <button class="theme_switch-container">
        <!-- svelte-ignore a11y-click-events-have-key-events -->
        <!-- svelte-ignore a11y-no-static-element-interactions -->
        <span
            class="theme_switch"
            class:theme_switch-on = { $theme === "Dark"}
            on:click={ toggleTheme }
        />
    </button>
</li>

<style>
    /* SIDEBAR GENERAL */
    p {
        font-size: 17px;
        font-weight: 500;
        white-space: nowrap;
        opacity: 1;
        font-family: var(--fonts);
    }

    i {
        display: grid;
        place-items: center;
        font-size: 20px;
        margin-right: 20px;
        margin-left: 20px;
    }

    i,
    p {
        color: var(--text-color);
        transition: var(--tran-02);
    }

    li {
        height: 50px;
        margin-top: 10px;
        list-style: none;
        display: flex;
        align-items: center;
    }

    /* SIDEBAR BOTTOM OPTIONS */
    .theme_selector-container {
        position: relative;
        margin-bottom: 10px;
        border-radius: 6px;
        background-color: var(--primary-color-light);
        cursor: default;
    }

    .theme_icon-container {
        position: relative;
        width: 60px;
        height: 60px;
        display: flex;
        align-items: center;
    }

    .theme_icon {
        position: absolute;
        left: 0;
    }

    .sun {
        opacity: 1;
    }

    .theme_switch-container {
        position: absolute;
        right: 8px;
        width: 44px;
        height: 22px;
        border-radius: 25px;
        background-color: var(--toggle-color);
        margin-left: 15px;
        cursor: pointer;
    }

    .theme_switch {
        content: "";
        position: absolute;
        width: 15px;
        height: 15px;
        border-radius: 50%;
        top: 50%;
        left: 5px;
        transform: translateY(-50%);
        background-color: var(--primary-color);
        transition: var(--tran-03);
    }

    /* SIDEBAR DARK MODE */
    section.Dark li .theme_icon-container i .moon {
        opacity: 1;
    }

    section.Dark li .theme_icon-container i .sun {
        opacity: 0;
    }

    .theme_switch-on {
        left: 25px;
    }

    /* SIDEVAR CLOSED */
    section.hidden li p {
        display: none;
    }
    
    section.hidden li p {
        opacity: 1;
    }

</style>
