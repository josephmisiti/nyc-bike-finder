CREATE EXTENSION postgis;

CREATE TABLE stations
(
	id integer PRIMARY KEY,
	station_name text NOT NULL,
	location geography,
	status_value text,
	status_key smallint,
	available_docks integer,
	total_docks integer,
	available_bikes integer,
	last_communication_time date,
	st_address1 text,
	st_address2 text,
	city text,
	postal_code text,
	location_text text,
	altitude text,
	test_station boolean NOT NULL,
	land_mark text,

	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL
);

CREATE TABLE station_histories
(
	id serial PRIMARY KEY,
	station_id integer NOT NULL REFERENCES stations (id),
	available_docks integer,
	total_docks integer,
	status_value text,
	status_key smallint,
	available_bikes integer,
	last_communication_time timestamp,

	created_at timestamp NOT NULL,

	UNIQUE (station_id, last_communication_time)
);
