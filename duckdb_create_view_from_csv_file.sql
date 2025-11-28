-- Requires duckDB version v1.4.1 or later.
-- This version gets the (i) column names, (ii) data types and the (iii) delimiter from the csv_sniffer.
-- BEWARE of the consequences of 'store_rejects' setting. https://duckdb.org/docs/stable/data/csv/reading_faulty_csv_files#reject-errors
/*
  Use as follows:-
  1) 
  -- set file_search_path = '/path_to_csv_file_directory'
  select 
        definition
  from  generate_table_from_csv_normalize_cols('some_data.csv');
  2)
  - Query 1 generates SQL code to create view from csv file.
  - Copy & Pase output to query editor.
  - Review all column names and data types.
  - Search/Replace '--:' to use the normalised column names, e.g. ColumnName --> column_name.
*/

create or replace macro generate_table_from_csv_normalize_cols(csv_file_name) as table
    with c_table_metadata as 
        (
        select 
               delimiter
              ,unnest(col_name_and_type) 
        from  (
              select 
                     delimiter
                    ,UNNEST (columns)     as col_name_and_type
              FROM  sniff_csv(csv_file_name, sample_size = 1000)
              ) 
        )
        ,c_delim as 
        (
        select distinct delimiter from c_table_metadata 
        )
        ,c_col_metadata as
        (
        select 
               format('{:02d}', row_number() over())                                      as col_id
              ,name                                                                       as column_name
              ,regexp_replace(name       , '([a-z0-9])([A-Z])', '\1_\2', 'g').lower()     as col_name_normalized
              ,len(name       )                                                           as col_len
              ,max(col_len) over()                                                        as mx_len
              ,repeat(' ', (mx_len - col_len) + 3)                                        as spacing
              ,type                                                                       as column_type
        from  c_table_metadata
        )
        select 'create or replace view v_' || lower(replace(csv_file_name, '.csv', '')) ||  ' as  -- **** RENAME AS REQUIRED ****' as definition
        union all
        select '    select '
        union all
        select 
              case when col_id =1 then '           ' else '          ,' end   || (column_name) || spacing ||  '--: as '  || lower(col_name_normalized) 
        from  c_col_metadata
        union all 
        select '    from  read_csv'
        union all 
        select '              (''' ||  csv_file_name || '''' 
        union all            
        select '              ,sep='  || '''' ||  concat(delimiter, '''                               -- Using sniffed value of delimiter.') from c_delim 
        union all            
        select '              --,quote=''"' || '''' || '                           -- Include if csv data is quoted.'
        union all            
        select '              --,DATEFORMAT = ''' || '%m/%d/%Y' || ''''  || '             -- Convert Dates to ISO-8601 format.' 
        union all            
        select '              ,header = True' || '                         -- comment out if no field names in file. Required names & types can be added below in columns section.'
        union all            
        select '              ,store_rejects = True' || '                  -- select * from reject_errors;'
        union all            
        select '              --,ignore_errors=True' || '                  -- Mutually Exclusive with store_rejects option.'
        union all            
        select '              --,nullstr=''NA'''  || '                        -- Use to convert string to null e.g. N\A, NA, etc.'
        union all            
        select '              ,columns = ' || '                            -- Data types are not always inferred correctly. Validate column list below. '
        union all            
        select '                  { '       
        union all            
        select 
              case when col_id =1 then '                   ' else '                  ,' end   ||  ''''  || (column_name) || '''' 
              || spacing || ':''' || column_type || ''''  || repeat(' ', 12-len(column_type)) || '-- (' || col_id || ')'
              as output
        from  c_col_metadata
        union all 
        select '                  } '       
        union all 
        select '              )'      
        union all 
        select ';' 
        union all 
        select '' 
        union all 
        select 'select * from reject_errors;  -- Check for loading errors:- run this after querying the view created above.'            

