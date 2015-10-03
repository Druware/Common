create schema web;

create table web.contact_types (
    type_id serial not null primary key,
    name varchar(32) not null,
    description varchar(255) null,
    active boolean not null default(true)
);

insert into web.contact_types ( type_id, name, description ) values (
    1, 'User', 'Application User'
);

insert into web.contact_types ( type_id, name, description ) values (
    2, 'Staff', 'OGRE Staff Member'
);

create table web.contact (
    contact_id bigserial not null primary key,
    type_id int not null default(1),
    last_name varchar(64) not null,
    first_name varchar(64) not null,
    middle_name varchar(64) null,
    constraint fk_contact_type_id
        foreign key ( type_id ) references web.contact_types ( type_id )
);

create table web.email_types (

);

create table web.email (

);

create table web.phone_types (

);

create table web.phone (

);

create table web.contact_email (

);

create table web.contact_phone (

);

create table web."user" (
    user_id bigserial not null primary key,
    login varchar(255) not null,
    password_hash varchar(255) null, -- a null password is a new account
    account_validated timestamp null, -- a null is an unvalidated account
    contact_info varchar(255) null
);

create table web."sessio n" (
    session_id bigserial not null primary key,
    session_uid varchar(42) not null,
    last_access timestamp not null default(now()),
    is_persistant boolean default(false) not null,
    device_id varchar(255) null,
    addresss varchar(16) null,
    user_id bigint null,
    constraint fk_session_user_is
        foreign key ( user_id ) references web."user" ( user_id )
);