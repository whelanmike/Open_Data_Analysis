# Note that newer files are zip format. Before 2017 format is .gz

curl https://data.dft.gov.uk/anonymised-mot-test/test_data/dft_test_result_2023.zip --output ./dft_test_result_2023.zip && unzip dft_test_result_2023.zip && rm dft_test_result_2023.zip
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/dft_test_result_2022.zip --output ./dft_test_result_2022.zip && unzip dft_test_result_2022.zip && rm dft_test_result_2022.zip
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/dft_test_result_2021.zip --output ./dft_test_result_2021.zip && unzip dft_test_result_2021.zip && rm dft_test_result_2021.zip
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/dft_test_result_2020.zip --output ./dft_test_result_2020.zip && unzip dft_test_result_2020.zip && rm dft_test_result_2020.zip
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/dft_test_result_2019.zip --output ./dft_test_result_2019.zip && unzip dft_test_result_2019.zip && rm dft_test_result_2019.zip
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/dft_test_result_2018.zip --output ./dft_test_result_2018.zip && unzip dft_test_result_2018.zip && rm dft_test_result_2018.zip
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/dft_test_result_2017.zip --output ./dft_test_result_2017.zip && unzip dft_test_result_2017.zip && rm dft_test_result_2017.zip

curl https://data.dft.gov.uk/anonymised-mot-test/test_data/test_result_2016.txt.gz --output ./dft_test_result_2016.gz && gunzip dft_test_result_2016.gz && mv ./dft_test_result_2016 ./dft_test_result_2016.csv
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/test_result_2015.txt.gz --output ./dft_test_result_2015.gz && gunzip dft_test_result_2015.gz && mv ./dft_test_result_2015 ./dft_test_result_2015.csv
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/test_result_2014.txt.gz --output ./dft_test_result_2014.gz && gunzip dft_test_result_2014.gz && mv ./dft_test_result_2014 ./dft_test_result_2014.csv
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/test_result_2013.txt.gz --output ./dft_test_result_2013.gz && gunzip dft_test_result_2013.gz && mv ./dft_test_result_2013 ./dft_test_result_2013.csv
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/test_result_2012.txt.gz --output ./dft_test_result_2012.gz && gunzip dft_test_result_2012.gz && mv ./dft_test_result_2012 ./dft_test_result_2012.csv
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/test_result_2011.txt.gz --output ./dft_test_result_2011.gz && gunzip dft_test_result_2011.gz && mv ./dft_test_result_2011 ./dft_test_result_2011.csv
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/test_result_2010.txt.gz --output ./dft_test_result_2010.gz && gunzip dft_test_result_2010.gz && mv ./dft_test_result_2010 ./dft_test_result_2010.csv
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/test_result_2009.txt.gz --output ./dft_test_result_2009.gz && gunzip dft_test_result_2009.gz && mv ./dft_test_result_2009 ./dft_test_result_2009.csv
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/test_result_2008.txt.gz --output ./dft_test_result_2008.gz && gunzip dft_test_result_2008.gz && mv ./dft_test_result_2008 ./dft_test_result_2008.csv
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/test_result_2007.txt.gz --output ./dft_test_result_2007.gz && gunzip dft_test_result_2007.gz && mv ./dft_test_result_2007 ./dft_test_result_2007.csv
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/test_result_2006.txt.gz --output ./dft_test_result_2006.gz && gunzip dft_test_result_2006.gz && mv ./dft_test_result_2006 ./dft_test_result_2006.csv
curl https://data.dft.gov.uk/anonymised-mot-test/test_data/test_result_2005.txt.gz --output ./dft_test_result_2005.gz && gunzip dft_test_result_2005.gz && mv ./dft_test_result_2005 ./dft_test_result_2005.csv


nl -v0 -ba -nrz -s'|' dft_test_result_2007.csv  >  dft_test_result_2007_NL.csv && rm dft_test_result_2007.csv
nl -v0 -ba -nrz -s'|' dft_test_result_2008.csv  >  dft_test_result_2008_NL.csv && rm dft_test_result_2008.csv
nl -v0 -ba -nrz -s'|' dft_test_result_2009.csv  >  dft_test_result_2009_NL.csv && rm dft_test_result_2009.csv
nl -v0 -ba -nrz -s'|' dft_test_result_2010.csv  >  dft_test_result_2010_NL.csv && rm dft_test_result_2010.csv
nl -v0 -ba -nrz -s'|' dft_test_result_2011.csv  >  dft_test_result_2011_NL.csv && rm dft_test_result_2011.csv
nl -v0 -ba -nrz -s'|' dft_test_result_2012.csv  >  dft_test_result_2012_NL.csv && rm dft_test_result_2012.csv
nl -v0 -ba -nrz -s'|' dft_test_result_2013.csv  >  dft_test_result_2013_NL.csv && rm dft_test_result_2013.csv
nl -v0 -ba -nrz -s'|' dft_test_result_2014.csv  >  dft_test_result_2014_NL.csv && rm dft_test_result_2014.csv
nl -v0 -ba -nrz -s'|' dft_test_result_2015.csv  >  dft_test_result_2015_NL.csv && rm dft_test_result_2015.csv
nl -v0 -ba -nrz -s'|' dft_test_result_2016.csv  >  dft_test_result_2016_NL.csv && rm dft_test_result_2016.csv


nl -v0 -ba -nrz -s'|' dft_test_result-from-2018-01-01_00-00-01-to-2018-04-01_00-00-01.csv > dft_test_result-from-2018-01_NL.csv > dft_test_result-from-2018-01_NL.csv && rm dft_test_result-from-2018-01-01_00-00-01-to-2018-04-01_00-00-01.csv
nl -v0 -ba -nrz -s'|' dft_test_result-from-2018-04-01_00-00-01-to-2018-07-01_00-00-01.csv > dft_test_result-from-2018-04_NL.csv > dft_test_result-from-2018-04_NL.csv && rm dft_test_result-from-2018-04-01_00-00-01-to-2018-07-01_00-00-01.csv
nl -v0 -ba -nrz -s'|' dft_test_result-from-2018-07-01_00-00-01-to-2018-10-01_00-00-01.csv > dft_test_result-from-2018-07_NL.csv > dft_test_result-from-2018-07_NL.csv && rm dft_test_result-from-2018-07-01_00-00-01-to-2018-10-01_00-00-01.csv
nl -v0 -ba -nrz -s'|' dft_test_result-from-2018-10-01_00-00-01-to-2019-01-01_00-00-01.csv > dft_test_result-from-2018-10_NL.csv > dft_test_result-from-2018-10_NL.csv && rm dft_test_result-from-2018-10-01_00-00-01-to-2019-01-01_00-00-01.csv
nl -v0 -ba -nrz -s'|' dft_test_result-from-2019-01-01_00-00-01-to-2019-04-01_00-00-01.csv > dft_test_result-from-2019-01_NL.csv > dft_test_result-from-2019-01_NL.csv && rm dft_test_result-from-2019-01-01_00-00-01-to-2019-04-01_00-00-01.csv
nl -v0 -ba -nrz -s'|' dft_test_result-from-2019-04-01_00-00-01-to-2019-07-01_00-00-01.csv > dft_test_result-from-2019-04_NL.csv > dft_test_result-from-2019-04_NL.csv && rm dft_test_result-from-2019-04-01_00-00-01-to-2019-07-01_00-00-01.csv
nl -v0 -ba -nrz -s'|' dft_test_result-from-2019-07-01_00-00-01-to-2019-10-01_00-00-01.csv > dft_test_result-from-2019-07_NL.csv > dft_test_result-from-2019-07_NL.csv && rm dft_test_result-from-2019-07-01_00-00-01-to-2019-10-01_00-00-01.csv
nl -v0 -ba -nrz -s'|' dft_test_result-from-2019-10-01_00-00-01-to-2020-01-01_00-00-01.csv > dft_test_result-from-2019-10_NL.csv > dft_test_result-from-2019-10_NL.csv && rm dft_test_result-from-2019-10-01_00-00-01-to-2020-01-01_00-00-01.csv
nl -v0 -ba -nrz -s'|' dft_test_result-from-2020-01-01_00-00-00-to-2020-04-01_00-00-00.csv > dft_test_result-from-2020-01_NL.csv > dft_test_result-from-2020-01_NL.csv && rm dft_test_result-from-2020-01-01_00-00-00-to-2020-04-01_00-00-00.csv
nl -v0 -ba -nrz -s'|' dft_test_result-from-2020-04-01_00-00-00-to-2020-07-01_00-00-00.csv > dft_test_result-from-2020-04_NL.csv > dft_test_result-from-2020-04_NL.csv && rm dft_test_result-from-2020-04-01_00-00-00-to-2020-07-01_00-00-00.csv
nl -v0 -ba -nrz -s'|' dft_test_result-from-2020-07-01_00-00-00-to-2020-10-01_00-00-00.csv > dft_test_result-from-2020-07_NL.csv > dft_test_result-from-2020-07_NL.csv && rm dft_test_result-from-2020-07-01_00-00-00-to-2020-10-01_00-00-00.csv
nl -v0 -ba -nrz -s'|' dft_test_result-from-2020-10-01_00-00-00-to-2021-01-01_00-00-00.csv > dft_test_result-from-2020-10_NL.csv > dft_test_result-from-2020-10_NL.csv && rm dft_test_result-from-2020-10-01_00-00-00-to-2021-01-01_00-00-00.csv
nl -v0 -ba -nrz -s'|' test_result_2022.csv                 > test_result_2022_NL.csv                 && rm test_result_2022.csv            
nl -v0 -ba -nrz -s'|' test_result_20220531131730_32355.csv > test_result_20220531131730_32355_NL.csv && rm test_result_20220531131730_32355
nl -v0 -ba -nrz -s'|' test_result_20220531131730_32357.csv > test_result_20220531131730_32357_NL.csv && rm test_result_20220531131730_32357
nl -v0 -ba -nrz -s'|' test_result_20220531131730_32360.csv > test_result_20220531131730_32360_NL.csv && rm test_result_20220531131730_32360
nl -v0 -ba -nrz -s'|' test_result_20220531131730_32361.csv > test_result_20220531131730_32361_NL.csv && rm test_result_20220531131730_32361
nl -v0 -ba -nrz -s'|' test_result_20220531131730_32365.csv > test_result_20220531131730_32365_NL.csv && rm test_result_20220531131730_32365
nl -v0 -ba -nrz -s'|' test_result_20220531131730_32367.csv > test_result_20220531131730_32367_NL.csv && rm test_result_20220531131730_32367
nl -v0 -ba -nrz -s'|' test_result_20220531131730_32370.csv > test_result_20220531131730_32370_NL.csv && rm test_result_20220531131730_32370
nl -v0 -ba -nrz -s'|' test_result_20220531131730_32372.csv > test_result_20220531131730_32372_NL.csv && rm test_result_20220531131730_32372
nl -v0 -ba -nrz -s'|' test_result_20220531131730_32375.csv > test_result_20220531131730_32375_NL.csv && rm test_result_20220531131730_32375
nl -v0 -ba -nrz -s'|' test_result_20220531131730_32378.csv > test_result_20220531131730_32378_NL.csv && rm test_result_20220531131730_32378
nl -v0 -ba -nrz -s'|' test_result_20220531131730_32384.csv > test_result_20220531131730_32384_NL.csv && rm test_result_20220531131730_32384
nl -v0 -ba -nrz -s'|' test_result_20220531131730_32386.csv > test_result_20220531131730_32386_NL.csv && rm test_result_20220531131730_32386
nl -v0 -ba -nrz -s'|' test_result_2023.csv                 > test_result_2023_NL.csv                 && rm test_result_2023.csv 
nl -v0 -ba -nrz -s'|' test_result_31859.csv                > test_result_31859_NL.csv                && rm test_result_31859.csv
nl -v0 -ba -nrz -s'|' test_result_31860.csv                > test_result_31860_NL.csv                && rm test_result_31860.csv
nl -v0 -ba -nrz -s'|' test_result_31861.csv                > test_result_31861_NL.csv                && rm test_result_31861.csv
nl -v0 -ba -nrz -s'|' test_result_31862.csv                > test_result_31862_NL.csv                && rm test_result_31862.csv
nl -v0 -ba -nrz -s'|' test_result_31863.csv                > test_result_31863_NL.csv                && rm test_result_31863.csv
nl -v0 -ba -nrz -s'|' test_result_31864.csv                > test_result_31864_NL.csv                && rm test_result_31864.csv
nl -v0 -ba -nrz -s'|' test_result_31868.csv                > test_result_31868_NL.csv                && rm test_result_31868.csv
nl -v0 -ba -nrz -s'|' test_result_31869.csv                > test_result_31869_NL.csv                && rm test_result_31869.csv
nl -v0 -ba -nrz -s'|' test_result_31870.csv                > test_result_31870_NL.csv                && rm test_result_31870.csv
nl -v0 -ba -nrz -s'|' test_result_31871.csv                > test_result_31871_NL.csv                && rm test_result_31871.csv
nl -v0 -ba -nrz -s'|' test_result_31876.csv                > test_result_31876_NL.csv                && rm test_result_31876.csv
nl -v0 -ba -nrz -s'|' test_result_31879.csv                > test_result_31879_NL.csv                && rm test_result_31879.csv




sed -i 's/|/,/g' dft_test_result-from-2018-01_NL.csv
sed -i 's/|/,/g' dft_test_result-from-2018-04_NL.csv
sed -i 's/|/,/g' dft_test_result-from-2018-07_NL.csv
sed -i 's/|/,/g' dft_test_result-from-2018-10_NL.csv
sed -i 's/|/,/g' dft_test_result-from-2019-01_NL.csv
sed -i 's/|/,/g' dft_test_result-from-2019-04_NL.csv
sed -i 's/|/,/g' dft_test_result-from-2019-07_NL.csv
sed -i 's/|/,/g' dft_test_result-from-2019-10_NL.csv
sed -i 's/|/,/g' dft_test_result-from-2020-01_NL.csv
sed -i 's/|/,/g' dft_test_result-from-2020-04_NL.csv
sed -i 's/|/,/g' dft_test_result-from-2020-07_NL.csv


sed -i 's/|/,/g'  test_result_20220531131730_32355_NL.csv
sed -i 's/|/,/g'  test_result_20220531131730_32357_NL.csv
sed -i 's/|/,/g'  test_result_20220531131730_32360_NL.csv
sed -i 's/|/,/g'  test_result_20220531131730_32361_NL.csv
sed -i 's/|/,/g'  test_result_20220531131730_32365_NL.csv
sed -i 's/|/,/g'  test_result_20220531131730_32367_NL.csv
sed -i 's/|/,/g'  test_result_20220531131730_32370_NL.csv
sed -i 's/|/,/g'  test_result_20220531131730_32372_NL.csv
sed -i 's/|/,/g'  test_result_20220531131730_32375_NL.csv
sed -i 's/|/,/g'  test_result_20220531131730_32378_NL.csv
sed -i 's/|/,/g'  test_result_20220531131730_32384_NL.csv
sed -i 's/|/,/g'  test_result_20220531131730_32386_NL.csv

mv dft_test_result_2005_NL.csv  pipe_dft_test_result_2005_NL.csv
mv dft_test_result_2006_NL.csv  pipe_dft_test_result_2006_NL.csv
mv dft_test_result_2007_NL.csv  pipe_dft_test_result_2007_NL.csv
mv dft_test_result_2008_NL.csv  pipe_dft_test_result_2008_NL.csv
mv dft_test_result_2009_NL.csv  pipe_dft_test_result_2009_NL.csv
mv dft_test_result_2010_NL.csv  pipe_dft_test_result_2010_NL.csv
mv dft_test_result_2011_NL.csv  pipe_dft_test_result_2011_NL.csv
mv dft_test_result_2012_NL.csv  pipe_dft_test_result_2012_NL.csv
mv dft_test_result_2013_NL.csv  pipe_dft_test_result_2013_NL.csv
mv dft_test_result_2014_NL.csv  pipe_dft_test_result_2014_NL.csv
mv dft_test_result_2015_NL.csv  pipe_dft_test_result_2015_NL.csv
mv dft_test_result_2016_NL.csv  pipe_dft_test_result_2016_NL.csv


mv dft_test_result-from-2018-01_NL.csv  comma_dft_test_result-from-2018-01_NL.csv
mv dft_test_result-from-2018-04_NL.csv  comma_dft_test_result-from-2018-04_NL.csv
mv dft_test_result-from-2018-07_NL.csv  comma_dft_test_result-from-2018-07_NL.csv
mv dft_test_result-from-2018-10_NL.csv  comma_dft_test_result-from-2018-10_NL.csv
mv dft_test_result-from-2019-01_NL.csv  comma_dft_test_result-from-2019-01_NL.csv
mv dft_test_result-from-2019-04_NL.csv  comma_dft_test_result-from-2019-04_NL.csv
mv dft_test_result-from-2019-07_NL.csv  comma_dft_test_result-from-2019-07_NL.csv
mv dft_test_result-from-2019-10_NL.csv  comma_dft_test_result-from-2019-10_NL.csv
mv dft_test_result-from-2020-01_NL.csv  comma_dft_test_result-from-2020-01_NL.csv
mv dft_test_result-from-2020-04_NL.csv  comma_dft_test_result-from-2020-04_NL.csv
mv dft_test_result-from-2020-07_NL.csv  comma_dft_test_result-from-2020-07_NL.csv
mv dft_test_result-from-2020-10_NL.csv  comma_dft_test_result-from-2020-10_NL.csv


# Validate data:- should be 14 Fields per record in csv file. 
# e.g. this file is pipe delimited. Write good and bad data to separate files. For bad data get NR (row number) for investigation. 
gawk -F'|' '{if (NF==14) print $0 > "good_file.csv"; else print "["NR"]", "["NF"]", $0 > "bad_file.csv"}' dft_test_result_2016.csv
or without if/else
gawk -F'|' 'NF==14 {print $0 > "good_file.csv"; next} {print "["NR"] ["NF"] " $0 > "bad_file.csv"}' dft_test_result_2016.csv


create table mot.test_data  as
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
from  read_csv ('pipe*'
                , header=True
                ,quote='^'
                ,DATEFORMAT = '%Y-%m-%d'
                ,ESCAPE = '\'
                ,ignore_errors = True
                ,sep='|'
                ,columns = 
                {
                 'row_num'           : 'BIGINT'
                ,'test_id'           : 'BIGINT'
                ,'vehicle_id'        : 'BIGINT'
                ,'test_date'         : 'DATE'
                ,'test_class_id'     : 'BIGINT'
                ,'test_type'         : 'VARCHAR'
                ,'test_result'       : 'VARCHAR'
                ,'test_mileage'      : 'BIGINT'
                ,'postcode_area'     : 'VARCHAR'
                ,'make'              : 'VARCHAR'
                ,'model'             : 'VARCHAR'
                ,'colour'            : 'VARCHAR'
                ,'fuel_type'         : 'VARCHAR'
                ,'cylinder_capacity' : 'BIGINT'
                ,'first_use_date'    : 'DATE'               
                }
               )
;

BEGIN TRANSACTION;
insert into mot.test_data              
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
    from  read_csv ('comma_*'
                    , header=True
                    ,quote='^'
                    ,DATEFORMAT = '%Y-%m-%d'
                    ,ESCAPE = '\'
                    ,ignore_errors = True
                    ,sep=','
                    ,columns = 
                    {
                     'row_num'           : 'BIGINT'
                    ,'test_id'           : 'BIGINT'
                    ,'vehicle_id'        : 'BIGINT'
                    ,'test_date'         : 'DATE'
                    ,'test_class_id'     : 'BIGINT'
                    ,'test_type'         : 'VARCHAR'
                    ,'test_result'       : 'VARCHAR'
                    ,'test_mileage'      : 'BIGINT'
                    ,'postcode_area'     : 'VARCHAR'
                    ,'make'              : 'VARCHAR'
                    ,'model'             : 'VARCHAR'
                    ,'colour'            : 'VARCHAR'
                    ,'fuel_type'         : 'VARCHAR'
                    ,'cylinder_capacity' : 'BIGINT'
                    ,'first_use_date'    : 'DATE'               
                    }
                 )
;
COMMIT;
