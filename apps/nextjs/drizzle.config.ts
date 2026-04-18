import { defineConfig } from "drizzle-kit";

import { env } from "./src/env.js";

export default defineConfig({
  schema: "./src/server/db/schemas",
  out: "./src/server/db/migrations",
  dialect: "postgresql",
  dbCredentials: {
    url: env.DATABASE_URL,
  },
});
