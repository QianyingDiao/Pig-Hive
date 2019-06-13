grunt> i_bigrams = LOAD 'i-bigrams/*'
>> AS (bigram: chararray, year: int, occurrences: int, books:int);


grunt> grouped = GROUP i_bigrams BY bigram;


grunt> filtered = FILTER grouped BY (MIN(i_bigrams.year) == 1950 AND COUNT(i_bigrams.year) == 60);


grunt> outputs = FOREACH filtered GENERATE group AS bigram, SUM(i_bigrams.occurrences) AS total_occ, SUM(i_bigrams.books) AS total_books, (FLOAT) SUM(i_bigrams.occurrences)/SUM(i_bigrams.books) AS average, MIN(i_bigrams.year) AS first_year, MAX(i_bigrams.year) AS last_year, COUNT(i_bigrams.year) AS number_year;


grunt> outputs_desc = ORDER outputs BY average DESC;


grunt> results = LIMIT outputs_desc 50;


grunt> STORE results INTO 'pig-results' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',');
