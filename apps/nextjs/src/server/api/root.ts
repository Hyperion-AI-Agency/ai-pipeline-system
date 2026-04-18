import { profileRouter } from "@/server/api/routers/profile";
import { threadsRouter } from "@/server/api/routers/threads";
import { createCallerFactory, createTRPCRouter } from "@/server/api/trpc";

export const appRouter = createTRPCRouter({
  threads: threadsRouter,
  profile: profileRouter,
});
export type AppRouter = typeof appRouter;
export const createCaller = createCallerFactory(appRouter);
