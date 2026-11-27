# CSE340-2026 Service Network


A CSE 340 course project: a Service Network website built with **Node.js**, **Express 5**, and **EJS** that connects volunteers with service opportunities in their community. Data is stored in **PostgreSQL**. The app includes user registration and login, role-based access (`user` and `admin`), volunteer sign-ups for projects, and admin tools for managing organizations, service projects, and categories.

**Live site:** YOUR-RENDER-URL


## 📋 Table of Contents


- [Overview](#-overview)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Project Structure](#️-project-structure)
- [Getting Started](#-getting-started)
- [Creating an Admin Account](#-creating-an-admin-account)
- [Test Admin Account](#-test-admin-account)
- [Pages](#️-pages)
- [Available Routes](#️-available-routes)
- [Access Control](#-access-control)
- [EJS Pages and Partials](#-ejs-pages--partials)
- [Database](#️-database)
- [Styling](#-styling)
- [Accessibility](#-accessibility)
- [Code Standards](#-code-standards)
- [Deployment](#-deployment)
- [License](#-license)


## 📖 Overview


The CSE 340 Service Network promotes service across the world by connecting volunteers with service opportunities in their community.


- **Visitors** can browse partner organizations, upcoming service projects, and service categories.
- **Registered users** can register, log in, volunteer for projects, and manage their volunteer sign-ups from a personal dashboard.
- **Admins** can create and edit organizations, projects, and categories, assign categories to projects, and view all registered users.


## ✨ Features


**Public site**


- **Home page**: welcome message and mission statement with the service network logo
- **Organizations**: list of partner organizations with contact email and logo, plus a details page for each
- **Projects**: list of upcoming service projects (limited to five), plus a details page showing each project's categories
- **Categories**: list of service categories, plus a details page showing the projects in each category
- **Responsive navigation and layout** for desktops, tablets, and phones


**Accounts and security**


- Registration and login with **bcrypt** password hashing
- Session-based login (sessions use a one-hour cookie max age)
- Protected dashboard for logged-in users
- **Role-based access control** with `user` and `admin` roles
- Flash messages for success and error feedback
- Server-side validation with **express-validator** on the create and edit forms
- Friendly 404 and 500 error pages


**Volunteering**


- Logged-in users can volunteer for a service project from its details page
- Logged-in users can remove themselves from a project, from the project page or from the dashboard
- The dashboard lists every project the user has volunteered for, ordered by project date
- Volunteer sign-ups are stored in a many-to-many table between users and projects
- Volunteer buttons are hidden from visitors who are not logged in


**Admin tools**


- Create and edit partner organizations
- Create and edit service projects
- Assign one or more categories to a project (many-to-many)
- Create and edit categories
- View a list of all registered users


## 🧰 Tech Stack


- [Node.js](https://nodejs.org/) with ES modules (`"type": "module"`)
- [Express 5](https://expressjs.com/) for routing and middleware
- [EJS](https://ejs.co/) for server-rendered templates
- [PostgreSQL](https://www.postgresql.org/) with the [`pg`](https://node-postgres.com/) driver
- [bcrypt](https://www.npmjs.com/package/bcrypt) for password hashing
- [express-session](https://www.npmjs.com/package/express-session) for login sessions
- [express-validator](https://express-validator.github.io/docs/) for form validation
- [nodemon](https://nodemon.io/) for development auto-reload


## 🗂️ Project Structure


```text
CSE340-2026/
├── public/
│   ├── css/
│   │   └── main.css              # Site stylesheet
│   └── images/                   # Organization logos and placeholder images
├── src/
│   ├── controllers/
│   │   ├── categories.js         # Category pages, create/edit, and project assignment
│   │   ├── errors.js             # Error test route
│   │   ├── index.js              # Home page
│   │   ├── organizations.js      # Organization pages, create/edit
│   │   ├── projects.js           # Project pages, create/edit
│   │   ├── users.js              # Register, login, logout, dashboard, role guards, users list
│   │   └── volunteers.js         # Volunteer and remove-volunteer actions
│   ├── middleware/
│   │   └── flash.js              # One-time flash messages
│   ├── models/
│   │   ├── categories.js         # Category database queries
│   │   ├── db.js                 # PostgreSQL connection pool
│   │   ├── organizations.js      # Organization database queries
│   │   ├── projects.js           # Project database queries
│   │   ├── users.js              # User and role database queries
│   │   └── volunteers.js         # Volunteer sign-up database queries
│   ├── views/
│   │   ├── errors/               # 404.ejs and 500.ejs
│   │   ├── partials/             # header.ejs and footer.ejs
│   │   └── *.ejs                 # Page templates
│   ├── routes.js                 # All route definitions
│   └── setup.sql                 # Database schema and sample data
├── .vscode/
├── LICENSE
├── nodemon.json                  # Nodemon watch and run settings
├── package.json
├── package-lock.json
└── server.js                     # App entry point
```


## 🚀 Getting Started


### Prerequisites


- [Node.js](https://nodejs.org/) **20.6 or newer** (includes npm). Newer LTS versions also work.
- A **PostgreSQL** database, either local or hosted (for example, [Render](https://render.com/) or [Supabase](https://supabase.com/)).


### Steps


1. **Clone the repository**


   ```bash
   git clone https://github.com/Chima-001/CSE340-2026.git
   cd CSE340-2026
   ```


2. **Install dependencies**


   ```bash
   npm install
   ```


3. **Create a `.env` file** in the project root:


   ```env
   PORT=3000
   NODE_ENV=development
   DB_URL=postgresql://USER:PASSWORD@HOST:5432/DATABASE
   SESSION_SECRET=replace-with-a-long-random-string


   # Optional: log SQL queries to the console (development only)
   ENABLE_SQL_LOGGING=true
   ```


   | Variable             | Required | Default      | Purpose                                                          |
   | -------------------- | -------- | ------------ | ---------------------------------------------------------------- |
   | `PORT`               | No       | `3000`       | Port the server listens on                                       |
   | `NODE_ENV`           | No       | `production` | Set to `development` for request logging and debug output        |
   | `DB_URL`             | Yes      | None         | PostgreSQL connection string                                     |
   | `SESSION_SECRET`     | Yes      | None         | Secret used to sign session cookies. Use a long, random value    |
   | `ENABLE_SQL_LOGGING` | No       | None         | Set to `true` with `NODE_ENV=development` to log SQL queries     |


   > ⚠️ **Note:** `.env` is listed in `.gitignore` and must NOT be committed to GitHub. It holds your database password and session secret.


4. **Set up the database**


   Run the setup script against your database. You can use `psql` or paste the contents of `src/setup.sql` into your database's SQL editor:


   ```bash
   psql "$DB_URL" -f src/setup.sql
   ```


   This creates the `organization`, `service_project`, `category`, `project_category`, `roles`, `users`, and `project_volunteer` tables. It also inserts sample organizations, projects, categories, and the `user` and `admin` roles.


   > ⚠️ **Warning:** The reset section at the top of `setup.sql` drops every table before recreating it. Running the script on a database that is already in use deletes all of its data, including registered users and volunteer sign-ups. You will need to register and promote your admin account again afterward.


5. **Start the server**


   ```bash
   # Development mode (auto-restarts when files change, loads .env)
   npm run dev


   # Production mode (environment variables must already be set)
   npm start
   ```


6. **Open your browser**


   Go to `http://localhost:3000`.


## 🔑 Creating an Admin Account


New accounts registered through `/register` always get the `user` role. To become an admin:


1. Register an account at `http://localhost:3000/register`.
2. Promote the account in your database:


   ```sql
   UPDATE users
   SET role_id = (SELECT role_id FROM roles WHERE role_name = 'admin')
   WHERE email = 'you@example.com';
   ```


3. Log out and log back in. The role is stored in your session when you log in, so you need to log in again to pick up the change.


## 🧪 Test Admin Account


The live site has a dedicated admin account for testing and grading:


| Field    | Value               |
| -------- | ------------------- |
| Email    | `admin@example.com` |
| Password | `cse340!`           |


This account has the `admin` role. Do not delete it.


## 🖥️ Pages


| Page                 | URL                       | Access     | Description                                                  |
| -------------------- | ------------------------- | ---------- | ------------------------------------------------------------ |
| Home                 | `/`                       | Public     | Welcome page with mission statement                          |
| Organizations        | `/organizations`          | Public     | Partner service organizations                                |
| Organization details | `/organization/:id`       | Public     | One organization and its details                             |
| Projects             | `/projects`               | Public     | Upcoming service projects                                    |
| Project details      | `/project/:id`            | Public     | One project and its categories. Logged-in users also see the volunteer button |
| Categories           | `/categories`             | Public     | Service project categories                                   |
| Category details     | `/category/:id`           | Public     | One category and its projects                                |
| Register             | `/register`               | Public     | Create an account                                            |
| Login                | `/login`                  | Public     | Log in to an existing account                                |
| Dashboard            | `/dashboard`              | Logged in  | Personal dashboard with the user's volunteer projects        |
| Registered users     | `/users`                  | Admin      | List of all registered users and their roles                 |


## 🛣️ Available Routes


**Public routes**


| Route                 | Method    | Description                                  |
| --------------------- | --------- | -------------------------------------------- |
| `/`                   | GET       | Home page                                    |
| `/organizations`      | GET       | Organizations list                           |
| `/organization/:id`   | GET       | Organization details                         |
| `/projects`           | GET       | Upcoming projects list                       |
| `/project/:id`        | GET       | Project details                              |
| `/categories`         | GET       | Categories list                              |
| `/category/:id`       | GET       | Category details                             |
| `/register`           | GET, POST | Registration form and submission             |
| `/login`              | GET, POST | Login form and submission                    |
| `/logout`             | GET       | Log out and return to the login page         |
| `/test-error`         | GET       | Triggers the error page (for testing)        |


**Logged-in routes**


| Route                     | Method | Description                                                       |
| ------------------------- | ------ | ----------------------------------------------------------------- |
| `/dashboard`              | GET    | Personal dashboard and volunteer list                             |
| `/volunteer/:projectId`   | POST   | Volunteer for a project                                           |
| `/unvolunteer/:projectId` | POST   | Remove yourself from a project (returns to the page you came from) |


**Admin routes**


| Route                           | Method    | Description                          |
| ------------------------------- | --------- | ------------------------------------ |
| `/new-organization`             | GET, POST | Create an organization               |
| `/edit-organization/:id`        | GET, POST | Edit an organization                 |
| `/new-project`                  | GET, POST | Create a service project             |
| `/edit-project/:id`             | GET, POST | Edit a service project               |
| `/assign-categories/:projectId` | GET, POST | Set the categories for a project     |
| `/new-category`                 | GET, POST | Create a category                    |
| `/edit-category/:id`            | GET, POST | Edit a category                      |
| `/users`                        | GET       | List all registered users            |


## 🔐 Access Control


- **Guests** can view all public pages and register or log in. They do not see the volunteer buttons.
- **Logged-in users** can also open the dashboard and volunteer for or leave projects. If a guest tries to open a protected page, the app redirects them to `/login`.
- **Admins** can use every create and edit route, assign categories to projects, and view the users list. If a logged-in non-admin tries to open an admin page, the app redirects them to `/dashboard`.
- Access is enforced by two middleware functions in `src/controllers/users.js`:
  - `requireLogin` protects routes that need any logged-in user, including the volunteer and remove routes.
  - `requireRole('admin')` protects routes that need the admin role.
- Volunteer actions are POST forms, and the user id always comes from the session, never from the form, so a user can only change their own sign-ups.
- Passwords are stored only as **bcrypt** hashes. The password hash is removed before the user is saved to the session.


## 🎨 EJS Pages and Partials


### Pages


Each page follows the same pattern:


1. Include the header partial: `<%- include('partials/header') %>`
2. Render the main content inside a `<main>` element
3. Include the footer partial: `<%- include('partials/footer') %>`


Routes pass a `title` value to the template. Templates print it with `<%= title %>` for the page title and heading.


Global values are available in every template through `res.locals`:


- `user`: the logged-in user object, or `null`
- `isLoggedIn`: `true` or `false`
- `NODE_ENV`: the current environment


### Partials


- **`header.ejs`**: the `<!DOCTYPE html>`, `<head>`, opening `<body>`, and navigation bar. The navigation changes based on login state and role.
- **`footer.ejs`**: the copyright notice with the current year, plus the closing `</body>` and `</html>` tags.


### EJS Syntax Standards


- `<%- include('partials/name') %>`: includes partials (unescaped)
- `<%= value %>`: prints data variables (escaped for security)
- `<%- %>` is used ONLY for partial includes, never for data


## 🗄️ Database


| Table               | Purpose                                                                         |
| ------------------- | ------------------------------------------------------------------------------- |
| `organization`      | Partner organizations (name, description, contact email, logo)                  |
| `service_project`   | Service projects, each linked to one organization                               |
| `category`          | Service categories (for example, Food Security)                                 |
| `project_category`  | Junction table linking projects and categories (many-to-many)                   |
| `roles`             | Role names: `user` and `admin`                                                  |
| `users`             | Registered users, with a password hash and a role                               |
| `project_volunteer` | Junction table linking users and the projects they volunteered for (many-to-many) |


`project_volunteer` uses a composite primary key of `user_id` and `project_id`, so a user can volunteer for a project only once. Both columns are foreign keys with `ON DELETE CASCADE`, so sign-ups are removed automatically if the user or project is deleted.


## 🎨 Styling


The site uses a responsive stylesheet at `public/css/main.css`.


- **CSS custom properties**: colors, typography, spacing, and borders are defined as variables in `:root`
- **Responsive navigation**: flexbox-based navigation that stacks vertically on screens 768px wide and smaller
- **Mobile-first breakpoints**: styles adapt for tablets (768px) and phones (480px)
- **Card-style lists**: list items lift with a shadow on hover
- **Sticky header**: navigation stays at the top while scrolling
- **Reduced motion**: respects the `prefers-reduced-motion` setting


### Color Palette


| Variable                 | Value     | Usage                   |
| ------------------------ | --------- | ----------------------- |
| `--color-primary`        | `#2c5f2d` | Primary links, headings |
| `--color-primary-dark`   | `#1e3e1f` | Footer background       |
| `--color-secondary`      | `#4a7c59` | Link hover state        |
| `--color-accent`         | `#e0a458` | Focus indicators        |
| `--color-background-alt` | `#f5f7f5` | Page background         |
| `--color-text`           | `#333333` | Body text               |


## ♿ Accessibility


The site is designed with accessibility in mind:


- **Semantic HTML**: `<nav>`, `<main>`, `<footer>`, and `<h1>`–`<h6>` are used for structure
- **Keyboard navigation**: all interactive elements can be reached and used with a keyboard
- **Focus indicators**: visible `:focus-visible` outlines on links and navigation items
- **Color contrast**: text and background colors have sufficient contrast
- **Responsive text**: font sizes scale on smaller screens
- **Reduced motion**: animations and transitions respect user preferences
- **Alt text**: images include descriptive `alt` attributes


## 📜 Code Standards


- **`const`** is preferred wherever possible
- **camelCase** for variable and function names
- **Arrow functions** for function declarations (`const xxx = () => {}`)
- **Async/await** instead of raw promises or callbacks
- **ESM** `import` / `export` syntax throughout
- **`<%= %>`** for EJS data variables, and `<%- %>` only for partial includes


## 🌐 Deployment


The site is deployed on [Render](https://render.com/) at YOUR-RENDER-URL, with a Render PostgreSQL database.


1. Create a PostgreSQL database on Render and run `src/setup.sql` against it (for example, from pgAdmin).
2. Create a Render **Web Service** connected to the GitHub repository.
3. Set the build command to `npm install` and the start command to `npm start`.
4. Add these environment variables to the web service:
   - `NODE_ENV=production`
   - `DB_URL`: the database's **Internal** URL
   - `SESSION_SECRET`: a long, random string
5. For local development, use the database's **External** URL in your `.env` file.


> ⚠️ **Note:** Render's free PostgreSQL databases expire after about a month. When that happens, create a new database, run `src/setup.sql` again, update `DB_URL`, and re-create the admin account.


## 📄 License


This project is licensed under the **GNU General Public License v3.0**. See the [LICENSE](LICENSE) file for details.


---


**Course:** CSE 340, BYU-Idaho
**Author:** Chima Nnaji
