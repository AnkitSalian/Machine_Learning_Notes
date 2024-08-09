update shipping_mode_dimen
set Toll_Required = true
where Ship_Mode = 'DELIVERY TRUCK';

select * from shipping_mode_dimen;

set SQL_SAFE_UPDATES = 0;
delete from shipping_mode_dimen
where Vehicle_Company = 'Air India';

set SQL_SAFE_UPDATES = 1;