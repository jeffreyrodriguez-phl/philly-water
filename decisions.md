## 2026-10-28
-Download PostgreSQL, DBeaver for Database. This is Linux-friendly and appears similar to T-SQL.
-Create Tableau Public account as Tableau Desktop and Power BI do not run on Linux
## 2026-11-1
-Using 2025 311 data to start, will full data for a year to learn
-Pulling data via Philadelphia's Carto API instead of downloading full CSV, to filter at source rather than download large CSV
-Use Bruno for API requests
-https://opendataphilly.org/datasets/311-service-and-information-requests/
-https://phl.carto.com/api/v2/sql
-`public_cases_fc` database

## 2026-11-02
- Created philly_water database (DBeaver's menu wouldn't allow it, so used createdb in Terminal).
- Tried importing the 2025 311 CSV with DBeaver's import wizard. Failed 3 times: "value too long for type character varying(50)".
- Checked in LibreOffice Calc: the longest value in status_notes is 254 characters. The wizard guessed 50-character columns and kept reusing the old table even after changing settings.
- Plan: create the raw table manually with all text columns and load the CSV with psql instead of the wizard.

## 2026-11-06 
- Table raw_311_2025 added into PostgreSQL, checked max lengths (status_notes 35, address 50, media_url 84). None hit 254 characters.
- address max is 50, same as the old column limit. Some rows may have been dropped ruing import.
- Several columns have NULLs ex status_notes, service_note and more. 
	- **To-Do cleaning for later - count NULLs per column**
- Counts by service_name are far below API's 2025 count (36204 vs 285476 for information request services)
- Checked min/max requested_datetimes and see that import failed partway through, only first 7 weeks (1/1/2025 -- 2/25/2025) were includedd.
- Plan: Drop the partial table, create raw_311_2025 with all text columns, reload full CSV via psql. Confirm row and date range.
- *Question: Which column had the 254-character values?*
- *Question*: Which agencies handle water complains? Query agency_responsible by service_type (so far have seen: "Broken Main Drain/Raw Sewage within Property" under Maintenance Complaint goes to License & Inspections.)

## 2026-11-07
- Dropped the partial raw_311_2025 and recreated it with all 20 columns as text. Checked with information_schema.columns: 20 columns, all text, same order as the CSV header.
- `wc -l` on public_cases_fc.csv: 518,842 lines (518,841 rows + header).
- Loaded the CSV with psql `\copy` (FORMAT csv, HEADER true): COPY 518841. 
- requested_datetime range: 2025-01-01 00:00:34+00 to 2025-12-31 23:51:10+00. Times are in UTC (+00), not local time.
- Counts by month: lowest Feb (35,881), highest Jul (52,630). No month missing data.
- API count for 2025 on requested_datetime: 518,841, exact match with the table. The ~550k I remembered was wrong.
	- Saved the count request in Bruno as "311 count – 2025".