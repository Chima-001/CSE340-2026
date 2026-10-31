# CSE340-2026 Service Network

A CSE 340 course project — a Service Network website built with **Node.js**, **Express**, and **EJS** that connects volunteers with service opportunities in their community.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Available Routes](#available-routes)
- [EJS Pages & Partials](#ejs-pages--partials)
- [Styling](#styling)
- [Accessibility](#accessibility)
- [Code Standards](#code-standards)
- [License](#license)

## 📖 Overview

The CSE 340 Service Network is a simple web application that promotes service across the world by connecting volunteers with service opportunities in their community. The site features pages for the home, partner organizations, service projects, and service project categories.

## ✨ Features

- **Home Page** — Welcome message and mission statement with the service network logo
- **Organizations Page** — List of partner service organizations with contact information and logos
- **Projects Page** — Upcoming service projects with descriptions
- **Categories Page** — Service project categories (Environmental, Educational, Community Service, Health and Wellness)
- **Responsive Navigation** — Consistent navigation across all pages with links to Home, Organizations, Projects, and Categories
- **Responsive Design** — Mobile-friendly layout that adapts to tablets and phones
- **Accessible** — Keyboard navigable, focus indicators, sufficient color contrast, and semantic HTML

## 🚀 Installation

### Prerequisites

- [Node.js](https://nodejs.org/) (v14 or higher)
- npm (comes with Node.js)

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

3. **Configure environment variables**
   Create a `.env` file in the root directory:

   ```env
   PORT=3000
   NODE_ENV=development
   ```

   > ⚠️ **Note:** The `.env` file is listed in `.gitignore` and should NOT be committed to GitHub.

4. **Start the server**

   ```bash
   # Development mode (with auto-reload via nodemon)
   npm run dev

   # Production mode
   npm start
   ```

5. **Open your browser**
   Navigate to `http://localhost:3000`

## 🖥️ Usage

Once the server is running, visit the following pages:

| Page          | URL                                   | Description                         |
| ------------- | ------------------------------------- | ----------------------------------- |
| Home          | `http://localhost:3000/`              | Welcome page with mission statement |
| Organizations | `http://localhost:3000/organizations` | Partner service organizations       |
| Projects      | `http://localhost:3000/projects`      | Upcoming service projects           |
| Categories    | `http://localhost:3000/categories`    | Service project categories          |

## 🛣️ Available Routes

| Route            | Method | View Rendered       | Title Variable               |
| ---------------- | ------ | ------------------- | ---------------------------- |
| `/`              | GET    | `home.ejs`          | `Home`                       |
| `/organizations` | GET    | `organizations.ejs` | `Our Partner Organizations`  |
| `/projects`      | GET    | `projects.ejs`      | `Service Projects`           |
| `/categories`    | GET    | `categories.ejs`    | `Service Project Categories` |

All routes use `res.render()` with an object containing the `title` property, which is injected into the `<title>` tag and `<h1>` heading via EJS.

## 🎨 EJS Pages & Partials

### Pages

All EJS pages follow the same pattern:

1. Include the header partial: `<%- include('partials/header') %>`
2. Render main content in a `<main>` element
3. Include the footer partial: `<%- include('partials/footer') %>`

The `title` variable is passed from the server route and used with `<%= title %>` for page titles and headings.

### Partials

**`header.ejs`** — Contains the `<!DOCTYPE html>`, `<head>`, opening `<body>`, and navigation bar. The page title is inserted via `<%= title %>`. Navigation links include:

- Home (`/`)
- Organizations (`/organizations`)
- Projects (`/projects`)
- Categories (`/categories`)

**`footer.ejs`** — Contains the copyright notice with the current year, closing `</body>` and `</html>` tags.

### EJS Syntax Standards

- `<%- include('partials/name') %>` — Used for including partials (unescaped)
- `<%= title %>` — Used for rendering data variables (escaped for security)
- `<%- %>` is used ONLY for partial includes, not for data variables

## 🎨 Styling

The site uses a professional, responsive CSS stylesheet located at `public/css/main.css`.

### Design Features

- **CSS Custom Properties** — Color palette, typography, spacing, and border values defined as CSS variables in `:root`
- **Responsive Navigation** — Flexbox-based navigation that stacks vertically on mobile devices (≤768px)
- **Card-Style Lists** — List items have hover effects with lift and shadow transitions
- **Sticky Header** — Navigation stays at the top when scrolling
- **Mobile-First Breakpoints** — Styles adapt for tablets (768px) and phones (480px)
- **Reduced Motion** — Respects `prefers-reduced-motion` for accessibility

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

- **Semantic HTML** — Proper use of `<nav>`, `<main>`, `<footer>`, `<h1>`-`<h6>` elements
- **Keyboard Navigation** — All interactive elements are keyboard accessible
- **Focus Indicators** — Visible `:focus-visible` outlines on links and navigation items
- **Color Contrast** — Sufficient contrast between text and background colors
- **Responsive Text** — Font sizes scale appropriately on smaller screens
- **Reduced Motion** — Animations and transitions respect user preferences
- **Alt Text** — All images include descriptive `alt` attributes

## 📜 Code Standards

The project follows these coding standards:

- **`const`** is used where possible (no `let` or `var`)
- **camelCase** is used for all variable names
- **Arrow functions** are used for all function declarations (`const xxx = () => {}`)
- **Async/await** is used instead of promises or callbacks
- **ESM export/import syntax** (`import express from 'express'`)
- **`<%= %>`** is used for EJS data variables (except header/footer partial includes which use `<%- %>`)

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

**Course:** CSE 340 — BYU-Idaho  
**Author:** Chima Nnaji
