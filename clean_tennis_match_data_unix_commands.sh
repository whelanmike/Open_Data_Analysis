#!/bin/bash

# Backup file with inconsistent data.
mv atp_matches_2023.csv atp_matches_ORIG_2023.csv

# Fields 9, 17 have alpha characters that are causing issues.
# These fields are defined as INT in the database.
# We are going to remove these characters. (40 lines impacted).
#   Looks like these characters should be in the subsequent columns (10, 18).
#   That's for another day.
cat atp_matches_ORIG_2023.csv | awk -F,                     \
                'BEGIN {OFS=","}                            \
                {if ($9 ~/[Q,LL,WC]/ ||  $17 ~/[Q,LL,WC]/)  \
                    {                                       \
                    gsub(/[[:alpha:]]/, "", $9);            \
                    gsub(/[[:alpha:]]/, "", $17);           \
                        print  $0                           \
                    }                                       \
                else                                        \
                    {print $0}                              \
                }' > atp_matches_2023.csv

