--Title: DIM_Vehicle
create table mot.dim_vehicle as 
	select distinct
		   t.vehicle_id 
		  , 
		  case 
		  	  when make = 'DODGE (USA)' then 'DODGE'
		  	  when make = 'MERCEDES'    then 'MERCEDES-BENZ'
		  	  when make = 'SMART'       then 'SMART (MCC)'
		  	  	   else make
		  end   as make_
		  ,t.model 
		  ,t.fuel_type 
		  ,t.cylinder_capacity 
		  ,t.colour 
		  ,t.first_use_date 
	from  mot.test_result   t 
	where 1=1
		  and test_class_id = 4
		  and make not in ('LONDON TAXIS INT')
		  and make in 
		  			(
					select 
						  case 
						  	  when make = 'DODGE (USA)' then 'DODGE'
						  	  when make = 'MERCEDES'    then 'MERCEDES-BENZ'
						  	  when make = 'SMART'       then 'SMART (MCC)'
						  	  	   else make
						  end   as make
					from  mot.test_result
					where 1=1
						  and test_class_id = 4
						  and make not in ('LONDON TAXIS INT')
					group by all 
					having 
						  approx_count_distinct(vehicle_id) >= 10000
		  			)

--Title: Model Grouping based on #
;
with c_model_counts as 
	(
	select 
	       make_ 
	      ,model 
	      ,approx_count_distinct(vehicle_id )	as record_count
	from  mot.dim_vehicle
	where 1=1
--		  and make_ = 'BMW'
	group by 
		  all
	having 
		  record_count >= 2000
	order by 
		  model
	)
	,c_model_grp as
	(
	select 
		   g1.*
		  ,g2.model				as model_grp
		  ,len(string_to_array(g2.model, ' ')) as mdl_arr_len
	from  c_model_counts 					g1 
		  left outer join c_model_counts 	g2  on 1=1
		  									   and g1.make_ = g2.make_ 
										  	   and g1.model like g2.model || ' %'  -- ' %' space stops VIVA matching VIVARO
										  	   and g2.model != g1.model 
										  	   and len(string_to_array(g2.model, ' ')) = 1  -- Choose 'TRANSIT' over 'TRANSIT CONNECT'
	order by 	
		  g1.model 
	)
	select --distinct
		   make_ 
		  ,model
		  ,
		  case 
		  	   when model_grp is null then model else model_grp 
		  end		as model_grp
		  ,record_count 
	from  c_model_grp 
	order by 
		   make_ 
		  ,model_grp 
		  ,model
