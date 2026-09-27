# Data sources (local only)

CSV files in this folder are **not committed** (see root `.gitignore`).

## Snapshot

- Source: [Inside Airbnb — get the data](https://insideairbnb.com/get-the-data/)
- City / region: Mallorca
- Files used: `listings.csv`, `calendar.csv`, `reviews.csv`
- Snapshot note: see `notes.txt` (23 June 2026)
- License: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

## Download

1. Open the Mallorca section on Inside Airbnb.
2. Download the three CSVs above into this folder (`data-sources/`).
3. Load into Postgres with `supabase/seed.sql` (after migrations), or your own `\copy`.

Do not publish host PII in demos: prefer aggregates and listing IDs.
