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
    import {
        EditMiembros,
    } from "$lib/components/elementsRoutes/miembros";
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
        "ID",
        "Miembro",
        "Teléfono",
        "Horario",
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
      axios
        .get(url)
        .then((response) => {
            const filter = response.data;
            let precioMensual = filter.dataMiembro.membresias.precio;
            let cantidad = filter.pagos.map((item) => {
                return item.cantidad;
            })
            let precioTotal = parseFloat(precioMensual) * cantidad[0];

            let estado_inscripcion = filter.pagos.map((item) => {
                return item.miembros.estado_inscripcion;
            });

            if (estado_inscripcion[0] === true) {
                estado_inscripcion[0] = "Activo";
            } else if (estado_inscripcion[0] === false) {
                estado_inscripcion[0] = "Inactivo";
            }

            data = [{
                id: filter.dataMiembro.ID_miembro,
                miembro: `${filter.dataMiembro.clientes.nombre} ${filter.dataMiembro.clientes.apellido}`,
                telefono: filter.dataMiembro.clientes.telefono,
                horario: filter.horario.turno,
                membresia: filter.dataMiembro.membresias.nombre_membresia,
                precioMensual: filter.dataMiembro.membresias.precio,
                pagoTotal: precioTotal,
                fecha_inscripcion: dayjs(filter.inscripcion.map((item) => {return item.fecha_inscripcion})).format("DD/MM/YYYY"),
                fecha_vencimiento: dayjs(filter.pagos.map((item) => {
                    return item.miembros.fecha_vencimiento;
                })).format("DD/MM/YYYY"),
                estado_inscripcion: estado_inscripcion[0],
            }];
        })
    }

    const generateReport = (months) => {
        const filteredData = data.filter(item => {
            const fecha_inscripcion = new Date(item.fecha_inscripcion);
            const endDate = new Date();
            endDate.setMonth(endDate.getMonth() - months);
            return fecha_inscripcion >= endDate;
        });

        const doc = new jsPDF();
        doc.text('Reporte de pago de Membresias', 10, 10);
        autoTable(doc, {
            startY: 20,
            body: filteredData.map(item => [
                item.id,
                item.miembro,
                item.telefono,
                item.horario,
                item.membresia,
                item.precioMensual,
                item.pagoTotal,
                item.fecha_inscripcion,
                item.fecha_vencimiento,
                item.estado_inscripcion
            ]),
            columns: [
                { header: 'ID', dataKey: 'id' },
                { header: 'Miembro', dataKey: 'miembro' },
                { header: 'Telefono', dataKey: 'telefono' },
                { header: 'Horario', dataKey: 'horario' },
                { header: 'Membresia', dataKey: 'membresia' },
                { header: 'Precio Mensual', dataKey: 'precioMensual' },
                { header: 'Pago Total', dataKey: 'pagoTotal' },
                { header: 'Fecha Inscripcion', dataKey: 'fecha_inscripcion' },
                { header: 'Fecha Vencimiento', dataKey: 'fecha_vencimiento' },
                { header: 'Estado Inscripcion', dataKey: 'estado_inscripcion' }
            ]
        });
        doc.save(`reporte_${months}_meses.pdf`);
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
                <button on:click={() => generateReport(1)}>Reporte último mes</button>
                <button on:click={() => generateReport(6)}>Reporte últimos 6 meses</button>
                <button on:click={() => generateReport(12)}>Reporte anual</button>
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
