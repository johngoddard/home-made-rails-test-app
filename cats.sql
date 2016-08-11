CREATE TABLE cats (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  owner_id INTEGER,

  FOREIGN KEY(owner_id) REFERENCES user(id)
);

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  password_digest VARCHAR(255) NOT NULL,
  session_token VARCHAR(255) NOT NULL
);

CREATE TABLE cat_rental_requests (
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  cat_id INTEGER,
  start_date DATE,
  end_date DATE,

  FOREIGN KEY(user_id) REFERENCES user(id),
  FOREIGN KEY(cat_id) REFERENCES cat(id)
);




-- INSERT INTO
--   humans (id, fname, lname)
-- VALUES
--   (1, "Devon", "Watts"),
--   (2, "Matt", "Rubens"),
--   (3, "Ned", "Ruggeri"),
--   (4, "Catless", "Human");
--
-- INSERT INTO
--   cats (id, name, owner_id)
-- VALUES
--   (1, "Breakfast", 1),
--   (2, "Earl", 2),
--   (3, "Haskell", 3),
--   (4, "Markov", 3),
--   (5, "Stray Cat", NULL);
