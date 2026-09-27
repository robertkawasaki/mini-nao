-- Efficient bulk load from data-sources/*.csv
-- Drops FKs + secondary indexes for COPY speed, then restores them.
-- calendar.csv is ~5.4M rows; local db reset can take several minutes.

alter table public.reviews drop constraint if exists reviews_listing_id_fkey;
alter table public.calendar drop constraint if exists calendar_listing_id_fkey;

drop index if exists public.listings_last_review_idx;
drop index if exists public.reviews_listing_id_date_idx;
drop index if exists public.reviews_date_idx;
drop index if exists public.calendar_date_idx;
drop index if exists public.calendar_listing_available_idx;

truncate table public.calendar, public.reviews, public.listings;

create temporary table listings_raw (
  id                             text,
  name                           text,
  host_id                        text,
  host_profile_id                text,
  host_name                      text,
  neighbourhood_group            text,
  neighbourhood                  text,
  latitude                       text,
  longitude                      text,
  room_type                      text,
  price                          text,
  minimum_nights                 text,
  number_of_reviews              text,
  last_review                    text,
  reviews_per_month              text,
  calculated_host_listings_count text,
  availability_365               text,
  number_of_reviews_ltm          text,
  license                        text
);

\copy listings_raw from '../data-sources/listings.csv' with (format csv, header true)

insert into public.listings (
  id,
  name,
  host_id,
  host_profile_id,
  host_name,
  neighbourhood_group,
  neighbourhood,
  latitude,
  longitude,
  room_type,
  price,
  minimum_nights,
  number_of_reviews,
  last_review,
  reviews_per_month,
  calculated_host_listings_count,
  availability_365,
  number_of_reviews_ltm,
  license
)
select
  id::bigint,
  name,
  host_id::bigint,
  host_profile_id,
  host_name,
  nullif(neighbourhood_group, ''),
  neighbourhood,
  nullif(latitude, '')::double precision,
  nullif(longitude, '')::double precision,
  room_type,
  public.clean_price(price),
  nullif(minimum_nights, '')::integer,
  nullif(number_of_reviews, '')::integer,
  nullif(last_review, '')::date,
  nullif(reviews_per_month, '')::numeric,
  nullif(calculated_host_listings_count, '')::integer,
  nullif(availability_365, '')::integer,
  nullif(number_of_reviews_ltm, '')::integer,
  license
from listings_raw;

\copy public.reviews (listing_id, date) from '../data-sources/reviews.csv' with (format csv, header true)

\copy public.calendar from '../data-sources/calendar.csv' with (format csv, header true)

alter table public.reviews
  add constraint reviews_listing_id_fkey
  foreign key (listing_id) references public.listings (id);

alter table public.calendar
  add constraint calendar_listing_id_fkey
  foreign key (listing_id) references public.listings (id);

create index listings_last_review_idx on public.listings (last_review);
create index reviews_listing_id_date_idx on public.reviews (listing_id, date);
create index reviews_date_idx on public.reviews (date);
create index calendar_date_idx on public.calendar (date);
create index calendar_listing_available_idx
  on public.calendar (listing_id)
  where available = true;
