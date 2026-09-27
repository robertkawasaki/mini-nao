# Golden set v1 — how to install

1. Delete `tests/control/` (e01 and e02 replace the two control tests).
2. Copy the `tests/` folders `easy/`, `medium/` and `traps_auto/` into your project `tests/`.
3. Copy `evals/` to the project root. It stays outside `tests/` on purpose: nao does not read it.
4. Run `evals/precheck.sql` in Supabase and fix any question whose premise fails.
5. Run each expected SQL in Supabase with the `postgres` user and check the result makes sense.
6. Add numeric tolerance to `nao_config.yaml` (see below), then run `nao test -s easy` first.

Tolerance, under the existing `test:` block:

    test:
      models:
        - "anthropic:claude-sonnet-4-6"
      threads: 2
      comparison:
        rtol: 0.01
        decimals: 2

Composition: 24 auto-graded (10 easy, 12 medium, 2 traps with a numeric answer)
+ 8 manual checks (6 traps that have no SQL answer, 2 explanation checks on t01/t04).
