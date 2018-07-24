Data Source:

"Raw data from online personality tests" http://personality-testing.info/_rawdata/

Answers to the Big Five Personality Test, constructed with items from the International Personality Item Pool.

Description:
50 likert rated statements, gender, age, race, native language, country
n = 19719

Download link for zipped folder with CSV: http://personality-testing.info/_rawdata/BIG5.zip

I renamed the file to "big5.csv" 
May need to change extension to .txt to get programs to read the data as separate columns (I had to do that for Excel but not Google Sheets).

Data cleaning:
- 1 case had 0 (missing) on all personality variables, so that case was deleted. (1 of 19,719)
- Cases with ages above 80 were deleted (most appeared to be either missing data codes or years that could not be easily recoded). (87 of 19,719)
- Cases with invalid country codes were deleted. (377 of 19,719)
- Any remaining cases with missing values on demographics variables were deleted
- Final n for complete cases: 18,931 of 19,719 = 96%

Simplified data:
- b5.csv contains only the 50 Big 5 variables