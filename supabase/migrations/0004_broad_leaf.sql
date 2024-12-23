/*
  # Create admin user

  1. Changes
    - Create admin user in auth.users table
    - Create corresponding entry in public.users table
    - Set admin role and username
*/

-- Create admin user
DO $$
DECLARE
  new_user_id uuid := gen_random_uuid();
BEGIN
  -- Insert into auth.users without ON CONFLICT
  INSERT INTO auth.users (
    id,
    instance_id,
    email,
    encrypted_password,
    email_confirmed_at,
    raw_app_meta_data,
    raw_user_meta_data,
    created_at,
    updated_at,
    role,
    aud
  ) VALUES (
    new_user_id,
    '00000000-0000-0000-0000-000000000000',
    'admin2014',
    crypt('Qazplm@#$201404', gen_salt('bf')),
    now(),
    '{"provider":"email","providers":["email"]}',
    '{"name":"Admin User"}',
    now(),
    now(),
    'authenticated',
    'authenticated'
  );

  -- Insert into public.users
  INSERT INTO public.users (
    id,
    email,
    name,
    role
  ) VALUES (
    new_user_id,
    'inktypedesigns@gmail.com',
    'Admin User',
    'admin'
  );

EXCEPTION WHEN unique_violation THEN
  -- Do nothing if user already exists
END $$;