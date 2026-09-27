-- Read-only role for the nao analytics agent.
-- Run manually in Supabase SQL Editor (do NOT commit a real password).
-- Replace CHANGE_ME with a strong password, then point nao's DATABASE_URL at this user.

do $$
begin
  if not exists (select 1 from pg_roles where rolname = 'nao_reader') then
    create role nao_reader with login password 'CHANGE_ME';
  end if;
end $$;

-- If the role already existed, rotate the password in SQL Editor:
--   alter role nao_reader with password 'CHANGE_ME';

grant usage on schema public to nao_reader;
grant select on all tables in schema public to nao_reader;
grant select on all sequences in schema public to nao_reader;
revoke create on schema public from nao_reader;

alter default privileges in schema public
  grant select on tables to nao_reader;

alter default privileges in schema public
  grant select on sequences to nao_reader;

alter role nao_reader set statement_timeout = '15s';

-- Connection string example (Session / direct):
-- postgresql://nao_reader:CHANGE_ME@db.<PROJECT_REF>.supabase.co:5432/postgres
--
-- Pooler (user often includes project ref):
-- postgresql://nao_reader.<PROJECT_REF>:CHANGE_ME@aws-0-<REGION>.pooler.supabase.com:5432/postgres
