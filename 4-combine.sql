create or replace function combine()
returns table (start_date_time timestamp, end_date_time timestamp) as $$
declare
start_count integer := 0;
end_count integer := 0;
cur_time interval_time;
begin
	for cur_time in 
	select intervals.start_date_time, 1 from intervals
	union
	select intervals.end_date_time, 2 from intervals
	order by 1, 2
	loop
		if start_count = end_count then
			start_date_time := cur_time.time_value;
		end if;
		if cur_time.time_type = 1 then
			start_count := start_count + 1;
		else
			end_count := end_count + 1;
		end if;
		if start_count = end_count then
			end_date_time := cur_time.time_value;
			return next;
		end if;
	end loop;
end;
$$ language plpgsql;