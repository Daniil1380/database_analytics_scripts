-- Определить, какие классы автомобилей имеют наибольшее количество автомобилей с низкой средней позицией
-- (больше 3.0) и вывести информацию о каждом автомобиле из этих классов, включая его имя, класс, среднюю позицию,
-- количество гонок, в которых он участвовал, страну производства класса автомобиля, а также общее количество гонок
-- для каждого класса. Отсортировать результаты по количеству автомобилей с низкой средней позицией.

WITH cars_result AS (
    SELECT c.name AS car_name, c.class AS car_class, AVG(r.position) AS average_position,
           COUNT(r.race) AS race_count, cl.country AS car_country
    FROM Results r
             JOIN Cars c ON r.car = c.name
             JOIN Classes cl on cl.class = c.class
    GROUP BY c.name, c.class, cl.country
    HAVING AVG(r.position) > 3.0
),

     class_result AS (
         SELECT c.class AS class, COUNT(c.name) AS car_count, COUNT(r.race) AS total_races
         FROM Results r
                  JOIN Cars c ON r.car = c.name
         GROUP BY c.class)

SELECT cr.car_name AS car_name, cr.car_class AS car_class, cr.average_position AS average_position,
       cr.race_count AS race_count, cr.car_country AS car_country, cls.total_races AS total_races,
       cls.car_count AS low_position_count
FROM cars_result cr
         JOIN class_result cls on cls.class = cr.car_class
ORDER BY low_position_count DESC;