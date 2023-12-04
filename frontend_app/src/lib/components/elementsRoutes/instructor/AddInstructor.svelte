<script>
    import axios from "axios";
    import { modalStore } from "../../../../store/modal.js";

    export let addInstructor;

    const cerrarModal = () => {
        modalStore.set({ showModal: false });
    };

    // ENTRADA DE DATOS
    let form = {
        nombre: null,
        apellido: null,
        direccion: null,
        telefono: null,
        email: null,
        fecha_nacimiento: null,
        especializacion: null,
        foto_instructor: null,
    }

    const url = "http://localhost:3000/api/instructores/create";

    const createInstructor = () => {
        axios
            .post(url, form)
            .then((res) => {
                const newUserData = {
                    id: res.data.ID_instructor,
                    nombre: res.data.nombre,
                    apellido: res.data.apellido,
                    direccion: res.data.direccion,
                    telefono: res.data.telefono,
                    email: res.data.email,
                    fecha_nacimiento: res.data.fecha_nacimiento,
                    especializacion: res.data.especializacion,
                    foto: res.data.foto_instructor,
                }
                addInstructor(newUserData);
                console.log("EXITO");
                cerrarModal();
            })
            .catch((err) => {
                console.log(JSON.stringify(err));
            });
    };
</script>

<form method="dialog" on:submit={createInstructor}>
    <h1>Nuevo Instructor</h1>
    <label>
        Nombre:
        <input
            type="text"
            name="nombre"
            on:change={(e) => (form.nombre = e.target.value)}
        />
    </label>
    <label>
        Apellido:
        <input
            type="text"
            name="apellido"
            on:change={(e) => (form.apellido = e.target.value)}
        />
    </label>
    <label>
        Dirección:
        <input
            type="text"
            name="direccion"
            on:change={(e) => (form.direccion = e.target.value)}
        />
    </label>
    <label>
        Teléfono:
        <input
            type="tel"
            name="telefono"
            on:change={(e) => (form.telefono = e.target.value)}
        />
    </label>
    <label>
        Correo electrónico:
        <input
            type="email"
            name="email"
            on:change={(e) => (form.email = e.target.value)}
        />
    </label>
    <label>
        Fecha de nacimiento:
        <input
            type="date"
            name="fechaNacimiento"
            on:change={(e) => (form.fecha_nacimiento = e.target.value)}
        />
    </label>
    <label>
        Especialización:
        <input
            type="text"
            name="especializacion"
            on:change={(e) => (form.especializacion = e.target.value)}
        />
    </label>
    <label>
        Foto:
        <input
            type="file"
            name="foto"
            on:change={(e) => (form.foto_instructor = e.target.value)}
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
