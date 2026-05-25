# Backend

Node.js/Express REST API serving both the mobile and web applications.

## Tech Stack

- Node.js with Express
- TypeScript
- PostgreSQL (Supabase)

## API Base URL

https://citizen-science-backend.fly.dev

## API Endpoints

### Auth

| Method | Endpoint           | Auth Required | Used By | Description                   |
| ------ | ------------------ | ------------- | ------- | ----------------------------- |
| POST   | /api/auth/register | No            | Web     | Create a teacher account      |
| POST   | /api/auth/login    | No            | Web     | Login and receive a JWT token |

### Projects

| Method | Endpoint                      | Auth Required | Used By      | Description                                |
| ------ | ----------------------------- | ------------- | ------------ | ------------------------------------------ |
| GET    | /api/projects                 | Yes           | Web          | Get all projects                           |
| GET    | /api/projects/:id             | No            | Mobile & Web | Get a projects details by its ID           |
| GET    | /api/projects/code/:classCode | No            | Mobile       | Get a project ID from using its class code |
| GET    | /api/projects/:id/export      | Yes           | Web          | Export observation data as a CSV file      |
| POST   | /api/projects                 | Yes           | Web          | Create a new project                       |
| PUT    | /api/projects/:id             | Yes           | Web          | Update a project                           |
| DELETE | /api/projects/:id             | Yes           | Web          | Delete a project                           |

### Fields

| Method | Endpoint                 | Auth Required | Used By      | Description                      |
| ------ | ------------------------ | ------------- | ------------ | -------------------------------- |
| GET    | /api/projects/:id/fields | No            | Mobile & Web | Get all fields for a project     |
| POST   | /api/projects/:id/fields | Yes           | Web          | Create a new field for a project |

### Observations

| Method | Endpoint                       | Auth Required | Used By      | Description                              |
| ------ | ------------------------------ | ------------- | ------------ | ---------------------------------------- |
| GET    | /api/projects/:id/observations | No            | Mobile & Web | Get all project observations             |
| POST   | /api/projects/:id/observations | No            | Mobile       | Submit a new observation                 |
| PATCH  | /api/projects/observations/:id | No            | Mobile       | Edit an observation from current session |

## Local Development

1. Navigate to the backend folder: `cd backend`
2. Install dependencies: `npm install`
3. Create a `.env` file and ask a teammate for the environment variables.
4. Run the app: `npm run dev`

## Deployment

The backend is hosted on Fly.io. To deploy backend updates:

1. Navigate to the backend folder: `cd backend`
2. Run: `fly deploy`

## Notes

The project connects to a Supabase database. `db/schema.sql` is provided as a
reference if you ever need to inspect the database structure.
