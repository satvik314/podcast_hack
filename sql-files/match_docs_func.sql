-- Create a function to search for podcasts
CREATE FUNCTION match_podcasts_v2 (
  query_transcript_vec vector(1536),
  match_count INT DEFAULT NULL
) RETURNS TABLE (
  uuid UUID,
  username TEXT,
  topic TEXT,
  language TEXT,
  voice TEXT,
  audio_length NUMERIC,
  transcript TEXT,
  transcript_vec vector(1536),
  similarity FLOAT
)
LANGUAGE plpgsql
AS $$
#variable_conflict use_column
BEGIN
  RETURN QUERY
  SELECT
    uuid,
    username,
    topic,
    language,
    voice,
    audio_length,
    transcript,
    transcript_vec,
    1 - (podcasts_db.transcript_vec <=> query_transcript_vec) AS similarity
  FROM podcasts_db
  ORDER BY podcasts_db.transcript_vec <=> query_transcript_vec
  LIMIT match_count;
END;
$$;
