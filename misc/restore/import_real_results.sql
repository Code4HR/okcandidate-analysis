--Copy in the election results
CREATE TABLE real_results(
candidate_name text, 
total_votes int, 
percentage_votes decimal);
COPY real_results(candidate_name, total_votes, percentage_votes)
FROM '$PATH/real_results.txt';