import Image from "next/image";

import { Logo } from "@/components/branding/logo";

interface AuthSidePanelProps {
  title: string;
  description: string;
  bgColor?: "blue" | "red";
}

export async function AuthSidePanel({ title, description, bgColor = "blue" }: AuthSidePanelProps) {
  const bgClass = bgColor === "red" ? "bg-red-100" : "bg-blue-50";

  return (
    <div className={`relative hidden ${bgClass} lg:flex lg:w-2/5 lg:flex-col lg:px-12`}>
      {/* Grain Texture Overlay */}
      <div className="absolute inset-0 z-0 opacity-10">
        <Image
          src="/assets/Grain-Texture.png"
          alt="Grain texture"
          fill
          className="object-cover"
          priority
        />
      </div>

      <div className="relative z-10 mb-8 pt-6">
        <Logo />
      </div>
      <div className="relative z-10 flex flex-1 flex-col justify-center">
        <div className="max-w-md">
          <h2 className="text-foreground mb-4 text-4xl font-semibold">{title}</h2>
          <p className="text-muted-foreground text-lg leading-relaxed">{description}</p>
        </div>
      </div>
    </div>
  );
}
