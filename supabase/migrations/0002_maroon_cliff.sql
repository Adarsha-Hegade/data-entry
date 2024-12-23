/*
  # Create Admin User

  1. Changes
    - Insert admin user into auth.users
    - Set admin role in users table
*/

-- Create admin user in auth.users
insert into auth.users (
  instance_id,
  id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  raw_app_meta_data,
  raw_user_meta_data,
  created_at,
  updated_at,
  confirmation_token,
  email_change,
  email_change_token_new,
  recovery_token
) values (
  '00000000-0000-0000-0000-000000000000',
  gen_random_uuid(),
  'authenticated',
  'authenticated',
  'admin2014',
  crypt('Qazplm@#$201404', gen_salt('bf')),
  now(),
  '{"provider":"email","providers":["email"]}',
  '{"name":"Admin User"}',
  now(),
  now(),
  '',
  '',
  '',
  ''
) on conflict (email) do nothing;

-- Set admin role
update public.users
set role = 'admin'
where email = 'admin2014';