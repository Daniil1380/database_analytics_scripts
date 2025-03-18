-- Определить, какие клиенты сделали более двух бронирований в разных отелях, и вывести информацию о каждом таком
-- клиенте, включая его имя, электронную почту, телефон, общее количество бронирований, а также список отелей,
-- в которых они бронировали номера (объединенные в одно поле через запятую с помощью CONCAT). Также подсчитать
-- среднюю длительность их пребывания (в днях) по всем бронированиям. Отсортировать результаты по количеству
-- бронирований в порядке убывания.

SELECT c.name                                  AS customer_name,
       c.email                                 AS customer_email,
       c.phone                                 AS customer_phone,
       COUNT(b.ID_booking)                     AS total_bookings,
       STRING_AGG(h.name, ', ')                AS hotels,

       AVG(b.check_out_date - b.check_in_date) AS average_stay_duration
FROM Customer c
         JOIN Booking b ON c.ID_customer = b.ID_customer
         JOIN Room r ON b.ID_room = r.ID_room
         JOIN Hotel h ON r.ID_hotel = h.ID_hotel
GROUP BY c.ID_customer
HAVING COUNT(DISTINCT h.ID_hotel) > 1
   AND COUNT(b.ID_booking) > 2
ORDER BY total_bookings DESC;