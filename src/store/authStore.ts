import { create } from 'zustand';
import type { User } from '../types';
import { getCurrentUser, signIn, signOut } from '../utils/auth';

interface AuthState {
  user: User | null;
  loading: boolean;
  error: Error | null;
  signIn: (email: string, password: string) => Promise<void>;
  signOut: () => Promise<void>;
  initialize: () => Promise<void>;
}

export const useAuthStore = create<AuthState>((set) => ({
  user: null,
  loading: true,
  error: null,
  signIn: async (email, password) => {
    try {
      set({ loading: true, error: null });
      const user = await signIn(email, password);
      set({ user, loading: false });
    } catch (error) {
      set({ error: error as Error, loading: false });
    }
  },
  signOut: async () => {
    try {
      set({ loading: true, error: null });
      await signOut();
      set({ user: null, loading: false });
    } catch (error) {
      set({ error: error as Error, loading: false });
    }
  },
  initialize: async () => {
    try {
      set({ loading: true, error: null });
      const user = await getCurrentUser();
      set({ user, loading: false });
    } catch (error) {
      set({ error: error as Error, loading: false });
    }
  },
}));