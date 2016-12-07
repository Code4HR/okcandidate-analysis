--Search for $$PATH$$ and replace with desired output directory.

/*
--output popular to a csv
copy (select survey_answer.id as survey_id, survey_answer.question_id, survey_answer.answer_id, question.question_text,
	answer.answer_label, category.category_name, survey_answer.intensity, geography.geography_name  
from survey_answer 
join question 
on survey_answer.question_id = question.id
join category
on question.category_id = category.id
join answer
on survey_answer.answer_id = answer.id
join survey_response
on survey_answer.survey_response_id = survey_response.id
join geography
on survey_response.geography_id = geography.id)
to '$$PATH$$/popular_results.csv' with csv header;
*/

/*
--output candidates
copy(select candidate.candidate_name, question.question_text, answer.answer_label, question.id as question_id, 
	answer.id as answer_id, category.category_name, candidate.id as candidate_id, candidate.victory,
	candidate_answer.intensity, candidate_type.type_name, geography.geography_name, real_results.total_votes, 
	real_results.percentage_votes, okelection_results.count as okelection_votes, okelection_results.intensity_avg
from candidate_answer
join question
on candidate_answer.question_id = question.id
join category
on question.category_id = category.id
join answer
on candidate_answer.answer_id = answer.id
join candidate
on candidate_answer.candidate_id = candidate.id
join candidate_type
on candidate.candidate_type_id = candidate_type.id
join candidate_geography
on candidate.id = candidate_geography.candidate_id
join geography
on candidate_geography.geography_id = geography.id
join real_results
on candidate.candidate_name = real_results.candidate_name
join okelection_results
on answer.id = okelection_results.answer_id)
to '$$PATH$$/candidate_results.csv' with csv header;
*/

--output results formatted for python analysis
copy(select * from survey_answer)
to '$$PATH$$/survey_results.csv' with csv header;

copy(select * from candidate_answer 
join candidate 
on candidate_answer.candidate_id = candidate.id)
to '$$PATH$$/candidate_results.csv' with csv header;

copy(select real_results.candidate_name, real_results.total_votes from real_results)
to '$$PATH$$/real_results.csv' with csv header;
