<script>
    import { get } from 'svelte/store';
    import { modalStore } from '../../../../store/modal.js';
    import axios from 'axios';

    const cerrarModal = () => {
        modalStore.set({ showModal: false, data: null });
    };
    export let recargar;

    // Datos a editar
    let productos = get(modalStore).data;

    // endpoint
    const editarProducto = () => {
        const url = `http://localhost:3000/api/productos/edit/${productos.id}`;
        axios
            .put(url, {
                nombre_producto: productos.nombre_producto,
                descripcion: productos.descripcion,
                precio: productos.precio,
                cantidad_stock: productos.cantidad
            })
            .then((res) => {
                alert('Producto actualizado correctamente')
                cerrarModal();
                recargar();
            })
            .catch((err) => {
                console.log(JSON.stringify(err));
                alert('Error al actualizar producto');
            })
    }

</script>

<form method="dialog" on:submit={editarProducto}>
    <h1>Editar valores de Producto</h1>
    <label>
        Nombre:
        <input
            type="text"
            bind:value={productos.nombre_producto}
        />
    </label>
    <label>
        Descripción:
        <input
            type="text"
            bind:value={productos.descripcion}
        />
    </label>
    <label>
        Precio:
        <input
            type="number"
            min="0"
            step="0.01"
            bind:value={productos.precio}
        />
    </label>
    <label>
        Cantidad Stock:
        <input
            type="number"
            min="0"
            bind:value={productos.cantidad}    
        />
    </label>
    <div class="buttons">
        <button type="submit">Agregar</button>
        <button type="button" on:click={cerrarModal}>Cancelar</button>
    </div>
</form>

<style>
    form {
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
