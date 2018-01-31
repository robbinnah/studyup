use phicomm_ad;
drop procedure if exists r_insert_daily_summary;
delimiter //
create procedure r_insert_daily_summary()
  BEGIN
    delete from phicomm_ad.daily_summary where eventDate=UNIX_TIMESTAMP(DATE_SUB(CURDATE(),INTERVAL 1 day));
    insert into phicomm_ad.daily_summary(channel, eventDate, eventHour, eventType, count, disCount, materialId, taskId, aderId,materialName, taskName, aderName)
      (SELECT
         'router',
         UNIX_TIMESTAMP(
             DATE_FORMAT(a.eventTime, '%Y-%m-%d')
         ) AS eventDate,
         UNIX_TIMESTAMP(
             DATE_FORMAT(a.eventTime, '%Y-%m-%d %H')
         ) AS eventHour,
         eventType,
         count(0) AS cnt,
         count(DISTINCT(deviceMac)) AS disCnt,
         updateJsId,
         pushUpdateId,
         aer.id,
         m.materialName,
         t.taskName,
         aer.shortName
       FROM
         ad_stats a
         LEFT JOIN router_material m ON a.updateJsId = m.id
         LEFT JOIN router_ad_task t ON a.pushUpdateId = t.id
         left join advertisers aer on m.ownerId=aer.id
       WHERE
         to_days(now()) - to_days(a.eventTime) = 1
       GROUP BY
         HOUR (a.eventTime),
         updateJsId,
         eventType,
         pushUpdateId);
    insert into phicomm_ad.daily_summary(channel, eventDate, eventHour, eventType, count, materialId, taskId, appId,materialName, taskName, appName)
      (
        SELECT
          'app',
          UNIX_TIMESTAMP(
              DATE_FORMAT(a.eventTime, '%Y-%m-%d')
          ) AS eventDate,
          UNIX_TIMESTAMP(
              DATE_FORMAT(a.eventTime, '%Y-%m-%d %H')
          ) AS eventHour,
          eventType,
          count(0) AS cnt,
          appMaterialId,
          appADTaskId,
          a.appId,
          m.NAME,
          t.taskName,
          i.appName
        FROM
          phicomm_ad_app.app_ad_stats a
          LEFT JOIN phicomm_ad_app.app_material m ON a.appMaterialId = m.id
          LEFT JOIN phicomm_ad_app.app_ad_task t ON a.appADTaskId = t.id
          LEFT JOIN phicomm_ad_app.app_info i on a.appId = i.appId
        WHERE
          to_days(now()) - to_days(a.eventTime) = 1
        GROUP BY
          HOUR (a.eventTime),
          appMaterialId,
          eventType,
          appADTaskId,
          a.appId
      );
  END;
//
delimiter ;

drop event if exists r_ad_daily_summary;
create event r_ad_daily_summary
  on schedule every 1 day starts timestamp '2017-12-16 01:00:00'
do
  call r_insert_daily_summary();

alter event r_ad_daily_summary enable;




/* 每五分钟执行的任务*/
use phicomm_ad;
drop procedure if exists r_insert_minly_summary;
delimiter //
create procedure r_insert_minly_summary()
  BEGIN
    TRUNCATE TABLE daily_summary_tmp;
    insert into phicomm_ad.daily_summary_tmp(channel, eventDate, eventHour, eventType, count, disCount, materialId, taskId, aderId,materialName, taskName, aderName)
      (SELECT
         'router',
         UNIX_TIMESTAMP(
             DATE_FORMAT(a.eventTime, '%Y-%m-%d')
         ) AS eventDate,
         UNIX_TIMESTAMP(
             DATE_FORMAT(a.eventTime, '%Y-%m-%d %H')
         ) AS eventHour,
         eventType,
         count(0) AS cnt,
         count(DISTINCT(deviceMac)) AS disCnt,
         updateJsId,
         pushUpdateId,
         aer.id,
         m.materialName,
         t.taskName,
         aer.shortName
       FROM
         ad_stats a
         LEFT JOIN router_material m ON a.updateJsId = m.id
         LEFT JOIN router_ad_task t ON a.pushUpdateId = t.id
         left join advertisers aer on m.ownerId=aer.id
       WHERE
         a.eventTime >= curdate()
       GROUP BY
         HOUR (a.eventTime),
         updateJsId,
         eventType,
         pushUpdateId);
    insert into phicomm_ad.daily_summary_tmp(channel, eventDate, eventHour, eventType, count, materialId, taskId, appId,materialName, taskName, appName)
      (
        SELECT
          'app',
          UNIX_TIMESTAMP(
              DATE_FORMAT(a.eventTime, '%Y-%m-%d')
          ) AS eventDate,
          UNIX_TIMESTAMP(
              DATE_FORMAT(a.eventTime, '%Y-%m-%d %H')
          ) AS eventHour,
          eventType,
          count(0) AS cnt,
          appMaterialId,
          appADTaskId,
          a.appId,
          m.NAME,
          t.taskName,
          i.appName
        FROM
          phicomm_ad_app.app_ad_stats a
          LEFT JOIN phicomm_ad_app.app_material m ON a.appMaterialId = m.id
          LEFT JOIN phicomm_ad_app.app_ad_task t ON a.appADTaskId = t.id
          LEFT JOIN phicomm_ad_app.app_info i on a.appId = i.appId
        WHERE
          a.eventTime >= curdate()
        GROUP BY
          HOUR (a.eventTime),
          appMaterialId,
          eventType,
          appADTaskId,
          a.appId
      );
    delete from daily_summary where eventDate=UNIX_TIMESTAMP(CURDATE());
    INSERT INTO daily_summary (
      channel,
      eventDate,
      eventHour,
      eventType,
      count,
      disCount,
      materialId,
      taskId,
      appId,
      aderId,
      materialName,
      taskName,
      appName,
      aderName
    )(
      SELECT
        channel,
        eventDate,
        eventHour,
        eventType,
        count,
        disCount,
        materialId,
        taskId,
        appId,
        aderId,
        materialName,
        taskName,
        appName,
        aderName
      FROM
        daily_summary_tmp
    );

  END;
//
delimiter ;

drop event if exists r_ad_minly_summary;
create event r_ad_minly_summary
  on schedule every 20 minute starts timestamp '2017-12-26 14:40:00'
do
  call r_insert_minly_summary();

alter event r_ad_minly_summary enable;



