-- Run in Supabase SQL Editor after creating your project.
-- Supabase Auth manages passwords and email verification.
create table if not exists public.profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  business_name text not null default '',
  created_at timestamptz not null default now()
);
create table if not exists public.quotes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade default auth.uid(),
  payload jsonb not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index if not exists quotes_user_id_idx on public.quotes(user_id);
alter table public.profiles enable row level security;
alter table public.quotes enable row level security;
revoke all on public.profiles from anon;
revoke all on public.quotes from anon;
grant select,insert,update,delete on public.profiles to authenticated;
grant select,insert,update,delete on public.quotes to authenticated;
drop policy if exists "profiles_owner_select" on public.profiles;
create policy "profiles_owner_select" on public.profiles for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "profiles_owner_insert" on public.profiles;
create policy "profiles_owner_insert" on public.profiles for insert to authenticated with check ((select auth.uid()) = user_id);
drop policy if exists "profiles_owner_update" on public.profiles;
create policy "profiles_owner_update" on public.profiles for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
drop policy if exists "profiles_owner_delete" on public.profiles;
create policy "profiles_owner_delete" on public.profiles for delete to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "quotes_owner_select" on public.quotes;
create policy "quotes_owner_select" on public.quotes for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "quotes_owner_insert" on public.quotes;
create policy "quotes_owner_insert" on public.quotes for insert to authenticated with check ((select auth.uid()) = user_id);
drop policy if exists "quotes_owner_update" on public.quotes;
create policy "quotes_owner_update" on public.quotes for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
drop policy if exists "quotes_owner_delete" on public.quotes;
create policy "quotes_owner_delete" on public.quotes for delete to authenticated using ((select auth.uid()) = user_id);
