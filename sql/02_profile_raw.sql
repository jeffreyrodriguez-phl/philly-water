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

--view longest addresses: some are canned 311 messages, not real addresses
select address, length (address) as len from raw_311_2025 where address is not null order by len desc;

--view addresses over 200 characters
select address from raw_311_2025 where length(address) > 200;

--count NULLs per column
select count(*) - count(status)             as status,
       count(*) - count(status_notes)       as status_notes,
       count(*) - count(service_name)       as service_name,
       count(*) - count(service_code)       as service_code,
       count(*) - count(agency_responsible) as agency_responsible,
       count(*) - count(service_notice)     as service_notice,
       count(*) - count(requested_datetime) as requested_datetime,
       count(*) - count(updated_datetime)   as updated_datetime,
       count(*) - count(expected_datetime)  as expected_datetime,
       count(*) - count(address)            as address,
       count(*) - count(zipcode)            as zipcode,
       count(*) - count(media_url)          as media_url,
       count(*) - count(lat)                as lat,
       count(*) - count(lon)                as lon,
       count(*) - count(subject)            as subject,
       count(*) - count(closed_datetime)    as closed_datetime,
       count(*) - count(gdb_geomattr_data)  as gdb_geomattr_data,
       count(*) - count(service_type)       as service_type
from raw_311_2025;

select count(*) from raw_311_2025 where lat is null and service_name != 'Information Request';
--1291 non-Information Request services with no longitude/latitude

select count(*) - count(address) from raw_311_2025 where lat is null and service_name != 'Information Request';
--948 non-Information Request services with no address
