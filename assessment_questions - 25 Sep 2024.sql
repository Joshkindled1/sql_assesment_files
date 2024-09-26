USE db;

-- 1. Analyse the data
-- Hint: use a SELECT statement via a JOIN to sample the data
-- ****************************************************************
SELECT *
FROM users u
JOIN progress p
ON u.user_id = p.user_id;

-- 2. What are the Top 25 schools (.edu domains)?
-- Hint: use an aggregate function to COUNT() schools with most students
-- ****************************************************************
SELECT email_domain,
COUNT(user_id) as top_schools
FROM users
GROUP BY email_domain
ORDER BY top_schools DESC
LIMIT 25;


-- 3. How many .edu learners are located in New York?
-- Hint: use an aggregate function to COUNT() students in New York
-- ****************************************************************
SELECT city, COUNT(user_id)
FROM users
WHERE city = 'New York'
GROUP BY city;


-- 4. The mobile_app column contains either mobile-user or NULL. 
-- How many of these learners are using the mobile app?
-- Hint: COUNT()...WHERE...IN()...GROUP BY...
-- Hint: Alternate answers are accepted.
-- ****************************************************************
SELECT mobile_app, COUNT(user_id) AS mobile_users
FROM users
WHERE mobile_app IN ('mobile-user')
GROUP BY mobile_app;

-- 5. Query for the sign up counts for each hour.
-- Hint: https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html#function_date-format 
-- ****************************************************************
SELECT 
    DATE_FORMAT(sign_up_at, '%Y-%m-%d %H:00:00') AS signup_hour,
    COUNT(user_id) AS user_perhour
    from
    users
    GROUP BY signup_hour
    ORDER BY user_perhour DESC;
    
-- 6. What courses are the New Yorker Students taking?
-- Hint: SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking C++"
-- ****************************************************************
SELECT city, SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking C++",
SUM(CASE WHEN learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking SQL",
SUM(CASE WHEN learn_html NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking HTML",
SUM(CASE WHEN learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking JS",
SUM(CASE WHEN learn_java NOT IN('') THEN 1 ELSE 0 END) AS "New Yorker learners taking JAVA"
FROM progress p
JOIN users u
ON u.user_id = p.user_id
WHERE city = 'New York';

-- 7. What courses are the Chicago Students taking?
-- Hint: SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking C++"
-- ****************************************************************
SELECT city, SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking C++",
SUM(CASE WHEN learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking SQL",
SUM(CASE WHEN learn_html NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking HTML",
SUM(CASE WHEN learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking JS",
SUM(CASE WHEN learn_java NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking JAVA"
FROM progress p
JOIN users u
ON u.user_id = p.user_id
WHERE city = 'Chicago';
