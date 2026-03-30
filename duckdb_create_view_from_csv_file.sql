-- Requires duckDB version v1.4.1 or later.
-- This version gets the following information from the csv_sniffer (Also works for .gz files)
--     (i)   column names
--     (ii)  data types
--     (iii) delimiter
-- BEWARE of the consequences of 'store_rejects' setting. https://duckdb.org/docs/stable/data/csv/reading_faulty_csv_files#reject-errors
/*
  After creating the MACRO below, Use as follows:-
  1) 
  -- set file_search_path = '/path_to_csv_file_directory'
  select 
        definition
  from  generate_table_from_csv_normalize_cols('some_data.csv');   -- or .gz file.
  2)
  - Query 1 generates SQL code to create view from csv file.
  - Copy & Paste output to query editor.
  - Review all column names and data types.
  - Search/Replace '--:' to use the normalised column names, e.g. ColumnName --> column_name.
  - ** 'store_rejects' option can mask errors. It's useful for debugging. Execute `select * from reject_errors` after running view.
  3) See duckdb_csv_MACRO_example.png in repo.
      https://github.com/whelanmike/Open_Data_Analysis/blob/main/duckdb_csv_MACRO_example.png
*/

create or replace macro generate_table_from_csv_normalize_cols(csv_file_name) as table
    with c_table_metadata as 
        (
        select 
               delimiter
              ,json_extract_string(col_name_and_type, '$.name')  as column_name
              ,json_extract_string(col_name_and_type, '$.type')  as data_type
        from  (
              select 
                     delimiter
                    ,UNNEST (columns)     as col_name_and_type
              from  sniff_csv(csv_file_name, sample_size = 1000)
              ) 
        )
        ,c_delim as 
        (
        select distinct delimiter from c_table_metadata 
        )
        ,c_col_metadata as
        (
        select 
               col_id             : format('{:02d}', row_number() over())                               
              ,column_name                                                                        
              ,col_name_normalized: regexp_replace(column_name, '([a-z0-9])([A-Z])', '\1_\2', 'g').lower()      -- e.g. UserName --> user_name
              ,col_len            : len(column_name)                                                           
              ,mx_len             : max(col_len) over()                                                 
              ,spacing            : repeat(' ', (mx_len - col_len) + 3)                                 
              ,data_type                                                                
        from  c_table_metadata
        )
                  select 'create or replace view v_' || lower(replace(csv_file_name, '.csv', '')) ||  ' as  -- **** RENAME AS REQUIRED ****' as definition
        union all select '    select '
        union all select 
                        case when col_id =1 then '           ' else '          ,' end   || (column_name) || spacing ||  '--: as '  || lower(col_name_normalized) 
                  from  c_col_metadata
        union all select  '          ,data_source'  || spacing || '''' || csv_file_name || ''' '  from  (select distinct repeat(' ', (mx_len) - 6) || ': '  as  spacing from c_col_metadata)
        union all select '    from  read_csv'
        union all select '              (''' ||  csv_file_name || '''' 
        union all select '              ,sep='  || '''' ||  concat(delimiter, '''                               -- Using sniffed value of delimiter.') from c_delim 
        union all select '              --,quote=''"' || '''' || '                           -- Include if csv data is quoted.'
        union all select '              --,DATEFORMAT = ''' || '%m/%d/%Y' || ''''  || '             -- Convert Dates to ISO-8601 format.' 
        union all select '              ,header = True' || '                         -- comment out if no field names in file. Required names & types can be added in columns section of generated SQL.'
        union all select '              --,store_rejects = True' || '                  -- select * from reject_errors;'
        union all select '              --,ignore_errors=True' || '                  -- Mutually Exclusive with store_rejects option.'
        union all select '              --,nullstr=''NA'''  || '                        -- Use to convert string to null e.g. N\A, NA, etc.'
        union all select '              ,columns = ' || '                            -- Data types are not always inferred correctly. Review and validate column list below. '
        union all select '                  { '       
        union all select 
                        case when col_id =1 then '                   ' else '                  ,' end   ||  ''''  || (column_name) || '''' 
                        || spacing || ':''' || data_type || ''''  || repeat(' ', 25-len(data_type)) || '-- (' || col_id || ')'
                        as output
                  from  c_col_metadata
        union all select '                  } '       
        union all select '              )'      
        union all select ';' 
        union all select '' 
        union all select 'select * from reject_errors;  -- Check for loading errors:- run this after querying the view created above.'            
;        
