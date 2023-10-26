<script>
</script>

<form>
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
    <button type="submit">Enviar</button>
</form>

<style>
    form {
        width: 50%;
        margin: 0 auto;
        background-color: var(--sidebar-color);
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
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

    button[type="submit"] {
        /* background-color: var(--primary-color); */
        color: white;
        border: none;
        border-radius: 5px;
        padding: 10px 15px;
        cursor: pointer;
        color: var(--text-color);
        transition: var(--tran-02);
    }

    button[type="submit"]:hover {
        background-color: var(--primary-color);
        color: white;
    }
</style>
