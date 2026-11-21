# Garments HRMS — Flutter Web Prototype

This is the first Dashboard prototype. It uses sample data only; no real employee, attendance, payroll, or approval data is stored.

## Hosting: GitHub Pages

The project is configured to deploy to GitHub Pages through GitHub Actions.

1. Open **Settings → Pages** and set the source to **GitHub Actions**.
2. Push a commit to the `main` branch, or manually run the deployment workflow from the **Actions** tab.
3. Wait for the **Deploy Flutter Web to GitHub Pages** workflow to finish successfully.
4. Open the Pages URL shown in the workflow deployment environment.

The deployment workflow runs only from `main`, so development branch commits do not change the live website. The web build also publishes a `404.html` fallback so client-side routes can be reopened from a browser URL.

## Navigation

- `/dashboard` — Dashboard
- `/employees` — Employees
- The root URL redirects to `/dashboard`.

## Important

- The default UI language is English.
- Dashboard and Employees currently use sample, in-memory data.
- Other sidebar modules are placeholders.
- Approve/Decline and Add Employee actions are demo-only.
- All numbers and names are sample data.
- Preserve the approved Dashboard and Employees UI design during future implementation.
