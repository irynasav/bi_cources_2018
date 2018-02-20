###################################
#                                 #
#   САМЫЕ ВОСТРЕБОВАННЫЕ ТОВАРЫ   #
#                                 #
###################################


# Most popular sushi
#------+-------------+
# name | sushi_count |
#------+-------------+
SELECT sushi.name, COUNT(sushi_id) AS sushi_count FROM order_compos
  JOIN sushi ON order_compos.sushi_id=sushi.id
  GROUP BY sushi_id ORDER BY sushi_count DESC;


# Most popular drink
#------+-------------+
# name | drink_count |
#------+-------------+
SELECT drinks.name, COUNT(drink_id) AS drink_count FROM order_compos
  JOIN drinks ON order_compos.drink_id=drinks.id
  GROUP BY drink_id ORDER BY drink_count DESC;


# Most popular roll
#------+------------+
# name | roll_count |
#------+------------+
SELECT rolls.name, COUNT(roll_id) AS roll_count FROM order_compos
  JOIN rolls ON order_compos.roll_id=rolls.id
  GROUP BY roll_id ORDER BY roll_count DESC;


# Most popular addition
#------+----------------+
# name | addition_count |
#------+----------------+
SELECT additions.name, COUNT(addition_id) AS addition_count FROM order_compos
  JOIN additions ON order_compos.addition_id=additions.id
  GROUP BY addition_id ORDER BY addition_count DESC;


# Most popular set
#------+-----------+
# name | set_count |
#------+-----------+
SELECT sets.name, COUNT(set_id) AS set_count FROM order_compos
  JOIN sets ON order_compos.set_id=sets.id
  GROUP BY set_id ORDER BY set_count DESC;


# Most popular sweet_sushi
#------+-------------------+
# name | sweet_sushi_count |
#------+-------------------+
SELECT sweet_sushi.name, COUNT(sweet_sushi_id) AS sushi_count FROM order_compos
  JOIN sweet_sushi ON order_compos.sweet_sushi_id=sweet_sushi.id
  GROUP BY sweet_sushi_id ORDER BY sushi_count DESC;





##############################################
#                                            #
#   РАСПРЕДЕЛЕНИЕ ЗАКАЗОВ ПО РАЙОНАМ ГОРОДА  #
#                                            #
##############################################

# Districts by amount of orders
#------+----------------+
# name | district_count |
#------+----------------+
SELECT name AS district, COUNT(name) AS order_count FROM (
 SELECT
   districts.name,
   COUNT(street_id) AS district_count
 FROM customers
   JOIN streets ON customers.street_id=streets.id
   JOIN districts ON streets.district_id=districts.id
 GROUP BY street_id ORDER BY district_count DESC
) x GROUP BY name ORDER BY order_count DESC;



####################################################################
#                                                                  #
#   РАСПРЕДЕЛЕНИЕ ЗАКАЗОВ ПО  МЕСЯЦАМ, ДНЯМ НЕДЕЛИ, ВРЕМЕНИ СУТОК  #
#                                                                  #
####################################################################


# Orders per month
SELECT month, COUNT(month) AS oreders_per_month FROM (
 SELECT
   orders.id AS order_id,
   customer_id,
   customers.name,
   streets.name AS street,
   districts.name AS district,
   MONTHNAME(orders.time) AS month
 FROM orders
   JOIN customers ON orders.customer_id=customers.id
   JOIN streets ON customers.street_id=streets.id
   JOIN districts ON streets.district_id=districts.id
 ORDER BY orders.time ASC

) x GROUP BY month ORDER BY oreders_per_month DESC;

# Orders per day of month
SELECT day, COUNT(day) AS oreders_per_day FROM (
 SELECT
   orders.id AS order_id,
   customer_id,
   customers.name,
   streets.name AS street,
   districts.name AS district,
   DAY(orders.time) AS day
 FROM orders
   JOIN customers ON orders.customer_id=customers.id
   JOIN streets ON customers.street_id=streets.id
   JOIN districts ON streets.district_id=districts.id
 ORDER BY orders.time ASC

) x GROUP BY day ORDER BY oreders_per_day DESC;


# Orders by time
SELECT time, COUNT(time) AS oreders_per_time FROM (
  SELECT
    orders.id AS order_id,
    customer_id,
    customers.name,
    streets.name AS street,
    districts.name AS district,
    CONCAT(HOUR(orders.time), ':', MINUTE(orders.time)) AS time
  FROM orders
    JOIN customers ON orders.customer_id=customers.id
    JOIN streets ON customers.street_id=streets.id
    JOIN districts ON streets.district_id=districts.id
  ORDER BY orders.time ASC

) x GROUP BY time ORDER BY oreders_per_time DESC;



################################################
#                                              #
#   РАЗБРОСЫ ПО ВРЕМЕНИ И ГЕОЛОКАЦИИ ДОСТАВКИ  #
#                                              #
################################################

# District, street and time
SELECT
  orders.id AS order_id,
  districts.name AS district,
  streets.name AS street,
  customers.home_number,
  CONCAT(HOUR(orders.time), ':', MINUTE(orders.time)) AS time
FROM orders
  JOIN customers ON orders.customer_id=customers.id
  JOIN streets ON customers.street_id=streets.id
  JOIN districts ON streets.district_id=districts.id
ORDER BY orders.time ASC;
