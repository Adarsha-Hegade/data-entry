/*
  # Initial Schema Setup

  1. New Tables
    - `users`
      - `id` (uuid, primary key)
      - `email` (text, unique)
      - `name` (text)
      - `role` (text, enum)
      - `profile_url` (text, optional)
      - `created_at` (timestamp)

  2. Security
    - Enable RLS on users table
    - Add policies for authenticated users
*/

-- Create auth trigger function
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.users (id, email, name, role)
  values (new.id, new.email, new.raw_user_meta_data->>'name', 'user');
  return new;
end;
$$ language plpgsql security definer;

-- Create users table
create table if not exists public.users (
  id uuid references auth.users primary key,
  email text unique not null,
  name text not null,
  role text not null check (role in ('admin', 'user')),
  profile_url text,
  created_at timestamptz default now()
);

-- Enable RLS
alter table public.users enable row level security;

-- Create RLS policies
create policy "Users can read own data"
  on users for select
  to authenticated
  using (auth.uid() = id);

create policy "Users can update own data"
  on users for update
  to authenticated
  using (auth.uid() = id);

-- Create trigger for new user signup
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();