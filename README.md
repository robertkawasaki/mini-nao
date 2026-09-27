# Mini-NAO

Weekend demo: measure how a text-to-SQL analytics agent improves **only by improving context**, on public Inside Airbnb Mallorca data.

> Accuracy went from X% to Y% in three iterations — by context, not by changing the model.

## Repo map

| Path | Role |
| --- | --- |
| `supabase/` | Postgres schema, seed load, read-only `nao_reader` role script |
| `mini-nao-mallorca/` | **nao agent project** (`nao init`): config, context, `tests/`, `RULES.md` |
| `.env.example` | Env var names for DB password and LLM key (copy to `.env`, never commit) |

Local-only (gitignored): `data-sources/` (Inside Airbnb CSVs) and `docs/` (screenshots).

The nested folder name matches the nao `project_name`. The GitHub repo is `mini-nao`; run nao commands from inside `mini-nao-mallorca/`.

## Secrets

`nao_config.yaml` references environment variables only:

- `NAO_DB_PASSWORD` — password for the `nao_reader` Supabase role
- `ANTHROPIC_API_KEY` — Claude API key

```powershell
copy .env.example .env
# edit .env, then load into the session (see comments in .env.example)
cd mini-nao-mallorca
nao debug
nao sync
nao chat
```

## Attribution

Listing / calendar / review data from [Inside Airbnb](https://insideairbnb.com/get-the-data/), licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Snapshot used locally: 23 June 2026. CSVs are not redistributed in this repository.

## Stack

- [nao](https://github.com/getnao/nao) — open-source analytics agent + `nao test`
- Supabase (PostgreSQL) — warehouse for the demo
