# DuckDB `DESCRIBE` clause infers data_types for each column in the file.
# Load this output to the file 'DuckDB_suggested_cols.txt'
# and run the command below to format.
cat DuckDB_suggested_cols.txt | awk '{OFS=";"}  {print ",'\''"$1"'\''", ":'\''"$2"'\''"}' | column -s';' -t
