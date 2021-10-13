USE noble__example;

CREATE TABLE noble (
year_ int ,
subject varchar(50),
winner varchar(50)
);
INSERT INTO noble
(year_,subject,winner)
VALUES 
(1960,'Chemistry','Willard F. Libby');

/* Question 1*/
SELECT * FROM noble n ;

/* Question 2 */

SELECT n.winner 
FROM noble n 
WHERE year_ = 1962
AND subject = 'Literature';

/* Question 3 */

SELECT n.year_ ,n.subject 
FROM noble n 
WHERE winner ='Albert Einstein ',

/* Question 4 */

SELECT n.winner 
FROM noble n 
WHERE year_ >= 2000;

/* Question 5 */

SELECT *
FROM noble n 
WHERE year_ BETWEEN 1980 AND 1989;

/* Question 6 */















