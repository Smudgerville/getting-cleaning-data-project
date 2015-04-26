# getting-cleaning-data-project
Course Project for Getting and Cleaning Data

## About

[Description of the original data](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Files:

- run_analysis.R:  Convert the raw data in folder 'UCI HAR Dataset' [(Downloaded from here)](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) to tidy output
- Codebook.md:  Describes the data
- tidy_out.txt:  Final tidy dataset

## Assumptions and Important Points

### Depends

- Requires packages `dplyr` and `tidyr`

### Filtering by `mean()` and `std()`

These are filtered using the `fixed = TRUE` command in `grep`to specifically exclude `meanFreq()`.
