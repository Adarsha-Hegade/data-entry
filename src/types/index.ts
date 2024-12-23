export type { Database } from './database';

export type User = Database['public']['Tables']['users']['Row'];
export type Task = Database['public']['Tables']['tasks']['Row'];
export type TaskSubmission = Database['public']['Tables']['task_submissions']['Row'];