import { Router } from 'express';
import { pool, connectDB, isConnected } from '../db.js';

const router = Router();

const ensureDBConnection = async () => {
    if (!isConnected) {
        await connectDB();
    }
};

// GET Methods
router.get('/profesores', async (req, res) => {
    try {
        await ensureDBConnection();
        const [rows] = await pool.query('SELECT * FROM Profesor');
        res.json(rows);
    } catch (err) {
        console.error('Error querying the database:', err);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.get('/cursos', async (req, res) => {
    try {
        await ensureDBConnection();
        const [rows] = await pool.query('SELECT * FROM Curso');
        res.json(rows);
    } catch (err) {
        console.error('Error querying the database:', err);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.get('/alumnos', async (req, res) => {
    try {
        await ensureDBConnection();
        const [rows] = await pool.query('SELECT * FROM Alumno');
        res.json(rows);
    } catch (err) {
        console.error('Error querying the database:', err);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.get('/administradores', async (req, res) => {
    try {
        await ensureDBConnection();
        const [rows] = await pool.query('SELECT * FROM Administradores');
        res.json(rows);
    } catch (err) {
        console.error('Error querying the database:', err);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

// POST Methods
router.post('/profesor', async (req, res) => {
    const { nombre, correoInstitucional, contraseña, Descripcion_profesional } = req.body;

    if (!nombre || !correoInstitucional || !contraseña || !Descripcion_profesional) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    try {
        await ensureDBConnection();
        const [result] = await pool.query(
            'INSERT INTO Profesor (nombre, correoInstitucional, contraseña, Descripcion_profesional) VALUES (?, ?, ?, ?)',
            [nombre, correoInstitucional, contraseña, Descripcion_profesional]
        );

        res.json({ message: 'Profesor inserted successfully', insertId: result.insertId });
    } catch (err) {
        console.error('Error inserting Profesor:', err);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.post('/curso', async (req, res) => {
    const { nombreCurso, materia, instructor, Duracion, Descripcion, Requisitos } = req.body;

    if (!nombreCurso || !materia || !instructor || !Duracion || !Descripcion || !Requisitos) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    try {
        await ensureDBConnection();
        const [result] = await pool.query(
            'INSERT INTO Curso (nombreCurso, materia, instructor, Duracion, Descripcion, Requisitos) VALUES (?, ?, ?, ?, ?, ?)',
            [nombreCurso, materia, instructor, Duracion, Descripcion, Requisitos]
        );

        res.json({ message: 'Curso inserted successfully', insertId: result.insertId });
    } catch (err) {
        console.error('Error inserting Curso:', err);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.post('/alumno', async (req, res) => {
    const { nombre, correoInstitucional, contraseña, boleta, carrera } = req.body;

    if (!nombre || !correoInstitucional || !contraseña || !boleta || !carrera) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    try {
        await ensureDBConnection();
        const [result] = await pool.query(
            'INSERT INTO Alumno (nombre, correoInstitucional, contraseña, boleta, carrera) VALUES (?, ?, ?, ?, ?)',
            [nombre, correoInstitucional, contraseña, boleta, carrera]
        );

        res.json({ message: 'Alumno inserted successfully', insertId: result.insertId });
    } catch (err) {
        console.error('Error inserting Alumno:', err);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.post('/administrador', async (req, res) => {
    const { Nombre, usuario, contraseña } = req.body;

    if (!Nombre || !usuario || !contraseña) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    try {
        await ensureDBConnection();
        const [result] = await pool.query(
            'INSERT INTO Administradores (Nombre, usuario, contraseña) VALUES (?, ?, ?)',
            [Nombre, usuario, contraseña]
        );

        res.json({ message: 'Administrador inserted successfully', insertId: result.insertId });
    } catch (err) {
        console.error('Error inserting Administrador:', err);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.post('/cursosinscritos', async (req, res) => {
    const { curso, alumnoInscrito } = req.body;

    if (!curso || !alumnoInscrito) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    try {
        await ensureDBConnection();
        const [result] = await pool.query(
            'INSERT INTO CursosInscritos (curso, alumnoInscrito) VALUES (?, ?)',
            [curso, alumnoInscrito]
        );

        res.json({ message: 'CursosInscritos inserted successfully', insertId: result.insertId });
    } catch (err) {
        console.error('Error inserting CursosInscritos:', err);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.post('/cursosimpartidos', async (req, res) => {
    const { curso, instructor } = req.body;

    if (!curso || !instructor) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    try {
        await ensureDBConnection();
        const [result] = await pool.query(
            'INSERT INTO CursosImpartidos (curso, instructor) VALUES (?, ?)',
            [curso, instructor]
        );

        res.json({ message: 'CursosImpartidos inserted successfully', insertId: result.insertId });
    } catch (err) {
        console.error('Error inserting CursosImpartidos:', err);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

export default router;
