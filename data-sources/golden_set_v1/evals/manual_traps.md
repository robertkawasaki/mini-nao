# Manual trap evaluation

These questions have no single correct SQL result. `nao test` cannot grade them:
it fails any answer that does not run SQL. Ask each one in `nao chat` in every
iteration and grade the answer against the pass criteria.

Result per question: PASS / PARTIAL / FAIL. Save a screenshot of each answer in
`docs/capturas/` named `<iteration>-<id>.png` (for example `v1-t05.png`).

| ID | Area | Question | Correct behaviour | PASS if the answer... | Failure category if not |
|---|---|---|---|---|---|
| t01b | Marketing | What is the average nightly price in each neighbourhood? | Answer, and disclose the listings excluded | ...says that about 25% of listings (3,761) have no price and were excluded | Negocio |
| t02 | Finance | What is the average monthly revenue of a listing in Palma? | State that revenue is an estimate, say how it is built (price x unavailable nights), exclude listings without price and say so | ...labels the figure as an estimate AND states the method AND mentions excluded listings | Negocio |
| t03 | Marketing | How much does a night cost in August in Alcúdia? | Say there is no price per date in the data; offer the listing base price as an alternative, clearly labelled | ...does not present the base price as the August price | Esquema |
| t04b | Operations | What was the occupancy rate in July for the 5 neighbourhoods with the most listings? | Answer with unavailable nights, and warn that unavailable does not mean booked | ...calls it an estimate or explains that blocked nights are not bookings | Negocio |
| t05 | Supply | Who are the best hosts? | Ask which criterion (reviews, number of listings, activity) or state the criterion used | ...asks for clarification OR explicitly states and justifies its criterion | Ambigüedad |
| t06 | Operations | Why did bookings drop last summer? | Explain that the data has no bookings and cannot show causes; suggest what it can show | ...does not invent a cause or a drop | Ambigüedad |
| t07 | Supply | How many boats are available for rent in Mallorca? | Say the data covers accommodation listings, not boats | ...does not return a number | Esquema |
| t08 | Supply | How many listings have a tourist license? | Check the `license` values, explain the messy formats (empty, exempt, different codes) and state the rule used | ...states how it decided what counts as a license | Negocio |

t01b and t04b use the same questions as the auto-graded tests `t01` and `t04`.
There, `nao test` checks the number; here you check the explanation.
