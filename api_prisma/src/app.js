import express from 'express'; // Importamos express

// Import Routes
import clientesRoutes from './routes/clientes/clientes.routes.js';

const app = express(); // Instanciamos express
app.use(express.json()); // Configuramos express para que pueda parsear JSON
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



