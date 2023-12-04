<script>
    import axios from "axios";
    import dayjs from "dayjs";
    import { modalStore } from "../../../../store/modal.js";

    export let addHorario;

    const cerrarModal = () => {
        modalStore.set({ showModal: false });
    };

    // ENTRADA DE DATOS
    let horario_inicio = null;
    let horario_fin = null;
    let turno = null;

    
    const createHorario = () => {
        const url = "http://localhost:3000/api/horarios/create";
        axios
            .post(url, {
                hora_inicio: horario_inicio,
                hora_finalizacion: horario_fin,
                turno,
            })
            .then(({ data: response }) => {
                console.log('EXITO');
                addHorario(response);
                cerrarModal();
            })
            .catch(err => {
                console.log(JSON.stringify(err));
            });
    };
</script>

<form method="dialog" on:submit={createHorario}>
    <h1>Agregar Nuevo Horario</h1>
    <label>
        Horario Inicio:
        <input
            type="time"
            on:change={(e) => (horario_inicio = e.target.value)}
        />
    </label>
    <label>
        Horario Fin:
        <input
            type="time"
            on:change={(e) => (horario_fin = e.target.value)}
        />
    </label>
    <label>
        Turno:
        <input
            type="text"
            on:change={(e) => (turno = e.target.value)}
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
