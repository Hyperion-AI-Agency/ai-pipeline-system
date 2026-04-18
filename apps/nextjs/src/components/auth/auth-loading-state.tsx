import { Loader2 } from "lucide-react";

interface AuthLoadingStateProps {
  message: string;
}

export function AuthLoadingState({ message }: AuthLoadingStateProps) {
  return (
    <div className="w-full max-w-md">
      <div className="flex flex-col items-center gap-4">
        <Loader2 className="text-primary h-8 w-8 animate-spin" />
        <p className="text-muted-foreground text-sm">{message}</p>
      </div>
    </div>
  );
}
