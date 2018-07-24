# DM_09_03.R

# INSTALL AND LOAD PACKAGES ################################

pacman::p_load(pacman, tm, SnowballC, dplyr)

# IMPORT DATA ##############################################

# Don't need to specify file path if file is in the same 
# directory or folder as the R script. Also, the metadata 
# has already been stripped from beginning and end of text
# files.

# "Jane Eyre" by Charlotte Brontë, published 1847
bookJE <- readLines('JaneEyre.txt')

# "Wuthering Heights" by Emily Brontë, also published 1847
bookWH <- readLines('WutheringHeights.txt')

# CORPUS FOR JANE EYRE #####################################

# Note: Most of the operations take a moment or two. Make
# sure to let them finish before moving to the next step.

# Preliminary corpus
corpusJE <- Corpus(VectorSource(bookJE)) %>%
            tm_map(removePunctuation) %>%
            tm_map(removeNumbers) %>%
            tm_map(content_transformer(tolower)) %>%
            tm_map(removeWords, stopwords("english")) %>%
            tm_map(stripWhitespace) %>%
            tm_map(stemDocument)

# Create term-document matrices & remove sparse terms
tdmJE <- DocumentTermMatrix(corpusJE) %>%
         removeSparseTerms(1 - (5/length(corpusJE)))

# Calculate and sort by word frequencies
word.freqJE <- sort(colSums(as.matrix(tdmJE)), 
                 decreasing = T)

# Create frequency table
tableJE <- data.frame(word = names(word.freqJE), 
             absolute.frequency = word.freqJE, 
             relative.frequency = 
             word.freqJE/length(word.freqJE))

# Remove the words from the row names
rownames(tableJE) <- NULL

# Show the 10 most common words
head(tableJE, 10)

# Export the 1000 most common words in CSV files
write.csv(tableJE[1:1000, ], "JE_1000.csv")

# CORPUS FOR WUTHERING HEIGHTS #############################

corpusWH <- Corpus(VectorSource(bookWH)) %>%
  tm_map(removePunctuation) %>%
  tm_map(removeNumbers) %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(removeWords, stopwords("english")) %>%
  tm_map(stripWhitespace) %>%
  tm_map(stemDocument)
tdmWH <- DocumentTermMatrix(corpusWH) %>%
  removeSparseTerms(1 - (5/length(corpusWH)))
word.freqWH <- sort(colSums(as.matrix(tdmWH)), 
  decreasing = T)
tableWH <- data.frame(word = names(word.freqWH), 
  absolute.frequency = word.freqWH, 
  relative.frequency = word.freqWH/length(word.freqWH))
rownames(tableWH) <- NULL
head(tableWH, 10)
write.csv(tableWH[1:1000, ], "WH_1000.csv")

# MOST DISTINCTIVE WORDS ###################################

# Set number of digits for output
options(digits = 2)

# Compare relative frequencies (via subtraction)
bronte <- tableJE %>%
            merge(tableWH, by = "word") %>%
            mutate(dProp = 
              relative.frequency.x -
              relative.frequency.y,
              dAbs = abs(dProp)) %>%
           arrange(desc(dAbs)) %>%
           rename(JE.freq = absolute.frequency.x,
             JE.prop = relative.frequency.x,
             WH.freq = absolute.frequency.y,
             WH.prop = relative.frequency.y)

# Show the 10 most distinctive terms
head(bronte, 10)

# View table of all results
View(bronte)  

# Save full table to CSV
write.csv(bronte, "bronte_table.csv")

# CLEAN UP #################################################

# Clear workspace
rm(list = ls()) 

# Clear packages
p_unload(pacman, tm, SnowballC, dplyr)

# Clear console
cat("\014")  # ctrl+L
