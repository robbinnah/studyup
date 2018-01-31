USE router2;

DROP PROCEDURE IF EXISTS r_update_city_sum;
DELIMITER //
CREATE PROCEDURE r_update_city_sum()
  BEGIN
    SELECT
      c.province,
      count(0) AS cnt
    FROM
      fx_device_city c
      INNER JOIN fx_device d
    WHERE
      c.mac = d.deviceMac
      AND d.deviceTyp = 'K2'
      AND d.deviceVer LIKE '22.5%'
    GROUP BY
      c.province;
  END;
//
DELIMITER ;

DROP EVENT IF EXISTS r_daily_city_summary;
CREATE EVENT r_daily_city_summary
  ON SCHEDULE EVERY 1 DAY STARTS TIMESTAMP '2017-12-08 01:00:00'
DO
  CALL r_update_city_sum();

ALTER EVENT r_daily_city_summary;

