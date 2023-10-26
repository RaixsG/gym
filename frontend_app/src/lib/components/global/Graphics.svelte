<script>
    import { onMount } from 'svelte';
    import * as d3 from 'd3';
  
    let data = [10, 20, 30, 40, 50, 60];
    let colors = d3.scaleOrdinal(d3.schemeCategory10);
  
    onMount(() => {
      let pie = d3.pie();
      let arc = d3.arc().innerRadius(0).outerRadius(100);
  
      let svg = d3.select("#graphics")
        .append("svg")
        .attr("width", 200)
        .attr("height", 200)
        .append("g")
        .attr("transform", "translate(100, 100)");
  
      svg.selectAll("path")
        .data(pie(data))
        .enter()
        .append("path")
        .attr("d", arc)
        .attr("fill", (d, i) => colors(i));
    });
  </script>
  
  <div id="graphics"></div>
  