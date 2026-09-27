-- Run in the Supabase SQL editor BEFORE the first nao test.
-- They confirm that the golden questions make sense with your snapshot.

-- 1. Calendar and reviews date ranges (July and August must fall inside the calendar)
select min(date) as calendar_from, max(date) as calendar_to from calendar;
select min(date) as reviews_from, max(date) as reviews_to from reviews;

-- 2. Exact neighbourhood names (t02 uses Palma, t03 uses Alcúdia)
select neighbourhood, count(*) from listings group by 1 order by 2 desc limit 15;

-- 3. Is neighbourhood_group empty? (if it is all NULL, note it for iteration 2)
select count(neighbourhood_group) as with_group from listings;

-- 4. License values (t08)
select license, count(*) from listings group by 1 order by 2 desc limit 15;

-- 5. Ties in rankings (e07, m02, m06): if the 5th/10th value is tied with the next one, the test is unstable
select host_id, count(*) from listings group by 1 order by 2 desc limit 12;

-- 6. Room types
select room_type, count(*) from listings group by 1;
