// Make sure to install the 'pg' package
import { env } from "@/env";
import { drizzle } from "drizzle-orm/node-postgres";
import { Pool } from "pg";
import type { PoolConfig } from "pg";

const poolConfig: PoolConfig = {
  connectionString: env.DATABASE_URL,
};

const pool = new Pool(poolConfig);

export const db = drizzle({ client: pool, casing: "camelCase" });

export { pool, poolConfig };
