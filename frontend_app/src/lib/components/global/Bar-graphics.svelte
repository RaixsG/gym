<script>
    import axios from "axios";
    import dayjs from "dayjs";

    let meses = [
        "Enero",
        "Febrero",
        "Marzo",
        "Abril",
        "Mayo",
        "Junio",
        "Julio",
        "Agosto",
        "Septiempre",
        "Octubre",
        "Noviembre",
        "Diciembre",
    ];

    let colores = [
        "red",
        "orange",
        "yellow",
        "green",
        "blue",
        "indigo",
        "violet",
        "pink",
        "brown",
        "gray",
        "black",
        "white",
    ];

    let data = [];

    const getInscripcionesUltimoMes = async () => {
        try {
            const response = await axios.get(
                "http://localhost:3000/api/inscripciones/miembros",
            );
            data = response.data.map((item) => {
                return {
                    fecha: dayjs(
                        item.inscripciones[0].fecha_inscripcion,
                    ).format("DD/MM/YYYY"),
                };
            });
        } catch (error) {
            console.log(
                `Error en la peticion de inscripciones: ${JSON.stringify(
                    error,
                )}`,
            );
        }
    };

    getInscripcionesUltimoMes().then(() => {
        let conteoMeses = Array(12).fill(0); //
        // console.log(conteoMeses);
        data.forEach((item) => {
            let partesFecha = item.fecha.split("/"); // Separar la fecha de registro en partes
            // console.log(partesFecha)
            let fechaRegistro = new Date(
                partesFecha[2],
                partesFecha[1] - 1,
                partesFecha[0],
            ); // Crear un objeto Date a partir de la fecha de registro
            // console.log(fechaRegistro);
            let mes = fechaRegistro.getMonth(); // Obtener el mes (0-11) de la fecha de registro
            // console.log(mes);
            conteoMeses[mes]++; // Incrementar el conteo de clientes en el mes correspondiente
            // console.log(conteoMeses)
        });

        return (data_length = meses.map((mes, i) => ({
            mes,
            count: conteoMeses[i],
        }))); // Crear el array data_length a partir de los conteos de meses
    });

    let data_length = [];
</script>

{#each data_length as item, i (item.mes)}
    <div
        class="bar"
        style="width: {item.count}%; background-color: {colores[
            i % colores.length
        ]}"
        title="{item.mes}: {item.count}"
    >
        <div>{item.mes}</div>
    </div>
{/each}

<style>
    .bar {
        width: 100%;
        height: 30px;
        border: 1px solid var(--text-color);
        box-sizing: border-box;
        position: relative;
        margin-bottom: 5px;

        /* Texto */
        color: var(--text-color);
        display: flex;
        align-items: center;
        font-weight: bold;
        font-size: 18px;
        white-space: nowrap; /* Evita que el texto se envuelva a la línea siguiente */
        /* overflow: hidden; Evita que el texto se desborde */
    }

    .bar::before {
        content: "";
        display: block;
        position: absolute;
        top: 0;
        left: 0;
        height: 100%;
        background-color: lightblue;
        display: none;
    }
</style>
