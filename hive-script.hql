hive> INSERT OVERWRITE DIRECTORY 'hive-results'
    > ROW FORMAT DELIMITED
    > FIELDS TERMINATED BY ','
    > SELECT * FROM( SELECT bigram, SUM(occurrences) AS total_occ, SUM(books) AS total_book, SUM(occurrences)/SUM(books) AS average, MIN(year) AS first_year, MAX(year) AS last_year, COUNT(year) AS number_year FROM origin
    > GROUP BY bigram
    > HAVING MIN(year) = 1950 AND MAX(year) = 2009 AND COUNT(year) = 60
    > ORDER BY average DESC
    > LIMIT 50) SUB
    > ORDER BY average ASC;
