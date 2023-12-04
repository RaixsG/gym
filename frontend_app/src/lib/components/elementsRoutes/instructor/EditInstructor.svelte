<script>
    import axios from 'axios';
    import dayjs from 'dayjs';
    import { get } from 'svelte/store';
    import { modalStore } from '../../../../store/modal.js';

    const cerrarModal = () => {
        modalStore.set({ showModal: false, data: null });
    };

    // Datos a editar
    let user = get(modalStore).data;

    // Endpoint
    const url = `http://localhost:3000/api/instructor/edit/${user.id}`;

    const editInstructor = () => {
        let fechaNacimiento = dayjs(user.fecha_nacimiento).format('YYYY-MM-DD');
        if (user.foto === 'Sin Foto') {
            user.foto = null;
        }

        axios
            .put(url, {
                nombre: user.nombre,
                apellido: user.apellido,
                direccion: user.direccion,
                telefono: user.telefono,
                email: user.correo,
                fecha_nacimiento: fechaNacimiento,
                especializacion: user.especializacion,
                foto_instructor: user.foto,
            })
            .then((res) => {
                alert(res, 'Instructor actualizado Exitosamente');
                cerrarModal();
            })
            .catch((err) => {
                console.log(JSON.stringify(err));
                alert('Error al actualizar Instructor');
            })
    }
</script>

<form method="dialog" on:submit={editInstructor}>
    <h1>Editar Instructor</h1>
    <label>
        Nombre:
        <input
            type="text"
            bind:value={user.nombre}
        />
    </label>
    <label>
        Apellido:
        <input
            type="text"
            bind:value={user.apellido}
        />
    </label>
    <label>
        Dirección:
        <input
            type="text"
            bind:value={user.direccion}
        />
    </label>
    <label>
        Teléfono:
        <input
            type="tel"
            bind:value={user.telefono}
        />
    </label>
    <label>
        Correo electrónico:
        <input
            type="email"
            bind:value={user.correo}
        />
    </label>
    <label>
        Fecha de nacimiento:
        <input
            type="date"
            bind:value={user.fecha_nacimiento}
        />
    </label>
    <label>
        Especialización:
        <input
            type="text"
            bind:value={user.especializacion}
        />
    </label>
    <label>
        Foto:
        <input
            type="file"
            bind:value={user.foto}
        />
    </label>
    <div class="buttons">
        <button type="submit">Confirmar</button>
        <button type="button" on:click={ cerrarModal }>Cancelar</button>
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
