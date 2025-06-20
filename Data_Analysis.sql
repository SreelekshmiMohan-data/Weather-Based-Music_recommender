-- Step 3: Data Analysis

-- 3.1 Top 10 most popular songs
SELECT track_name, artists, popularity 
FROM songs_cleaned 
ORDER BY popularity DESC 
LIMIT 10;
--The most popular track is 'Comedy' by Gen Hoshino

-- 3.2 Average popularity by genre
SELECT track_genre, AVG(popularity) AS avg_popularity
FROM songs_cleaned
GROUP BY track_genre
ORDER BY avg_popularity DESC;
--The highest average popularity is for k-pop genre and the least popularity is for 'iranian'. 'Indian' (personal favorite) comes at 8th position in the ranking


-- 3.3 Top 10 most popular artists based on popularity
SELECT artists, COUNT(track_id) AS total_songs, AVG(popularity) AS avg_popularity
FROM songs_cleaned
GROUP BY artists
ORDER BY avg_popularity DESC, total_songs DESC
LIMIT 10;
--The most popular artist is the duo Sam Smith & Kim Petras

-- 3.4 Most common keys in songs
SELECT key, COUNT(*) AS count 
FROM songs_cleaned 
GROUP BY key 
ORDER BY count DESC;
-- The top most common key is '7', and the least common is '3'

-- 3.5 Songs with the highest danceability
SELECT track_name, artists, danceability 
FROM songs_cleaned 
ORDER BY danceability DESC 
LIMIT 10;
--The top-most song with danceability is Sol Clap by Quantic

-- 3.6 Relationship between energy and popularity
SELECT 
    CASE 
        WHEN energy < 0.3 THEN 'Low Energy'
        WHEN energy BETWEEN 0.3 AND 0.7 THEN 'Medium Energy'
        ELSE 'High Energy'
    END AS energy_level,
    AVG(popularity) AS avg_popularity
FROM songs_cleaned
GROUP BY energy_level;
-- Medium enery is the most popular, followed by High Energy. Low Energy has the least popularity


-- 3.7 Average duration of songs by genre (converted to minutes)
SELECT track_genre, AVG(duration_ms)/60000 AS avg_duration_min
FROM songs_cleaned
GROUP BY track_genre
ORDER BY avg_duration_min DESC;
-- The genre 'Minimal-techno' has the most duration, and  'grindcore' has the minimum duration. 'Indian' songs have a duration of approx 3.9 min



