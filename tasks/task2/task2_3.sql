-- Определить классы автомобилей, которые имеют наименьшую среднюю позицию в гонках, и вывести информацию
-- о каждом автомобиле из этих классов, включая его имя, среднюю позицию, количество гонок, в которых он участвовал,
-- страну производства класса автомобиля, а также общее количество гонок, в которых участвовали автомобили этих классов.
-- Если несколько классов имеют одинаковую среднюю позицию, выбрать все из них.

WITH class_for_results AS (
    SELECT c.class AS class, AVG(r.position) AS avg_pos, COUNT(r.race) AS total_races
    FROM Results r
             JOIN Cars c ON r.car = c.name
    GROUP BY c.class
),

     result_for_cars AS (
         SELECT c.name AS car_name, c.class AS car_class, AVG(r.position) AS average_position,
                COUNT(r.race) AS race_count, cl.country AS car_country
         FROM Results r
                  JOIN Cars c ON r.car = c.name
                  JOIN Classes cl on cl.class = c.class
         WHERE c.class IN (SELECT class FROM class_for_results WHERE avg_pos = (SELECT MIN(avg_pos) FROM class_for_results))
         GROUP BY c.name, c.class, cl.country)

SELECT cr.car_name AS car_name, cr.car_class AS car_class, cr.average_position AS average_position,
       cr.race_count AS race_count, cr.car_country AS car_country, cls.total_races AS total_races
FROM result_for_cars cr
         JOIN class_for_results cls on cls.class = cr.car_class;