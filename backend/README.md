# Backend

Node.js/Express REST API serving both the mobile and web applications.

## Tech Stack

- Node.js with Express
- TypeScript
- PostgreSQL (Supabase)

## Getting Started

1. Navigate to the backend folder: `cd backend`
2. Install dependencies: `npm install`
3. Create a `.env` file and ask a teammate for the environment variables.
   For JWT_SECRET, generate your own by entering this command in the terminal:
   `node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"`
   Copy that string into your `.env` file.
4. Run the app: `npm run dev`

## Notes

The project currently connects to a Supabase database managed by one of the team members.
`db/schema.sql` is provided as a reference if you ever need to set up your own database.
