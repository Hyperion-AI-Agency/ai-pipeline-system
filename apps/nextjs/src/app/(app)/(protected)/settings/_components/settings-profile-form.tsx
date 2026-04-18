"use client";

import { useState } from "react";
import { authClient } from "@/server/auth/auth-client";
import { useTRPCClient } from "@/server/trpc/trpc";
import { useForm } from "@tanstack/react-form";
import { Loader2 } from "lucide-react";
import { useTranslations } from "next-intl";
import { toast } from "sonner";
import { z, type ZodIssue } from "zod";

import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Field, FieldError } from "@/components/ui/field";
import { Input } from "@/components/ui/input";

interface User {
  id: string;
  name: string;
  email: string;
  image?: string | null;
}

interface SettingsProfileFormProps {
  user: User;
}

const MAX_IMAGE_SIZE = 1024 * 1024;
const ALLOWED_IMAGE_TYPES = ["image/jpeg", "image/jpg", "image/png", "image/gif", "image/webp"];

function fileToBase64(file: File): Promise<string> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = () => {
      const result = reader.result as string;
      resolve(result.split(",")[1]!);
    };
    reader.onerror = reject;
    reader.readAsDataURL(file);
  });
}

const nameSchema = z
  .string()
  .min(1, "Name is required")
  .max(100, "Name must be less than 100 characters")
  .trim();

const imageSchema = z
  .instanceof(File)
  .optional()
  .refine(
    file => {
      if (!file) return true;
      return file.size <= MAX_IMAGE_SIZE;
    },
    { message: "Image size must be less than 1MB" }
  )
  .refine(
    file => {
      if (!file) return true;
      return ALLOWED_IMAGE_TYPES.includes(file.type);
    },
    { message: "Image must be JPG, PNG, or GIF" }
  );

export function SettingsProfileForm({ user: initialUser }: SettingsProfileFormProps) {
  const t = useTranslations("dashboard.settings.profile");
  const trpcClient = useTRPCClient();
  const [profileImage, setProfileImage] = useState<File | null>(null);
  const [imagePreview, setImagePreview] = useState<string | null>(null);
  const [isUpdating, setIsUpdating] = useState(false);
  const [imageError, setImageError] = useState<string | null>(null);
  const [lastSavedName, setLastSavedName] = useState(initialUser.name || "");

  const form = useForm({
    defaultValues: {
      name: initialUser.name || "",
    },
    validators: {
      onChange: z.object({ name: nameSchema }),
    },
    onSubmit: async ({ value }) => {
      setIsUpdating(true);
      try {
        const trimmedName = value.name.trim();
        let imageUrl: string | undefined;

        if (profileImage) {
          const base64 = await fileToBase64(profileImage);
          const result = await trpcClient.profile.uploadAvatar.mutate({
            image: base64,
            mimeType: profileImage.type as "image/jpeg" | "image/png" | "image/gif" | "image/webp",
          });
          imageUrl = result.url;
        }

        await authClient.updateUser({
          name: trimmedName,
          ...(imageUrl && { image: imageUrl }),
        });

        toast.success(t("profileUpdated"));
        setLastSavedName(trimmedName);
        if (imageUrl) {
          setImagePreview(null);
          setProfileImage(null);
          window.location.reload();
        }
      } catch {
        toast.error(t("profileUpdateFailed"));
      } finally {
        setIsUpdating(false);
      }
    },
  });

  const currentName = form.state.values.name.trim();
  const isDirty = currentName !== lastSavedName || profileImage !== null;

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      setImageError(null);
      const validationResult = imageSchema.safeParse(file);
      if (!validationResult.success) {
        const imgError = validationResult.error.issues.find(
          (err: ZodIssue) => err.path[0] === "image" || err.path.length === 0
        );
        if (imgError) {
          setImageError(imgError.message);
          e.target.value = "";
          return;
        }
      }
      setProfileImage(file);
      const reader = new FileReader();
      reader.onloadend = () => setImagePreview(reader.result as string);
      reader.readAsDataURL(file);
    }
  };

  const initials = form.state.values.name
    .split(" ")
    .map(n => n[0])
    .join("")
    .toUpperCase();

  return (
    <form
      onSubmit={e => {
        e.preventDefault();
        e.stopPropagation();
        form.handleSubmit();
      }}
      className="space-y-6"
    >
      <div className="space-y-1.5">
        <label className="text-foreground text-sm">{t("fullName")}</label>
        <div className="flex items-center gap-3">
          <button
            type="button"
            onClick={() => document.getElementById("profile-image-input")?.click()}
            className="shrink-0 focus:outline-none"
            disabled={isUpdating}
            title={t("changePhoto")}
          >
            <Avatar className="h-10 w-10">
              <AvatarImage src={imagePreview || initialUser.image || ""} />
              <AvatarFallback className="bg-foreground text-background text-sm font-medium">
                {initials || "?"}
              </AvatarFallback>
            </Avatar>
          </button>
          <input
            id="profile-image-input"
            type="file"
            accept="image/*"
            onChange={handleImageChange}
            className="hidden"
          />
          <form.Field name="name">
            {field => {
              const isInvalid = field.state.meta.isTouched && !field.state.meta.isValid;
              return (
                <Field data-invalid={isInvalid} className="flex-1">
                  <Input
                    id={field.name}
                    name={field.name}
                    value={field.state.value}
                    onChange={e => field.handleChange(e.target.value)}
                    onBlur={field.handleBlur}
                    placeholder={t("fullNamePlaceholder")}
                    disabled={isUpdating}
                    aria-invalid={isInvalid}
                    className="border-input"
                  />
                  {isInvalid && <FieldError errors={field.state.meta.errors} />}
                </Field>
              );
            }}
          </form.Field>
        </div>
        {imageError && <p className="mt-1 text-sm text-red-500">{imageError}</p>}
      </div>

      <Button type="submit" disabled={isUpdating || !isDirty}>
        {isUpdating ? (
          <>
            <Loader2 className="mr-2 h-4 w-4 animate-spin" />
            {t("saving")}
          </>
        ) : (
          t("saveChanges")
        )}
      </Button>
    </form>
  );
}
