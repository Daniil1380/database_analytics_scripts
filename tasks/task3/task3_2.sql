-- Необходимо провести анализ клиентов, которые сделали более двух бронирований в разных отелях и потратили более
-- 500 долларов на свои бронирования.

SELECT
    c.ID_customer AS ID_customer,
    c.name AS name,
    COUNT(b.ID_booking) AS total_bookings,
    SUM(r.price * (b.check_out_date - b.check_in_date)) AS total_days,
    SUM(r.price) AS total_spent,
    COUNT(DISTINCT h.ID_hotel) AS unique_hotels
FROM Customer c
         JOIN Booking b ON c.ID_customer = b.ID_customer
         JOIN Room r ON b.ID_room = r.ID_room
         JOIN Hotel h ON r.ID_hotel = h.ID_hotel
GROUP BY c.ID_customer
HAVING COUNT(DISTINCT h.ID_hotel) > 1 AND COUNT(b.ID_booking) > 2 and SUM(r.price * (b.check_out_date - b.check_in_date)) > 500
ORDER BY SUM(r.price * (b.check_out_date - b.check_in_date));