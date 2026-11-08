select column_name, data_type
from information_schema.columns
where table_name = 'raw_311_2025'
order by ordinal_position
