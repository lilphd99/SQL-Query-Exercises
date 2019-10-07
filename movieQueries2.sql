# Q1. Find the names of all reviewers who rated Gone with the Wind.

SELECT DISTINCT name
FROM Movie
INNER JOIN Rating USING(mID)
INNER JOIN Reviewer USING(rID)
WHERE title = 'Gone with the Wind';

# Q2. For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.

SELECT name, title, stars
FROM Movie
INNER JOIN Rating USING(mID)
INNER JOIN Reviewer USING(rID)
WHERE name = director;

# Q3. Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".)

SELECT title FROM Movie
UNION
SELECT name FROM Reviewer
ORDER BY name, title;

# Q4. Find the titles of all movies not reviewed by Chris Jackson.

SELECT DISTINCT title
FROM Movie
EXCEPT
SELECT title
FROM Movie, Rating, Reviewer
WHERE Rating.rID = Reviewer.rID AND Movie.mID = Rating.mID and name = 'Chris Jackson';

# Q5. For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order.

SELECT DISTINCT rv1.name, rv2.name
FROM Reviewer rv1, Reviewer rv2, Rating r1, Rating r2
WHERE r1.mID = r2.mID
AND r1.rID = rv1.rID
AND r2.rID = rv2.rID
AND rv1.name < rv2.name
ORDER BY rv1.name, rv2.name;

# Q6. For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars.

SELECT name, title, stars
FROM MOVIE
INNER JOIN Rating USING(mID)
INNER JOIN Reviewer USING(rID)
WHERE stars = (SELECT MIN(stars) FROM Rating);

# Q7. List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order.

SELECT title, AVG(stars)
FROM Movie
INNER JOIN Rating USING(mID)
GROUP BY title
ORDER BY AVG(stars) DESC, title;

# Q8. Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.)

SELECT name
FROM Reviewer
WHERE (SELECT COUNT(rID) from Rating WHERE Reviewer.rID = Rating.rID) >= 3; 

# Q9. Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.)

SELECT title, director
FROM Movie m1
WHERE (SELECT COUNT(director) FROM Movie m2 WHERE m1.director = m2.director) > 1
ORDER BY director, title;

# Q10. Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.)

SELECT title, AVG(stars) AS average
FROM Movie
INNER JOIN Rating USING(mID)
GROUP BY mID
HAVING average = (
    SELECT MAX(average_stars)
    FROM (
        SELECT title, AVG(stars) AS average_stars
        FROM Movie
        INNER JOIN Rating USING(mID)
        GROUP BY mID
    )
);

# Q11. Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.)

SELECT title, AVG(stars) AS average
FROM Movie
INNER JOIN Rating USING(mID)
GROUP BY mID
HAVING average = (
    SELECT MIN(average_stars)
    FROM (
        SELECT title, AVG(stars) AS average_stars
        FROM Movie
        INNER JOIN Rating USING(mID)
        GROUP BY mID
    )
);

# Q12. For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL.

SELECT director, title, MAX(stars)
FROM Movie
INNER JOIN Rating USING(mId)
WHERE director IS NOT NULL
GROUP BY director;
