<script>
  import { onMount } from "svelte";
  import { error } from "@sveltejs/kit";
  import axios from "axios";
  import dayjs from "dayjs";
  import utc from "dayjs/plugin/utc";
  import { modalStore } from "../../store/modal";

  dayjs.extend(utc);

  // Components
  import { RegistrarPedido } from "$lib/components/elementsRoutes/ventas";
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

  // ENDPOINTS
  // ***DATA MEMBRESIAS***
  let headersMembresias = [
    "ID Pago Membresía",
    "Fecha de Pago",
    "Cantidad de Meses",
    "Metodo de Pago",
    "Miembro || ID",
  ];
  let ventaMembresias = [];


  const addProductToList = (id) => {
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
  };

  onMount(() => {});
</script>

<div class="contend">
  <main class={`${showModal ? "dialog-activate" : ""}`}>
    <h1>VENTAS</h1>
    <div class="contend-ventas">
      <div>
        <div class="titles">
          <h2>Venta Productos</h2>
        </div>
        <label for="">ID del Producto</label>
        <input type="number" bind:value={id_producto} />
        {#if error_mensaje}
          <p>El producto no existe</p>
        {/if}
        <button on:click={() => addProductToList(id_producto)}
          >Añadir Producto</button
        >
        <TablaVentas {headers} data={productos} />
      </div>
      <div>
        <div class="titles">
          <h2>Pago Membresías</h2>
        </div>
        <div>
          <button
            on:click={() =>
              modalStore.set({ showModal: true, component: "RegistrarPedido" })}
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
