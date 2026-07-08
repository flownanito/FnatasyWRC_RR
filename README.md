<div align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/World_Rally_Championship_logo.svg/1200px-World_Rally_Championship_logo.svg.png" alt="WRC Logo" width="200" style="margin-bottom: 20px;">
  
  # Fantasy WRC 🏁
  
  **El Manager Definitivo del Campeonato Mundial de Rally**

  [![Ruby Version](https://img.shields.io/badge/Ruby-3.x-red.svg)](https://www.ruby-lang.org/)
  [![Rails Version](https://img.shields.io/badge/Rails-7.x-red.svg)](https://rubyonrails.org/)
  [![TailwindCSS](https://img.shields.io/badge/Tailwind-CSS-38B2AC.svg)](https://tailwindcss.com/)
  [![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
</div>

---

## 📖 Sobre el Proyecto

**Fantasy WRC** es una aplicación web interactiva que simula una liga de fantasía basada en el World Rally Championship (WRC). Permite a los usuarios crear ligas privadas con amigos, competir mediante la compra y venta de pilotos reales en un mercado dinámico, gestionar presupuestos y configurar estrategias para cada rally de la temporada.

La aplicación está diseñada para ofrecer una experiencia inmersiva, con un diseño moderno, animaciones fluidas y un rendimiento excelente.

---

## ✨ Características Principales

### 🏆 Gestión de Ligas y Competición
* **Ligas Privadas:** Creación de ligas mediante códigos únicos para competir exclusivamente con amigos (máximo 5 jugadores por liga).
* **Sistema de Puntuación:** Clasificaciones actualizadas en tiempo real basadas en los resultados oficiales de los rallies.
* **Presupuesto Inicial:** Cada jugador comienza con un presupuesto limitado para construir su equipo.

### 💰 Mercado de Fichajes Dinámico
* **Compra de Pilotos:** Los jugadores pueden adquirir pilotos que estén libres en el mercado ("Agentes Libres").
* **Sistema de "Clausulazos":** Mecánica que permite robar un piloto a otro usuario pagando su cláusula de rescisión (150% del valor inicial).
* **Venta Estratégica:** Los usuarios pueden vender sus propios pilotos en cualquier momento, recuperando el 80% del valor base (simulando una penalización por rescisión de contrato).

### 🛠️ Configuración Estratégica (Setup)
Además de los pilotos, el éxito depende del equipo técnico:
* Elección de **Vehículo** (Car)
* Elección de **Ingeniero** (Engineer)
* Elección de **Patrocinador** (Sponsor)

### 🎨 Experiencia de Usuario (UX/UI)
* **Diseño Premium:** Interfaz construida con Tailwind CSS, con efectos Glassmorphism, gradientes dinámicos y micro-animaciones.
* **Modo Oscuro/Claro (Theming):** Tematización completa y persistente por usuario, sin necesidad de recargar la página.
* **Internacionalización (i18n):** Soporte total para múltiples idiomas (Español e Inglés) intercambiables al instante.

---

## 🏗️ Arquitectura y Tecnologías

El proyecto sigue el patrón **MVC** (Modelo-Vista-Controlador) característico de Ruby on Rails, apoyándose en las herramientas más modernas del ecosistema de Rails 7.

* **Backend Framework:** Ruby on Rails 7
* **Base de Datos:** SQLite (Desarrollo/Test) / PostgreSQL (Producción)
* **Autenticación:** Devise
* **Frontend:**
  * **Estilos:** Tailwind CSS (a través de la gema `tailwindcss-rails`)
  * **JavaScript:** Importmaps (sin necesidad de Node.js ni Webpack)
  * **Reactividad:** Turbo & Hotwire (para navegación súper rápida tipo SPA)
  * **Iconos:** Heroicons

---

## 🚀 Guía de Instalación y Despliegue Local

Sigue estos pasos para levantar el entorno de desarrollo en tu máquina local.

### 1. Prerrequisitos
Asegúrate de tener instalado en tu sistema:
- Ruby (versión 3.0.0 o superior)
- SQLite3
- Git

### 2. Clonar el Repositorio
```bash
git clone https://github.com/flownanito/FnatasyWRC_RR.git
cd FnatasyWRC_RR
```

### 3. Instalar Dependencias
Instala todas las gemas necesarias ejecutando Bundler:
```bash
bundle install
```

### 4. Configurar la Base de Datos
Crea la base de datos, ejecuta las migraciones (para crear las tablas) y puebla la base de datos con los datos semilla (seeds) que incluyen pilotos, coches, ingenieros y sponsors reales:
```bash
rails db:create db:migrate db:seed
```

### 5. Iniciar el Servidor de Desarrollo
Para arrancar el servidor web de Rails junto con el compilador en tiempo real de Tailwind CSS, usa:
```bash
bin/dev
```

La aplicación estará disponible en: `http://localhost:3000`

---

## 🗄️ Estructura de la Base de Datos (Modelos)

La aplicación cuenta con una base de datos relacional robusta. A continuación se detallan los modelos principales:

- **User**: Usuarios autenticados del sistema (gestionados por Devise). Almacena preferencias como `locale` y `theme`.
- **League**: Ligas creadas. Tienen un `owner_id` y un `code` alfanumérico único.
- **LeagueMember**: Tabla intermedia que vincula a los `Users` con las `Leagues`. Almacena el `budget` (presupuesto restante) y los `total_points`.
- **Driver**: Tabla maestra con todos los pilotos reales del WRC, sus estadísticas (ritmo, consistencia, experiencia) y precio base.
- **LeagueDriver**: Representa a qué usuario pertenece un piloto dentro de una liga específica, y cuál es su `release_clause` (cláusula).
- **Rally & Stage**: Información sobre las competiciones, fechas, localidades y tramos.
- **OfficialDriverResult**: Puntuaciones oficiales reales obtenidas en cada Rally.
- **FantasyLineup**: La alineación concreta (Pilotos, Coche, Ingeniero, Sponsor) que un usuario decide utilizar para un Rally específico.

---

## 👨‍💻 Comandos Útiles para Desarrolladores

* **Consola de Rails:** Para interactuar directamente con la base de datos y los modelos en la terminal.
  ```bash
  rails console
  ```
* **Ver Rutas Disponibles:** Para listar todas las URLs (endpoints) de la aplicación.
  ```bash
  rails routes
  ```
* **Resetear la Base de Datos:** Si necesitas limpiar todo y volver a empezar de cero.
  ```bash
  rails db:drop db:create db:migrate db:seed
  ```

---

## 📄 Licencia

Este proyecto se distribuye bajo los términos de la **Licencia MIT**. Eres libre de utilizar, modificar y distribuir el código. 

---
*Desarrollado con ❤️ para los fanáticos del rally y la programación.*
