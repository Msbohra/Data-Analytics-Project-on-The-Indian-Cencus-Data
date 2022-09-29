select* from analytics.dataset;
select * from analytics.dataset2;

select count(*) from analytics.dataset1;

select count(*) from analytics.dataset2;

select * from analytics.dataset1
where state in  ('Jharkhand', 'Bihar');

select sum(population) as population from analytics.dataset2;

select avg(growth) as Avg_dataset1growth from analytics.dataset1;

select state , avg(Growth) as Avg_growth_statewise from analytics.dataset1 
 group by State;
 
 select state, round(avg(Sex_Ratio)) as Avg_Sex_Ratio from analytics.dataset1 group by State order by Avg_Sex_Ratio desc;
 
 Select State, round(avg(literacy)) as Avg_literacy from analytics.dataset1 group by state having Avg_literacy> 90 order by Avg_literacy des
 
 select state, avg(Sex_Ratio) as Avg_Sex_Ratio from analytics.dataset1 group by State order by Avg_Sex_Ratio asc limit 3;
 
 Select State,  avg(Sex_Ratio) as Avg_Sex_Ratio from analytics.dataset1 group by State order by Avg_Sex_Ratio desc limit 3;
 
 select distinct(State) from analytics.dataset1 where lower(State) like 'a%';
 
 #joining both tables to
Select sum(d.females) Total_females, sum( d.males)as Total_Males from 
((select c.district, c.state, round((population/(sex_ratio+1),0) as Males , round(((population*(Sex_ratio)))/(sex_ratio +1),0)) as Females from
   (select a.district, a.state ,a.sex_ratio*1000 as Sex_ratio ,b.population from analytics.dataset1 a join analytics.dataset2 b on a.District = b.district) c) d) 
     Group by d.state;
     
# total literacy rate
select c.state, sum(c.literate_people) as Total_literate_people, sum(c.illiterate_people) as Total_illiterate_people from 
(select d.district , d.state , round(d.literacy_ratio*d.population) as literate_people, round((1- d.literacy_ratio)*d.population) as illiterate_people from
(select a.State, a.district , a.literacy as literacy_ratio ,b.population from analytics.dataset1 a inner join analytics.dataset2 b on a.district = b.district)d)c
group by c.state;

#Population in previous cencus

select sum(m.previous_cencus_population) as previous_cencus_population ,sum(m.current_cencus_population) as current_cencus_population from
(select c.state, sum(c.previous_cencus_population) as previous_cencus  ,sum(c.current_cencus_population) as current_cencus from
(select d.State, d.district, round(d.population/(1+ d.growth),0) as previous_cencus_population, population as current_cencus_population from
(select a.State, a.district , a.growth  ,b.population from analytics.dataset1 a inner join analytics.dataset2 b on a.district = b.district)d)c
group by c.state)m;

#POPULATION VS AREA

select q.* , r.* from
(select '1' as keyy, n*1 from
(select sum(m.previous_cencus) as previous_cencus_population ,sum(m.current_cencus) as current_cencus_population from
(select c.state, sum(c.previous_cencus_population) as previous_cencus  ,sum(c.current_cencus_population) as current_cencus from
(select d.State, d.district, round(d.population/(1+ d.growth),0) as previous_cencus_population, population as current_cencus_population from
(select a.State, a.district , a.growth  ,b.population from analytics.dataset1 a inner join analytics.dataset2 b on a.district = b.district)d)c
group by c.state)m)n) q inner join 

(select'1' as keyy, z*1 from
(select sum(area_km2) as total_area from analytics.dataset2)z)r on q.keyy = r.keyy;

#window functions

select a.* from
(select  state, district, literacy, rank() over(partition by state order by literacy desc)rnk from analytics.dataset1)a
where a.rnk in (1,2,3) order by state;



select sum(area_km2) from analytics.dataset2;






 