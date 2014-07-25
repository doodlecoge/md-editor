CREATE SCHEMA IF NOT EXISTS md;

CREATE TABLE IF NOT EXISTS md.users (
  username     VARCHAR(20) NOT NULL,
  password     VARCHAR(20) NOT NULL,
  display_name VARCHAR(20) NOT NULL,
  CONSTRAINT IF NOT EXISTS pk_username PRIMARY KEY (username)
);

CREATE TABLE IF NOT EXISTS md.files (
  id       INT          NOT NULL,
  pid      INT          NULL,
  type     VARCHAR(6)   NOT NULL, -- FILE | FOLDER
  name     VARCHAR(100) NOT NULL,
  username VARCHAR(20)  NOT NULL,
  CONSTRAINT IF NOT EXISTS pk_file_id PRIMARY KEY (id),
  CONSTRAINT IF NOT EXISTS fk_username FOREIGN KEY (username)
  REFERENCES md.users (username) ON DELETE CASCADE,
  CONSTRAINT IF NOT EXISTS fk_pid FOREIGN KEY (pid)
  REFERENCES md.files (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS md.contents (
  file_id INT           NOT NULL,
  content VARCHAR(8096) NULL,
  CONSTRAINT IF NOT EXISTS fk_file_id FOREIGN KEY (file_id)
  REFERENCES md.files (id) ON DELETE CASCADE
);


-- populate with test data

INSERT INTO
  md.users (username, password, display_name)
VALUES
  ('huaichao', 'password', 'Huaichao Wang');


INSERT INTO
  md.files (id, username, name, pid, type)
VALUES
  (1, 'huaichao', 'java notes', NULL, 'D'),
  (2, 'huaichao', 'spring',     1,    'D'),
  (3, 'huaichao', 'reflection', 1,    'D'),
  (4, 'huaichao', 'ejb notes',  1,    'F'),
  (5, 'huaichao', 'spring ws',  2,    'F'),
  (6, 'huaichao', 'spring mvc', 2,    'F');


INSERT INTO
  md.contents (file_id, content)
VALUES
  (4, '
Enterprise Java Bean
====================

1. java types
2. flow control statements'),


  (5, '
Spring Web Service
==================

1. Web Service Basis
2. Spring WS Configuration'),


  (6, '
Spring MVC
==========

1. MVC annotation
2. flow control statements');