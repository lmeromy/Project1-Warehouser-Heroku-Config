DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS manufacturers;


CREATE TABLE manufacturers (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  sector VARCHAR(255)
);

CREATE TABLE items (
  id SERIAL4 PRIMARY KEY,
  product VARCHAR(255),
  category VARCHAR(255),
  costprice INT4,
  sellprice INT4,
  manuf_id INT4 REFERENCES manufacturers(id) ON DELETE CASCADE,
  quantity INT4,
  stock_level VARCHAR(255)
);
