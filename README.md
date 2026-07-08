# Fantasy WRC 🏎️💨

Welcome to the **Fantasy WRC** application! A fully-featured fantasy league platform for the World Rally Championship, built with Ruby on Rails 7.

## 🌟 Features

* **League Management**: Create or join custom leagues with your friends.
* **Driver Market**: Buy drivers, trigger "clausulazos" (buyouts), and sell drivers back to the market with a temporary contract penalty.
* **Financial Strategy**: Manage your budget efficiently to build the ultimate rally team.
* **Lineup Setup**: Configure your car, engineer, and sponsors for each rally.
* **Modern UI/UX**: Built with Tailwind CSS, featuring smooth transitions and micro-animations.
* **Theming**: Fully functional **Dark Mode** and Light Mode, customizable per user.
* **Internationalization (i18n)**: Seamlessly switch between English and Spanish.

## 🛠️ Technology Stack

* **Framework**: Ruby on Rails 7
* **Database**: PostgreSQL / SQLite (Development)
* **Styling**: Tailwind CSS via `tailwindcss-rails`
* **JavaScript**: Importmaps & Turbo (Hotwire)
* **Authentication**: Devise

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed:
* Ruby 3.x
* Rails 7.x
* SQLite3 / PostgreSQL

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/flownanito/FnatasyWRC_RR.git
   cd FnatasyWRC_RR
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create db:migrate db:seed
   ```

4. Run the development server (with Tailwind watcher):
   ```bash
   bin/dev
   ```

5. Open your browser and navigate to `http://localhost:3000`.

## 📜 License

This project is licensed under the MIT License.
