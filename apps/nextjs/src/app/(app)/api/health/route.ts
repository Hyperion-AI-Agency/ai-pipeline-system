import { NextResponse } from "next/server";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";

/**
 * Health check endpoint for load balancers and Coolify.
 * GET /api/health returns 200 with { status: "healthy" }.
 */
export async function GET() {
  return NextResponse.json({ status: "healthy" }, { status: 200 });
}
