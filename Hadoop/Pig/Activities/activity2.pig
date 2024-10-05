-- Load input file from HDFS
inputFile = LOAD 'hdfs:///user/nithya/input.txt' AS (line);
-- Tokeize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words from the above stage
grpd = GROUP words BY word;
-- Count the occurence of each word (Reduce)
totalCount = FOREACH grpd GENERATE group, COUNT(words);
--remove old results folder
rmf hdfs:///user/nithya/PigResult;
-- Store the result in HDFS
STORE cntd INTO 'hdfs:///user/nithya/PigResult';
