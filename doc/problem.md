## 技术问题归纳

---
### `千万级数据记录查询如何优化`
> 1. 每条记录的size尽量小，使用后及时释放引用，避免内存溢出
> 2. 
---
### `线上异常--死锁`
> 1. `show engine innodb status;` 查找到最近一次死锁发生的详情--查到影响死锁发生的三条语句
> 2. `show variables like '%general%'` 查看general_log
##### sql1
```
update phicomm_ad_app.app_ad_task set updateTime = current_timestamp 
where id = 83;
```
##### sql2
```
CREATE TRIGGER `triUpdateAppTaskName` 
AFTER UPDATE ON phicomm_ad_app.app_ad_task
FOR EACH ROW
    UPDATE phicomm_ad.daily_summary,phicomm_ad_app.app_ad_task
    SET daily_summary.taskName = phicomm_ad_app.app_ad_task.taskName
    WHERE daily_summary.taskId = phicomm_ad_app.app_ad_task.id 
    and daily_summary.channel='app';
```
##### sql3
(仅为示例)

```
select * from phicomm_ad_app.app_ad_task;
```
其中`sql3`为读操作执行频率高，当`sql2`写时资源发生竞争，产生死锁
问题发生在`sql2`, update操作锁住了`app_ad_task`整个表。
解决和优化方法有：
1. 读写分离
2. trigger优化，判断只有在任务名称变化时触发更新操作，
3. 更新时只更新该记录
#### 完整的优化代码为
```
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
```
---

### `httpClient4.5的使用问题，一定要设置连接超时和读取超时时间，默认永不超时`
`
httpGet.setConfig(RequestConfig.custom().setConnectTimeout(10000).setSocketTimeout(10000).build());
`
---

### 如何判断一个资源已经加载完成
* IE的script 元素只支持onreadystatechange事件，不支持onload事件。
* FF的script 元素不支持onreadystatechange事件，只支持onload事件。
* 如果要一个<script\> 加载完成执行一个操作，FF使用onload事件就行了，IE下则要结合onreadystatechange事件和this.readyState，
this.readyState的值为'loaded'或者'complete'都可以表示这个script已经加载完成．
如何结合IE和FF的区别?参考一下jquery的源码：
```
var script = document.createElement('script');
script.src="xx.js";
script.onload = script.onreadystatechange = function(){
     if(  ! this.readyState     //这是FF的判断语句，因为ff下没有readyState这人值，IE的readyState肯定有值
          || this.readyState=='loaded' || this.readyState=='complete'   // 这是IE的判断语句
    ){
          alert('loaded');
    }
};
```

### DDOS 攻击防范

### 前端
