create table intervals (
    start_date_time timestamp,
    end_date_time   timestamp,
    constraint pk primary key (start_date_time, end_date_time)
)