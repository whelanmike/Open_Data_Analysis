.mode duckbox
.timer on
.open ./database/general_analysis.duckdb

create schema if not exists mot;
-- drop table if exists mot.staging_test_data;

create table mot.staging_test_data  as
    select
           test_id
          ,vehicle_id
          ,test_date
          ,test_class_id
          ,test_type
          ,test_result
          ,test_mileage
          ,postcode_area
          ,make
          ,model
          ,colour
          ,fuel_type
          ,cylinder_capacity
          ,first_use_date
    from  read_csv ('*.txt.gz'
                    , header=True
                    ,quote='"'
                    ,DATEFORMAT = '%Y-%m-%d'
                    ,ESCAPE = '\'
                    ,sep='|'
                    ,store_rejects = true           -- log failures
                    ,columns =
                    {
                     'test_id'           : 'BIGINT'
                    ,'vehicle_id'        : 'BIGINT'
                    ,'test_date'         : 'DATE'
                    ,'test_class_id'     : 'BIGINT'
                    ,'test_type'         : 'VARCHAR'
                    ,'test_result'       : 'VARCHAR'
                    ,'test_mileage'      : 'varchar'
                    ,'postcode_area'     : 'VARCHAR'
                    ,'make'              : 'VARCHAR'
                    ,'model'             : 'VARCHAR'
                    ,'colour'            : 'VARCHAR'
                    ,'fuel_type'         : 'VARCHAR'
                    ,'cylinder_capacity' : 'varchar'
                    ,'first_use_date'    : 'DATE'
                    }
                   )
;


insert into mot.staging_test_data
    select 
           test_id          
          ,vehicle_id       
          ,test_date        
          ,test_class_id    
          ,test_type        
          ,test_result      
          ,test_mileage     
          ,postcode_area    
          ,make             
          ,model            
          ,colour           
          ,fuel_type        
          ,cylinder_capacity
          ,first_use_date       
    from  read_csv ('*.csv.gz'
                    , header=True
                    ,quote='"'
                    ,DATEFORMAT = '%Y-%m-%d'
                    ,ESCAPE = '\'
                    ,sep=','
                    ,store_rejects = true           -- log failures
                    ,columns = 
                    {
                     'test_id'           : 'BIGINT'
                    ,'vehicle_id'        : 'BIGINT'
                    ,'test_date'         : 'DATE'
                    ,'test_class_id'     : 'BIGINT'
                    ,'test_type'         : 'VARCHAR'
                    ,'test_result'       : 'VARCHAR'
                    ,'test_mileage'      : 'varchar'
                    ,'postcode_area'     : 'VARCHAR'
                    ,'make'              : 'VARCHAR'
                    ,'model'             : 'VARCHAR'
                    ,'colour'            : 'VARCHAR'
                    ,'fuel_type'         : 'VARCHAR'
                    ,'cylinder_capacity' : 'varchar'
                    ,'first_use_date'    : 'DATE'               
                    }
                   )
;

insert into mot.staging_test_data
    select 
           test_id          
          ,vehicle_id       
          ,test_date        
          ,test_class_id    
          ,test_type        
          ,test_result      
          ,test_mileage     
          ,postcode_area    
          ,make             
          ,model            
          ,colour           
          ,fuel_type        
          ,cylinder_capacity
          ,first_use_date       
    from  read_csv ('*.qcsv.gz'
                    , header=True
                    ,quote='"'
                    ,DATEFORMAT = '%Y-%m-%d'
                    ,ESCAPE = '\'
                    ,sep=','
                    ,store_rejects = true           -- log failures
                    ,columns = 
                    {
                     'test_id'           : 'BIGINT'
                    ,'vehicle_id'        : 'BIGINT'
                    ,'test_date'         : 'DATE'
                    ,'test_class_id'     : 'BIGINT'
                    ,'test_type'         : 'VARCHAR'
                    ,'test_result'       : 'VARCHAR'
                    ,'test_mileage'      : 'varchar'
                    ,'postcode_area'     : 'VARCHAR'
                    ,'make'              : 'VARCHAR'
                    ,'model'             : 'VARCHAR'
                    ,'colour'            : 'VARCHAR'
                    ,'fuel_type'         : 'VARCHAR'
                    ,'cylinder_capacity' : 'varchar'
                    ,'first_use_date'    : 'DATE'               
                    }
                   )
;


create table if not exists mot.reject_errors as 
    select * from reject_errors
;

select 
       count(line)              as records_log
      ,count(distinct line)     as records_rejected
from  mot.reject_errors
;
select 
      year(test_date)       as test_year
      ,count(vehicle_id)    as test_count
from  mot.staging_test_data
group by all
order by 1
;


