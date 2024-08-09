use market_star_schema;

alter table shipping_mode_dimen
add constraint primary key (Ship_Mode);

alter table shipping_mode_dimen
add Vehicle_Number varchar(20);

set SQL_SAFE_UPDATES = 0;
update shipping_mode_dimen
set Vehicle_Number = 'MH-03-1234';

alter table shipping_mode_dimen
drop column Vehicle_Number;

alter table shipping_mode_dimen
change Toll_Required Toll_Amount int;