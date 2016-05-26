# okcandidate-analysis

Contains all data taken from results of Norfolk okcandidate election with SQL scripts to rearrange and output data into CSVs for data analysis. 

## Data
In the election_analysis directory are CSVs with the data from the candidates surveys, the website surveys, and the results of the real election. A Python Notebook `election_analysis.ipynb` with some initial analyses and lots of room for improvement/expansion runs through these CSVs.

## Setup Database
Following the same steps from the 'Database Setup' section of https://github.com/Code4HR/okcandidate


1. Open `okcandidate_database_create.sql` and make the following modifications:  
  1. Uncomment the header section in lines 1-11`
  2. Change `survey_manager` and the corresponding password to your desired username and password in line 3
  3. change `username` in lines 7 and 11 to the username you specified in step 2

2. From the main directory, create tables and insert sample data with
`psql -d okcandidate -a -f okcandidate_database_create.sql`  
`psql -d okcandidate -a -f okcandidate_database_sampledata.sql`  

## Data analysis
To add the results of the election to the database, in the `restore` directory:    
1. Open `restore.sql` and follow the instructions in the header comments.  
2. In command line, run `psql -d okcandidate -a -f restore.sql`  

The database now contains all election results, if you would like to:  

Add the results of the real election to a new table, run:  
`psql -d okcandidate -a -f import_real_results.sql`, making sure the path to `real_results.txt` is correct.  

Rearrange the tables for output/ease of use, run:  
`psql -d okcandidate -a -f newformat.sql`  

Output the tables to CSV:  
1. Return to main directory  
2. Open `dumptocsv.sql`, change paths to desired directory  
3. Run `psql -d okcandidate -a -f dumptocsv.sql`  
This will output the files that are already in the `election_analysis` directory. The commented code produces the output used to produce the Tableau visualizations and can be easily modified to include any other aggregations desired.
