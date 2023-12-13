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
    RegistrarPedido,
    PagoMembresia,
  } from "$lib/components/elementsRoutes/ventas";
  import TablaActions from "$lib/components/global/table-actions/TablaActions.svelte";
  import TablaVentas from "$lib/components/global/table-ventas/TablaVentas.svelte";

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

  // Error
  let error_mensaje = false;

  // Almacenamiento de productos
  // Headers
  let headers = [
    "ID Producto",
    "Nombre de producto",
    "Descripción",
    "Precio",
    "Cantidad Stock",
  ];
  let id_producto;
  let productos = [];

  function deleteProduct (id) {
    productos = productos.filter((item) => item.id !== id);
  };

  // ENDPOINTS
  // ***DATA MEMBRESIAS***
  let headersMembresias = [
    "ID Pago Membresía",
    "Fecha de Pago",
    "Cantidad de Meses",
    "Metodo de Pago",
    "Miembro",
    "ID Miembro",
  ];
  let ventaMembresias = [];

  // Todos las membresias pagadas
  function getMembresiasPagadas () {
    const url = "http://localhost:3000/api/membresias/pagadas";
    axios
      .get(url)
      .then((response) => {
        const filter = response.data;
        const datosPago = filter.pagos;
        const nombresMiembros = filter.dataMiembro;
        ventaMembresias = datosPago.map((item) => {
          return {
            id: item.ID_pago_mem,
            fecha: dayjs.utc(item.fecha_pago).format("DD/MM/YYYY"),
            cantidad: item.cantidad,
            metodo_pago: item.metodo_pago,
            miembro: nombresMiembros.clientes.nombre,
            id_miembro: datosPago.map((item) => item.ID_miembro),
          };
        });
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const addProductToList = (id) => {
    if (id) {
      const url = `http://localhost:3000/api/productos/${id}`;
      axios
        .get(url)
        .then(({ data: response }) => {
          console.log(response);
          productos = [...productos, response];
        })
        .catch((error) => {
          console.log(error);
          error_mensaje = true;
          setTimeout(() => (error_mensaje = false), 4000);
        });
        return;
    }
    alert("Ingrese un ID de producto");
  };

  // Miembros
  let miembros = [];
  const getMiembros = () => {
    const url = "http://localhost:3000/api/inscripciones/miembros";
    axios
      .get(url)
      .then((response) => {
        const filter = response.data;
        miembros = filter.map((item) => {
          return {
            id: item.miembros[0].ID_miembro,
            nombre: item.nombre,
          };
        });
      })
      .catch((error) => {
        console.log(error);
      });
  };

  // TABLA DATOS PRODUCTOS VENDIDOS
  let salesData = [];
  const getSalesData = () => {
    const url = "http://localhost:3000/api/ventas/dinamic";
    axios
      .get(url)
      .then(({ data: response }) => {
        salesData = response.recibe.map(item => ({
          sale: item
        }));
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const generateReport = () => {
    const doc = new jsPDF();
    const fecha = dayjs().format("DD/MM/YYYY");
    const hora = dayjs().format("HH:mm:ss");
    const fechaHora = fecha + " " + hora;
    const columns = [
      { header: "ID Venta", dataKey: "id" },
      { header: "Nombre Producto", dataKey: "nombre" },
      { header: "Precio", dataKey: "precio" },
      { header: "Cantidad", dataKey: "cantidad_stock" },
      { header: "Precio Total", dataKey: "total"},
      { header: "Fecha", dataKey: "fecha"},
      { header: "Metodo de Pago", dataKey: "metodo_pago"},
      { header: "ID Cliente", dataKey: "id_cliente"}
    ];
    const rows = salesData.map((item) => {
      return {
        id: item.sale.id_venta,
        nombre: item.sale.nombre_producto,
        precio: item.sale.precio,
        cantidad_stock: item.sale.cantidad,
        total: item.sale.precio_total,
        fecha: dayjs.utc(item.sale.fecha_pago).format("DD/MM/YYYY"),
        metodo_pago: item.sale.metodo_pago,
        id_cliente: item.sale.id_cliente
      };
    });
    doc.text("Reporte de ventas", 14, 15);
    doc.text(fechaHora, 14, 23);
    autoTable(doc, { columns, body: rows, startY: 30 });
    doc.save("reporte-ventas.pdf");
  };

  onMount(() => {
    getMembresiasPagadas();
    getMiembros();
    getSalesData();
  });
</script>

<div class="contend">
  <main class={`${showModal ? "dialog-activate" : ""}`}>
    <h1>VENTAS</h1>
    <div class="contend-ventas">
      <div>
        <div class="titles">
          <h2>Venta Productos</h2>
          <div class="buttons">
            <button on:click={() => generateReport()}
              >Reporte</button
            >
          </div>
        </div>
        <label for="">ID del Producto</label>
        <input required type="number" bind:value={id_producto} />
        {#if error_mensaje}
          <p>El producto no existe</p>
        {/if}
        <button on:click={() => addProductToList(id_producto)}
          >Añadir Producto</button
        >
        <TablaVentas {deleteProduct} {headers} data={productos} />
      </div>
      <div>
        <div class="titles">
          <h2>Pago Membresías</h2>
        </div>
        <div>
          <button
            on:click={() =>
              modalStore.set({
                showModal: true,
                component: "PagoMembresia",
                data: miembros,
              })}
          >
            Pagar Membresía
          </button>
        </div>
        <TablaActions headers={headersMembresias} data={ventaMembresias} />
      </div>
    </div>
  </main>
  {#if component === "RegistrarPedido"}
    <dialog>
      <RegistrarPedido />
    </dialog>
  {:else if component === "PagoMembresia"}
    <dialog>
      <PagoMembresia />
    </dialog>
  {/if}
</div>

<style>
  .contend {
    z-index: -1;
    padding: 0px 50px 0px 50px;

    top: 0;
    left: 0;

    width: 100%;
    height: 100vh;
    max-height: 100%;

    /* background-color: var(--sidebar-color); */
    color: var(--text-color);
  }

  .contend-ventas {
    padding-top: 15px;

    display: flex;
    flex-direction: column;
    gap: 20px;
  }

  h1 {
    display: flex;
    justify-content: center;
    padding-top: 20px;

    font-size: 2rem;
  }

  h2 {
    font-size: 1.5rem;
  }

  .buttons {
    display: grid;
  }

  .contend-table {
    position: relative;
    display: flex;
    flex-direction: column;

    height: 500px;
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

  input {
    padding: 10px;
    border: 1px solid var(--toggle-color);
    border-radius: 5px;
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
</style>
