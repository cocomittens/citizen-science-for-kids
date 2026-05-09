if (!process.env.JWT_SECRET) {
  throw new Error("JWT_SECRET environment variable is not set");
}
if (!process.env.DATABASE_URL) {
  throw new Error("DATABASE_URL environment variable is not set");
}

export const JWT_SECRET = process.env.JWT_SECRET;
export const DATABASE_URL = process.env.DATABASE_URL;
