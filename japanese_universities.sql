## Inspect data columns types
DESCRIBE jpn_uni;

/* Retrieve all columns and display the first 10 rows of the dataset */
SELECT * FROM jpn_uni LIMIT 10;

### Identify missing values in the 'review_rating' column ###
SELECT
	(
		SELECT COUNT(*)
		FROM jpn_uni
		WHERE review_rating IS NULL OR review_rating = ''
	) AS review_rating_missing,
	COUNT(*) AS tatal_universities
FROM
	jpn_uni;

/* Result: Total 813 universities and has 15 review_rating_missing values */

/* Identify missing values in the and 'difficulty_SD' column */
SELECT 
	(
		SELECT COUNT(*)
		FROM jpn_uni
		WHERE difficulty_SD IS NULL OR difficulty_SD = ''
	) AS difficulty_SD_missing,
    COUNT(*) AS tatal_universities
FROM
	jpn_uni;

/* Result: Total 813 universities and has 59 difficulty_SD_missing values */

/* Number of university types */
SELECT
	COUNT(DISTINCT type) AS num_university_types
FROM
	jpn_uni;

/* Result: There are 3 types of university types */

/* List all the types of universities */
SELECT
	DISTINCT type
FROM
	jpn_uni;
    
/* Investigate the number of states the universities are spread across */
SELECT
	COUNT(DISTINCT state) AS num_states
FROM
	jpn_uni;

/* Result: All the universities are spread across 47 states. */

/* Investigate the number of universities in each state */
SELECT
	state,
    COUNT(name)
FROM
	jpn_uni
GROUP BY
	state
ORDER BY
	COUNT(state) DESC;

/* The top 10 states with the highest number of universities */
SELECT
	state,
    COUNT(name)
FROM
	jpn_uni
GROUP BY
	state
ORDER BY
	COUNT(state) DESC LIMIT 10;    

/* Number of universities belongs to each type */
SELECT 
    type,
    COUNT(name) AS count
FROM
	jpn_uni
GROUP BY
	type;

/* Number of postal codes are available in the dataset */
SELECT 
	COUNT(DISTINCT postal_code) AS num_postal_codes
FROM
	jpn_uni;

/* Result: There are 804 unique postal codes in the dataset */

/* Number of universities belonging to each Postal Code */
SELECT
	postal_code,
	COUNT(name) AS count
FROM
	jpn_uni
GROUP BY
	postal_code
ORDER BY
	COUNT(name) DESC;
    
/* Examine the distribution of universities according to their type within each state */
SELECT
	State,
    COUNT(CASE WHEN type = 'National' THEN name END) AS 'National Universities',
    COUNT(CASE WHEN type = 'Private' THEN name END) AS 'Private Universities',
    COUNT(CASE WHEN type = 'Public' THEN name END) AS 'Public Universities',
    COUNT(name) AS 'Total Universities'
FROM
	jpn_uni
GROUP BY
	state
ORDER BY
	COUNT(name) DESC;

/* Identify the top 10 states with the highest number of National, Public, and Private universities. */
/* National Universities */
SELECT
	State,
    COUNT(name) AS 'National Universities'
FROM
	jpn_uni
WHERE
	type = 'national'
GROUP BY
	state
ORDER BY
	COUNT(name) DESC LIMIT 10;

/* Public Universities */
SELECT
	State,
    COUNT(name) AS 'Public Universities'
FROM
	jpn_uni
WHERE
	type = 'public'
GROUP BY
	state
ORDER BY
	COUNT(name) DESC LIMIT 10;
    
/* Private Universities */
SELECT
	State,
    COUNT(name) AS 'Private Universities'
FROM
	jpn_uni
WHERE
	type = 'private'
GROUP BY
	state
ORDER BY
	COUNT(name) DESC LIMIT 10;
    
/* Determine the maximum, average, and minimum faculty counts for each type of university */
SELECT
	type,
    MAX(faculty_count) AS max_faculty_count,
    AVG(faculty_count) AS avg_faculty_count,
    MIN(faculty_count) As min_faculty_count
FROM
	jpn_uni
GROUP BY
	type;
    
/* Determine the maximum, average, and minimum department counts for each type of university */
SELECT
	type,
    MAX(department_count) AS max_department_count,
    AVG(department_count) AS avg_department_count,
    MIN(department_count) As min_department_count
FROM
	jpn_uni
GROUP BY
	type;
    
/* Explore the availability of graduate schools for each type of university */
SELECT
	type,
    COUNT(CASE WHEN has_grad = 'TRUE' THEN name END) AS 'has_grad=TRUE',
    COUNT(CASE WHEN has_grad = 'FALSE' THEN name END) AS 'has_grad=FALSE'
FROM
	jpn_uni
GROUP BY
	type;
	
/* Explore the availability of remote learning option for each type of university */
SELECT
	type,
    COUNT(CASE WHEN has_remote = 'TRUE' THEN name END) AS 'has_remote=TRUE',
    COUNT(CASE WHEN has_remote = 'FALSE' THEN name END) AS 'has_remote=FALSE'
FROM
	jpn_uni
GROUP BY
	type;

/* Analyze the average review ratings and review counts for each type of university, as well as a combination of both */
SELECT
	type,
    AVG(review_rating) AS 'avg_review_rating'
FROM
	jpn_uni
GROUP BY
	type
ORDER BY
	AVG(review_rating) DESC;
    
SELECT
	type,
    AVG(review_count) AS 'avg_review_count'
FROM
	jpn_uni
GROUP BY
	type
ORDER BY
	AVG(review_count) DESC;
    
SELECT
	type,
    AVG(review_count) AS 'avg_review_count',
    AVG(review_rating) AS 'avg_review_rating'
FROM
	jpn_uni
GROUP BY
	type
ORDER BY
    AVG(review_rating) DESC;
    
/* Explore the distribution of universities according to their difficulty rank. */
SELECT
	difficulty_rank,
    COUNT(name) AS 'Count'
FROM
	jpn_uni
GROUP BY
	difficulty_rank;
