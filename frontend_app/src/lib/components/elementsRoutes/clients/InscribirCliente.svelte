<script>
    import axios from "axios";
    import { modalStore } from "../../../../store/modal.js";
    import { get } from "svelte/store";
    import { onMount } from "svelte";

    const cerrarModal = () => {
        modalStore.set({ showModal: false });
    };

    let data = get(modalStore).data;
    export let recargar;
    
    // ENTRADA DE DATOS
    let clientes = data; //Lista de todos los clientes


    let clienteSeleccionado = null;
    let busqueda = '';

    $: clientesFiltrados = clientes.filter(cliente => {
        return cliente.nombre.toLowerCase().includes(busqueda.toLowerCase());
    });

    
    let fechaSeleccionada = null;
    let horarioSeleccionado = null;
    let membresiaSeleccionada = null;
    
    const createInscripcion = () => {
        let cliente = clientes.find(c => c.id === clienteSeleccionado);
        let horario = dataHorario.find(d => d.id === horarioSeleccionado);
        let membresia = dataMembresias.find(m => m.id === membresiaSeleccionada);

        if (!cliente) {
            alert('No se ha seleccionado un cliente');
            return;
        }

        const url = "http://localhost:3000/api/inscripciones/create";
        const body = {
            fecha_inscripcion: fechaSeleccionada,
            ID_cliente: cliente.id,
            ID_enseña_en: horario.id,
            ID_membresia: membresia.id,
        }
        console.log(JSON.stringify(body))
        axios
            .post(url, body)
            .then(res => {
                console.log('EXITO');
                cerrarModal();
                recargar();
            })
            .catch(err => {
                alert('Error al crear inscripción');
                console.log(JSON.stringify(err));
            });
    };

    // **HORARIO**
    let dataHorario = '';
    const getHorarios = () => {
        const urlHorario = 'http://localhost:3000/api/horarios';
        axios
            .get(urlHorario)
            .then((response) => {
                const filter = response.data;
                dataHorario = filter.map((item) => {
                    let horaInicio = item.hora_inicio;
                    return {
                        id: item.ID_horario,
                        horaInicio,
                        horaFin: item.hora_finalizacion,
                        turno: item.turno,
                    }
                })
            })
            .catch((error) => {
                alert(`Error en la peticion de clientes: ${JSON.stringify(error)}`)
            })
    }

    // ***MEMBRESIAS***
    let dataMembresias = '';
    const getMembresias = () => {
        const urlMembresias = 'http://localhost:3000/api/membresia';
        axios
            .get(urlMembresias)
            .then((response) => {
                const filter = response.data;
                console.log(filter)
                dataMembresias = filter.map((item) => {
                    return {
                        id: item.ID_membresia,
                        nombre: item.nombre_membresia,
                        precio: item.precio,
                        beneficios: item.beneficios,
                    }
                })
            })
            .catch((error) => {
                alert(`Error en la peticion de clientes: ${JSON.stringify(error)}`)
            })
    }

    onMount(() => {
        getHorarios();
        getMembresias();
    })
</script>

<form method="dialog" on:submit={createInscripcion}>
    <h1>Registrando Inscripción</h1>
    <label>
        Buscar Cliente:
        <input 
            type="search"
            bind:value={busqueda}
        />
    </label>
    <label>
        Seleccionar Cliente:
        <select bind:value={clienteSeleccionado}>
            <option value={null} disabled>-- Selecciona un cliente --</option>
            {#each clientesFiltrados as cliente (cliente.id)}
                <option value={cliente.id}>{cliente.nombre}</option>
            {/each}
        </select>
    </label>
    <label>
        Fecha Inscripción:
        <input
            type="date"
            on:change={(e) => (fechaSeleccionada = e.target.value)}
        />
    </label>
    <label>
        Horario:
        <select bind:value={horarioSeleccionado}>
            <option value={null} disabled >-- Seleciona un Horario --</option>
            {#each dataHorario as horario (horario.id) }
                <option value={horario.id}>{horario.turno}</option>
            {/each}
        </select>
    </label>
    <label>
        Membresías: 
        <select bind:value={membresiaSeleccionada}>
            <option value={null} disabled >-- Seleciona una Membresía --</option>
            {#each dataMembresias as membresia (membresia.id) }
                <option value={membresia.id}>{membresia.nombre} || S/.{membresia.precio}</option>
            {/each}
        </select>
    </label>
    <div class="buttons">
        <button type="submit">Inscribir</button>
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

    input[type="search"],
    select,
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

    select:focus {
        background-color: var(--primary-color);
        color: white;
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
