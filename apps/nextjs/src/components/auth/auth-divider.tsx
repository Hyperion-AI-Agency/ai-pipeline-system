import { Separator } from "@/components/ui/separator";

interface AuthDividerProps {
  text: string;
}

export function AuthDivider({ text }: AuthDividerProps) {
  return (
    <div className="relative my-6 flex items-center">
      <Separator className="flex-1" />
      <span className="bg-background text-muted-foreground px-4 text-xs">{text}</span>
      <Separator className="flex-1" />
    </div>
  );
}
