-- DuckDB version
pragma version

      
-- Create a new schema for this data. 
create schema tennis
;

-- Get a list of
--      1) column names
--      2) The data types inferred by the database. (These can be changed manually as we will see below)  
describe 
    select * from read_csv_auto('C:\Users\user.name\Downloads\sql_tutorial\tennis_atp\atp_matches_[0-9][0-9][0-9][0-9].csv', header=True)



-- Create a table from the csv file
-- Column names and data types are explicitly named here. Many changed from BIGINT to INT.
--      using 'read_csv' here. Above we used 'read_csv_auto' to infer data types.
--      Explicitly formatting any DATE field as 'YYYY-MM'DD'     
create table tennis.atp_matches as
    select * from read_csv('C:\Users\user.name\Downloads\sql_tutorial\tennis_atp\atp_matches_[0-9][0-9][0-9][0-9].csv' 
    ,header=True
    ,DATEFORMAT = '%Y%m%d'
    ,columns={
             'tourney_id'           :  'VARCHAR NOT NULL'
            ,'tourney_name'         :  'VARCHAR NOT NULL'
            ,'surface'              :  'VARCHAR'
            ,'draw_size'            :  'INT'
            ,'tourney_level'        :  'VARCHAR'
            ,'tourney_date'         :  'DATE'
            ,'match_num'            :  'INT'
            ,'winner_id'            :  'INT'
            ,'winner_seed'          :  'INT'
            ,'winner_entry'         :  'VARCHAR'
            ,'winner_name'          :  'VARCHAR'
            ,'winner_hand'          :  'VARCHAR'
            ,'winner_ht'            :  'INT'
            ,'winner_ioc'           :  'VARCHAR'
            ,'winner_age'           :  'DOUBLE'
            ,'loser_id'             :  'INT'
            ,'loser_seed'           :  'INT'
            ,'loser_entry'          :  'VARCHAR'
            ,'loser_name'           :  'VARCHAR'
            ,'loser_hand'           :  'VARCHAR'
            ,'loser_ht'             :  'INT'
            ,'loser_ioc'            :  'VARCHAR'
            ,'loser_age'            :  'DOUBLE'
            ,'score'                :  'VARCHAR'
            ,'best_of'              :  'INT'
            ,'round'                :  'VARCHAR'
            ,'minutes'              :  'INT'
            ,'w_ace'                :  'INT'
            ,'w_df'                 :  'INT'
            ,'w_svpt'               :  'INT'
            ,'w_1stIn'              :  'INT'
            ,'w_1stWon'             :  'INT'
            ,'w_2ndWon'             :  'INT'
            ,'w_SvGms'              :  'INT'
            ,'w_bpSaved'            :  'INT'
            ,'w_bpFaced'            :  'INT'
            ,'l_ace'                :  'INT'
            ,'l_df'                 :  'INT'
            ,'l_svpt'               :  'INT'
            ,'l_1stIn'              :  'INT'
            ,'l_1stWon'             :  'INT'
            ,'l_2ndWon'             :  'INT'
            ,'l_SvGms'              :  'INT'
            ,'l_bpSaved'            :  'INT'
            ,'l_bpFaced'            :  'INT'
            ,'winner_rank'          :  'INT'
            ,'winner_rank_points'   :  'INT'
            ,'loser_rank'           :  'INT'
            ,'loser_rank_points'    :  'INT'
            }
        )      

select count(1) from tennis.atp_matches
-- Cross numbers check in Terminal using `wc -l` command


create table tennis.atp_rankings as
    select 
           *
    from  read_csv('C:\Users\user.name\Downloads\sql_tutorial\tennis_atp\atp_rankings_*.csv'
    ,header=True
    ,DATEFORMAT = '%Y%m%d'  -- ISO 8601
    ,columns={
             'ranking_date' : 'DATE'
            ,'player_rank'  : 'INT'  -- `RANK` is a reserved keyword in SQL
            ,'player_id'    : 'INT'  -- Rename a column when loading (was `player`). keep consistent with other tables.
            ,'points'       : 'INT'
            }    
        )

-- 
create table tennis.atp_players as
    select * from  read_csv('C:\Users\user.name\Downloads\sql_tutorial\tennis_atp\atp_players.csv'
    , header=True
    ,DATEFORMAT = '%Y%m%d'
    ,IGNORE_ERRORS=True     -- See Query below. Ignore 103 players with invalid dob.
    ,columns={
             'player_id'     : 'INT'
            ,'name_first'    : 'VARCHAR'
            ,'name_last'     : 'VARCHAR'
            ,'hand'          : 'VARCHAR'
            ,'dob'           : 'DATE'
            ,'ioc'           : 'VARCHAR'
            ,'height'        : 'INT'
            ,'wikidata_id'   : 'VARCHAR'
        }    
    )


-- Player data: 103 dob with invalid data format
-- Note: this data in the source repo will probably get updated over time and these errors disappear. 
select 
      *
from  read_csv_auto('C:\Users\user.name\Downloads\sql_tutorial\tennis_atp\atp_players.csv', header=True)
where right(dob,4) = '0000'
;


-- Loading atp_matches data we run into an error.
--      [ERROR: Could not convert string 'Q' to INT64 at line 164 in column] 
--      Note this is $9 in csv file. In awk, the first column is $1 whereas DuckDB sees it as 0. 
select 
      *
from  read_csv_auto('C:\Users\user.name\Downloads\sql_tutorial\tennis_atp\atp_matches_[1-2][0-9][0-9][0-3].csv', header=True)
using sample 100 rows

-- =============================================================== Question Time =============================================================== 
-- Questions we want to answer:- 
--1) Highest points ever for a player.
select distinct
       plr.name_first ||' '|| plr.name_last as player_name   -- Note: || is the concatenation operator
      ,rnk.player_rank
      ,rnk.points 
from  tennis.atp_rankings               rnk
      inner join tennis.atp_players     plr on rnk.player_id = plr.player_id 
where 1=1
      and rnk.points is not null
order by 
      rnk.points desc
limit 1
;

-- 2) All #1 Ranked players from most recent
-- Take the first date on which they made #1 rank
select 
       plr.name_first ||' '|| plr.name_last     as player_name
      ,max(rnk.ranking_date)                    as first_ranking_date 
      ,rnk.player_rank 
from  tennis.atp_rankings               rnk
      inner join tennis.atp_players     plr on rnk.player_id = plr.player_id 
where 1=1
      and rnk.points is not null
      and rnk.player_rank = 1
group by 
       player_name
      ,rnk.player_rank
order by 
      first_ranking_date desc
;
--3) Distinct List of #1 players 
select distinct
       plr.name_first ||' '|| plr.name_last as player_name
from  tennis.atp_rankings               rnk
      inner join tennis.atp_players     plr on rnk.player_id = plr.player_id 
where 1=1
      and rnk.points is not null
      and rnk.player_rank = 1
;  
--4) Highest points rating for each player
-- QUALIFY clause allows filtering on a Windowing function. 
select 
       plr.name_first ||' '|| plr.name_last     as player_name
      ,max (rnk.player_rank)                    as player_rank
      ,rnk.points 
      ,dense_rank() over (partition by rnk.player_id order by rnk.points  desc)  as rank_status
from  tennis.atp_rankings               rnk
      inner join tennis.atp_players     plr on rnk.player_id = plr.player_id 
where 1=1
      and rnk.points is not null
group by 
       player_name
      ,rnk.player_id  
      ,rnk.points 
qualify 
      rank_status = 1
order by 
      rnk.points desc
;

--5)  Total time (days/weeks) at the top per player.
with c_top_ranked as 
    (
    select 
           plr.name_first ||' '|| plr.name_last                  as player_name
          ,rnk.points 
          ,min(rnk.ranking_date)                                 as first_ranking_date 
          ,rnk.player_rank                                       as player_rank
          ,dense_rank () over (order by first_ranking_date desc) as row_num
    from  tennis.atp_rankings               rnk
          inner join tennis.atp_players     plr on rnk.player_id = plr.player_id 
    where 1=1
          and rnk.points is not null
          and rnk.player_rank = 1
    group by 
           player_name
          ,rnk.player_rank
          ,rnk.points 
    )
    ,c_days_at_the_top as 
    (
    select 
           tr.player_name
          ,tr.points
          ,tr.first_ranking_date
          ,tr.row_num
          ,lag(tr.first_ranking_date, -1) over (order by tr.row_num)                                             as prior_ranking_date
          ,case when lag(tr.player_name) over (order by tr.row_num) != tr.player_name then 1 end                 as group_break
          ,datediff( 'day', (lag(tr.first_ranking_date, -1) over (order by tr.row_num)), tr.first_ranking_date ) as day_delta
    from  c_top_ranked      tr
    )
    select 
           tp.player_name
          ,sum(day_delta)           as total_days_at_top
          ,sum(day_delta) / 7       as total_weeks_at_top
    from  c_days_at_the_top  tp
    group by 
          tp.player_name
    order by 
          total_days_at_top desc
;                

-- 5a) Most consecutive weeks at #1 position per player.
--    
with c_top_ranked as 
    (
    select 
           plr.name_first ||' '|| plr.name_last                  as player_name
          ,rnk.points 
          ,min(rnk.ranking_date)                                 as first_ranking_date 
          ,rnk.player_rank                                       as player_rank
          ,dense_rank () over (order by first_ranking_date desc) as row_num
    from  tennis.atp_rankings               rnk
          inner join tennis.atp_players     plr on rnk.player_id = plr.player_id 
    where 1=1
          and rnk.points is not null
          and rnk.player_rank = 1
    group by 
           player_name
          ,rnk.player_rank
          ,rnk.points 
    )
    ,c_days_at_the_top as 
    (
    select 
           tr.player_name
          ,tr.points
          ,tr.first_ranking_date
          ,tr.row_num
          ,lag(tr.first_ranking_date, -1) over (order by tr.row_num)                                             as prior_ranking_date
          ,case when lag(tr.player_name) over (order by tr.row_num) != tr.player_name then 1 end                 as group_break
          ,datediff( 'day', (lag(tr.first_ranking_date, -1) over (order by tr.row_num)), tr.first_ranking_date ) as day_delta
    from  c_top_ranked      tr
    )
    ,c_consecutive_groups as 
    (
    select 
           tp.player_name
          ,tp.first_ranking_date
          ,count ( group_break or null) over (order by tp.first_ranking_date desc) as grp
    from  c_days_at_the_top  tp
    )
    ,c_consecutive_weeks_at_top as
    (
    select 
          cgrp.player_name
         ,min (first_ranking_date)   as begin_date
         ,max (first_ranking_date)   as end_date
         ,datediff ('week', (min (first_ranking_date)), (max (first_ranking_date)) ) as weeks_at_top
         ,count (*)                  as grp_count
    from  c_consecutive_groups   cgrp
    group by 
          cgrp.player_name
         ,cgrp.grp
    )
    select 
          wk_top.player_name
         ,begin_date
         ,end_date
         ,max (wk_top.weeks_at_top)                                                                     as consec_weeks_at_top
         ,dense_rank() over (partition by  wk_top.player_name order by max (wk_top.weeks_at_top)  desc) as top_time_rank
    from  c_consecutive_weeks_at_top    wk_top
    group by 
          wk_top.player_name
         ,begin_date
         ,end_date
    qualify 
          top_time_rank = 1
    order by 
          consec_weeks_at_top desc
;

-- 6) longest and shortest matches
select 
       max (mat.minutes)  as longest_match_mins
      ,min (mat.minutes)  as shortest_match_mins
from  tennis.atp_matches        mat
where 1=1
      and mat.minutes > 0
;
-- 7) Playing time summary
select 
     minutes / 30                                           as half_hours_played
    ,count(1)                                               as no_of_games
    ,round (count(1) * 100.0 / sum( count(1)) over (), 2)   as pct_of_matches
--    ,sum(count(1)) over (order by NULL)                     as total_games
    ,sum(count(1)) over (order by half_hours_played)        as no_of_games_cumulative
    ,round (no_of_games_cumulative * 100.0/ ( sum(count(1)) over (order by NULL) ), 2) as running_pct
from  tennis.atp_matches        mat
where 1=1
      and minutes > 0
group by 
      (minutes / 30)
qualify
      pct_of_matches > 1.0
order by 
      half_hours_played
;

-- 8) Five Number Summary      
-- Data for Box Plot -- https://en.wikipedia.org/wiki/Box_plot 
select distinct
       percentile_cont(0.00) within group (order  by mat.minutes) as min_mins
      ,percentile_cont(0.25) within group (order  by mat.minutes) as q1_mins
      ,percentile_cont(0.50) within group (order  by mat.minutes) as median_mins
      ,percentile_cont(0.75) within group (order  by mat.minutes) as q3_mins
      ,percentile_cont(1.00) within group (order  by mat.minutes) as max_mins
from  tennis.atp_matches        mat
where 1=1
      and mat.minutes > 0
;
-- 9) Longest matches by seeded winners and losers
-- Limit to matches over 4 hours      
select 
       mat.tourney_id 
      ,mat.tourney_name 
      ,mat.tourney_date 
      ,mat.minutes                                as duration_mins
      ,plr_w.name_first || ' ' || plr_w.name_last as player_name_win
      ,mat.winner_seed 
      ,mat.winner_age 
      ,plr_l.name_first || ' ' || plr_l.name_last as player_name_lose
      ,mat.loser_seed 
      ,mat.loser_age 
      ,mat.score 
from  tennis.atp_matches                mat
      inner join tennis.atp_players     plr_w on mat.winner_id = plr_w.player_id 
      inner join tennis.atp_players     plr_l on mat.loser_id  = plr_l.player_id 
where 1=1
      and mat.winner_seed is not null
      and mat.loser_seed is not null
      and mat.minutes > 240
order by 
      duration_mins desc
;
--  10) Most scoring
--      I've just taken the length of the `score` field here.
--      I'm sure there's a better way. Not sure if the result here is correct.
select 
       mat.tourney_id 
      ,mat.tourney_name 
      ,mat.tourney_date 
      ,mat.minutes                                as duration_mins
      ,plr_w.name_first || ' ' || plr_w.name_last as player_name_win
      ,mat.winner_seed 
      ,mat.winner_age 
      ,plr_l.name_first || ' ' || plr_l.name_last as player_name_lose
      ,mat.loser_seed 
      ,mat.loser_age 
      ,mat.score 
from  tennis.atp_matches                mat
      inner join tennis.atp_players     plr_w on mat.winner_id = plr_w.player_id 
      inner join tennis.atp_players     plr_l on mat.loser_id  = plr_l.player_id 
where 1=1
      and len (mat.score) =
                           (
                           select 
                                 max(len(mat.score)) 
                           from  tennis.atp_matches                mat
                           where 
                                 mat.score not like '%Played and unfinished%'
                           )
      and mat.score not like '%Played and unfinished%'
;

-- 11) Most typical scores for high ranked players.
select 
       mat.score 
      ,count (mat.score)  as freq
from  tennis.atp_matches                mat
where 
      mat.score not like '%Played and unfinished%'
      and mat.winner_seed is not null
      and mat.loser_seed is not null
      and mat.winner_seed < 10
      and mat.loser_seed < 10
group by 
      mat.score 
order by 
      freq desc
;      
-- 12)  Biggest shock outcomes
--      i.e winning player is ranked much lower than losing player.
select 
       mat.tourney_id 
      ,mat.tourney_name 
      ,mat.tourney_date 
      ,mat.minutes                                as duration_mins
      ,plr_w.name_first || ' ' || plr_w.name_last as player_name_win
      ,mat.winner_seed 
      ,mat.winner_age 
      ,plr_l.name_first || ' ' || plr_l.name_last as player_name_lose
      ,mat.loser_seed 
      ,mat.loser_age 
      ,mat.score 
from  tennis.atp_matches                mat
      inner join tennis.atp_players     plr_w on mat.winner_id = plr_w.player_id 
      inner join tennis.atp_players     plr_l on mat.loser_id  = plr_l.player_id 
where 1=1
      and mat.winner_seed is not null
      and mat.loser_seed is not null      
      and (mat.winner_seed - mat.loser_seed) > 20
      and mat.loser_seed < 10
;