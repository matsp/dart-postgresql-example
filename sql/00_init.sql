\connect app;

-- auth schema 

CREATE SCHEMA IF NOT EXISTS auth AUTHORIZATION app;

CREATE TABLE IF NOT EXISTS auth.users
(
  id UUID,
  name text,
  PRIMARY KEY (id)
);

ALTER TABLE auth.users OWNER to "app";

-- other schemas
