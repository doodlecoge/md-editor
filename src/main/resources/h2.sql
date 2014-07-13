CREATE SCHEMA IF NOT EXISTS md;

CREATE TABLE IF NOT EXISTS md.users (
  username     VARCHAR(20) NOT NULL,
  password     VARCHAR(20) NOT NULL,
  display_name VARCHAR(20) NOT NULL,
  CONSTRAINT IF NOT EXISTS pk_username PRIMARY KEY (username)
);

INSERT INTO
  md.users (username, password, display_name)
VALUES
  ('huaichao', 'password', 'Huaichao Wang');

CREATE TABLE IF NOT EXISTS md.folders (
  folder_id   INT         NOT NULL,
  username    VARCHAR(20) NOT NULL,
  folder_name VARCHAR(20) NOT NULL,
  parent_id   INT         NULL,
  CONSTRAINT IF NOT EXISTS pk_folder_id PRIMARY KEY (folder_id),
  CONSTRAINT IF NOT EXISTS fk_username FOREIGN KEY (username)
  REFERENCES md.users (username) ON DELETE CASCADE,
  CONSTRAINT IF NOT EXISTS fk_parent_id FOREIGN KEY (parent_id)
  REFERENCES md.folders (folder_id) ON DELETE CASCADE
);

INSERT INTO
  md.folders (folder_id, username, folder_name, parent_id)
VALUES
  (1, 'huaichao', 'java notes', NULL),
  (2, 'huaichao', 'spring', 1),
  (3, 'huaichao', 'reflection', 1);