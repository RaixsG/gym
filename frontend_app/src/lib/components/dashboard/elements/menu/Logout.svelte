<li>
    <a href="#">
        <i class="bx bx-log-out" />
        <button
            on:click={() => {
                console.log("Log out");
            }}
            on:keypress={(event) => console.log(event)}
        >
            Logout
        </button>
    </a>
</li>

<style>
    button {
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
    button {
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
    a {
        height: 100%;
        width: 100%;
        display: flex;
        align-items: center;
        text-decoration: none;
        border-radius: 6px;
        transition: var(--tran-04);
    }

    a:hover {
        background-color: var(--primary-color);
    }

    a:hover button,
    a:hover i {
        color: var(--white);
    }
    /* SIDEVAR CLOSED */
    section.hidden li a button {
        display: none;
    }

</style>