#!/usr/bin/bash
# Invalid character data in column 9, 17 of atp_matches_2023.csv
# Backup original.
cp atp_matches_2023.csv atp_matches_ORIG_2023.csv
# 0) Write new file with clean data.
# Include Header
head -n1 atp_matches_ORIG_2023.csv  > new_file.txt

# 1) Match both [$9, $17] (3 records)
cat atp_matches_ORIG_2023.csv | awk -F, 'BEGIN {OFS=","}; NR>1 && $9 ~ /[[:alpha:]]/ && $17 ~ /[[:alpha:]]/ {$9=""; $17=""; print NR,  $0}'

# 2) Match $9 (28 records -- 3 dupes)
cat atp_matches_ORIG_2023.csv | awk -F, 'BEGIN {OFS=","}; NR>1 && $9 ~ /[[:alpha:]]/ {$9=""; print  $0}'
# 2a) Match $9 (25 records) Remove dupes by piping into #1
cat atp_matches_ORIG_2023.csv | awk -F, 'BEGIN {OFS=","}; NR>1 && $17 ~ /[[:alpha:]]/ {$17=""; print  $0}' | awk -F, 'BEGIN {OFS=","}; $9 !~ /[[:alpha:]]/ && $17 !~ /[[:alpha:]]/ {print  $0}'

# 3) Match $9 (28 records -- 3 dupes)
cat atp_matches_ORIG_2023.csv | awk -F, 'BEGIN {OFS=","}; NR>1 && $17 ~ /[[:alpha:]]/ {$17=""; print  $0}'
# 3a) Match $9 (25 records) Remove dupes by piping into #1
cat atp_matches_ORIG_2023.csv | awk -F, 'BEGIN {OFS=","}; NR>1 && $9 ~ /[[:alpha:]]/ {$9=""; print  $0}' | awk -F, 'BEGIN {OFS=","}; $9 !~ /[[:alpha:]]/ && $17 !~ /[[:alpha:]]/ {print  $0}'

# 4) Match all others
cat atp_matches_ORIG_2023.csv | awk -F, 'BEGIN {OFS=","}; NR>1 && $9 !~ /[[:alpha:]]/ && $17 !~ /[[:alpha:]]/ {print $0}' |  wc -l


# ===========================================================================
#All in one 
head -n1 atp_matches_ORIG_2023.csv  > new_file.txt
cat atp_matches_ORIG_2023.csv | awk -F, 'BEGIN {OFS=","}; NR>1 && $9 ~ /[[:alpha:]]/ && $17 ~ /[[:alpha:]]/ {$9=""; $17=""; print $0}' >> new_file.txt
cat atp_matches_ORIG_2023.csv | awk -F, 'BEGIN {OFS=","}; NR>1 && $17 ~ /[[:alpha:]]/ {$17=""; print  $0}' | awk -F, 'BEGIN {OFS=","}; $9 !~ /[[:alpha:]]/ && $17 !~ /[[:alpha:]]/ {print  $0}' >> new_file.txt
cat atp_matches_ORIG_2023.csv | awk -F, 'BEGIN {OFS=","}; NR>1 && $9 ~ /[[:alpha:]]/ {$9=""; print  $0}' | awk -F, 'BEGIN {OFS=","}; $9 !~ /[[:alpha:]]/ && $17 !~ /[[:alpha:]]/ {print  $0}' >> new_file.txt
cat atp_matches_ORIG_2023.csv | awk -F, 'BEGIN {OFS=","}; NR>1 && $9 !~ /[[:alpha:]]/ && $17 !~ /[[:alpha:]]/ {print $0}' >> new_file.txt

#Rename cleansed file
mv new_file.txt atp_matches_2023.csv

