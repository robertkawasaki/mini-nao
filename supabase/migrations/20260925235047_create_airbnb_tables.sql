-- Airbnb Mallorca listings / reviews / calendar
-- price is stored as numeric; CSV currency symbols are stripped at load time (see seed.sql)

create or replace function public.clean_price(raw text)
returns numeric
language sql
immutable
parallel safe
as $$
  select nullif(regexp_replace(coalesce(raw, ''), '[^0-9.-]', '', 'g'), '')::numeric;
$$;

create table public.listings (
  id                             bigint primary key,
  name                           text,
  host_id                        bigint,
  host_profile_id                text,
  host_name                      text,
  neighbourhood_group            text,
  neighbourhood                  text,
  latitude                       double precision,
  longitude                      double precision,
  room_type                      text,
  price                          numeric,
  minimum_nights                 integer,
  number_of_reviews              integer,
  last_review                    date,
  reviews_per_month              numeric,
  calculated_host_listings_count integer,
  availability_365               integer,
  number_of_reviews_ltm          integer,
  license                        text
);

create table public.reviews (
  listing_id bigint not null references public.listings (id),
  date       date   not null,
  primary key (listing_id, date)
);

create table public.calendar (
  listing_id     bigint  not null references public.listings (id),
  date           date    not null,
  available      boolean not null,
  minimum_nights integer,
  maximum_nights integer,
  primary key (listing_id, date)
);

-- listing_id is covered by the composite PKs; add date (and useful secondary) indexes
create index listings_last_review_idx on public.listings (last_review);
create index reviews_date_idx on public.reviews (date);
create index calendar_date_idx on public.calendar (date);
create index calendar_listing_available_idx
  on public.calendar (listing_id)
  where available = true;
