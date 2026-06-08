set file_search_path = '/file_location/'

create or replace macro export_csv_to_parquet(csv_file_name) as table
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
                  select 'copy ('
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
        union all select '              ) '      
        union all select '      ) TO '        
        || '''' || current_setting('file_search_path') || '\' || lower(replace(csv_file_name, '.csv', '.parquet')) || ' '' (FORMAT parquet);'
;   


select * from  export_csv_to_parquet('some_csv_file.csv')
