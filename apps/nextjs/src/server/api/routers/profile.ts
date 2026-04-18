import { mkdir, writeFile } from "fs/promises";
import path from "path";
import { createTRPCRouter, protectedProcedure } from "@/server/api/trpc";
import { TRPCError } from "@trpc/server";
import sharp from "sharp";
import { z } from "zod";

const MAX_IMAGE_SIZE = 1024 * 1024; // 1MB
const ALLOWED_MIME_TYPES = ["image/jpeg", "image/png", "image/gif", "image/webp"] as const;

export const profileRouter = createTRPCRouter({
  uploadAvatar: protectedProcedure
    .input(
      z.object({
        image: z.string().min(1),
        mimeType: z.enum(ALLOWED_MIME_TYPES),
      })
    )
    .mutation(async ({ ctx, input }) => {
      const buffer = Buffer.from(input.image, "base64");

      if (buffer.length > MAX_IMAGE_SIZE) {
        throw new TRPCError({ code: "BAD_REQUEST", message: "Image must be less than 1MB" });
      }

      const avatarsDir = path.join(process.cwd(), "public", "avatars");
      await mkdir(avatarsDir, { recursive: true });

      const filename = `${ctx.session.user.id}-${Date.now()}.webp`;
      const filepath = path.join(avatarsDir, filename);

      const webpBuffer = await sharp(buffer)
        .resize(256, 256, { fit: "cover" })
        .webp({ quality: 80 })
        .toBuffer();

      await writeFile(filepath, webpBuffer);

      return { url: `/avatars/${filename}` };
    }),
});
