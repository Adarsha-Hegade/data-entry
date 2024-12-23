/*
  # Create Admin User

  1. Changes
    - Create admin user through auth.users() function
    - Set admin role in users table
*/

-- Create admin user if not exists
DO $$
DECLARE
  new_user_id uuid;
BEGIN
  -- Check if user already exists
  IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'admin2014') THEN
    -- Create user through auth functions
    new_user_id := auth.uid();
    
    INSERT INTO auth.users (
      id,
      email,
      raw_user_meta_data,
      raw_app_meta_data,
      encrypted_password,
      email_confirmed_at
    ) VALUES (
      new_user_id,
      'admin2014',
      '{"name":"Admin User"}',
      '{"provider":"email","providers":["email"]}',
      crypt('Qazplm@#$201404', gen_salt('bf')),
      now()
    );

    -- Set admin role
    UPDATE public.users
    SET role = 'admin'
    WHERE id = new_user_id;
  END IF;
END $$;