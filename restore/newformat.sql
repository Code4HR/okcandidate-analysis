
--Makes the victory column
ALTER TABLE candidate
ADD COLUMN victory text;

--Adds victory outcomes for Norfolk
UPDATE candidate
set victory = 'No';

UPDATE candidate
set victory = 'Yes'
where  candidate_name= 'Kenneth Cooper Alexander' 
or candidate_name='Andria P. McClellan' 
or candidate_name='Angelia Williams Graves';

--Sort candidate table to original order after inserting victory
CREATE VIEW candidate_view AS 
SELECT * from candidate
ORDER BY id;

SELECT * INTO candidate_temp from candidate_view;
DROP TABLE candidate CASCADE;
ALTER TABLE candidate_temp RENAME to candidate;

--Fix geography issues, add third category for all city election, remake candidate_geography to reflect this.
INSERT INTO geography VALUES (3,'City');

DROP TABLE candidate_geography;
CREATE TABLE candidate_geography(
id INT,
candidate_id INT,
geography_id INT);

INSERT INTO candidate_geography
VALUES 
(1,1,3),
(2,2,3),
(3,3,3),
(4,4,1),
(5,5,1),
(6,6,1),
(7,7,2),
(8,8,2),
(9,9,2),
(10,10,2);


--Create okelection results table
CREATE TABLE okelection_results(
	answer_id int, 
	question_id int, 
	count int, 
	intensity_avg decimal);

INSERT INTO okelection_results
(SELECT answer_id, question_id, COUNT(id) as popular_vote, AVG(intensity) as avg_intensity
FROM survey_answer 
GROUP BY answer_id, question_id 
ORDER BY answer_id);




