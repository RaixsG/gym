<script>
    import axios from "axios";
    import { modalStore } from "../../../../store/modal.js";

    const cerrarModal = () => {
        modalStore.set({ showModal: false, data: null });
    };
    export let recargar;

    // ENTRADA DE DATOS
    let producto = {
        nombre: null,
        descripcion: null,
        precio: null,
        cantidadStock: null,
    }

    const url = "http://localhost:3000/api/productos/create";

    const createProducto = () => {
        axios
            .post(url, {
                nombre_producto: producto.nombre,
                descripcion: producto.descripcion,
                precio: producto.precio,
                cantidad_stock: producto.cantidadStock,
            })
            .then(res => {
                console.log('EXITO');
                cerrarModal();
                recargar();
            })
            .catch(err => {
                console.log(JSON.stringify(err));
            });
    };
</script>

<form method="dialog" on:submit={createProducto}>
    <h1>Agregar Nuevo Producto</h1>
    <label>
        Nombre:
        <input
            type="text"
            on:change={(e) => (producto.nombre = e.target.value)}
        />
    </label>
    <label>
        Descripción:
        <input
            type="text"
            on:change={(e) => (producto.descripcion = e.target.value)}
        />
    </label>
    <label>
        Precio:
        <input
            type="number"
            step="0.01"
            on:change={(e) => (producto.precio = e.target.value)}
        />
    </label>
    <label>
        Cantidad Stock:
        <input
            type="number"
            on:change={(e) => (producto.cantidadStock = e.target.value)}    
        />
    </label>
    <div class="buttons">
        <button type="submit">Agregar</button>
        <button type="button" on:click={cerrarModal}>Cancelar</button>
    </div>
</form>

<style>
    form {
        position: relative;
        width: 100%;
        margin: 0 auto;
        background-color: var(--sidebar-color);
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
        transition: var(--tran-02);
        color: var(--text-color);
    }

    h1 {
        text-align: center;
        margin-bottom: 20px;
    }

    label {
        display: block;
        margin-bottom: 10px;
    }

    input[type="text"],
    input[type="number"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    button[type="submit"],
    button[type="button"] {
        color: white;
        border: none;
        border-radius: 5px;
        padding: 10px 15px;
        cursor: pointer;
        color: var(--text-color);
        transition: var(--tran-02);
    }

    button[type="submit"]:hover,
    button[type="button"]:hover {
        background-color: var(--primary-color);
        color: white;
    }

    .buttons {
        display: flex;
        justify-content: space-between;
    }

</style>
