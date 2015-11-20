CREATE TABLE my_test_table
(
  name text,
  age smallint,
  id serial NOT NULL,
  CONSTRAINT id PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE my_test_table
  OWNER TO postgres;
