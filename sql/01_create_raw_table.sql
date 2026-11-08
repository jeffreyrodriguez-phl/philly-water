DROP TABLE IF EXISTS raw_311_2025;

CREATE TABLE raw_311_2025 (
    objectid            text,
    service_request_id  text,
    status              text,
    status_notes        text,
    service_name        text,
    service_code        text,
    agency_responsible  text,
    service_notice      text,
    requested_datetime  text,
    updated_datetime    text,
    expected_datetime   text,
    address             text,
    zipcode             text,
    media_url           text,
    lat                 text,
    lon                 text,
    subject             text,
    closed_datetime     text,
    gdb_geomattr_data   text,
    service_type        text
);