<script>
    import { goto } from "$app/navigation";
    import { appStatus } from "$stores"

    const doLogout = () => {
        console.log("Log Outing");
        localStorage.removeItem("appStatus");
        appStatus.set("unauth");
        goto("/login");
    };
    
</script>

<li>
    <div>
        <i class="bx bx-log-out" />
        <button
            on:click={ doLogout }
            on:keypress={(event) => console.log(event)}
        >
            Logout
        </button>
    </div>
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
    div {
        height: 100%;
        width: 100%;
        display: flex;
        align-items: center;
        text-decoration: none;
        border-radius: 6px;
        cursor: pointer;
        transition: var(--tran-04);
    }

    div:hover {
        background-color: var(--primary-color);
    }

    div:hover button,
    div:hover i {
        color: var(--white);
    }
    /* SIDEVAR CLOSED */
    section.hidden li div button {
        display: none;
    }

</style>