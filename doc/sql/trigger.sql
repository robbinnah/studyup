
###
DELIMITER ||
DROP TRIGGER IF EXISTS `triUpdateAppTaskName`;
CREATE TRIGGER `triUpdateAppTaskName`
AFTER UPDATE ON phicomm_ad_app.app_ad_task
FOR EACH ROW
BEGIN
  IF NEW.taskName != OLD.taskName
  THEN
    UPDATE phicomm_ad.daily_summary, phicomm_ad_app.app_ad_task
    SET daily_summary.taskName = phicomm_ad_app.app_ad_task.taskName
    WHERE
      phicomm_ad_app.app_ad_task.id = OLD.id
      AND daily_summary.taskId = phicomm_ad_app.app_ad_task.id
      AND daily_summary.channel = 'app';
  END IF;
END ||
DELIMITER ;
###
DROP TRIGGER `triUpdateAppMaterialName`;
CREATE TRIGGER `triUpdateAppMaterialName`
AFTER UPDATE ON phicomm_ad_app.app_material
FOR EACH ROW
  IF NEW.name != OLD.name
  THEN
    UPDATE phicomm_ad.daily_summary, phicomm_ad_app.app_material
    SET daily_summary.materialName = phicomm_ad_app.app_material.name
    WHERE
      phicomm_ad_app.app_material.id = OLD.id
      AND daily_summary.materialId = phicomm_ad_app.app_material.id
      AND daily_summary.channel = 'app';
  END IF;

###
DROP TRIGGER `triUpdateRouterMaterialName`;
CREATE TRIGGER `triUpdateRouterMaterialName`
AFTER UPDATE ON `router_material`
FOR EACH ROW
  IF NEW.materialName != OLD.materialName
  THEN
    UPDATE phicomm_ad.daily_summary, router_material
    SET daily_summary.materialName = `router_material`.`materialName`
    WHERE
      router_material.id = OLD.id
      AND daily_summary.materialId = router_material.id AND daily_summary.channel = 'router';
  END IF;
###
DROP TRIGGER `triUpdateRouterTaskName`;
CREATE TRIGGER `triUpdateRouterTaskName`
AFTER UPDATE ON `router_ad_task`
FOR EACH ROW
  IF NEW.taskName != OLD.taskName
  THEN
    UPDATE phicomm_ad.daily_summary, router_ad_task
    SET daily_summary.taskName = router_ad_task.taskName
    WHERE
      router_ad_task.id = OLD.id
      AND daily_summary.taskId = router_ad_task.id
      AND daily_summary.channel = 'router';
  END IF;
###
DROP TRIGGER `triUpdateAderName`;
CREATE TRIGGER `triUpdateAderName`
AFTER UPDATE ON `advertisers`
FOR EACH ROW
  IF NEW.shortName != OLD.shortName
  THEN
    UPDATE phicomm_ad.daily_summary, advertisers
    SET daily_summary.materialName = `advertisers`.`shortName`
    WHERE
      router_ad_task.id = OLD.id

      AND daily_summary.aderId = advertisers.id;
  END IF;
# app_info暂时不设触发器

