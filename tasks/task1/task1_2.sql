-- Найти информацию о производителях и моделях различных типов транспортных средств (автомобили, мотоциклы и велосипеды),
-- которые соответствуют заданным критериям.

SELECT v.maker, c.model, c.horsepower, c.engine_capacity, v.type AS vehicle_type
FROM Car c JOIN Vehicle v ON c.model = v.model
WHERE horsepower > 150 AND engine_capacity < 3 AND price < 35000 UNION ALL
SELECT v.maker, m.model, m.horsepower, m.engine_capacity, v.type AS vehicle_type
FROM Motorcycle m JOIN Vehicle v ON m.model = v.model
WHERE horsepower > 150 AND engine_capacity < 1.5 AND price < 20000
UNION ALL
SELECT v.maker, b.model, NULL AS horsepower, NULL AS engine_capacity, v.type AS vehicle_type
FROM Bicycle b JOIN Vehicle v ON b.model = v.model
WHERE gear_count > 18 AND price < 4000
ORDER BY horsepower DESC NULLS LAST;