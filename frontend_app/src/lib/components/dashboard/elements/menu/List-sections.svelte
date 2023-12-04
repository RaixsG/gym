<ul>
    <li>
        <a href="/">
            <i class="bx bx-home-smile" />
            <p class="text nav-text">Inicio</p>
        </a>
    </li>
    <li>
        <a href="/clients">
            <i class='bx bx-user' ></i>
            <p class="text nav-text">Clientes</p>
        </a>
    </li>
    <li>
        <a href="/instructor">
            <i class='bx bx-user-pin' ></i>
            <p class="text nav-text">Instructores</p>
        </a>
    </li>
    <li>
        <a href="/ventas">
            <i class='bx bx-shopping-bag' ></i>
            <p class="text nav-text">Ventas</p>
        </a>
    </li>
    <li>
        <a href="/membresias">
            <i class='bx bx-id-card' ></i>
            <p class="text nav-text">Tipos de Membresias</p>
        </a>
    </li>
    <li>
        <a href="/producto">
            <i class='bx bx-purchase-tag-alt' ></i>
            <p class="text nav-text">Productos</p>
        </a>
    </li>
    <li>
        <a href="/horarios">
            <i class='bx bx-calendar-plus' ></i>
            <p class="text nav-text">Horarios</p>
        </a>
    </li>
    <li>
        <a href="/miembros">
            <i class='bx bx-calendar-event' ></i>
            <p class="text nav-text">Horarios de Miembros</p>
        </a>
    </li>
</ul>

<style>
    /* SIDEBAR GENERAL */
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
        font-family: var(--fonts);
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

    a:hover p,
    a:hover i {
        color: var(--white);
    }

    /* SIDEVAR CLOSED */
    section.hidden .menu-container ul li a p{
        display: none;
    }

</style>