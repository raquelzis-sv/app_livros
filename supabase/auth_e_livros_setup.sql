-- Executado no SQL Editor do Supabase

-- 1) Coluna para vincular cada livro ao usuário autenticado
ALTER TABLE public."Livros"
ADD COLUMN IF NOT EXISTS user_id uuid REFERENCES auth.users(id);

-- 2) Ativar Row Level Security
ALTER TABLE public."Livros" ENABLE ROW LEVEL SECURITY;

-- 3) Remover políticas antigas (se existirem) e recriar
DROP POLICY IF EXISTS "Usuário vê seus livros" ON public."Livros";
DROP POLICY IF EXISTS "Usuário insere seus livros" ON public."Livros";
DROP POLICY IF EXISTS "Usuário atualiza seus livros" ON public."Livros";
DROP POLICY IF EXISTS "Usuário exclui seus livros" ON public."Livros";

CREATE POLICY "Usuário vê seus livros"
ON public."Livros"
FOR SELECT
TO authenticated
USING (auth.uid() = user_id);

CREATE POLICY "Usuário insere seus livros"
ON public."Livros"
FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Usuário atualiza seus livros"
ON public."Livros"
FOR UPDATE
TO authenticated
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Usuário exclui seus livros"
ON public."Livros"
FOR DELETE
TO authenticated
USING (auth.uid() = user_id);
