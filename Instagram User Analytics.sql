/* A) Marketing: */

/* Finding 5 oldest users */

SELECT * FROM users
ORDER BY created_at
LIMIT 5;

/*Find the users who have never posted a single photo on Instagram*/

SELECT
	users.id,
    username,
    users.created_at as user_joining_date
FROM users
    LEFT JOIN photos
        ON users.id = photos.user_id
    WHERE photos.user_id IS NULL;

/*Identify the winner of the contest and provide their details to the team */
SELECT
    users.id AS user_id,
    username,
	photos.id AS photo_id,
    photos.image_url,
    COUNT(*) AS total_likes_count
FROM photos
    JOIN likes
        ON photos.id = likes.photo_id
    JOIN users
        ON users.id = photos.user_id
    GROUP BY photos.id
    ORDER BY total_likes_count DESC
    LIMIT 1;

/*Identify and suggest the top 5 most commonly used hashtags on the platform*/
 
SELECT
    tags.id AS tag_id,
    tags.tag_name,
    COUNT(*) as total_tags_count
FROM tags
    JOIN photo_tags
        ON tags.id = photo_tags.tag_id
    GROUP BY tags.id
    ORDER BY total_tags_count DESC
    LIMIT 5;


/*What day of the week do most users register on? Provide insights on when to schedule an ad campaign*/
 
SELECT
	id,
    username,
    created_at,
    DAYNAME(created_at) AS day_of_the_week,
    COUNT(*) AS total_count
FROM users
    GROUP by day_of_the_week
    ORDER by total_count DESC;
    
/* B) Investor Metrics:*/

 /* Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of users*/
 
select user_id,count(id) total_number_of_post,avg(id) as average
from photos
group by user_id;


/* Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).*/

SELECT
    users.id AS user_id,
    users.username,
    COUNT(*) AS total_user_likes
FROM users
    JOIN likes
        ON users.id = likes.user_id
    GROUP BY users.id
    HAVING total_user_likes = (
        SELECT COUNT(*) FROM photos
    );
