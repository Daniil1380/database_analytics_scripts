-- Определить автомобиль, который имеет наименьшую среднюю позицию в гонках среди всех автомобилей,
-- и вывести информацию об этом автомобиле, включая его класс, среднюю позицию, количество гонок,
-- в которых он участвовал, и страну производства класса автомобиля. Если несколько автомобилей имеют
-- одинаковую наименьшую среднюю позицию, выбрать один из них по алфавиту (по имени автомобиля).

SELECT r.car, c.class, AVG(r.position) AS avg_pos, COUNT(r.race) AS race_count, cl.country AS car_country
FROM Results r
         JOIN Cars c ON r.car = c.name
         JOIN Classes cl ON c.class = cl.class
GROUP BY r.car, c.class, cl.country, c.name
ORDER BY avg_pos, c.name
LIMIT 1;