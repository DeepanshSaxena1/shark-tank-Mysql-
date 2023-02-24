use sharktank;


select * from data1;

-- total episodes

select max(`Ep. No.`) from data1;

-- pitches 

select count(distinct brand) from data1;

-- pitches converted

select cast(sum(a.converted_not_converted) as float) /cast(count(*) as float) from (
select `amount invested lakhs` , case when `amount invested lakhs`>0 then 1 else 0 end as converted_not_converted from data1) a;

-- total male

select sum(male) from data1;

-- total female

select sum(female) from data1;

-- gender ratio

select sum(female)/sum(male) from data1;

-- total invested amount

select sum(`amount invested lakhs`) from data1;

-- avg equity taken

select avg(a.`equity taken %`) from
(select * from data1 where `equity taken %`>0) a;

-- highest deal taken

select max(`amount invested lakhs`) from data1; 

-- higheest equity taken

select max(`equity taken %`) from data1;

-- startups having at least women

select sum(a.female_count) startups_having_at_least_woman from (
select female,case when female>0 then 1 else 0 end as female_count from data1) a;

-- pitches converted having atleast one women
select sum(b.female_count) from(

select case when a.female>0 then 1 else 0 end as female_count ,a.*from (
(select * from data1 where deal!='No Deal')) a)b;

-- avg team members

select avg(`team members`) from data1;

-- amount invested per deal

select avg(a.`amount invested lakhs`) amount_invested_per_deal from
(select * from data1 where deal!='No Deal') a; 

-- avg age group of contestants

select `avg age`,count(`avg age`) cnt from data1 group by `avg age` order by cnt desc;

-- location group of contestants

select location,count(location) cnt from data1 group by location order by cnt desc;

-- sector group of contestants

select sector,count(sector) cnt from data1 group by sector order by cnt desc;


-- partner deals

select partners,count(partners) cnt from data1  where partners!='-' group by partners order by cnt desc;

-- making the matrix

select 'Ashnner' as keyy,count(`ashneer amount invested`) from data1 where `ashneer amount invested` is not null;


select 'Ashnner' as keyy,count(`ashneer amount invested`) from data1 where `ashneer amount invested` is not null AND `ashneer amount invested`!=0;

SELECT 'Ashneer' as keyy,SUM(C.`ASHNEER AMOUNT INVESTED`),AVG(C.`ASHNEER EQUITY TAKEN %`) 
FROM (SELECT * FROM DATA1  WHERE `ASHNEER EQUITY TAKEN %`!=0 AND `ASHNEER EQUITY TAKEN %` IS NOT NULL) C;


select m.keyy,m.total_deals_present,m.total_deals,n.total_amount_invested,n.avg_equity_taken from

(select a.keyy,a.total_deals_present,b.total_deals from(

select 'Ashneer' as keyy,count(`ashneer amount invested`) total_deals_present from data1 where `ashneer amount invested` is not null) a

inner join (
select 'Ashneer' as keyy,count(`ashneer amount invested`) total_deals from data1 
where `ashneer amount invested` is not null AND `ashneer amount invested`!=0) b 

on a.keyy=b.keyy) m

inner join 

(SELECT 'Ashneer' as keyy,SUM(C.`ASHNEER AMOUNT INVESTED`) total_amount_invested,
AVG(C.`ASHNEER EQUITY TAKEN %`) avg_equity_taken
FROM (SELECT * FROM DATA1  WHERE `ASHNEER EQUITY TAKEN %`!=0 AND `ASHNEER EQUITY TAKEN %` IS NOT NULL) C) n

on m.keyy=n.keyy;

-- which is the startup in which the highest amount has been invested in each domain/sector

select c.* from 
(select brand,sector,`amount invested lakhs`,rank() over(partition by sector order by `amount invested lakhs` desc) rnk 

from data1) c

where c.rnk=1;