/* 1 
What grades are stored in the database? */	
SELECT * 
FROM Grade;

/* 2 
What emotions may be associated with a poem? */	
SELECT *
FROM Emotion;

/* 3 
How many poems are in the database?*/	
SELECT COUNT(*) AS TotalPoems
FROM Poem;

/* 4 
Sort authors alphabetically by name. What are the names of the top 76 authors? */	
SELECT TOP 76 Name
FROM Author
ORDER BY Name ASC;

/* 5 
Starting with the above query, add the grade of each of the authors. */	
SELECT Author.Name, Grade.Name AS Grade
FROM Author
LEFT JOIN Grade
	ON Author.GradeId = Grade.Id;

/* 6 
Starting with the above query, add the recorded gender of each of the authors. */	
SELECT Author.Name, Gender.Name, Grade.Name AS Grade
FROM Author
LEFT JOIN Grade
	ON Author.GradeId = Grade.Id
LEFT JOIN Gender
	ON Author.GenderId = Gender.Id;

/* 7 
What is the total number of words in all poems in the database?  */	
SELECT SUM(WordCount)
FROM Poem;

/* 8 
Which poem has the fewest characters?  */	
SELECT MIN(WordCount) AS WordCount
FROM Poem;

/* 9
How many authors are in the third grade?  */	
SELECT DISTINCT g.Name as Grade, SUM(a.GradeId) as Authors
FROM Grade g
LEFT JOIN Author a
	ON g.id = a.GradeId
GROUP BY g.Name
HAVING g.Name = '3rd Grade';

/* 10 
How many authors are in the first, second or third grades?  */
SELECT DISTINCT g.Name as Grade, SUM(a.GradeId) as Authors
FROM Grade g
LEFT JOIN Author a
	ON g.id = a.GradeId
WHERE g.name = '1st Grade'
	OR g.name = '2nd Grade'
	OR g.name = '3rd Grade'
GROUP BY g.Name

/* 11
What is the total number of poems written by fourth graders?  */
SELECT g.name as Grade, COUNT(p.id) AS Poems
FROM Grade g
LEFT JOIN Author a
	ON g.id = a.GradeId
LEFT JOIN Poem p
	ON a.id = p.AuthorId
GROUP BY g.name
HAVING g.name = '4th Grade';

/* 12 
How many poems are there per grade?  */
SELECT g.name as Grade, COUNT(p.id) AS Poems
FROM Grade g
LEFT JOIN Author a
	ON g.id = a.GradeId
LEFT JOIN Poem p
	ON a.id = p.AuthorId
GROUP BY g.name;

/* 13 
How many authors are in each grade? (Order your results by grade starting with 1st Grade)  */
SELECT g.name as Grade, COUNT(a.id) AS Authors
FROM Grade g
LEFT JOIN Author a
	ON g.id = a.GradeId
GROUP BY g.name;

/* 14 
What is the title of the poem that has the most words?  */
SELECT Title, WordCount
FROM Poem
WHERE WordCount = (
	SELECT MAX(WordCount)
	FROM Poem);

/* 15 
Which author(s) have the most poems? (Remember authors can have the same name.)  */
SELECT TOP 1 a.Name, COUNT(p.id) AS Poems
FROM Author a
LEFT JOIN Poem p
	ON a.id = p.AuthorId
GROUP BY a.id, a.name
ORDER BY COUNT(p.id) DESC;

/* 16 
How many poems have an emotion of sadness?  */
SELECT e.Name, COUNT(p.id) AS Poems
FROM Emotion e
LEFT JOIN PoemEmotion pe
	ON e.id = pe.EmotionId
LEFT JOIN Poem p
	ON pe.PoemId = p.id
GROUP BY e.name
HAVING e.name = 'Sadness';

/* 17 
How many poems are not associated with any emotion?  */
SELECT COUNT(pe.PoemId) AS PoemsWithoutEmotion
FROM Emotion e
LEFT JOIN PoemEmotion pe
	ON e.id = pe.EmotionId
LEFT JOIN Poem p
	ON pe.PoemId = p.id
WHERE pe.EmotionId IS NULL
GROUP BY p.id;

/* 18 
Which emotion is associated with the least number of poems?  */
SELECT TOP 1 e.Name, COUNT(p.id) AS Poems
FROM Emotion e
LEFT JOIN PoemEmotion pe
	ON e.id = pe.EmotionId
LEFT JOIN Poem p
	ON pe.PoemId = p.id
GROUP BY e.Name
ORDER BY COUNT(p.id) ASC;

/* 19 
Which grade has the largest number of poems with an emotion of joy?  */
SELECT TOP 1 g.name AS Grade, COUNT(p.id) AS JoyPoems
FROM Grade g
LEFT JOIN Author a
	ON g.id = a.GradeId
LEFT JOIN Poem p
	ON a.id = p.AuthorId
LEFT JOIN PoemEmotion pe
	ON p.id = pe.PoemId
WHERE pe.EmotionID = 4
GROUP BY g.Name
ORDER BY COUNT(p.id) DESC;

SELECT * FROM Emotion

/* 20 
Which gender has the least number of poems with an emotion of fear?  */
SELECT TOP 1 g.name AS Grade, COUNT(p.id) AS FearPoems
FROM Gender g
LEFT JOIN Author a
	ON g.id = a.GenderId
LEFT JOIN Poem p
	ON a.id = p.AuthorId
LEFT JOIN PoemEmotion pe
	ON p.id = pe.PoemId
WHERE pe.EmotionID = 2
GROUP BY g.Name
ORDER BY COUNT(p.id) ASC;
