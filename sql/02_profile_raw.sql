--view earliest and latest dates to ensure full data was pulled
select min(requested_datetime) min, max(requested_datetime) max from raw_311_2025;

--view total count per month
select count(*), left(requested_datetime,7) as month from raw_311_2025 group by left(requested_datetime,7) order by month asc; 

--view max length of each column
select max(length(objectid))           as objectid,
       max(length(service_request_id)) as service_request_id,
       max(length(status))             as status,
       max(length(status_notes))       as status_notes,
       max(length(service_name))       as service_name,
       max(length(service_code))       as service_code,
       max(length(agency_responsible)) as agency_responsible,
       max(length(service_notice))     as service_notice,
       max(length(requested_datetime)) as requested_datetime,
       max(length(updated_datetime))   as updated_datetime,
       max(length(expected_datetime))  as expected_datetime,
       max(length(address))            as address,
       max(length(zipcode))            as zipcode,
       max(length(media_url))          as media_url,
       max(length(lat))                as lat,
       max(length(lon))                as lon,
       max(length(subject))            as subject,
       max(length(closed_datetime))    as closed_datetime,
       max(length(gdb_geomattr_data))  as gdb_geomattr_data,
       max(length(service_type))       as service_type
from raw_311_2025;
