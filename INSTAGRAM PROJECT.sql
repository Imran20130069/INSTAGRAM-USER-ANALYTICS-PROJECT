use ig_clone;
-- Q1 Loyal User Reward.
-- Identify the five oldest users on Instagram from the provided database.
SELECT 
    *
FROM
    USERS
ORDER BY CREATED_AT
LIMIT 5;
 
 
--   Q2--- Inactive User Engagement:
-- Identify users who have never posted a single photo on Instagram.
SELECT 
    USERNAME , IMAGE_URL
FROM
    USERS AS U
        LEFT JOIN
    PHOTOS AS P ON P.USER_ID = U.ID WHERE IMAGE_URL IS NULL;
    
-- Q3 Contest Winner Declaration
--  Determine the winner of the contest and provide their details to the team.

SELECT PHOTOS.USER_ID  , USERNAME, COUNT(P.PHOTO_ID) AS TOTAL_LIKES FROM PHOTOS INNER JOIN  LIKES ON LIKES.PHOTO_ID = PHOTOS.ID
 INNER JOIN USERS ON PHOTOS.USER_ID = USERS.ID
 GROUP BY PHOTOS.ID 
 ORDER BY TOTAL_LIKES DESC 
 LIMIT 1;

-- Q4 Hashtag Research:
-- Identify and suggest the top five most commonly used hashtags on the platform. 

SELECT * FROM tags , photo_tags;

SELECT 
    TAG_NAME, COUNT(TAG_NAME ) AS MOST_COMMON_TAG
FROM TAGS AS T
INNER JOIN PHOTO_TAGS AS P ON T.ID = P.TAG_ID
GROUP BY TAG_NAME
ORDER BY MOST_COMMON_TAG DESC
LIMIT 5;

-- Q5 Ad Campaign Launch: 
-- Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign.
SELECT DAYNAME(CREATED_AT) AS DAY, COUNT(*) AS MOST_USER_REGISTER  FROM USERS
GROUP BY DAY
ORDER BY MOST_USER_REGISTER DESC LIMIT 2 ; 

-- B) Investor Metrics:

-- Q1 User Engagement:
-- Calculate the average number of posts per user on Instagram. Also, provide the total number of photos on Instagram divided by the total number of users.
SELECT
 (SELECT COUNT(*) FROM PHOTOS ) / (SELECT COUNT(*) FROM USERS) AS AVERAGE_USERS;
 SELECT * FROM PHOTOS , USERS;
WITH BASE AS  (SELECT USERS.ID AS USERID,COUNT(PHOTOS.ID) AS PHOTOID FROM USERS 
 LEFT JOIN PHOTOS ON PHOTOS.USER_ID= USERS.ID GROUP BY USERS.ID )
 SELECT SUM(PHOTOID) AS TOTAL_PHOTOS , COUNT(USERID) AS TOTAL_USERS, SUM(PHOTOID)/COUNT(USERID) AS AVERAGEUSERS FROM BASE ;


--  Q2 Bots & Fake Accounts: 
--   Identify users (potential bots) who have liked every single photo on the site, as this is not typically possible for a normal user.
 SELECT * FROM LIKES , USERS;
WITH BASE AS (
 SELECT USERS.USERNAME , COUNT(LIKES.PHOTO_ID) AS USER_LIKES FROM LIKES INNER JOIN USERS ON USERS.ID = LIKES.USER_ID
GROUP BY USERS.USERNAME)
SELECT USERNAME , USER_LIKES FROM BASE WHERE USER_LIKES = (SELECT COUNT(*) FROM PHOTOS ) ORDER BY USERNAME ;






