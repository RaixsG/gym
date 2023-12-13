<script>
    import { get } from 'svelte/store';
    import { modalStore } from '../../../../store/modal.js';
    import axios from 'axios';

    const cerrarModal = () => {
        modalStore.set({ showModal: false, data: null });
    };

    // Datos a editar
    let user = get(modalStore).data;

    // Endpoint
    
    const editarCliente = () => {
        const url = `http://localhost:3000/api/horarios/edit/${user.id}`;
        axios
            .put(url, {
                hora_inicio: user.inicio,
                hora_finalizacion: user.fin,
                turno: user.turno,
            })
            .then((res) => {
                alert('Cliente actualizado exitosamente');
                cerrarModal();
            })
            .catch((err) => {
                console.log(JSON.stringify(err));
                alert('Error al actualizar cliente');
            });
    };
</script>

<form method="dialog" on:submit={editarCliente}>
    <h1>Editar Horario</h1>
    <label>
        Hora Inicio:
        <input 
            type="time"
            bind:value={user.inicio}
        />
    </label>
    <label>
        Hora Fin:
        <input 
            type="time"
            bind:value={user.fin}
        />
    </label>
    <label>
        Turno:
        <input 
            type="text"
            bind:value={user.turno}
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
    input[type="time"] {
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
