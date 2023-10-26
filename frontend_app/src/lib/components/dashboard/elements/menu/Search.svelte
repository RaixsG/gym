<div class="search-container">
    <input type="search" placeholder="Search" />
    <i class="bx bx-search search-icon" />
</div>

<style>
    i {
        display: grid;
        place-items: center;
        font-size: 20px;
        margin-right: 20px;
        margin-left: 20px;
    }

    i {
        color: var(--text-color);
        transition: var(--tran-02);
    }

    /* SIDEBAR MENU */
    .search-container {
        position: relative;
        background-color: var(--primary-color-light);
        border-radius: 6px;
        height: 50px;
        padding: 0 20px;
    }

    /* SEARCH */
    input {
        height: 100%;
        width: 100%;
        outline: none;
        border: none;
        border-radius: 6px;
        background-color: var(--primary-color-light);
        color: var(--text-color);
        font-size: 17px;
        font-family: var(--fonts);
    }

    .search-icon {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        right: -10px;
        cursor: pointer;
        padding: 10px;
        border-radius: 6px;
    }

    .search-icon:hover {
        background-color: var(--sidebar-color);
    }

    /* SIDEVAR CLOSED */
    section.hidden .search-container input {
        display: none;
    }

</style>