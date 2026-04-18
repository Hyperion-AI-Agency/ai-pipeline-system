interface AuthFormHeaderProps {
  title: string;
  subtitle?: string;
}

export function AuthFormHeader({ title, subtitle }: AuthFormHeaderProps) {
  return (
    <div className="mb-8">
      <h1 className="mb-2 text-2xl font-semibold">{title}</h1>
      {subtitle && <h2 className="text-muted-foreground text-sm">{subtitle}</h2>}
    </div>
  );
}
