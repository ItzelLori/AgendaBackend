# Tutorias API

API para gestionar una plataforma de tutorías, incluyendo la gestión de profesores, cursos, alumnos, administradores, cursos inscritos e impartidos.

## Tabla de Contenidos

- [Instalación](#instalación)
- [Configuración](#configuración)
- [Uso](#uso)
- [Endpoints](#endpoints)
  - [GET](#get)
  - [POST](#post)
- [Contribuir](#contribuir)
- [Licencia](#licencia)

## Instalación

1. Clona el repositorio:
    ```bash
    git clone https://github.com/tu-usuario/tu-repositorio.git
    cd tu-repositorio
    ```

2. Instala las dependencias:
    ```bash
    npm install
    ```

3. Instala PM2 globalmente si aún no lo tienes:
    ```bash
    sudo npm install -g pm2
    ```

## Configuración

1. Crea un archivo `.env` en la raíz del proyecto y agrega las siguientes variables de entorno con tus configuraciones:

    ```plaintext
    # Configuración SSH
    SSH_HOST=example.ssh.host
    SSH_PORT=22
    SSH_USER=your_ssh_username
    SSH_KEY_PATH=./path/to/your/private/key.ppk

    # Configuración de la Base de Datos
    DB_HOST=localhost
    DB_USER=your_db_username
    DB_PASSWORD=your_db_password
    DB_NAME=your_db_name
    DB_PORT=3306
    ```

2. Asegúrate de tener configurado el archivo `.gitignore` para que ignore el archivo `.env` y otros archivos sensibles:
    ```plaintext
    node_modules/
    .env
    claveaws.ppk
    ```

## Uso

1. Inicia la aplicación en modo desarrollo:
    ```bash
    npm run dev
    ```

2. Alternativamente, inicia la aplicación con PM2 para producción:
    ```bash
    pm2 start npm --name "tutorias" -- run dev
    pm2 save
    pm2 startup
    ```

## Endpoints

### GET

- **Obtener todos los profesores:**
    - **URL:** `/api/profesores`
    - **Método:** `GET`

- **Obtener todos los cursos:**
    - **URL:** `/api/cursos`
    - **Método:** `GET`

- **Obtener todos los alumnos:**
    - **URL:** `/api/alumnos`
    - **Método:** `GET`

- **Obtener todos los administradores:**
    - **URL:** `/api/administradores`
    - **Método:** `GET`

### POST

- **Insertar un nuevo profesor:**
    - **URL:** `/api/profesor`
    - **Método:** `POST`
    - **Body:**
        ```json
        {
            "nombre": "Juan Pérez",
            "correoInstitucional": "juan.perez@instituto.edu",
            "contraseña": "password123",
            "Descripcion_profesional": "Profesor de Matemáticas con 10 años de experiencia."
        }
        ```

- **Insertar un nuevo curso:**
    - **URL:** `/api/curso`
    - **Método:** `POST`
    - **Body:**
        ```json
        {
            "nombreCurso": "Cálculo I",
            "materia": "Matemáticas",
            "instructor": 1,
            "Duracion": 40,
            "Descripcion": "Curso introductorio de cálculo diferencial e integral.",
            "Requisitos": "Conocimientos básicos de álgebra."
        }
        ```

- **Insertar un nuevo alumno:**
    - **URL:** `/api/alumno`
    - **Método:** `POST`
    - **Body:**
        ```json
        {
            "nombre": "Carlos López",
            "correoInstitucional": "carlos.lopez@estudiantes.edu",
            "contraseña": "password789",
            "boleta": "20210001",
            "carrera": "Ingeniería en Sistemas"
        }
        ```

- **Insertar un nuevo administrador:**
    - **URL:** `/api/administrador`
    - **Método:** `POST`
    - **Body:**
        ```json
        {
            "Nombre": "Admin1",
            "usuario": "admin1",
            "contraseña": "adminpass1"
        }
        ```

- **Insertar un nuevo curso inscrito:**
    - **URL:** `/api/cursosinscritos`
    - **Método:** `POST`
    - **Body:**
        ```json
        {
            "curso": 1,
            "alumnoInscrito": 1
        }
        ```

- **Insertar un nuevo curso impartido:**
    - **URL:** `/api/cursosimpartidos`
    - **Método:** `POST`
    - **Body:**
        ```json
        {
            "curso": 1,
            "instructor": 1
        }
        ```

## Contribuir

1. Haz un fork del repositorio.
2. Crea una nueva rama (`git checkout -b feature-nueva-funcionalidad`).
3. Realiza los cambios necesarios y haz commit (`git commit -am 'Añadir nueva funcionalidad'`).
4. Haz push a la rama (`git push origin feature-nueva-funcionalidad`).
5. Abre un Pull Request.

## Licencia

Este proyecto está licenciado bajo la Licencia MIT - mira el archivo [LICENSE](LICENSE) para más detalles.

