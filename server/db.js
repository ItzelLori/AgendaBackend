// db.js
import { createPool } from 'mysql2/promise'; // Usar mysql2/promise para soporte de promesas
import { Client } from 'ssh2';
import fs from 'fs';
import dotenv from 'dotenv';

dotenv.config();

const sshClient = new Client();

const sshConfig = {
    host: process.env.SSH_HOST,
    port: process.env.SSH_PORT,
    username: process.env.SSH_USER,
    privateKey: fs.readFileSync(process.env.SSH_KEY_PATH)
};

const dbConfig = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT
};

let pool;
let isConnected = false;

const connectDB = () => {
    return new Promise((resolve, reject) => {
        sshClient.on('ready', () => {
            sshClient.forwardOut(
                '127.0.0.1',
                3306,
                dbConfig.host,
                dbConfig.port,
                (err, stream) => {
                    if (err) return reject(err);

                    pool = createPool({
                        ...dbConfig,
                        stream,
                        waitForConnections: true,
                        connectionLimit: 10,
                        queueLimit: 0
                    });

                    pool.getConnection().then(connection => {
                        console.log('Connected to the database');
                        connection.release();
                        isConnected = true;
                        resolve(pool);
                    }).catch(err => {
                        console.error('Error connecting to the database:', err);
                        reject(err);
                    });
                }
            );
        }).connect(sshConfig);

        sshClient.on('error', (err) => {
            console.error('SSH connection error:', err);
            reject(err);
        });

        sshClient.on('end', () => {
            console.log('SSH connection ended');
            isConnected = false;
        });

        sshClient.on('close', () => {
            console.log('SSH connection closed');
            isConnected = false;
        });
    });
};

export { pool, connectDB, isConnected };
