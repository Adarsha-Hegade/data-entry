import { supabase } from '../lib/supabase';
import type { User } from '../types';

export async function getCurrentUser(): Promise<User | null> {
  const { data: { session } } = await supabase.auth.getSession();
  if (!session) return null;

  const { data } = await supabase
    .from('users')
    .select('*')
    .eq('id', session.user.id)
    .single();

  return data;
}

export async function signIn(username: string, password: string): Promise<User | null> {
  try {
    // First get the email associated with the username
    const { data: userData, error: userError } = await supabase
      .from('users')
      .select('email')
      .eq('username', username)
      .single();

    if (userError || !userData?.email) {
      console.error('User lookup error:', userError);
      throw new Error('Invalid username or password');
    }

    // Sign in with the email
    const { data: { user }, error: authError } = await supabase.auth.signInWithPassword({
      email: userData.email,
      password,
    });

    if (authError || !user) {
      console.error('Auth error:', authError);
      throw new Error('Invalid username or password');
    }

    // Get the full user profile
    const { data: profile, error: profileError } = await supabase
      .from('users')
      .select('*')
      .eq('id', user.id)
      .single();

    if (profileError || !profile) {
      console.error('Profile fetch error:', profileError);
      throw new Error('Failed to fetch user profile');
    }

    return profile;
  } catch (error) {
    console.error('Sign in error:', error);
    throw error;
  }
}

export async function signOut() {
  const { error } = await supabase.auth.signOut();
  if (error) {
    console.error('Sign out error:', error);
    throw error;
  }
}