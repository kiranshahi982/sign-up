-- Create contact_submissions table
CREATE TABLE public.contact_submissions (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id),
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  subject TEXT NOT NULL,
  message TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE public.contact_submissions ENABLE ROW LEVEL SECURITY;

-- Create policies for contact submissions
CREATE POLICY "Users can view their own contact submissions" 
ON public.contact_submissions 
FOR SELECT 
USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own contact submissions" 
ON public.contact_submissions 
FOR INSERT 
WITH CHECK (auth.uid() = user_id);

-- Create an index for better performance
CREATE INDEX idx_contact_submissions_user_id ON public.contact_submissions(user_id);
CREATE INDEX idx_contact_submissions_created_at ON public.contact_submissions(created_at);