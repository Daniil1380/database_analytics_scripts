-- Вам необходимо провести анализ данных о бронированиях в отелях и определить предпочтения клиентов по типу отелей

WITH hotel_categories AS (
    SELECT  h.ID_hotel, h.name AS hotel_name,
            CASE
                WHEN AVG(r.price) < 175 THEN 'Дешевый'
                WHEN AVG(r.price) BETWEEN 175 AND 300 THEN 'Средний'
                ELSE 'Дорогой'
                END AS category
    FROM Hotel h
             JOIN Room r ON h.ID_hotel = r.ID_hotel
    GROUP BY  h.ID_hotel
),
     customer_preferences AS (
         SELECT
             c.ID_customer,
             c.name,
             COUNT(DISTINCT CASE WHEN hc.category = 'Дешевый' THEN hc.ID_hotel END) AS cheap_count,
             COUNT(DISTINCT CASE WHEN hc.category = 'Средний' THEN hc.ID_hotel END) AS medium_count,
             COUNT(DISTINCT CASE WHEN hc.category = 'Дорогой' THEN hc.ID_hotel END) AS expensive_count,
             string_agg(DISTINCT hc.hotel_name, ', ') AS visited_hotels
         FROM Customer c
                  JOIN Booking b ON c.ID_customer = b.ID_customer
                  JOIN Room r ON b.ID_room = r.ID_room
                  JOIN hotel_categories hc ON r.ID_hotel = hc.ID_hotel
         GROUP BY c.ID_customer, c.name
     )
SELECT
    ID_customer, name,
    CASE
        WHEN expensive_count > 0 THEN 'Дорогой'
        WHEN medium_count > 0 THEN 'Средний'
        WHEN cheap_count > 0 THEN 'Дешевый'
        END AS preferred_hotel_type,
    visited_hotels
FROM
    customer_preferences
ORDER BY
    CASE
        WHEN expensive_count > 0 THEN 3
        WHEN medium_count > 0 THEN 2
        WHEN cheap_count > 0 THEN 1
        END