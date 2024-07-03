import express from 'express';
import morgan from 'morgan';
import {PORT} from './config.js';
import indexRoutes from './routes/index.routes.js'
import dotenv from 'dotenv';
import cors from 'cors';



dotenv.config();

const app = express();

app.use(morgan('dev'));
app.use(express.json());
app.use(cors());
app.use('/api', indexRoutes);



app.listen(PORT)
console.log('Server listening on port ' + PORT);