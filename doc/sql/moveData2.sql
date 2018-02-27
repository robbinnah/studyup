USE ad_task;
CREATE PROCEDURE `Movefxdevicepushupdaterecord`()
  BEGIN
    DECLARE ids_begin INT;
    SET ids_begin = 0;
    SELECT id
    INTO ids_begin
    FROM fx_device_pushupdate_record
    WHERE createtime < date_sub(curdate(), INTERVAL 3 DAY)
    LIMIT 1;
    WHILE ids_begin > 0 DO
      SET ids_begin = 0;
      SELECT id
      INTO ids_begin
      FROM fx_device_pushupdate_record
      WHERE createtime < date_sub(curdate(), INTERVAL 3 DAY)
      LIMIT 1;
      DELETE FROM fx_device_pushupdate_record
      WHERE createtime < date_sub(curdate(), INTERVAL 3 DAY)
      LIMIT 200;
    END WHILE;


    USE phicomm_ad;

    CREATE TABLE `adstats_tmp` (
      `id` BIGINT(20) NOT NULL
    )

    CREATE TABLE `ad_stats_history` (
      `id`           BIGINT(20) NOT NULL AUTO_INCREMENT,
      `browserType`  VARCHAR(255)        DEFAULT NULL,
      `deviceMac`    VARCHAR(48)         DEFAULT NULL,
      `eventTime`    DATETIME   NOT NULL,
      `eventType`    VARCHAR(16)         DEFAULT NULL,
      `reqIp`        VARCHAR(32)         DEFAULT NULL,
      `terminalType` VARCHAR(255)        DEFAULT NULL,
      `updateJsId`   VARCHAR(32)         DEFAULT NULL,
      `hostUrl`      VARCHAR(255)        DEFAULT NULL,
      `pushUpdateId` VARCHAR(32)         DEFAULT NULL,
      PRIMARY KEY (`id`, `eventTime`),
      KEY `fx_ad_stats_pushUpdateId` (`pushUpdateId`) USING BTREE,
      KEY `fx_ad_stats_updateJsId` (`updateJsId`) USING BTREE,
      KEY `fx_ad_stats_eventType` (`eventType`) USING BTREE,
      KEY `fx_ad_stats_eventTime` (`eventTime`)
    )
      ENGINE = InnoDB
      AUTO_INCREMENT = 41348861
      DEFAULT CHARSET = utf8
      /*!50100 PARTITION BY RANGE (TO_DAYS(eventTime))
    (PARTITION p1 VALUES LESS THAN (736937)
      ENGINE = InnoDB,
    PARTITION p2 VALUES LESS THAN (736938)
      ENGINE = InnoDB,
    PARTITION p3 VALUES LESS THAN (736939)
      ENGINE = InnoDB,
    PARTITION p4 VALUES LESS THAN (736940)
      ENGINE = InnoDB,
    PARTITION p5 VALUES LESS THAN (736941)
      ENGINE = InnoDB,
    PARTITION p6 VALUES LESS THAN (736942)
      ENGINE = InnoDB,
    PARTITION p7 VALUES LESS THAN (736943)
      ENGINE = InnoDB,
    PARTITION p8 VALUES LESS THAN (736944)
      ENGINE = InnoDB,
    PARTITION p9 VALUES LESS THAN (736945)
      ENGINE = InnoDB,
    PARTITION p10 VALUES LESS THAN (736946)
      ENGINE = InnoDB,
    PARTITION p11 VALUES LESS THAN (736947)
      ENGINE = InnoDB,
    PARTITION p12 VALUES LESS THAN (736948)
      ENGINE = InnoDB,
    PARTITION p13 VALUES LESS THAN (736949)
      ENGINE = InnoDB,
    PARTITION p14 VALUES LESS THAN (736950)
      ENGINE = InnoDB,
    PARTITION p15 VALUES LESS THAN (736951)
      ENGINE = InnoDB,
    PARTITION p16 VALUES LESS THAN (736952)
      ENGINE = InnoDB,
    PARTITION p17 VALUES LESS THAN (736953)
      ENGINE = InnoDB,
    PARTITION p18 VALUES LESS THAN (736954)
      ENGINE = InnoDB,
    PARTITION p19 VALUES LESS THAN (736955)
      ENGINE = InnoDB,
    PARTITION p20 VALUES LESS THAN (736956)
      ENGINE = InnoDB,
    PARTITION p21 VALUES LESS THAN (736957)
      ENGINE = InnoDB,
    PARTITION p22 VALUES LESS THAN (736958)
      ENGINE = InnoDB,
    PARTITION p23 VALUES LESS THAN (736959)
      ENGINE = InnoDB,
    PARTITION p24 VALUES LESS THAN (736960)
      ENGINE = InnoDB,
    PARTITION p25 VALUES LESS THAN (736961)
      ENGINE = InnoDB,
    PARTITION p26 VALUES LESS THAN (736962)
      ENGINE = InnoDB,
    PARTITION p27 VALUES LESS THAN (736963)
      ENGINE = InnoDB,
    PARTITION p28 VALUES LESS THAN (736964)
      ENGINE = InnoDB,
    PARTITION p29 VALUES LESS THAN (736965)
      ENGINE = InnoDB,
    PARTITION p30 VALUES LESS THAN (736966)
      ENGINE = InnoDB,
    PARTITION p31 VALUES LESS THAN (736967)
      ENGINE = InnoDB,
    PARTITION p32 VALUES LESS THAN (736968)
      ENGINE = InnoDB,
    PARTITION p33 VALUES LESS THAN (736969)
      ENGINE = InnoDB,
    PARTITION p34 VALUES LESS THAN (736970)
      ENGINE = InnoDB,
    PARTITION p35 VALUES LESS THAN (736971)
      ENGINE = InnoDB,
    PARTITION p36 VALUES LESS THAN (736972)
      ENGINE = InnoDB,
    PARTITION p37 VALUES LESS THAN (736973)
      ENGINE = InnoDB,
    PARTITION p38 VALUES LESS THAN (736974)
      ENGINE = InnoDB,
    PARTITION p39 VALUES LESS THAN (736975)
      ENGINE = InnoDB,
    PARTITION p40 VALUES LESS THAN (736976)
      ENGINE = InnoDB,
    PARTITION p41 VALUES LESS THAN (736977)
      ENGINE = InnoDB,
    PARTITION p42 VALUES LESS THAN (736978)
      ENGINE = InnoDB,
    PARTITION p43 VALUES LESS THAN (736979)
      ENGINE = InnoDB,
    PARTITION p44 VALUES LESS THAN (736980)
      ENGINE = InnoDB,
    PARTITION p45 VALUES LESS THAN (736981)
      ENGINE = InnoDB,
    PARTITION p46 VALUES LESS THAN (736982)
      ENGINE = InnoDB,
    PARTITION p47 VALUES LESS THAN (736983)
      ENGINE = InnoDB,
    PARTITION p48 VALUES LESS THAN (736984)
      ENGINE = InnoDB,
    PARTITION p49 VALUES LESS THAN (736985)
      ENGINE = InnoDB,
    PARTITION p50 VALUES LESS THAN (736986)
      ENGINE = InnoDB,
    PARTITION p51 VALUES LESS THAN (736987)
      ENGINE = InnoDB,
    PARTITION p52 VALUES LESS THAN (736988)
      ENGINE = InnoDB,
    PARTITION p53 VALUES LESS THAN (736989)
      ENGINE = InnoDB,
    PARTITION p54 VALUES LESS THAN (736990)
      ENGINE = InnoDB,
    PARTITION p55 VALUES LESS THAN (736991)
      ENGINE = InnoDB,
    PARTITION p56 VALUES LESS THAN (736992)
      ENGINE = InnoDB,
    PARTITION p57 VALUES LESS THAN (736993)
      ENGINE = InnoDB,
    PARTITION p58 VALUES LESS THAN (736994)
      ENGINE = InnoDB,
    PARTITION p59 VALUES LESS THAN (736995)
      ENGINE = InnoDB,
    PARTITION p60 VALUES LESS THAN (736996)
      ENGINE = InnoDB)


    CREATE TABLE `ad_stats_summary` (
      `id`             BIGINT(20)   NOT NULL AUTO_INCREMENT,
      `push_update_id` BIGINT(20)   NOT NULL,
      `adCustomer`     VARCHAR(100) NOT NULL,
      `distinctshow`   BIGINT(20)   NOT NULL,
      `pushSuccess`    BIGINT(20)   NOT NULL,
      `click`          BIGINT(20)   NOT NULL,
      `close`          BIGINT(20)   NOT NULL,
      `distinctclick`  BIGINT(20)   NOT NULL,
      `distinctclose`  BIGINT(20)   NOT NULL,
      `total`          BIGINT(20)   NOT NULL,
      `times`          BIGINT(20)   NOT NULL,
      `display`        BIGINT(20)            DEFAULT NULL,
      PRIMARY KEY (`id`),
      UNIQUE KEY `fx_ad_stats_pushUpdateId` (`push_update_id`, `adCustomer`)
    )
      ENGINE = InnoDB
      AUTO_INCREMENT = 348
      DEFAULT CHARSET = utf8;


    # move ad_stats to ad_stats_history
DROP PROCEDURE IF EXISTS move_ad_stats;
DELIMITER $$
CREATE PROCEDURE `move_ad_stats`()
  BEGIN
    DECLARE ids_begin INTEGER DEFAULT 0;
    DECLARE end_day VARCHAR(20);
    SELECT date_sub(curdate(), INTERVAL 2 DAY) INTO end_day;
    REPEAT
      SET ids_begin = 0;
      TRUNCATE TABLE ad_stats_tmp;
      INSERT IGNORE INTO ad_stats_tmp SELECT *
                               FROM ad_stats
                               WHERE eventTime < end_day
                               LIMIT 500;
      INSERT IGNORE INTO ad_stats_history SELECT *
                                   FROM ad_stats_tmp;
      DELETE s.* FROM ad_stats s inner join ad_stats_tmp st on s.id=st.id;

      SELECT id
      INTO ids_begin
      FROM ad_stats
      WHERE eventTime < end_day
      LIMIT 1;
    UNTIL ids_begin = 0
    END REPEAT;
  END $$
DELIMITER ;

drop event if exists move_ad_stats_event;
create event move_ad_stats_event
  on schedule every 1 day starts timestamp '2018-02-08 00:30:00'
do
  call move_ad_stats();

alter event move_ad_stats_event enable;

   
   
   