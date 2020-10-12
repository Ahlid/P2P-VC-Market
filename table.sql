create table "Token"
(
	id uuid default uuid_generate_v4() not null
		constraint token_pk
			primary key,
	revoked boolean default false,
	subject_type varchar(255),
	subject_id uuid not null
);

alter table "Token" owner to postgres;

create unique index token_id_uindex
	on "Token" (id);

create table "User"
(
	password varchar(255) not null,
	email varchar(255) not null,
	credits integer default 0,
	id uuid default uuid_generate_v4() not null
		constraint user_pk
			primary key
);

alter table "User" owner to postgres;

create table "Job"
(
	id uuid default uuid_generate_v4() not null
		constraint job_pk
			primary key,
	disc integer,
	"RAM" integer,
	exec_time double precision,
	status varchar(255),
	price integer,
	deadline timestamp,
	init_time timestamp,
	r_data_path varchar(255),
	folder_path varchar(255),
	mean_up_time double precision,
	user_id uuid
		constraint job_user_id_fk
			references "User",
	name varchar(255),
	"CPU" integer,
	exec_file varchar(255),
	"partialResultsVars" jsonb
);

alter table "Job" owner to postgres;

create table "Machine"
(
	id uuid default uuid_generate_v4() not null
		constraint machine_pk
			primary key,
	name varchar(255),
	"CPU" integer,
	disc integer,
	"RAM" integer,
	price integer,
	scj integer,
	credibility integer,
	user_id uuid not null
		constraint machine_user_id_fk
			references "User"
);

alter table "Machine" owner to postgres;

create table hearthz
(
	timestamp timestamp default now() not null,
	machine_id uuid not null
		constraint hearthz_machine_id_fk
			references "Machine",
	disc integer,
	"RAM" integer,
	"CPU" integer,
	network integer,
	jobs integer,
	ip varchar(255),
	session_id uuid
		constraint hearthz_token_id_fk
			references "Token",
	constraint hearthz_pkey
		primary key (timestamp, machine_id)
);

alter table hearthz owner to postgres;

create index hearthz_timestamp_idx
	on hearthz (timestamp desc);

create trigger ts_insert_blocker
	before insert
	on hearthz
	for each row
	execute procedure ???();

create trigger ts_cagg_invalidation_trigger
	after insert or update or delete
	on hearthz
	for each row
	execute procedure ???();

create unique index machine_id_uindex
	on "Machine" (id);

create table "Volunteer"
(
	id uuid default uuid_generate_v4() not null
		constraint volunteer_pk
			primary key,
	machine_id uuid not null
		constraint volunteer_machine_id_fk
			references "Machine",
	ip varchar(255),
	port integer,
	state varchar(50),
	created_at timestamp default now(),
	session_id uuid not null
		constraint volunteer_token_id_fk
			references "Token",
	stoped boolean default false,
	timeouted boolean default false
);

alter table "Volunteer" owner to postgres;

create table partial_results
(
	id uuid default uuid_generate_v4(),
	name varchar,
	job_id uuid,
	value bytea,
	created_at timestamp default now()
);

alter table partial_results owner to postgres;

create table peer
(
	peer_id uuid not null
		constraint peer_machine_id_fk
			references "Machine",
	super_peer_id uuid not null
		constraint peer_machine_id_fk_2
			references "Machine",
	disk integer,
	credits integer,
	host varchar,
	cpu integer,
	ram integer,
	created_at timestamp with time zone default now(),
	port integer,
	constraint peer_pkey
		primary key (peer_id, super_peer_id)
);

alter table peer owner to postgres;

