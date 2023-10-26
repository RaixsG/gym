<script>
    import Icon from "../img/icon_gym.png";

    // @ts-ignore
    /**
     * @type {any}
     */
     export let handleHidden;
</script>

<header >
    <span class="image-container">
        <img src={Icon} alt="logo" />
    </span>

    <div class="header_text-container">
        <p>PersonalVIP</p>
        <p class="low_space-text">Gymnasio</p>
    </div>

    <!-- svelte-ignore a11y-no-static-element-interactions -->
    <i
        class="bx bx-chevron-right header_arrow"
        on:click={ handleHidden }
        on:keypress={ handleHidden }
    />
</header>

<style>
    /* GENERAL */
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

    /* SIDEBAR HEADER */

    header {
        position: relative;
        display: flex;
    }

    .image-container {
        min-width: 60px;
        display: grid;
        place-items: center;
    }

    img {
        width: 40px;
        border-radius: 20px;
    }

    .header_text-container {
        display: flex;
        flex-direction: column;
    }

    .header_arrow {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        right: -45px;
        height: 25px;
        width: 25px;
        aspect-ratio: 1;
        background: var(--primary-color);
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        color: var(--toggle-color);
        font-size: 22px;
        transition: var(--tran-04);
    }

    .header_arrow:hover {
        cursor: pointer;
        filter: brightness(1.8);
    }

    /* SIDEVAR CLOSED */
    section.hidden header .header_text-container {
        display: none;
    }

    section.hidden header .header_arrow {
        transform: translateY(-50%) rotate(-180deg);
    }

</style>
