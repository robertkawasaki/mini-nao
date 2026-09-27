## Where the context is
The database has exactly three tables: listings, calendar, reviews.
Read these files directly with these exact paths. Do not search or list folders:
- /databases/type=postgres/database=postgres/schema=public/table=listings/columns.md
- /databases/type=postgres/database=postgres/schema=public/table=calendar/columns.md
- /databases/type=postgres/database=postgres/schema=public/table=reviews/columns.md

## Business glossary (always applies)
- Snapshot: the data was collected in June 2026. "Now", "last year" or "last 12 months" are relative to the snapshot, never to today's date.
- Reviews: use the counters in listings (number_of_reviews, number_of_reviews_ltm). Count rows in reviews only when the question needs review dates.
- Host size: listings.calculated_host_listings_count.
- Location: listings.neighbourhood (municipality). neighbourhood_group is always empty.
- Price: listings.price is the base nightly price in EUR, not a price for a specific date. NULL means no published price.
- Availability: calendar is future availability. available = false means not bookable (booked or blocked by the host), not a booking.
- Tourist license: read the value right after "Mallorca - Regional registration number<br />". If it starts with "Exempt", the listing is exempt. Any other value is a registration code, whatever its format. No Mallorca entry means no regional entry. NULL means no data.

## How to answer
- If you exclude records, give the number and the percentage of the total, counted before the filter.
- Occupancy or revenue from the calendar are estimates: say so and explain the method.
- Always use EUR. Never use $.
- Do not explain causes unless the data shows them. If asked "why", say what data is missing.
- If a question depends on an undefined criterion ("best", "top"), ask or state the criterion you use.
- If the data cannot answer the exact question, say so in the first sentence and label the result with what it really is.
- Do not explain why a value is high or low unless the user asks.