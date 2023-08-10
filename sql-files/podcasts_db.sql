CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE podcasts_db (
    uuid UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    id SERIAL,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null, 
    username TEXT,
    topic TEXT,
    language TEXT,
    voice TEXT,
    audio_length NUMERIC,
    transcript TEXT,
    category TEXT, 
    transcript_vec vector(1536)
);