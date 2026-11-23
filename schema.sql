-- Priorité du ménage — exécuter dans Supabase > SQL Editor > New query
create extension if not exists pgcrypto;
create table if not exists public.members (
  id uuid primary key default gen_random_uuid(),
  name text not null check (length(trim(name)) > 0)
);
create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  title text not null check (length(trim(title)) > 0)
);
create table if not exists public.ratings (
  member_id uuid not null references public.members(id) on delete cascade,
  task_id uuid not null references public.tasks(id) on delete cascade,
  score integer not null check (score between 0 and 10),
  primary key (member_id, task_id)
);
alter table public.members enable row level security;
alter table public.tasks enable row level security;
alter table public.ratings enable row level security;
-- App familiale simple : accès anon complet. Adaptez ces règles si le projet
-- est exposé au public ou contient des informations sensibles.
do $$
declare t text; op text;
begin
  foreach t in array array['members','tasks','ratings'] loop
    foreach op in array array['select','insert','update','delete'] loop
      execute format('drop policy if exists "anon %s %s" on public.%I', op, t, t);
      if op = 'select' then
        execute format('create policy "anon %s %s" on public.%I for select to anon using (true)', op, t, t);
      elsif op = 'insert' then
        execute format('create policy "anon %s %s" on public.%I for insert to anon with check (true)', op, t, t);
      elsif op = 'update' then
        execute format('create policy "anon %s %s" on public.%I for update to anon using (true) with check (true)', op, t, t);
      else
        execute format('create policy "anon %s %s" on public.%I for delete to anon using (true)', op, t, t);
      end if;
    end loop;
  end loop;
end $$;
grant usage on schema public to anon;
grant select, insert, update, delete on public.members, public.tasks, public.ratings to anon;
