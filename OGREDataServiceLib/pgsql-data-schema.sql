create schema web;


create table web."user" (
user_id bigserial not null primary key,
contact_info varchar(255) null
);

create table web."session" (
session_id bigserial not null primary key,
session_uid varchar(42) not null,
last_access timestamp not null default(now()),
is_persistant boolean default(false) not null,
device_id varchar(255) null,
user_id bigint null,
constraint fk_session_user_is foreign key ( user_id ) references web."user" ( user_id )
);