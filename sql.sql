DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS order_compos;
DROP TABLE IF EXISTS sushi;
DROP TABLE IF EXISTS sweet_sushi;
DROP TABLE IF EXISTS rolls;
DROP TABLE IF EXISTS sets;
DROP TABLE IF EXISTS drinks;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS couriers;
DROP TABLE IF EXISTS streets;
DROP TABLE IF EXISTS districts;
DROP TABLE IF EXISTS additions;





CREATE TABLE sushi (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  price DECIMAL(4,2),
  weight INT,
  quantity INT,
  composition VARCHAR(200)
);


CREATE TABLE rolls (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  price DECIMAL(4,2),
  weight INT(11),
  quantity INT,
  composition VARCHAR(200)
);


CREATE TABLE sets (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  price DECIMAL(4,2) NOT NULL,
  weight INT (11),
  quantity INT,
  composition VARCHAR(200)
);


CREATE TABLE sweet_sushi (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  price DECIMAL(4,2) NOT NULL,
  weight INT,
  quantity INT,
  composition VARCHAR(200)
);

CREATE TABLE districts (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE streets (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  name VARCHAR(100),
  district_id INT,
  FOREIGN KEY (district_id) REFERENCES districts(id)
);


CREATE TABLE customers (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  name VARCHAR (50),
  phone VARCHAR(30),
  street_id INT,
  home_number INT,
  FOREIGN KEY (street_id) REFERENCES streets(id),
  payment_method VARCHAR(20)
);

CREATE TABLE couriers (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  name VARCHAR(40) NOT NULL,
  phone VARCHAR(20),
  district_id INT,
  FOREIGN KEY (district_id) REFERENCES districts(id),
  is_available BOOLEAN
);


CREATE TABLE drinks (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY ,
  name VARCHAR(30) NOT NULL ,
  price DECIMAL(4,2) NOT NULL,
  litre DECIMAL(4,2)
);



CREATE TABLE additions (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(30),
  price DECIMAL(4,2),
  weight INT
);


CREATE TABLE order_compos (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  sushi_id INT,
  sushi_quantity INT,
  roll_id INT,
  roll_quantity INT,
  set_id INT,
  set_quantity INT,
  sweet_sushi_id INT,
  sweet_quantity INT,
  drink_id INT,
  drink_quantity INT,
  addition_id INT,
  addition_quantity INT,
  FOREIGN KEY (sushi_id) REFERENCES sushi(id),
  FOREIGN KEY (roll_id) REFERENCES rolls(id),
  FOREIGN KEY (set_id) REFERENCES sets(id),
  FOREIGN KEY (sweet_sushi_id) REFERENCES sweet_sushi(id),
  FOREIGN KEY (drink_id) REFERENCES drinks(id),
  FOREIGN KEY (addition_id) REFERENCES additions(id)
);


CREATE TABLE orders (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  customer_id INT,
  courier_id INT,
  order_compos_id INT,
  FOREIGN KEY (customer_id) REFERENCES customers(id),
  FOREIGN KEY (courier_id) REFERENCES couriers(id),
  FOREIGN KEY (order_compos_id) REFERENCES order_compos(id),
  time TIMESTAMP,
  done BOOLEAN
);


