-- Step 1: Explore the Data

-- 1.1 Check the structure of the table
PRAGMA table_info(songs);

-- 1.2 Count total rows
SELECT COUNT(*) AS total_rows FROM songs;

-- 1.3 Preview the first 5 rows
SELECT * FROM songs LIMIT 5;

-- 1.4 Check for missing values in key columns
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN track_id IS NULL OR track_id = '' THEN 1 ELSE 0 END) AS missing_track_id,
    SUM(CASE WHEN artists IS NULL OR artists = '' THEN 1 ELSE 0 END) AS missing_artists,
    SUM(CASE WHEN album_name IS NULL OR album_name = '' THEN 1 ELSE 0 END) AS missing_album_name,
    SUM(CASE WHEN track_name IS NULL OR track_name = '' THEN 1 ELSE 0 END) AS missing_track_name,
    SUM(CASE WHEN popularity IS NULL THEN 1 ELSE 0 END) AS missing_popularity
FROM songs;

-- Step 2: Clean the Data

-- 2.1 Remove rows with missing values
DELETE FROM songs WHERE track_id IS NULL OR track_id = '';
DELETE FROM songs WHERE artists IS NULL OR artists = '';
DELETE FROM songs WHERE album_name IS NULL OR album_name = '';
DELETE FROM songs WHERE track_name IS NULL OR track_name = '';
DELETE FROM songs WHERE popularity IS NULL;

-- 2.2 Check for duplicate track IDs
SELECT track_id, COUNT(*) 
FROM songs 
GROUP BY track_id 
HAVING COUNT(*) > 1;

-- 2.3 Remove duplicate rows, keeping the first occurrence
DELETE FROM songs
WHERE rowid NOT IN (
    SELECT MIN(rowid)
    FROM songs
    GROUP BY track_id
);

-- 2.4 Standardize 'explicit' column (convert TRUE/FALSE to 1/0)
UPDATE songs SET explicit = '1' WHERE explicit = 'TRUE';
UPDATE songs SET explicit = '0' WHERE explicit = 'FALSE';

-- 2.5 Detect outliers in numerical columns
SELECT 
    MIN(popularity) AS min_popularity, 
    MAX(popularity) AS max_popularity,
    MIN(duration_ms) AS min_duration,
    MAX(duration_ms) AS max_duration
FROM songs;

-- Optional: Remove extreme song durations (less than 30 sec or more than 10 min)
DELETE FROM songs WHERE duration_ms < 30000 OR duration_ms > 600000;

-- 2.6 Standardize text formatting (capitalize track_name & artists)
UPDATE songs 
SET track_name = UPPER(SUBSTR(track_name, 1, 1)) || LOWER(SUBSTR(track_name, 2));

UPDATE songs 
SET artists = UPPER(SUBSTR(artists, 1, 1)) || LOWER(SUBSTR(artists, 2));

--to avoid error in case of re-running this code later
DROP TABLE IF EXISTS songs_cleaned;

-- 2.7 Save cleaned data into a new table as backup
--CREATE TABLE songs_cleaned AS SELECT * FROM songs;

--Final verification of cleaned data
SELECT * FROM songs_cleaned LIMIT 10;



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



