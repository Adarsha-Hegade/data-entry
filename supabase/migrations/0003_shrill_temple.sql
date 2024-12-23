/*
  # Add username field to users table

  1. Changes
    - Add username column to users table
    - Make username unique
    - Update existing admin user with username
*/

-- Add username column
ALTER TABLE public.users
ADD COLUMN username text UNIQUE;

-- Update existing admin user
UPDATE public.users
SET username = 'admin2014'
WHERE email = 'admin2014';

-- Make username required for future records
ALTER TABLE public.users
ALTER COLUMN username SET NOT NULL;