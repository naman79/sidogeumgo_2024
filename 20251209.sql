select
    table_name,
    column_id,
    column_name,
    data_type,
    data_length,
    nullable
from all_tab_columns
where owner = 'ICTOWN'
order by table_name, column_id 



select
    column_name,
    table_name
from all_tab_columns
where owner = 'ICTOWN'
order by table_name, column_id 