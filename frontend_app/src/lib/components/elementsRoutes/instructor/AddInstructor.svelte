<script>
    import { modalStore } from '../../../../store/modal.js';

    const cerrarModal = () => {
        modalStore.set({ showModal: false });
    };
</script>

<form method="dialog">
    <h1>Nuevo Instructor</h1>
    <label>
        Nombre:
        <input type="text" name="nombre" />
    </label>
    <label>
        Apellido:
        <input type="text" name="apellido" />
    </label>
    <label>
        Dirección:
        <input type="text" name="direccion" />
    </label>
    <label>
        Teléfono:
        <input type="tel" name="telefono" />
    </label>
    <label>
        Correo electrónico:
        <input type="email" name="email" />
    </label>
    <label>
        Fecha de nacimiento:
        <input type="date" name="fechaNacimiento" />
    </label>
    <label>
        Especialización:
        <input type="text" name="especializacion" />
    </label>
    <label>
        Foto:
        <input type="file" name="foto" />
    </label>
    <div class="buttons">
        <button type="submit">Agregar</button>
        <button type="button" on:click={ cerrarModal } >Cancelar</button>
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
    input[type="tel"],
    input[type="email"],
    input[type="date"] {
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
