CREATE TABLE booking_table(
   Booking_id       VARCHAR(3) NOT NULL 
  ,Booking_date     date NOT NULL
  ,User_id          VARCHAR(2) NOT NULL
  ,Line_of_business VARCHAR(6) NOT NULL
);
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b1','2022-03-23','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b2','2022-03-27','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b3','2022-03-28','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b4','2022-03-31','u4','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b5','2022-04-02','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b6','2022-04-02','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b7','2022-04-06','u5','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b8','2022-04-06','u6','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b9','2022-04-06','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b10','2022-04-10','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b11','2022-04-12','u4','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b12','2022-04-16','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b13','2022-04-19','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b14','2022-04-20','u5','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b15','2022-04-22','u6','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b16','2022-04-26','u4','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b17','2022-04-28','u2','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b18','2022-04-30','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b19','2022-05-04','u4','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b20','2022-05-06','u1','Flight');
;
CREATE TABLE user_table(
   User_id VARCHAR(3) NOT NULL
  ,Segment VARCHAR(2) NOT NULL
);
INSERT INTO user_table(User_id,Segment) VALUES ('u1','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u2','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u3','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u4','s2');
INSERT INTO user_table(User_id,Segment) VALUES ('u5','s2');
INSERT INTO user_table(User_id,Segment) VALUES ('u6','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u7','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u8','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u9','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u10','s3');



select * from booking_table;

select * from user_table;

select * from booking_table
where extract(month from booking_date) >='4';

-- How many users from each segment booked flights in April 2022,
-- and how many total user entries were counted (including duplicates)?
select count(u.user_id) as total_users, count(distinct u.user_id) as total_user,u.segment from user_table u left 
join booking_table b on u.user_id=b.user_id
where extract(month from booking_date)='4'
and extract(year from booking_date)='2022'
and b.line_of_business ='Flight'
group by u.segment;


-- How many users from each segment made bookings (of any type) in April 2022?
SELECT DISTINCT
  u.segment,
  COUNT(*) OVER (PARTITION BY u.segment) AS total_user
FROM user_table u
INNER JOIN booking_table b ON u.user_id = b.user_id
WHERE EXTRACT(MONTH FROM booking_date) = 4
  AND EXTRACT(YEAR FROM booking_date) = 2022;


-- Which users made their very first booking in the 'Hotel' line of business?
select distinct user_id,rn,line_of_business from
(select * ,rank() over (partition by user_id order by booking_date asc) as rn
from booking_table ) as a
where rn='1' and upper(line_of_business)='HOTEL'


-- For each user, what is the number of days between their first and last booking?
select user_id, min(booking_date) as start_date,max(booking_date) as last_date,
(max(booking_date)- min(booking_date)) as no_of_days
from booking_table
group by user_id;


select segment ,
sum(case when line_of_business='Flight' then 1 else 0 end) as flight_bookings,
sum(case when line_of_business='Hotel' then 1 else 0 end) as Hotel_bookings
from booking_table b 
inner join user_table u 
on b.user_id=u.user_id
where extract(year from booking_date) ='2022'
group by segment order by 1 asc;




 -- Which segment has the highest number of unique users who made bookings?
select * from booking_table;

select  count(distinct b.user_id) as no_of_users,u.segment from
user_table u inner join booking_table b on
u.user_id=b.user_id group by u.segment  order by no_of_users desc limit 1;


select * from
(
select u.segment,count(distinct b.user_id) as users,
rank() over (partition by u.segment order by count(distinct b.user_id) desc )
as rn from user_table u inner join booking_table b on
u.user_id=b.user_id 

)
where rn=1 group by u.segment;


-- What is the total number of bookings made per line of business (Flight, Hotel) and their respective users?
 
select b.user_id,
sum(case when line_of_business='Flight' then 1 else 0 end) as flight_bookings,
sum(case when line_of_business='Hotel' then 1 else 0 end) as Hotel_bookings
from booking_table b 
inner join user_table u 
on b.user_id=u.user_id
group by b.user_id order by 1 asc;



-- How many users from each segment did not make any bookings?
SELECT 
  u.segment,
  COUNT(u.user_id) AS no_of_users_without_bookings
FROM user_table u
LEFT JOIN booking_table b ON u.user_id = b.user_id
WHERE b.user_id IS NULL
GROUP BY u.segment;

-- . Which users have booked in more than one line of business?
SELECT 
  user_id,count(DISTINCT line_of_business)
FROM booking_table
GROUP BY user_id
HAVING COUNT(DISTINCT line_of_business) > 1;


 -- Which users made the most bookings overall
 select * from booking_table;
select user_id ,count(booking_id) as total_bookings
from booking_table 
group by user_id
order by  total_bookings desc
limit 1;


-- What is the monthly trend of bookings across all lines of business?

select  count(booking_id) as total_bookings,line_of_business,extract(month from booking_date) as month
from booking_table group by  extract(month from booking_date),line_of_business order by month asc;

 -- Which users made bookings across multiple months?
 SELECT 
  user_id,
  COUNT(DISTINCT EXTRACT(MONTH FROM booking_date)) AS months_booked
FROM booking_table
GROUP BY user_id
HAVING COUNT(DISTINCT EXTRACT(MONTH FROM booking_date)) > 1;


 -- What is the first line of business each user booked?
SELECT user_id, line_of_business
FROM (
  SELECT 
    user_id,
    line_of_business,
    booking_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY booking_date asc) AS rn
  FROM booking_table
) ranked
WHERE rn = 1;



-- What is the booking count by segment and line of business combination?
select count(booking_id),segment,line_of_business
from user_table u
INNER JOIN booking_table b ON u.user_id = b.user_id
GROUP BY 2,3 order by 2 asc ;
