-- Определить, какие автомобили из каждого класса имеют наименьшую среднюю позицию в гонках, и вывести информацию
-- о каждом таком автомобиле для данного класса, включая его класс, среднюю позицию и количество гонок, в которых
-- он участвовал. Также отсортировать результаты по средней позиции.

WITH results_by_car AS (SELECT c.class, r.car, AVG(r.position) AS avg_pos, COUNT(r.race) AS race_count
                        FROM Results r
                                 JOIN Cars c ON r.car = c.name
                        GROUP BY c.class, r.car),

     car_with_avg_pos AS (SELECT class,
                                 car,
                                 avg_pos,
                                 race_count,
                                 RANK() OVER (PARTITION BY class ORDER BY avg_pos) AS rank
                          FROM results_by_car)

SELECT car AS car_name, class AS car_class, avg_pos AS average_position, race_count
FROM car_with_avg_pos
WHERE rank = 1
ORDER BY avg_pos;