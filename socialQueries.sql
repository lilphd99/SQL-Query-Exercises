# Q1. Find the names of all students who are friends with someone named Gabriel.

SELECT h1.name
FROM Highschooler h1
INNER JOIN Friend ON h1.ID = Friend.ID1
INNER JOIN Highschooler h2 ON h2.ID = Friend.ID2
WHERE h2.name = 'Gabriel';

# Q2. For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like.

SELECT h1.name, h1.grade, h2.name, h2.grade
FROM Highschooler h1
INNER JOIN Likes ON h1.ID = Likes.ID1
INNER JOIN Highschooler h2 ON h2.ID = Likes.ID2
WHERE (h1.grade - h2.grade) >= 2;

# Q3. For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order.

SELECT h1.name, h1.grade, h2.name, h2.grade
FROM Highschooler h1, Highschooler h2, Likes l1, Likes l2
WHERE (h1.ID = l1.ID1 AND h2.ID = l1.ID2) AND (h2.ID = l2.ID1 AND h1.ID = l2.ID2) AND h1.name < h2.name
ORDER BY h1.name, h2.name;

# Q4. Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.

SELECT name, grade
FROM Highschooler h1
WHERE h1.ID NOT IN(
    SELECT DISTINCT ID1
    FROM Likes
    UNION
    SELECT DISTINCT ID2
    FROM Likes
    )
ORDER BY grade, name;

# Q5. For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.

SELECT h1.name, h1.grade, h2.name, h2.grade
FROM Highschooler h1
INNER JOIN Likes ON h1.ID = Likes.ID1
INNER JOIN Highschooler h2 ON h2.ID = Likes.ID2
WHERE (h1.ID = Likes.ID1 AND h2.ID = Likes.ID2) AND h2.ID NOT IN (
    SELECT DISTINCT ID1
    FROM Likes
);

# Q6. Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade.


# Q7.
