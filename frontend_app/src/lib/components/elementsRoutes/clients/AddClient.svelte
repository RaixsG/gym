<script>
    import axios from "axios";
    import { modalStore } from "../../../../store/modal.js";

    const cerrarModal = () => {
        modalStore.set({ showModal: false });
    };

    // ENTRADA DE DATOS
    let nombre = null;
    let apellido = null;
    let direccion = null;
    let telefono = null;
    let email = null;
    let fechaNacimiento = null;

    const url = "http://localhost:3000/api/clientes/create";

    const createClient = () => {
        console.log(fechaNacimiento); // Formato: 2021-09-01
        axios
            .post(url, {
                nombre: nombre,
                apellido: apellido,
                direccion: direccion,
                telefono: telefono,
                email: email,
                fecha_nacimiento: fechaNacimiento,
            })
            .then(res => {
                console.log(res.data);
                console.log('EXITO');
                cerrarModal();
            })
            .catch(err => {
                console.log(JSON.stringify(err));
                alert("Error al agregar cliente");
            });
    };
</script>

<form method="dialog" on:submit={createClient}>
    <h1>Agregar Nuevo Cliente</h1>
    <label>
        Nombre:
        <input
            type="text"
            name="nombre"
            on:change={(e) => (nombre = e.target.value)}
        />
    </label>
    <label>
        Apellido:
        <input
            type="text"
            name="apellido"
            on:change={(e) => (apellido = e.target.value)}
        />
    </label>
    <label>
        Dirección:
        <input
            type="text"
            name="direccion"
            on:change={(e) => (direccion = e.target.value)}
        />
    </label>
    <label>
        Teléfono:
        <input
            type="tel"
            name="telefono"
            on:change={(e) => (telefono = e.target.value)}    
        />
    </label>
    <label>
        Correo electrónico:
        <input
            type="email"
            name="email"
            on:change={(e) => (email = e.target.value)}
        />
    </label>
    <label>
        Fecha de nacimiento:
        <input
            type="date"
            name="fechaNacimiento"
            on:change={(e) => (fechaNacimiento = e.target.value)}    
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
