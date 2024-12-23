export interface Database {
  public: {
    Tables: {
      users: {
        Row: {
          id: string;
          username: string;
          email: string;
          name: string;
          role: 'admin' | 'user';
          profileUrl?: string;
          createdAt: string;
        };
        Insert: Omit<Database['public']['Tables']['users']['Row'], 'id' | 'createdAt'>;
        Update: Partial<Database['public']['Tables']['users']['Insert']>;
      };
      tasks: {
        Row: {
          id: string;
          title: string;
          description: string;
          status: 'pending' | 'in_progress' | 'completed' | 'reviewed';
          documentUrl: string;
          assignedTo: string;
          score?: number;
          createdAt: string;
          updatedAt: string;
        };
        Insert: Omit<Database['public']['Tables']['tasks']['Row'], 'id' | 'createdAt' | 'updatedAt'>;
        Update: Partial<Database['public']['Tables']['tasks']['Insert']>;
      };
      task_submissions: {
        Row: {
          id: string;
          taskId: string;
          userId: string;
          content: string;
          score?: number;
          status: 'pending_review' | 'reviewed';
          createdAt: string;
          updatedAt: string;
        };
        Insert: Omit<Database['public']['Tables']['task_submissions']['Row'], 'id' | 'createdAt' | 'updatedAt'>;
        Update: Partial<Database['public']['Tables']['task_submissions']['Insert']>;
      };
    };
  };
}