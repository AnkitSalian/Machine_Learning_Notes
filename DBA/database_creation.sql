create database market_star_schema;

use market_star_schema;

create table shipping_mode_dimen(
	Ship_Mode varchar(25),
    Vehicle_Company varchar(25),
    Toll_Required boolean
);