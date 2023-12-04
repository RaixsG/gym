import express from 'express'; // Importamos express
import cors from 'cors'; // Importamos cors
// Import Routes
import clientesRoutes from './routes/clientes/clientes.routes.js';
import instructoresRoutes from './routes/instructores/instructores.routes.js';
import loginRoutes from './routes/login/login.routes.js';
import productoRoutes from './routes/productos/productos.routes.js';
import membresiaRoute from './routes/membresia/membresia.routes.js'
import horarioRoute from './routes/horarios/horarios.routes.js';
import ventasRoutes from './routes/ventas/ventas.routes.js';
import inscripcionesRoutes from './routes/inscripciones/inscripciones.routes.js';
import horarioInstructoresRoutes from './routes/enseña_en/ense_a_en.routes.js';

const app = express(); // Instanciamos express
// const cors = require('cors');
app.use(express.json()); // Configuramos express para que pueda parsear JSON
app.use(cors()); // Configuramos CORS para que cualquier cliente pueda hacer peticiones a nuestra API
app.disable('x-powered-by'); // Deshabilitamos la cabecera X-Powered-By

// Escuchamos en el puerto 3000
app.listen(3000, () => {
    console.log(`Servidor listo en http://localhost:3000`);
});

// Ruta para comprobar que el servidor está online
app.get('/', (_, res) => {
    res.status(200).json({ message: 'Online!' })
});

// Ruta para comprobar que la API está online
app.get('/api', (_, res)   => {
    res.status(200).json({ message: 'API Online!' })
});

// Ruta clientes
app.use('/api', clientesRoutes);
app.use('/api', instructoresRoutes);
app.use('/api', loginRoutes);
app.use('/api', productoRoutes);
app.use('/api', membresiaRoute);
app.use('/api', horarioRoute);
app.use('/api', ventasRoutes);
app.use('/api', inscripcionesRoutes);
app.use('/api', horarioInstructoresRoutes);

