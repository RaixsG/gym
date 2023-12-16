<script>
    import { onMount } from "svelte";
    import { error } from "@sveltejs/kit";
    import axios from "axios";
    import dayjs from "dayjs";
    import utc from "dayjs/plugin/utc";
    import { modalStore } from "../../store/modal";
    import jsPDF from "jspdf";
    import autoTable from "jspdf-autotable";

    dayjs.extend(utc);

    // Components
    import { EditMiembros } from "$lib/components/elementsRoutes/miembros";
    import Tabla from "$lib/components/global/table/Tabla.svelte";

    // Protected route
    let status;
    export function load(e) {
        if (status === "unauth") {
            return error(401, "Unauthorized");
        }
    }

    // **Modal**
    let showModal = false;
    let component = null;
    modalStore.subscribe((state) => {
        showModal = state.showModal;
        component = state.component;
    });

    let headers = [
        "ID Pago",
        "ID Miembro",
        "Teléfono",
        "Membresía",
        "Precio Unitario Mensual",
        "Pago Total",
        "Fecha de Inscripción",
        "Fecha de Vencimiento",
        "Estado de Inscripción",
    ];

    // ENDPOINTS
    // get pago de las membresias
    let data = [];
    const getPagoMembresias = () => {
        const url = "http://localhost:3000/api/membresias/pagadas";
        axios.get(url).then((response) => {
            const filter = response.data;
            const datosPago = filter.pagos;
            const datosInscripcion = filter.inscripcion;
            const datosMembresias = filter.membresias;
            const datosClientes = filter.clientes;

            let clientesConPago = datosPago.map((item) => {
                return item.miembros.ID_cliente;
            });
            let telefonos = datosClientes
                .filter(cliente => clientesConPago.includes(cliente.ID_cliente))
                .map(cliente => {
                    return {
                        id: cliente.ID_cliente,
                        telefono: cliente.telefono
                    }
                });

            let membresias = datosPago
                .map(pago => datosMembresias.find(membresia => membresia.ID_membresia === pago.miembros.ID_membresia))
                .filter(Boolean)
                .map(membresia => {
                    return {
                        id: membresia.ID_membresia,
                        nombre_membresia: membresia.nombre_membresia,
                        precio: membresia.precio
                    };
                });

            let estado_inscripcion = filter.pagos.map((item) => {
                return item.miembros.estado_inscripcion;
            });

            if (estado_inscripcion[0] === true) {
                estado_inscripcion[0] = "Activo";
            } else if (estado_inscripcion[0] === false) {
                estado_inscripcion[0] = "Inactivo";
            }

            data = datosPago.map((item) => {
                let membresia = membresias.find(membresia => membresia.id === item.miembros.ID_membresia);
                let cantidad = item.cantidad || 0;
                let precioTotal = membresia ? membresia.precio * cantidad : 'N/A';
                let inscripcion = datosInscripcion.find(inscripcion => inscripcion.ID_cliente === item.miembros.ID_cliente);
                let fecha_inscripcion = inscripcion ? dayjs(inscripcion.fecha_inscripcion).format("DD-MM-YYYY") : 'N/A';
                return {
                    id: item.ID_pago_mem,
                    miembro: item.ID_miembro,
                    telefono: telefonos.find(cliente => cliente.id === item.miembros.ID_cliente).telefono,
                    membresias: membresias.find(membresia => membresia.id === item.miembros.ID_membresia).nombre_membresia,
                    precioUnitario: membresias.find(membresia => membresia.id === item.miembros.ID_membresia).precio,
                    precioMensual: precioTotal,
                    fecha_inscripcion: fecha_inscripcion,
                    fecha_vencimiento: dayjs(item.miembros.fecha_vencimiento).format("DD-MM-YYYY"),
                    estado_inscripcion: estado_inscripcion[0],
                };
            });
        });
    };

    const generateReport = () => {
        const doc = new jsPDF();
        doc.text("Reporte de pago de Membresias", 10, 10);
        autoTable(doc, {
            startY: 20,
            body: data.map((item) => [
                item.id,
                item.miembro,
                item.telefono,
                item.membresias,
                item.precioUnitario,
                item.precioMensual,
                item.fecha_inscripcion,
                item.fecha_vencimiento,
                item.estado_inscripcion,
            ]),
            columns: [
                { header: "ID", dataKey: "id" },
                { header: "Miembro", dataKey: "miembro" },
                { header: "Telefono", dataKey: "telefono" },
                { header: "Membresia", dataKey: "membresia" },
                { header: "Precio Mensual", dataKey: "precioUnitario" },
                { header: "Pago Total", dataKey: "precioMensual" },
                { header: "Fecha Inscripcion", dataKey: "fecha_inscripcion" },
                { header: "Fecha Vencimiento", dataKey: "fecha_vencimiento" },
                { header: "Estado Inscripcion", dataKey: "estado_inscripcion" },
            ],
        });
        doc.save(`reporte_completo.pdf`);
    };

    onMount(() => {
        getPagoMembresias();
    });
</script>

<div class="contend">
    <article class={`${showModal ? "dialog-activate" : ""}`}>
        <h1>Miembros</h1>
        <section class="contend-table">
            <div class="buttons">
                <button on:click={() => generateReport()}
                    >Reporte</button
                >
            </div>
            <Tabla {headers} {data} />
        </section>
    </article>
    {#if showModal}
        <dialog>
            {#if component === "EditClient"}
                <EditMiembros />
            {/if}
        </dialog>
    {/if}
</div>

<style>
    .contend {
        z-index: -1;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;

        top: 0;
        left: 0;

        width: 100%;
        height: 100vh;
        max-height: 100%;

        /* background-color: var(--sidebar-color); */
        color: var(--text-color);
    }

    article {
        width: 90%;
        height: 100%;
    }

    h1 {
        display: flex;
        justify-content: center;
        padding-top: 20px;
        padding-bottom: 20px;

        font-size: 2rem;
    }

    .contend-table {
        position: relative;
        display: flex;
        flex-direction: column;

        /* height: 500px; */
    }

    .button-add {
        width: 150px;
        display: flex;
        justify-content: flex-start;
    }

    dialog {
        position: absolute;
        z-index: 1;
        top: 15%;
        left: 50%;
        transform: translateX(-50%);

        display: flex;
        flex-direction: column;
        border-radius: 5px;

        background-color: var(--sidebar-color);
    }

    .dialog-activate {
        filter: blur(5px);
    }

    button {
        margin: 10px;
        padding: 5px;
        border-radius: 5px;
        color: var(--text-color);
        cursor: pointer;
    }

    button:hover {
        background-color: var(--primary-color);
        color: white;
    }

    button:disabled {
        background-color: var(--text-color);
        cursor: default;
    }

    .buttons {
        display: flex;
        flex-direction: row;
    }
</style>
