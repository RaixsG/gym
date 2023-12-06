<script>
  import { onMount } from "svelte";
  import * as d3 from "d3";
  import axios from "axios";
  let colors = d3.scaleOrdinal(d3.schemeCategory10);

  const url = "http://localhost:3000/api/ventas/productosMasVendidos";

  // categorias
  let nombresProductos = [];

  // para los datos
  let productos_completos = [];
  let productosMasVendidos = [];

  const getMasVendidos = () => {
    return axios
      .get(url)
      .then((response) => {
        const filter = response.data;
        // console.log(filter);
        productos_completos = filter.map((item) => {
          return item.cantidad;
        });
        // console.log(productos_completos);
        nombresProductos = filter.map((nombres) => {
          return nombres.nombre_producto;
        });
        // console.log(nombresProductos);
        productosMasVendidos = productos_completos.slice();
      })
      .catch((err) => {
        console.log(JSON.stringify(err));
      });
  };

  onMount(async () => {
    await getMasVendidos();

    let pie = d3.pie();
    let arc = d3.arc().innerRadius(0).outerRadius(100);

    let svg = d3
      .select("#graphics")
      .append("svg")
      .attr("width", 100)
      .attr("height", 200)
      .append("g")
      .attr("transform", "translate(100, 100)");

    svg
      .selectAll("path")
      .data(pie(productosMasVendidos))
      .enter()
      .append("path")
      .attr("d", arc)
      .attr("fill", (d, i) => colors(i));

    // Crea un nuevo grupo SVG para la leyenda
    let leyendaSvg = d3
      .select("#leyenda")
      .append("svg")
      .attr("width", 200)
      .attr("height", 200)
      .append("g")
      .attr("transform", "translate(250, 0)");

    // Crea la leyenda
    let leyenda = leyendaSvg
      .selectAll("#leyenda")
      .data(nombresProductos)
      .enter()
      .append("g")
      .attr("class", "leyenda")
      .attr("transform", (d, i) => "translate(0," + i * 20 + ")");

    leyenda
      .append("rect")
      .attr("width", 18)
      .attr("height", 18)
      .style("fill", (d, i) => colors(i));

    leyenda
      .append("text")
      .attr("x", 24)
      .attr("y", 9)
      .attr("dy", ".35em")
      .text((d) => d);
  });
</script>

<div>

  <div id="graphics"></div>
  <div id="leyenda"></div>
</div>

<style>
  div {
    position: relative;
    width: 100%;
    display: grid;
    
  }
  #graphics {
    /* background-color: transparent; */
    position: absolute;
    top: 0;
    left: 0;
  }
  #leyenda {
    /* background-color: transparent; */
    position: absolute;
    top: 0;
    left: 50px;
  }
</style>