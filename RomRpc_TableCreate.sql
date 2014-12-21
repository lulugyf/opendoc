/*======================================================================================*/
/* 维护操作平台oracle数据库建表语句，默认表空间(OBOSS_DATA)和索引表空间(OBOSS_IDX)请根据*/
/*实际情况修改本脚本.在建立数据库对象之前会先删除该对象，仅用于初始化数据库，一次性使用 */
/*======================================================================================*/


/*==============================================================*/
/* SEQUENCE: SEQ_EXPAND             扩展信息表用的序列                        */
/*==============================================================*/
DROP SEQUENCE SEQ_EXPAND;

CREATE SEQUENCE SEQ_EXPAND
  START WITH 1
  MAXVALUE 1000000
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

/*==============================================================*/
/* SEQUENCE: SEQ_COMMON             序列                        */
/*==============================================================*/
/* drop SEQUENCE */
drop sequence SEQ_COMMON;
/* create SEQUENCE */
create sequence SEQ_COMMON
minvalue 0
maxvalue 999999999999999
start with 2
increment by 1
nocache;

/*==============================================================*/
/* SEQUENCE: SEQ_HOSTCHECK          用于生成日检项目序列        */
/*==============================================================*/
/* drop SEQUENCE */
drop sequence SEQ_HOSTCHECK;
-- Create sequence 
create sequence SEQ_HOSTCHECK
minvalue 1
maxvalue 99999
start with 1
increment by 1
nocache;

/*==============================================================*/
/* Table: ONEBOSS_BUSIGRO_RELATION    一级BOSS业务与分组关系表  */
/*==============================================================*/
--drop table 
drop table ONEBOSS_BUSIGRO_RELATION;
-- Create table
create table ONEBOSS_BUSIGRO_RELATION
(
  group_id INTEGER not null,
  trans_id INTEGER not null,
  reserve1 VARCHAR2(256),
  reserve2 VARCHAR2(256),
  reserve3 VARCHAR2(256)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ONEBOSS_BUSIGRO_RELATION
  add constraint PK_ONEBOSS_BUSIGRO_RELATION primary key (GROUP_ID, TRANS_ID)
  using index ;
-- Add comments to the table 
comment on table ONEBOSS_BUSIGRO_RELATION
  is '一级BOSS业务与分组关系表';
-- Add comments to the columns 
comment on column ONEBOSS_BUSIGRO_RELATION.group_id
  is '分组ID';
comment on column ONEBOSS_BUSIGRO_RELATION.trans_id
  is '交易ID';
comment on column ONEBOSS_BUSIGRO_RELATION.reserve1
  is '预留字段1';
comment on column ONEBOSS_BUSIGRO_RELATION.reserve2
  is '预留字段2';
comment on column ONEBOSS_BUSIGRO_RELATION.reserve3
  is '预留字段3';
  
/*==============================================================*/
/* Table: ONEBOSS_BUSI_GROUPS               一级BOSS业务分组表  */
/*==============================================================*/
--drop table 
drop table ONEBOSS_BUSI_GROUPS;
-- Create table
create table ONEBOSS_BUSI_GROUPS
(
  group_id   INTEGER not null,
  pro_code   VARCHAR2(8),
  host_id    INTEGER,
  group_name VARCHAR2(64),
  isdefault  INTEGER,
  login_no   VARCHAR2(8),
  remarks    VARCHAR2(256),
  reserve1   VARCHAR2(256),
  reserve2   VARCHAR2(256),
  reserve3   VARCHAR2(256)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ONEBOSS_BUSI_GROUPS
  add constraint PK_ONEBOSS_BUSI_GROUPS primary key (GROUP_ID)
  using index ;
-- Add comments to the table 
comment on table ONEBOSS_BUSI_GROUPS
  is '一级BOSS业务分组表';
-- Add comments to the columns 
comment on column ONEBOSS_BUSI_GROUPS.group_id
  is '分组ID';
comment on column ONEBOSS_BUSI_GROUPS.pro_code
  is '产品编码';
comment on column ONEBOSS_BUSI_GROUPS.host_id
  is '主机编码';
comment on column ONEBOSS_BUSI_GROUPS.group_name
  is '分组名称';
comment on column ONEBOSS_BUSI_GROUPS.isdefault
  is '0：不是默认；1：默认';
comment on column ONEBOSS_BUSI_GROUPS.login_no
  is '操作工号';
comment on column ONEBOSS_BUSI_GROUPS.remarks
  is '备注';
comment on column ONEBOSS_BUSI_GROUPS.reserve1
  is '预留字段1';
comment on column ONEBOSS_BUSI_GROUPS.reserve2
  is '预留字段2';
comment on column ONEBOSS_BUSI_GROUPS.reserve3
  is '预留字段3';
   
/*==============================================================*/
/* Table: ONEBOSS_BUSI_NOTES               一级BOSS交易节点表  */
/*==============================================================*/
--drop table 
drop table ONEBOSS_BUSI_NOTES;
-- Create table
create table ONEBOSS_BUSI_NOTES
(
  trans_id   INTEGER not null,
  trans_name VARCHAR2(64),
  item_id    INTEGER not null,
  trans_code VARCHAR2(10),
  reserve1   VARCHAR2(256),
  reserve2   VARCHAR2(256),
  reserve3   VARCHAR2(256)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ONEBOSS_BUSI_NOTES
  add constraint PK_ONEBOSS_BUSI_NOTES primary key (TRANS_ID, ITEM_ID)
  using index ;
-- Add comments to the table 
comment on table ONEBOSS_BUSI_NOTES
  is '一级BOSS交易节点表';
-- Add comments to the columns 
comment on column ONEBOSS_BUSI_NOTES.trans_id
  is '交易ID,自增序列';
comment on column ONEBOSS_BUSI_NOTES.trans_name
  is '交易名称';
comment on column ONEBOSS_BUSI_NOTES.item_id
  is '业务编码,即条目表工作条目编码';
comment on column ONEBOSS_BUSI_NOTES.trans_code
  is '交易代码';
comment on column ONEBOSS_BUSI_NOTES.reserve1
  is '预留字段1';
comment on column ONEBOSS_BUSI_NOTES.reserve2
  is '预留字段2';
comment on column ONEBOSS_BUSI_NOTES.reserve3
  is '预留字段3';
  
/*==============================================================*/
/* ROM_CRON_DATA_REPORT            重点业务监控报表             */
/*==============================================================*/
--drop table 
Drop table ROM_CRON_DATA_REPORT;
--create table 
create table ROM_CRON_DATA_REPORT
(
  task_id        INTEGER,
  create_date    DATE,
  bipcode        VARCHAR2(8),
  activitycode   VARCHAR2(8),
  tradetotal     VARCHAR2(8),
  tradesucc      VARCHAR2(8),
  failforuser    VARCHAR2(8),
  failnotforuser VARCHAR2(8),
  failtimeout    VARCHAR2(8),
  faildelay      VARCHAR2(8),
  opttime        DATE
) ;
-- Add comments to the table 
comment on table ROM_CRON_DATA_REPORT
  is '重点业务监控报表';
-- Add comments to the columns 
comment on column ROM_CRON_DATA_REPORT.bipcode
  is '业务功能代码';
comment on column ROM_CRON_DATA_REPORT.activitycode
  is '交易代码';
comment on column ROM_CRON_DATA_REPORT.tradetotal
  is '交易总量';
comment on column ROM_CRON_DATA_REPORT.tradesucc
  is '成功交易量';
comment on column ROM_CRON_DATA_REPORT.failforuser
  is '用户方原因失败量';
comment on column ROM_CRON_DATA_REPORT.failnotforuser
  is '非用户方原因失败量';
comment on column ROM_CRON_DATA_REPORT.failtimeout
  is '超时失败交易量';
comment on column ROM_CRON_DATA_REPORT.faildelay
  is '相应不及时交易量';
comment on column ROM_CRON_DATA_REPORT.opttime
  is '数据入库时间';  
  
/*==============================================================*/
/* Table: ROM_CRON_TASK_CONF      定时任务配置表                */
/*==============================================================*/
-- drop table
drop table ROM_CRON_TASK_CONF;
-- Create table
create table ROM_CRON_TASK_CONF
(
  task_id       INTEGER,
  pro_code      VARCHAR2(8) not null,
  func_code     VARCHAR2(8) not null,
  scripts_id    INTEGER not null,
  begin_time    DATE,
  end_time      DATE,
  interval_time INTEGER,
  next_run_time DATE,
  task_state    CHAR(1),
  user_flag     CHAR(1),
  remark        VARCHAR2(2048)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_CRON_TASK_CONF
  add constraint PK_ROM_CRON_TASK_CONF primary key (PRO_CODE, FUNC_CODE, SCRIPTS_ID)
  using index ;
-- Add comments to the table 
comment on table ROM_CRON_TASK_CONF
  is '定时任务配置表';
-- Add comments to the columns 
comment on column ROM_CRON_TASK_CONF.task_id
  is '定时任务ID';
comment on column ROM_CRON_TASK_CONF.pro_code
  is '产品编码';
comment on column ROM_CRON_TASK_CONF.func_code
  is '功能代码';
comment on column ROM_CRON_TASK_CONF.scripts_id
  is '脚本编码';
comment on column ROM_CRON_TASK_CONF.begin_time
  is '任务开始时间';
comment on column ROM_CRON_TASK_CONF.end_time
  is '任务结束时间';
comment on column ROM_CRON_TASK_CONF.interval_time
  is '任务执行间隔';
comment on column ROM_CRON_TASK_CONF.next_run_time
  is '下次执行时间';
comment on column ROM_CRON_TASK_CONF.task_state
  is '任务执行状态 0：未执行；1：正在执行；2：执行完成';
comment on column ROM_CRON_TASK_CONF.user_flag
  is '有效标识';
comment on column ROM_CRON_TASK_CONF.remark
  is '备注';
  
/*==============================================================*/
/* Table: ROM_CRON_TASK_DATA      定时任务执行结果表            */
/*==============================================================*/
-- drop table
drop table ROM_CRON_TASK_DATA;
-- Create table
create table ROM_CRON_TASK_DATA
(
  task_id        INTEGER,
  create_date    DATE,
  item_name      VARCHAR2(64),
  item_desc      VARCHAR2(64),
  item_data      VARCHAR2(8),
  item_dimension VARCHAR2(8),
  remark         VARCHAR2(2048)
) ;
-- Add comments to the table 
comment on table ROM_CRON_TASK_DATA
  is '定时任务执行结果表';
-- Add comments to the columns 
comment on column ROM_CRON_TASK_DATA.task_id
  is '定时任务ID';
comment on column ROM_CRON_TASK_DATA.create_date
  is '数据生成时间';
comment on column ROM_CRON_TASK_DATA.item_name
  is '结果项名称';
comment on column ROM_CRON_TASK_DATA.item_desc
  is '结果项描述';
comment on column ROM_CRON_TASK_DATA.item_data
  is '结果项数据';
comment on column ROM_CRON_TASK_DATA.item_dimension
  is '结果项单位';  
comment on column ROM_CRON_TASK_DATA.remark
  is '备注'; 

/*==============================================================*/
/* Table: ROM_FTPSITES_INFO      FTP站点表                      */
/*==============================================================*/ 
--drop table
drop table ROM_FTPSITES_INFO;
-- Create table
create table ROM_FTPSITES_INFO
(
  site_id     INTEGER not null,
  site_name   VARCHAR2(64),
  host_id     INTEGER,
  ftp_port    INTEGER default 21,
  ftp_user    VARCHAR2(32),
  ftp_passwd  VARCHAR2(32),
  local_path  VARCHAR2(128),
  remote_path VARCHAR2(128),
  agent_addr  VARCHAR2(32),
  ssl_flag    INTEGER default 0,
  login_no     VARCHAR2(8),
  grant_logins VARCHAR2(1024),
  isgrant      INTEGER default 0,
  remarks     VARCHAR2(256)
) ;
-- Create/Recreate indexes 
create index IDX_SITE_NAME on ROM_FTPSITES_INFO (SITE_NAME)
  ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_FTPSITES_INFO
  add constraint PK_ROM_FTPSITES_INFO primary key (SITE_ID)
  using index ;
-- Add comments to the table 
comment on table ROM_FTPSITES_INFO
  is 'FTP站点表';
-- Add comments to the columns 
comment on column ROM_FTPSITES_INFO.site_id
  is '站点编码';
comment on column ROM_FTPSITES_INFO.site_name
  is '站点名称';
comment on column ROM_FTPSITES_INFO.host_id
  is '主机编码';
comment on column ROM_FTPSITES_INFO.ftp_port
  is 'FTP端口,默认值21';
comment on column ROM_FTPSITES_INFO.ftp_user
  is 'FTP用户';
comment on column ROM_FTPSITES_INFO.ftp_passwd
  is 'FTP口令';
comment on column ROM_FTPSITES_INFO.local_path
  is '本地路径';
comment on column ROM_FTPSITES_INFO.remote_path
  is '远端路径';
comment on column ROM_FTPSITES_INFO.agent_addr
  is '代理地址';
comment on column ROM_FTPSITES_INFO.ssl_flag
  is '0：无SSL认证;1：有SSL认证;默认为0';
comment on column ROM_FTPSITES_INFO.login_no
  is '操作工号';
comment on column ROM_FTPSITES_INFO.grant_logins
  is '授权工号';
comment on column ROM_FTPSITES_INFO.isgrant
  is '是否授权';
comment on column ROM_FTPSITES_INFO.remarks
  is '备注';
  
/*==============================================================*/
/* Table: ROM_FTP_SCRIPT_RELATION      FTP远程脚本关系表        */
/*==============================================================*/
drop table ROM_FTP_SCRIPT_RELATION;
-- Create table
create table ROM_FTP_SCRIPT_RELATION
(
  site_id   INTEGER not null,
  script_id INTEGER not null,
  action_id INTEGER not null
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_FTP_SCRIPT_RELATION
  add constraint PK_ROM_FTP_SCRIPT_RELATION primary key (SITE_ID, SCRIPT_ID, ACTION_ID)
  using index ;
-- Add comments to the table 
comment on table ROM_FTP_SCRIPT_RELATION
  is 'FTP远程脚本关系表';
-- Add comments to the columns 
comment on column ROM_FTP_SCRIPT_RELATION.action_id
  is '站点编码';
comment on column ROM_FTP_SCRIPT_RELATION.action_id
  is '脚本编码';
comment on column ROM_FTP_SCRIPT_RELATION.action_id
  is '条目动作.见工作条目动作表';
  
/*==============================================================*/
/* Table: ROM_HOST_INFO      远程主机管理表                     */
/*==============================================================*/
--drop table
drop table ROM_HOST_INFO;
-- Create table
create table ROM_HOST_INFO
(
  host_id       INTEGER not null,
  province_code VARCHAR2(8),
  tell_type     CHAR(1),
  host_env      CHAR(1),
  host_ip       VARCHAR2(32),
  host_name     VARCHAR2(32),
  host_os       CHAR(1),
  update_time   DATE,
  remark        VARCHAR2(128)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_HOST_INFO
  add constraint PK_ROM_HOST_INFO primary key (HOST_ID)
  using index ;
-- Add comments to the table 
comment on table ROM_HOST_INFO
  is '远程主机管理表';
-- Add comments to the columns 
comment on column ROM_HOST_INFO.host_id
  is '主机编码';
comment on column ROM_HOST_INFO.province_code
  is '省份编码';
comment on column ROM_HOST_INFO.tell_type
  is '0：移动
1：电信
2：联通
3：广电
4：全行业';
comment on column ROM_HOST_INFO.host_env
  is '0：测试环境
1：生产环境
2：开发环境
';
comment on column ROM_HOST_INFO.host_ip
  is '主机IP';
comment on column ROM_HOST_INFO.host_name
  is '主机名称';
comment on column ROM_HOST_INFO.host_os
  is '主机操作系统,0：aix
1：hp
2：sun
3：linux
4：其他
';
comment on column ROM_HOST_INFO.UPDATE_TIME
  is '最后一次更新时间';
comment on column ROM_HOST_INFO.REMARK
  is '备注';

 /*==============================================================*/
/* Table: ROM_ITEM_ACTION      工作条目动作表                   */
/*==============================================================*/
--drop table
drop table ROM_ITEM_ACTION;
-- Create table
create table ROM_ITEM_ACTION
(
  action_id   INTEGER not null,
  action_name VARCHAR2(64) not null,
  remarks     VARCHAR2(256)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_ITEM_ACTION
  add constraint PK_ROM_ITEM_ACTION primary key (ACTION_ID, ACTION_NAME)
  using index ;
-- Add comments to the table 
comment on table ROM_ITEM_ACTION
  is '工作条目动作表';
-- Add comments to the columns 
comment on column ROM_ITEM_ACTION.action_id
  is '动作编码,0：进程启动
1：进程停止
2：进程状态检测
3：工单监控
4：文件上传
5：文件下载
6：一级BOSS交易量统计
7：一级BOSS交易时长统计
8：一级boss业务汇总交易量查询
9：一级boss业务汇总交易时长查询
10：主机定时巡检';
comment on column ROM_ITEM_ACTION.action_name
  is '动作名称';
comment on column ROM_ITEM_ACTION.remarks
  is '备注';


/*==============================================================*/
/* Table: ROM_ITEM_SCRIPT_RELATION    工作条目与脚本关系表      */
/*==============================================================*/
drop table ROM_ITEM_SCRIPT_RELATION;
-- Create table
create table ROM_ITEM_SCRIPT_RELATION
(
  item_id   INTEGER not null,
  script_id INTEGER not null,
  action_id INTEGER not null
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_ITEM_SCRIPT_RELATION
  add constraint PK_ROM_ITEM_SCRIPT_RELATION primary key (ITEM_ID, SCRIPT_ID, ACTION_ID)
  using index ;
-- Add comments to the table 
comment on table ROM_ITEM_SCRIPT_RELATION
  is '工作条目与脚本关系表';
-- Add comments to the columns 
comment on column ROM_ITEM_SCRIPT_RELATION.item_id
  is '工作条目编码';
comment on column ROM_ITEM_SCRIPT_RELATION.script_id
  is '脚本编码';
comment on column ROM_ITEM_SCRIPT_RELATION.action_id
  is '条目动作';

/*==============================================================*/
/* Table: ROM_LOGIN_ROLE_RELATION     工号角色关系表            */
/*==============================================================*/
--drop table
drop table ROM_LOGIN_ROLE_RELATION;
-- Create table
create table ROM_LOGIN_ROLE_RELATION
(
  login_no VARCHAR2(8) not null,
  role_id  INTEGER not null,
  remarks  VARCHAR2(256)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_LOGIN_ROLE_RELATION
  add constraint PK_ROM_LOGIN_ROLE_RELATION primary key (LOGIN_NO, ROLE_ID)
  using index ;
-- Add comments to the table 
comment on table ROM_LOGIN_ROLE_RELATION
  is '工号角色关系表';
-- Add comments to the columns 
comment on column ROM_LOGIN_ROLE_RELATION.login_no
  is '登录工号';
-- Add comments to the columns 
comment on column ROM_LOGIN_ROLE_RELATION.role_id
  is '角色ID';
-- Add comments to the columns 
comment on column ROM_LOGIN_ROLE_RELATION.remarks
  is '备注';  
  
/*==============================================================*/
/* Table: ROM_MAINTAIN_ITEMS  远程维护工作条目表                */
/*==============================================================*/
--drop table 
drop table ROM_MAINTAIN_ITEMS;
-- Create table
create table ROM_MAINTAIN_ITEMS
(
  pro_code  VARCHAR2(8),
  func_code VARCHAR2(8),
  host_id   INTEGER,
  item_id   INTEGER not null,
  item_name VARCHAR2(128),
  item_desc VARCHAR2(1024),
  login_no     VARCHAR2(8),
  grant_logins VARCHAR2(1024),
  isgrant      INTEGER default 0,
  remark    VARCHAR2(2048)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_MAINTAIN_ITEMS
  add constraint PK_ROM_MAINTAIN_ITEMS primary key (ITEM_ID)
  using index ;
-- Add comments to the table 
comment on table ROM_MAINTAIN_ITEMS
  is '远程维护工作条目表';
-- Add comments to the columns 
comment on column ROM_MAINTAIN_ITEMS.pro_code
  is '产品编码:省份编码+主机环境+3位数字';
comment on column ROM_MAINTAIN_ITEMS.func_code
  is '功能代码';
comment on column ROM_MAINTAIN_ITEMS.host_id
  is '远程主机编码';
comment on column ROM_MAINTAIN_ITEMS.item_id
  is '工作条目编码';
comment on column ROM_MAINTAIN_ITEMS.item_name
  is '工作条目名称';
comment on column ROM_MAINTAIN_ITEMS.item_desc
  is '工作条目描述';
comment on column ROM_MAINTAIN_ITEMS.login_no
  is '操作工号';
comment on column ROM_MAINTAIN_ITEMS.grant_logins
  is '授权工号';
comment on column ROM_MAINTAIN_ITEMS.isgrant
  is '是否授权';  
comment on column ROM_MAINTAIN_ITEMS.remark
  is '备注';   

/*==============================================================*/
/* Table: ROM_OPERA_CODE     操作编码表                         */
/*==============================================================*/
--drop table
drop table ROM_OPERA_CODE;
-- Create table
create table ROM_OPERA_CODE
(
  opera_code VARCHAR2(2) not null,
  opera_name VARCHAR2(64),
  remarks    VARCHAR2(256)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_OPERA_CODE
  add constraint PK_ROM_OPERA_CODE primary key (OPERA_CODE)
  using index ;
-- Add comments to the table 
comment on table ROM_OPERA_CODE
  is '操作编码表';
-- Add comments to the columns 
comment on column ROM_OPERA_CODE.opera_code
  is '操作代码,1：新增
2：删除
3：修改
4：赋权
5：启动或停止
6：文件上传下载';
comment on column ROM_OPERA_CODE.opera_name
  is '操作名称';
comment on column ROM_OPERA_CODE.remarks
  is '备注';
  
/*==============================================================*/
/* Table: ROM_PROVINCE_CODE      省份代码表                     */
/*==============================================================*/
--drop table
drop table ROM_PROVINCE_CODE;
-- Create table
create table ROM_PROVINCE_CODE
(
  province_code VARCHAR2(3),
  province_name VARCHAR2(64),
  remarks       VARCHAR2(256)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_PROVINCE_CODE
  add constraint PK_ROM_PROVINCE_CODE primary key (province_code)
  using index ;
-- Add comments to the table 
comment on table ROM_PROVINCE_CODE
  is '省份代码表';
-- Add comments to the columns 
comment on column ROM_PROVINCE_CODE.province_code
  is '省份代码';
comment on column ROM_PROVINCE_CODE.province_name
  is '省份名称';
comment on column ROM_PROVINCE_CODE.remarks
  is '备注';
  
/*==============================================================*/
/* Table: ROM_PRO_CODE   产品代码表                             */
/*==============================================================*/
--drop table
drop table ROM_PRO_CODE;
-- Create table
create table ROM_PRO_CODE
(
  pro_code    VARCHAR2(8) not null,
  pro_name    VARCHAR2(64),
  pro_version VARCHAR2(10),
  remarks     VARCHAR2(256)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_PRO_CODE
  add constraint PK_ROM_PRO_CODE primary key (PRO_CODE)
  using index ;
-- Add comments to the table 
comment on table ROM_PRO_CODE
  is '产品代码表';
-- Add comments to the columns 
comment on column ROM_PRO_CODE.pro_code
  is '产品代码';
comment on column ROM_PRO_CODE.pro_name
  is '产品名称';
comment on column ROM_PRO_CODE.pro_version
  is '产品版本';
comment on column ROM_PRO_CODE.remarks
  is '备注';

/*==============================================================*/
/* Table: ROM_PRO_FTPSITE_RELATION      产品FTP站点关系表       */
/*==============================================================*/
--drop table 
drop table ROM_PRO_FTPSITE_RELATION;
-- Create table
create table ROM_PRO_FTPSITE_RELATION
(
  pro_code VARCHAR2(8) not null,
  site_id  INTEGER not null,
  remarks  VARCHAR2(256)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_PRO_FTPSITE_RELATION
  add constraint PK_ROM_PRO_FTPSITE_RELATION primary key (PRO_CODE, SITE_ID)
  using index ;
-- Add comments to the table 
comment on table ROM_PRO_FTPSITE_RELATION
  is '产品FTP站点关系表';
-- Add comments to the columns 
comment on column ROM_PRO_FTPSITE_RELATION.pro_code
  is '产品代码';
comment on column ROM_PRO_FTPSITE_RELATION.site_id
  is '站点编码'; 
comment on column ROM_PRO_FTPSITE_RELATION.remarks
  is '备注';  
    
/*==============================================================*/
/* Table: ROM_PRO_HOST_RELATION  产品远程主机关系表             */
/*==============================================================*/
--drop table
drop table ROM_PRO_HOST_RELATION;
-- Create table
create table ROM_PRO_HOST_RELATION
(
  pro_code VARCHAR2(8) not null,
  host_id  INTEGER not null,
  remarks  VARCHAR2(256)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_PRO_HOST_RELATION
  add constraint PK_ROM_PRO_HOST_RELATION primary key (PRO_CODE, HOST_ID)
  using index ;
-- Add comments to the table 
comment on table ROM_PRO_HOST_RELATION
  is '产品远程主机关系表';
-- Add comments to the columns
comment on column ROM_PRO_HOST_RELATION.pro_code
  is '产品代码';
comment on column ROM_PRO_HOST_RELATION.host_id
  is '主机编码';
comment on column ROM_PRO_HOST_RELATION.remarks
  is '备注';

/*==============================================================*/
/* Table: ROM_SCRIPTS_CONFIG     远程脚本配置表                 */
/*==============================================================*/
--drop table
drop table ROM_SCRIPTS_CONFIG;
-- Create table
create table ROM_SCRIPTS_CONFIG
(
  scripts_id   INTEGER not null,
  host_id      INTEGER,
  scripts_dir  VARCHAR2(256),
  scripts_name VARCHAR2(512),
  scripts_type CHAR(1),
  req_url      VARCHAR2(128),
  visit_user   VARCHAR2(8),
  visit_pswd   VARCHAR2(128),
  remarks      VARCHAR2(2048)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_SCRIPTS_CONFIG
  add constraint PK_ROM_SCRIPTS_CONFIG primary key (SCRIPTS_ID)
  using index ;   
-- Add comments to the table 
comment on table ROM_SCRIPTS_CONFIG
  is '远程脚本配置表:存放远程主机（受控端主机）的脚本目录和脚本名称';
-- Add comments to the columns 
comment on column ROM_SCRIPTS_CONFIG.scripts_id
  is '脚本编码';
comment on column ROM_SCRIPTS_CONFIG.host_id
  is '省份编码+主机环境+3位数字';
comment on column ROM_SCRIPTS_CONFIG.scripts_dir
  is '脚本目录';
comment on column ROM_SCRIPTS_CONFIG.scripts_name
  is '脚本名称';
comment on column ROM_SCRIPTS_CONFIG.scripts_type
  is '0：定时执行的脚本
1：手工执行的脚本';
comment on column ROM_SCRIPTS_CONFIG.req_url
  is '脚本对应的远程请求URL';
comment on column ROM_SCRIPTS_CONFIG.visit_user
  is '远程访问远端URL的用户名';
comment on column ROM_SCRIPTS_CONFIG.visit_pswd
  is '远程访问远端URL的口令';
comment on column ROM_SCRIPTS_CONFIG.remarks
  is '备注';
  
/*==============================================================*/
/* Table: ROM_SYS_FUNCTION    系统功能表                        */
/*==============================================================*/
--drop table
drop table ROM_SYS_FUNCTION;
-- Create table
create table ROM_SYS_FUNCTION
(
  function_code  VARCHAR2(64) not null,
  function_name  VARCHAR2(64),
  action_name    VARCHAR2(1024),
  node_type      CHAR(1),
  parent_code    VARCHAR2(8),
  operation_code VARCHAR2(32),
  remarks        VARCHAR2(256),
  note_seq       INTEGER default 0,
  open_type char(1)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_SYS_FUNCTION
  add constraint PK_ROM_SYS_FUNCTION primary key (FUNCTION_CODE)
  using index ;
-- Add comments to the table 
comment on table ROM_SYS_FUNCTION
  is '以产品名称命名的功能代码来自产品代码表';
-- Add comments to the columns 
comment on column ROM_SYS_FUNCTION.function_code
  is '功能代码';
comment on column ROM_SYS_FUNCTION.function_name
  is '功能名称';
comment on column ROM_SYS_FUNCTION.action_name
  is '功能点url';
comment on column ROM_SYS_FUNCTION.node_type
  is '0：可见
1：不可见';
comment on column ROM_SYS_FUNCTION.parent_code
  is '父节点';
comment on column ROM_SYS_FUNCTION.operation_code
  is '操作';
comment on column ROM_SYS_FUNCTION.remarks
  is '备注';
comment on column ROM_SYS_FUNCTION.note_seq
  is '节点序列';
comment on column ROM_SYS_FUNCTION.open_type
  is '打开方式';
  
/*==============================================================*/
/* Table: ROM_SYS_LOGIN    系统工号表                           */
/*==============================================================*/
drop table ROM_SYS_LOGIN;
-- Create table
create table ROM_SYS_LOGIN
(
  login_no    VARCHAR2(8) not null,
  login_name  VARCHAR2(64),
  login_pwd   VARCHAR2(128),
  use_flg     CHAR(1),
  expire_time DATE,
  login_flg   CHAR(1),
  phone_no    VARCHAR2(15),
  login_ip    VARCHAR2(128),
  remark      VARCHAR2(64),
  province_code varchar2(4)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_SYS_LOGIN
  add constraint PK_ROM_SYS_LOGIN primary key (LOGIN_NO)
  using index ;
-- Add comments to the table 
comment on table ROM_SYS_LOGIN
  is '系统工号表';
-- Add comments to the columns 
comment on column ROM_SYS_LOGIN.login_no
  is '登陆工号';
comment on column ROM_SYS_LOGIN.login_name
  is '姓名';
comment on column ROM_SYS_LOGIN.login_pwd
  is '工号密码';
comment on column ROM_SYS_LOGIN.use_flg
  is '使用标识,0：有效
1：无效';
comment on column ROM_SYS_LOGIN.expire_time
  is '过期日期';
comment on column ROM_SYS_LOGIN.login_flg
  is '登陆标识';
comment on column ROM_SYS_LOGIN.phone_no
  is '联系号码';
comment on column ROM_SYS_LOGIN.login_ip
  is '登录IP';
comment on column ROM_SYS_LOGIN.remark
  is '备注';

/*==============================================================*/
/* Table: ROM_SYS_OP_LOG   操作日志表                           */
/*==============================================================*/
--drop table 
drop table ROM_SYS_OP_LOG;
-- Create table
create table ROM_SYS_OP_LOG
(
  op_date       VARCHAR2(8),
  op_staff      VARCHAR2(64),
  staff_name    VARCHAR2(64),
  pro_code      VARCHAR2(8),
  function_code VARCHAR2(8),
  op_time       DATE,
  op_content    VARCHAR2(1024),
  remarks       VARCHAR2(256)
) ;
-- Create/Recreate indexes 
create index PK_OP_DATE_OP_LOG on ROM_SYS_OP_LOG (OP_DATE)
   ;
-- Add comments to the table 
comment on table ROM_SYS_OP_LOG
  is '操作日志表';
-- Add comments to the columns 
comment on column ROM_SYS_OP_LOG.op_date
  is '如：YYYYMMDD';
comment on column ROM_SYS_OP_LOG.op_staff
  is '同系统工号表里登陆工号字段';
comment on column ROM_SYS_OP_LOG.staff_name
  is '同系统工号表里姓名字段';
comment on column ROM_SYS_OP_LOG.pro_code
  is '同产品代码表里产品编码字段';
comment on column ROM_SYS_OP_LOG.function_code
  is '同系统功能表里功能编码';
comment on column ROM_SYS_OP_LOG.op_time
  is '操作时间';
comment on column ROM_SYS_OP_LOG.op_content
  is '操作内容';
comment on column ROM_SYS_OP_LOG.remarks
  is '备注';
  
/*==============================================================*/
/* Table: ROM_SYS_POPEDOM     权限注册表                        */
/*==============================================================*/
--drop table
drop table ROM_SYS_POPEDOM;
-- Create table
create table ROM_SYS_POPEDOM
(
  function_code  VARCHAR2(8) not null,
  action_name    VARCHAR2(256) not null,
  operation_code VARCHAR2(32)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_SYS_POPEDOM
  add constraint PK_ROM_SYS_POPEDOM primary key (function_code,action_name)
  using index ;
-- Create/Recreate indexes 
create index IDX_ROM_SYS_POPEDOM on ROM_SYS_POPEDOM (FUNCTION_CODE)
    ;
-- Add comments to the table 
comment on table ROM_SYS_POPEDOM
  is '权限注册表';
-- Add comments to the columns 
comment on column ROM_SYS_POPEDOM.function_code
  is '功能代码';
comment on column ROM_SYS_POPEDOM.action_name
  is '功能点url';
comment on column ROM_SYS_POPEDOM.operation_code
  is '操作';

/*==============================================================*/
/* Table: ROM_SYS_PRO_FUNCTION    产品功能关系表                */
/*==============================================================*/
--drop table
drop table ROM_SYS_PRO_FUNCTION;
-- Create table
create table ROM_SYS_PRO_FUNCTION
(
  pro_code      VARCHAR2(8) not null,
  function_code VARCHAR2(8) not null,
  remarks       VARCHAR2(256)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_SYS_PRO_FUNCTION
  add constraint PK_ROM_SYS_PRO_FUNCTION primary key (PRO_CODE, FUNCTION_CODE)
  using index ;
-- Add comments to the table 
comment on table ROM_SYS_PRO_FUNCTION
  is '产品功能关系表';
-- Add comments to the columns 
comment on column ROM_SYS_PRO_FUNCTION.pro_code
  is '产品代码';  
comment on column ROM_SYS_PRO_FUNCTION.function_code
  is '功能代码';  
comment on column ROM_SYS_PRO_FUNCTION.remarks
  is '备注';  
   
/*==============================================================*/
/* Table: ROM_SYS_ROLE                    角色信息表            */
/*==============================================================*/  
--drop table
drop table ROM_SYS_ROLE;
-- Create table
create table ROM_SYS_ROLE
(
  role_id       INTEGER not null,
  role_name     VARCHAR2(64),
  role_type     CHAR(1),
  role_state    CHAR(1),
  pro_code      VARCHAR2(8),
  province_code VARCHAR2(3),
  tell_type     CHAR(1),
  remarks       VARCHAR2(256)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_SYS_ROLE
  add constraint PK_ROM_SYS_ROLE primary key (ROLE_ID)
  using index ; 
-- Add comments to the table 
comment on table ROM_SYS_ROLE
  is '角色信息表';  
-- Add comments to the columns 
comment on column ROM_SYS_ROLE.role_id
  is '角色ID';
comment on column ROM_SYS_ROLE.role_name
  is '角色名称';
comment on column ROM_SYS_ROLE.role_type
  is '0：超级管理员
1：普通管理员';
comment on column ROM_SYS_ROLE.role_state
  is '0：有效
1：无效';
comment on column ROM_SYS_ROLE.pro_code
  is '产品编码';
comment on column ROM_SYS_ROLE.province_code
  is '省份编码';
comment on column ROM_SYS_ROLE.tell_type
  is '0：移动
1：电信
2：联通
3：广电
4：全行业';   
comment on column ROM_SYS_ROLE.remarks
  is '备注';

/*==============================================================*/
/* Table: ROM_SYS_ROLE_FUNCTION       角色功能关系表            */
/*==============================================================*/
drop table ROM_SYS_ROLE_FUNCTION;
-- Create table
create table ROM_SYS_ROLE_FUNCTION
(
  role_id        INTEGER not null,
  function_code  VARCHAR2(8) not null,
  operation_code VARCHAR2(32) not null
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_SYS_ROLE_FUNCTION
  add constraint PK_ROM_SYS_ROLE_FUNCTION primary key (ROLE_ID, FUNCTION_CODE, OPERATION_CODE)
  using index ;
-- Create/Recreate indexes 
create index IDX_ROM_SYS_ROLE_FUNCTION on ROM_SYS_ROLE_FUNCTION (ROLE_ID)
    ;
-- Add comments to the table 
comment on table ROM_SYS_ROLE_FUNCTION
  is '角色功能关系表';  
-- Add comments to the columns 
comment on column ROM_SYS_ROLE_FUNCTION.role_id
  is '角色ID';
comment on column ROM_SYS_ROLE_FUNCTION.function_code
  is '功能代码';
comment on column ROM_SYS_ROLE_FUNCTION.operation_code
  is '操作代码以;分割';  
   
/*==============================================================*/
/* Table: ROM_TELLCORP_CODE  运营商代码表                       */
/*==============================================================*/
--drop table
drop table ROM_TELLCORP_CODE;
-- Create table
create table ROM_TELLCORP_CODE
(
  tellcorp_code VARCHAR2(1),
  tellcorp_name VARCHAR2(64),
  remarks       VARCHAR2(256)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_TELLCORP_CODE
  add constraint PK_ROM_TELLCORP_CODE primary key (tellcorp_code)
  using index ;
-- Add comments to the table 
comment on table ROM_TELLCORP_CODE
  is '运营商代码表'; 
-- Add comments to the columns 
comment on column ROM_TELLCORP_CODE.tellcorp_code
  is '运营商代码';
comment on column ROM_TELLCORP_CODE.tellcorp_name
  is '运营商名称';
comment on column ROM_TELLCORP_CODE.remarks
  is '备注';
   
/*==============================================================*/
/* Table: ROM_USER_INFO      远程用户管理表                     */
/*==============================================================*/
--drop table
drop table ROM_USER_INFO;
-- Create table
create table ROM_USER_INFO
(
  user_id   INTEGER not null,
  host_id   INTEGER,
  user_name VARCHAR2(32),
  passwd    VARCHAR2(32),
  home_dir  VARCHAR2(64),
  remark    VARCHAR2(128)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_USER_INFO
  add constraint PK_ROM_USER_INFO primary key (USER_ID)
  using index ;
-- Add comments to the table 
comment on table ROM_USER_INFO
  is '远程用户管理表'; 
-- Add comments to the columns 
comment on column ROM_USER_INFO.user_id
  is '远程用户编号';
comment on column ROM_USER_INFO.host_id
  is '主机编码';
comment on column ROM_USER_INFO.user_name
  is '用户名';
comment on column ROM_USER_INFO.passwd
  is '密码';
comment on column ROM_USER_INFO.home_dir
  is 'HOME目录';
comment on column ROM_USER_INFO.remark
  is '备注';

/*==============================================================*/
/* Table: EAI_APP_RULES       APPID规则表                     */
/*==============================================================*/
--drop table
drop table EAI_APP_RULES;
-- Create table
create table EAI_APP_RULES
(
  instance_id INTEGER,
  min_appid   INTEGER,
  max_appid   INTEGER
) ;
-- Add comments to the table 
comment on table EAI_APP_RULES
  is '应用集成平台appid规则表';
-- Add comments to the columns 
comment on column EAI_APP_RULES.instance_id
  is '实例ID';
comment on column EAI_APP_RULES.min_appid
  is '最小appid';
comment on column EAI_APP_RULES.max_appid
  is '最大appid';
 
/*==============================================================*/
/* Table: EAI_BUS_ADAPT_RELATION       总线与适配器关系表       */
/*==============================================================*/
--drop table
drop table EAI_BUS_ADAPT_RELATION;
-- Create table
create table EAI_BUS_ADAPT_RELATION
(
  bus_id       INTEGER not null,
  adapt_id     INTEGER,
  in_flag      CHAR(1),
  appid        INTEGER,
  transcode    VARCHAR2(8),
  server_count INTEGER,
  reserver1    VARCHAR2(64),
  reserver2    VARCHAR2(256)
);
-- Add comments to the table 
comment on table EAI_BUS_ADAPT_RELATION
  is '总线与适配器关系表';
-- Add comments to the columns 
comment on column EAI_BUS_ADAPT_RELATION.bus_id
  is '总线节点ID';
comment on column EAI_BUS_ADAPT_RELATION.adapt_id
  is '0：总线
1：tuxedo适配器
2：webservice适配器
3：http+xml适配器
4：mml适配器
5：tongeasy适配器
6：uasp适配器
7：socket适配器（lua版）';
comment on column EAI_BUS_ADAPT_RELATION.in_flag
  is '0：接入总线 1：接出总线';
comment on column EAI_BUS_ADAPT_RELATION.APPID
  is 'APPID';
comment on column EAI_BUS_ADAPT_RELATION.transcode
  is '交易编码';
comment on column EAI_BUS_ADAPT_RELATION.server_count
  is '服务个数';
comment on column EAI_BUS_ADAPT_RELATION.RESERVER1
  is '保留字1';
comment on column EAI_BUS_ADAPT_RELATION.RESERVER2
  is '保留字2';
-- Create/Recreate primary, unique and foreign key constraints 
alter table EAI_BUS_ADAPT_RELATION
  add constraint PK_EAI_BUS_ADAPT_RELATION primary key (BUS_ID)
  using index ;

/*==============================================================*/
/* Table: EAI_CONF_INST_RELATION       EAI配置实例关系表       */
/*==============================================================*/
--drop table
drop table EAI_CONF_INST_RELATION;
-- Create table
create table EAI_CONF_INST_RELATION
(
  node_id       INTEGER not null,
  instance_id   INTEGER,
  static_flag   INTEGER
);
-- Add comments to the table 
comment on table EAI_CONF_INST_RELATION
  is ' 配置和实例关系表';
-- Add comments to the columns 
comment on column EAI_CONF_INST_RELATION.node_id
  is '节点ID';
comment on column EAI_CONF_INST_RELATION.instance_id
  is '实例ID 0：总线
1：tuxedo适配器
2：webservice适配器
3：http+xml适配器
4：mml适配器
5：tongeasy适配器
6：uasp适配器
7：socket适配器（lua版）';
comment on column EAI_CONF_INST_RELATION.static_flag
  is '静态标志 0：非静态配置
1：是静态配置
静态配置含义：所有实例共同的配置即是静态配置。如tuxedo适配器的WSNADDR就是所有实例共享，为静态配置。';

/*==============================================================*/
/* Table: EAI_NODES_CONFINFO       EAI节点配置信息表       */
/*==============================================================*/
--drop table
drop table EAI_NODES_CONFINFO;
-- Create table
create table EAI_NODES_CONFINFO
(
  node_id   INTEGER not null,
  node_flag INTEGER,
  node_name VARCHAR2(32),
  node_desc VARCHAR2(64),
  reserve1  VARCHAR2(256),
  reserve2  VARCHAR2(256)
);
-- Add comments to the table 
comment on table EAI_NODES_CONFINFO
  is '应用集成平台节点信息，配置总线、适配器等信息';
-- Add comments to the columns 
comment on column EAI_NODES_CONFINFO.node_id
  is '节点ID';
comment on column EAI_NODES_CONFINFO.node_flag
  is '0：总线
1：tuxedo适配器
2：webservice适配器
3：http+xml适配器
4：mml适配器
5：tongeasy适配器
6：uasp适配器
7：socket适配器（lua版）';
comment on column EAI_NODES_CONFINFO.node_name
  is '节点名称';
comment on column EAI_NODES_CONFINFO.node_desc
  is '节点描述';
comment on column EAI_NODES_CONFINFO.reserve1
  is '保留字1';
comment on column EAI_NODES_CONFINFO.reserve2
  is '保留字2';
-- Create/Recreate primary, unique and foreign key constraints 
alter table EAI_NODES_CONFINFO
  add constraint PK_EAI_NODES_CONFINFO primary key (NODE_ID)
  using index ;

/*==============================================================*/
/* Table: EAI_NODES_INSTANCE       EAI节点实例表                */
/*==============================================================*/
--drop table
drop table EAI_NODES_INSTANCE;
-- Create table
create table EAI_NODES_INSTANCE
(
  instance_id INTEGER not null,
  section     VARCHAR2(32),
  item_name   VARCHAR2(64),
  item_value  VARCHAR2(256),
  item_seq    INTEGER,
  reserve1    VARCHAR2(256),
  reserve2    VARCHAR2(256)
) ;
-- Add comments to the table 
comment on table EAI_NODES_INSTANCE
  is '应用集成平台节点实例，配置总线、适配器等部署实例和业务参数，该表为增量表';
-- Add comments to the columns 
comment on column EAI_NODES_INSTANCE.instance_id
  is '实例ID';
comment on column EAI_NODES_INSTANCE.section
  is 'section名';
comment on column EAI_NODES_INSTANCE.item_name
  is '配置键名';
comment on column EAI_NODES_INSTANCE.item_value
  is '配置键值';
comment on column EAI_NODES_INSTANCE.item_seq
  is '配置顺序';
comment on column EAI_NODES_INSTANCE.reserve1
  is '保留字1';
comment on column EAI_NODES_INSTANCE.reserve2
  is '保留字2';
-- Create/Recreate primary, unique and foreign key constraints 
alter table EAI_NODES_INSTANCE
  add constraint PK_EAI_NODES_INSTANCE primary key (INSTANCE_ID)
  using index ;

/*==============================================================*/
/* Table: ROM_DAYMONITOR_CONF       日常巡检项目定义表          */
/*==============================================================*/
--drop table
drop table ROM_DAYMONITOR_CONF;
-- Create table
create table ROM_DAYMONITOR_CONF
(
  seq_id         INTEGER not null,
  province_code  VARCHAR2(3) not null,
  tell_type  CHAR(1) not null,
  pro_code       VARCHAR2(8) not null,
  father_section VARCHAR2(64) not null,
  child_section  VARCHAR2(64) not null,
  kpi_id         VARCHAR2(32) not null,
  check_cycle    VARCHAR2(32),
  reserved1      VARCHAR2(32),
  reserved2      VARCHAR2(64),
  remark         VARCHAR2(64)
) ;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_DAYMONITOR_CONF
  add constraint PK_ROM_DAYMONITOR_CONF primary key (SEQ_ID, PROVINCE_CODE, tell_type, PRO_CODE, FATHER_SECTION, CHILD_SECTION, KPI_ID)
  using index ;
-- Add comments to the table 
comment on table ROM_DAYMONITOR_CONF
  is '日常巡检项目定义表';
-- Add comments to the columns 
comment on column ROM_DAYMONITOR_CONF.seq_id
  is '序列号';
comment on column ROM_DAYMONITOR_CONF.province_code
  is '省份代码';
comment on column ROM_DAYMONITOR_CONF.tell_type
  is '运营商代码';
comment on column ROM_DAYMONITOR_CONF.pro_code
  is '产品代码';
comment on column ROM_DAYMONITOR_CONF.father_section
  is '日检父节点项';
comment on column ROM_DAYMONITOR_CONF.child_section
  is '日检子节点项';
comment on column ROM_DAYMONITOR_CONF.kpi_id
  is 'KPI编号';
comment on column ROM_DAYMONITOR_CONF.check_cycle
  is '检查周期';
comment on column ROM_DAYMONITOR_CONF.reserved1
  is '预留字段1';
comment on column ROM_DAYMONITOR_CONF.reserved2
  is '预留字段2';
comment on column ROM_DAYMONITOR_CONF.remark
  is '备注';



/*==============================================================*/
/* Table: ROM_DAYMONITOR_DATA       日常巡检项目实例表          */
/*==============================================================*/
--drop table
drop table ROM_DAYMONITOR_DATA;
-- Create table
create table ROM_DAYMONITOR_DATA
(
  seq_id           INTEGER,
  check_time       DATE,
  mul_section_name VARCHAR2(128),
  check_value      VARCHAR2(32),
  err_flag         CHAR(1),
  reserved1        VARCHAR2(32),
  reserved2        VARCHAR2(64),
  remark           VARCHAR2(64)
) ;
-- Add comments to the table 
comment on table ROM_DAYMONITOR_DATA
  is '日常巡检项目实例表';
-- Add comments to the columns 
comment on column ROM_DAYMONITOR_DATA.seq_id
  is '序列号';
comment on column ROM_DAYMONITOR_DATA.check_time
  is '日检时间';
comment on column ROM_DAYMONITOR_DATA.mul_section_name
  is '多维日检结果项名称';
comment on column ROM_DAYMONITOR_DATA.check_value
  is '检查结果值';
comment on column ROM_DAYMONITOR_DATA.err_flag
  is '异常标识 0：正常 1：异常';
comment on column ROM_DAYMONITOR_DATA.reserved1
  is '预留字段1';
comment on column ROM_DAYMONITOR_DATA.reserved2
  is '预留字段2';
comment on column ROM_DAYMONITOR_DATA.remark
  is '备注';
  
/*==============================================================*/
/* Table: ROM_BUSICHECK_DATA       进程监控实例表          */
/*==============================================================*/
--drop table
drop table ROM_BUSICHECK_DATA;
-- Create table
create table ROM_BUSICHECK_DATA
(
  seq_id           INTEGER,
  check_time       DATE,
  mul_section_name VARCHAR2(128),
  check_value      VARCHAR2(32),
  err_flag         CHAR(1),
  reserved1        VARCHAR2(32),
  reserved2        VARCHAR2(64),
  remark           VARCHAR2(64)
) ;
-- Add comments to the table 
comment on table ROM_BUSICHECK_DATA
  is '进程监控实例表';
-- Add comments to the columns 
comment on column ROM_BUSICHECK_DATA.seq_id
  is '序列号';
comment on column ROM_BUSICHECK_DATA.check_time
  is '进程监控时间';
comment on column ROM_BUSICHECK_DATA.mul_section_name
  is '进程监控项名称';
comment on column ROM_BUSICHECK_DATA.check_value
  is '进程监控结果值';
comment on column ROM_BUSICHECK_DATA.err_flag
  is '异常标识 0：正常 1：异常';
comment on column ROM_BUSICHECK_DATA.reserved1
  is '预留字段1';
comment on column ROM_BUSICHECK_DATA.reserved2
  is '预留字段2';
comment on column ROM_BUSICHECK_DATA.remark
  is '备注';
/*==============================================================*/
/* Table: ROM_NETCELL_INFO       网元信息表                  */
/*==============================================================*/
--drop table
drop table ROM_NETCELL_INFO;
-- Create table
create table ROM_NETCELL_INFO
(
  cell_id       INTEGER not null,
  province_code VARCHAR2(3) not null,
  tell_type     CHAR(1) not null,
  cell_code     VARCHAR2(8) not null,
  cell_name     VARCHAR2(32),
  hlr_code      VARCHAR2(8) not null,
  ip_addr       VARCHAR2(32) not null,
  port          NUMBER(6) not null,
  use_flag      CHAR(1),
  reserved1     VARCHAR2(32),
  reserved2     VARCHAR2(64),
  remark        VARCHAR2(64)
)  ;

-- Add comments to the columns 
comment on column ROM_NETCELL_INFO.use_flag
  is 'y:有效 n:无效';
-- Create/Recreate indexes 
create unique index NETCELL_INDEX on ROM_NETCELL_INFO (PROVINCE_CODE, TELL_TYPE, CELL_CODE, HLR_CODE, IP_ADDR, PORT)
   ;
 
-- Create/Recreate primary, unique and foreign key constraints 
alter table ROM_NETCELL_INFO
  add constraint PK_ROM_NETCELL_INFO primary key (CELL_ID)
  using index 
  ;


/*==============================================================*/
/* Table: ROM_EXPAND_CODE       扩展属性代码表                  */
/*==============================================================*/
--drop table
drop table ROM_EXPAND_CODE;  
-- Create table
create table ROM_EXPAND_CODE
(
  property_key      VARCHAR2(60) not null,
  property_key_desc VARCHAR2(200) not null,
  table_name        VARCHAR2(30) not null,
  table_name_desc   VARCHAR2(30) not null
) ;

-- Create/Recreate indexes 
create unique index PK_ROM_EXPAND_CODE on ROM_EXPAND_CODE (PROPERTY_KEY, PROPERTY_KEY_DESC, TABLE_NAME, TABLE_NAME_DESC)
  ;
 
/*==============================================================*/
/* Table: ROM_EXPAND_INFO       扩展属性实例表                  */
/*==============================================================*/
--drop table
drop table ROM_EXPAND_INFO;  
-- Create table
create table ROM_EXPAND_INFO
(
  expand_id      INTEGER not null,
  record_id      INTEGER not null,
  property_key   VARCHAR2(60),
  property_value VARCHAR2(200) not null,
  property_order INTEGER not null,
  remark         VARCHAR2(200)
) ;
-- Create/Recreate indexes 
create unique index IDK1_ROM_EXPAND_INFO on ROM_EXPAND_INFO (RECORD_ID, PROPERTY_KEY, PROPERTY_VALUE, PROPERTY_ORDER)
  ;
create unique index PK_ROM_EXPAND_INFO on ROM_EXPAND_INFO (EXPAND_ID)
  ;


/*==============================================================*/
/* Table:  ROM_BUSICHECK_CONF      业务监控配置表                  */
/*==============================================================*/
DROP TABLE ROM_BUSICHECK_CONF CASCADE CONSTRAINTS;

CREATE TABLE ROM_BUSICHECK_CONF
(
  SEQ_ID             INTEGER                    NOT NULL,
  PROVINCE_CODE      VARCHAR2(3 BYTE)           NOT NULL,
  TELL_TYPE          CHAR(1 BYTE)               NOT NULL,
  BUSI_TYPE          INTEGER                    NOT NULL,
  BUSI_IDENTIFY      VARCHAR2(3 BYTE)           NOT NULL,
  BUSI_NAME          VARCHAR2(64 BYTE)          NOT NULL,
  CHECK_NODES        VARCHAR2(64 BYTE),
  CHILD_NODE         VARCHAR2(64 BYTE),
  HOST_IP            VARCHAR2(32 BYTE),
  USER_NAME          VARCHAR2(16 BYTE),
  HOST_DIR           VARCHAR2(128 BYTE),
  CHECK_LIMIT_VALUE  VARCHAR2(16 BYTE)          NOT NULL,
  LOGIN_NO           VARCHAR2(8 BYTE),
  GRANT_LOGINS       VARCHAR2(1024 BYTE),
  ISGRANT            INTEGER,
  RESERVED1          VARCHAR2(32 BYTE),
  RESERVED2          VARCHAR2(64 BYTE),
  RESERVED3          VARCHAR2(64 BYTE),
  REMARK             VARCHAR2(64 BYTE)
)
;


CREATE UNIQUE INDEX PK_ROM_BUSICHECK_CONF ON ROM_BUSICHECK_CONF
(SEQ_ID)
;
  
/*==============================================================*/
/* Table:  CMSWORKORDERSAVERULE      网元与网元日志表的对应关系配置表                  */
/*CmsWorkOrderSaveRule  表主要是 在工单明细查询和工单统计查询时，通过选择 网元编码，自动获取对应的当月数据存储的工单表，工单历史表表名（1.1. 中 工单历史表默认是在工单表名后添加 _his，在jsp页面实现）, 动态查询统计工单数据。 */
/*==============================================================*/
create table CMSWORKORDERSAVERULE
(
  cell_code VARCHAR2(8),
  hlr_code  VARCHAR2(8),
  save_code VARCHAR2(64),
  use_flag  CHAR(1),
  remarks   VARCHAR2(1000)
) ;
 
comment on column CMSWORKORDERSAVERULE.cell_code 
  is '网元编码';
comment on column CMSWORKORDERSAVERULE.hlr_code 
is '网元编号';
comment on column CMSWORKORDERSAVERULE.save_code 
is '工单表（当月数据存储的工单表）';
comment on column CMSWORKORDERSAVERULE.use_flag 
is '是否在用';
comment on column CMSWORKORDERSAVERULE.remarks
is '备注';
  
/*==============================================================*/
/* Table:  ROM_OBSMONITOR_CFG      山西业支需求：显示异常金额或频次的交易核查记录或监控记录；该表是监控策略的配置表                  */
/*==============================================================*/
CREATE TABLE ROM_OBSMONITOR_CFG
(
  ID             INTEGER                        NOT NULL,
  PROVINCE_CODE  VARCHAR2(3 BYTE)               NOT NULL,
  TELL_TYPE      CHAR(1 BYTE)                   NOT NULL,
  TYPE           NUMBER                         NOT NULL,
  NAME           VARCHAR2(60 BYTE)              NOT NULL,
  OP_TYPE        NUMBER                         NOT NULL,
  DEFAULT_VALUE  NUMBER,
  REMARK         VARCHAR2(200 BYTE)
)
;

COMMENT ON TABLE ROM_OBSMONITOR_CFG IS '山西业支需求：显示异常金额或频次的交易核查记录或监控记录；该表是监控策略的配置表';

/*==============================================================*/
/* Table:  WOBSPANPROVOPRALL      山西业支需求：显示异常金额或频次的交易核查记录或监控记录；该表是要查询的数据来源表                  */
/*==============================================================*/
CREATE TABLE WOBSPANPROVOPRALL
(
  OP_TYPE       CHAR(1 BYTE)                    NOT NULL,
  ACTIVITYCODE  CHAR(8 BYTE)                    NOT NULL,
  CUTOFFDAY     CHAR(8 BYTE)                    NOT NULL,
  OSNDUNS       CHAR(4 BYTE),
  HSNDUNS       CHAR(4 BYTE),
  RSPCODE       CHAR(4 BYTE),
  PHONE_NO      VARCHAR2(15 BYTE)               NOT NULL,
  LOGIN_ACCEPT  NUMBER                          NOT NULL,
  SM_CODE       CHAR(2 BYTE)                    NOT NULL,
  LOGIN_NO      VARCHAR2(9 BYTE)                NOT NULL,
  OP_TIME       VARCHAR2(30 BYTE)               NOT NULL,
  PAY_MONEY     NUMBER(15,2)                    NOT NULL,
  BACK_FLAG     CHAR(1 BYTE)                    NOT NULL,
  NOTE          VARCHAR2(60 BYTE)
)
;

COMMENT ON TABLE WOBSPANPROVOPRALL IS '山西业支需求：显示异常金额或频次的交易核查记录或监控记录；该表是要查询的数据来源表';

/*=============================四川移动 表同步查询需求=================================*/
CREATE TABLE  ROM_COPYTABLE_HOST    
(
  HOSTID      NUMBER(10)                        NOT NULL,
  HOSTIP      VARCHAR2(20 BYTE)                 NOT NULL,
  USERNAME    VARCHAR2(20 BYTE)                 NOT NULL,
  USERPASSWD  VARCHAR2(20 BYTE)                 NOT NULL,
  FILEDIR     VARCHAR2(256 BYTE)                NOT NULL,
  FILENAME    VARCHAR2(256 BYTE)                NOT NULL,
  FILETYPE    VARCHAR2(1 BYTE)                  NOT NULL
)
;

COMMENT ON TABLE ROM_COPYTABLE_HOST IS '全量同步主机配置表';


CREATE TABLE ROM_COPYTABLE_ALL
(
  HOSTID            NUMBER(10)                  NOT NULL,
  SRC_TABLE_OWNER   VARCHAR2(30 BYTE)           NOT NULL,
  SRC_TABLE_NAME    VARCHAR2(60 BYTE)           NOT NULL,
  DESC_TABLE_OWNER  VARCHAR2(30 BYTE)           NOT NULL,
  DESC_TABLE_NAME   VARCHAR2(60 BYTE)           NOT NULL
);

COMMENT ON TABLE ROM_COPYTABLE_ALL IS '全量同步表关系配置表';


CREATE TABLE ROM_COPYTABLE_ADD
(
  DBFLAG      VARCHAR2(4 BYTE)                  NOT NULL,
  DBSTR       VARCHAR2(100 BYTE)                NOT NULL,
  TABLEOWNER  VARCHAR2(30 BYTE)                 NOT NULL,
  TABLENAME   VARCHAR2(60 BYTE)                 NOT NULL,
  SQLSTR      VARCHAR2(256 BYTE),
  REMARK      VARCHAR2(256 BYTE)
);

COMMENT ON TABLE ROM_COPYTABLE_ADD IS '全量增量同步查询配置表';


CREATE TABLE ROM_BUSICHECK_DATA
(
  SEQ_ID            INTEGER,
  CHECK_TIME        DATE,
  MUL_SECTION_NAME  VARCHAR2(128 BYTE),
  CHECK_VALUE       VARCHAR2(32 BYTE),
  ERR_FLAG          CHAR(1 BYTE),
  RESERVED1         VARCHAR2(32 BYTE),
  RESERVED2         VARCHAR2(64 BYTE),
  REMARK            VARCHAR2(64 BYTE)
);

COMMENT ON TABLE ROM_BUSICHECK_DATA IS '进程监控表';

/*==============================================================*/
/* Table:  ROM_DATASCRIPT_CONFIG 山西业支需求： 脚本提取数据配置表 */
/*==============================================================*/

DROP TABLE ROM_DATASCRIPT_CONFIG CASCADE CONSTRAINTS;

CREATE TABLE ROM_DATASCRIPT_CONFIG
(
  FUNCTION_CODE        VARCHAR2(64 BYTE)        NOT NULL,
  PROVINCE_CODE        VARCHAR2(8 BYTE)         NOT NULL,
  TELL_TYPE            VARCHAR2(1 BYTE)         NOT NULL,
  HOST_ID              INTEGER                  NOT NULL,
  START_SCRIPTS_DIR    VARCHAR2(256 BYTE)       NOT NULL,
  START_SCRIPTS_NAME   VARCHAR2(512 BYTE)       NOT NULL,
  STOP_SCRIPTS_DIR     VARCHAR2(256 BYTE),
  STOP_SCRIPTS_NAME    VARCHAR2(512 BYTE),
  CHECK_SCRIPTS_ORDER  VARCHAR2(512 BYTE)       NOT NULL,
  SCRIPTS_PARAM_NUM    INTEGER                  NOT NULL,
  SCRIPTS_PARAM_NAME   VARCHAR2(512 BYTE),
  SCRIPTS_LOG_DIR      VARCHAR2(512 BYTE)       NOT NULL,
  SCRIPTS_LOG_NAME     VARCHAR2(512 BYTE)       NOT NULL,
  USER_NAME            VARCHAR2(64 BYTE)        NOT NULL,
  USER_PASSWD          VARCHAR2(64 BYTE)        NOT NULL,
  REMARK    VARCHAR2(256 BYTE) 
);
 
 
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.FUNCTION_CODE           IS '模块代码';
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.PROVINCE_CODE           IS '模省份代码';
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.TELL_TYPE               IS '电信运营商';
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.HOST_ID                 IS '主机ID 关联 rom_host_info表';
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.START_SCRIPTS_DIR       IS '开始脚本所在的目录';
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.START_SCRIPTS_NAME      IS '开始脚本的名称';
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.STOP_SCRIPTS_DIR        IS '停止脚本所在的目录';
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.STOP_SCRIPTS_NAME       IS '停止脚本的名称';
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.CHECK_SCRIPTS_ORDER     IS '查询开始脚本是否在运行的命令';
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.SCRIPTS_PARAM_NUM       IS '开始脚本附带参数的个数' ;
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.SCRIPTS_PARAM_NAME      IS '开始脚本附带参数的名称' ;
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.SCRIPTS_LOG_DIR         IS '脚本日志所在的目录' ;
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.SCRIPTS_LOG_NAME        IS '脚本日志的名称' ;
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.USER_NAME               IS '主机的用户名' ;
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.USER_PASSWD             IS '主机的密码' ;
COMMENT ON COLUMN  ROM_DATASCRIPT_CONFIG.REMARK                  IS '备注' ;

                                                                                                                  


CREATE UNIQUE INDEX  UIDK1_ROM_DATASCRIPT_CONFIG ON ROM_DATASCRIPT_CONFIG
(FUNCTION_CODE, PROVINCE_CODE, TELL_TYPE);
 

/*==============================================================*/
/* Table:  ROM_DATASQL_CONFIG 山西业支需求：SQL提取数据配置表   */
/*==============================================================*/
 

DROP TABLE ROM_DATASQL_CONFIG CASCADE CONSTRAINTS;

CREATE TABLE ROM_DATASQL_CONFIG
(
  FUNCTION_CODE  VARCHAR2(64 BYTE)              NOT NULL,
  PROVINCE_CODE  VARCHAR2(64 BYTE)              NOT NULL,
  TELL_TYPE      VARCHAR2(64 BYTE)              NOT NULL,
  SQL_DESC       VARCHAR2(4000 BYTE)            NOT NULL,
  SQL_PARAM      VARCHAR2(128 BYTE)             NOT NULL,
  SQL_TITLE      VARCHAR2(128 BYTE)             NOT NULL,
  DB_ID          VARCHAR2(64 BYTE)              NOT NULL,
  REMARK         VARCHAR2(256 BYTE)
);
 
 
COMMENT ON COLUMN  ROM_DATASQL_CONFIG.FUNCTION_CODE      IS '模块代码';
COMMENT ON COLUMN  ROM_DATASQL_CONFIG.PROVINCE_CODE      IS '模省份代码';
COMMENT ON COLUMN  ROM_DATASQL_CONFIG.TELL_TYPE          IS '电信运营商';
COMMENT ON COLUMN  ROM_DATASQL_CONFIG.SQL_DESC           IS 'SQL语句 查询参数用问号代替';
COMMENT ON COLUMN  ROM_DATASQL_CONFIG.SQL_PARAM          IS '查询参数的名称';
COMMENT ON COLUMN  ROM_DATASQL_CONFIG.SQL_TITLE          IS '查询字段的名称';
COMMENT ON COLUMN  ROM_DATASQL_CONFIG.DB_ID              IS '数据库标识 关联 ROM_DATATITLE_CONFIG 表';
COMMENT ON COLUMN  ROM_DATASQL_CONFIG.REMARK             IS '备注';



CREATE UNIQUE INDEX  UIDK1_ROM_DATASQL_CONFIG ON ROM_DATASQL_CONFIG
(FUNCTION_CODE, PROVINCE_CODE, TELL_TYPE);


/*==============================================================*/
/* Table:  ROM_DATATITLE_CONFIG 山西业支需求：数据库标识配置表   */
/*==============================================================*/
 

DROP TABLE ROM_DATATITLE_CONFIG CASCADE CONSTRAINTS;

CREATE TABLE ROM_DATATITLE_CONFIG
(
  DB_ID          VARCHAR2(64 BYTE)              NOT NULL,
  PROVINCE_CODE  VARCHAR2(64 BYTE)              NOT NULL,
  TELL_TYPE      VARCHAR2(64 BYTE)              NOT NULL,
  DB_NAME        VARCHAR2(64 BYTE)              NOT NULL,
  REMARK         VARCHAR2(256 BYTE)
);
 
COMMENT ON COLUMN  ROM_DATATITLE_CONFIG.DB_ID              IS '数据库标识';
COMMENT ON COLUMN  ROM_DATATITLE_CONFIG.PROVINCE_CODE      IS '模省份代码';
COMMENT ON COLUMN  ROM_DATATITLE_CONFIG.TELL_TYPE          IS '电信运营商';
COMMENT ON COLUMN  ROM_DATATITLE_CONFIG.DB_NAME            IS '数据库名称';
COMMENT ON COLUMN  ROM_DATATITLE_CONFIG.REMARK             IS '备注';

CREATE UNIQUE INDEX  UIDK1_ROM_DATATITLE_CONFIG ON ROM_DATATITLE_CONFIG
(DB_ID, PROVINCE_CODE, TELL_TYPE);
 

/*==============================================================*/
/* Table:  ROM_WF_PRODUCT 湖北移动分支需求： 产品信息表*/  
/*==============================================================*/
 
DROP TABLE ROM_WF_PRODUCT CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_PRODUCT
(
  PRODUCT_ID     INTEGER                        NOT NULL,
  PROVINCE_CODE  VARCHAR2(3 BYTE)               NOT NULL,
  TELLCORP_CODE  VARCHAR2(1 BYTE)               NOT NULL,
  PRODUCT_NAME   VARCHAR2(128 BYTE)             NOT NULL,
  DEPART         VARCHAR2(30 BYTE),
  VERSION        VARCHAR2(30 BYTE),
  MANAGER        VARCHAR2(30 BYTE),
  REMARK         VARCHAR2(256 BYTE)
);

COMMENT ON COLUMN ROM_WF_PRODUCT.PRODUCT_ID IS '产品序号ID';

COMMENT ON COLUMN ROM_WF_PRODUCT.PROVINCE_CODE IS '省份';

COMMENT ON COLUMN ROM_WF_PRODUCT.TELLCORP_CODE IS '运营商';

COMMENT ON COLUMN ROM_WF_PRODUCT.PRODUCT_NAME IS '产品名称';

COMMENT ON COLUMN ROM_WF_PRODUCT.DEPART IS '产品所属部门';

COMMENT ON COLUMN ROM_WF_PRODUCT.VERSION IS '产品版本';

COMMENT ON COLUMN ROM_WF_PRODUCT.MANAGER IS '负责人，用于标识各产品在各个省份的负责人';

COMMENT ON COLUMN ROM_WF_PRODUCT.REMARK IS '备注';


CREATE UNIQUE INDEX IDK1_ROM_WF_PRODUCT ON ROM_WF_PRODUCT
(PRODUCT_ID);



/*==============================================================*/
/* Table:  ROM_WF_TASK 湖北移动分支需求： 任务信息表*/  
/*==============================================================*/

 
DROP TABLE ROM_WF_TASK CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_TASK
(
  TASK_ID     VARCHAR2(30 BYTE)                 NOT NULL,
  PRODUCT_ID  INTEGER                           NOT NULL,
  STATUS      VARCHAR2(1 BYTE)                  NOT NULL,
  TASK_NAME   VARCHAR2(100 BYTE)                NOT NULL,
  REMARK      VARCHAR2(256 BYTE)
);

COMMENT ON COLUMN ROM_WF_TASK.TASK_ID IS '任务ID';

COMMENT ON COLUMN ROM_WF_TASK.PRODUCT_ID IS '产品ID';

COMMENT ON COLUMN ROM_WF_TASK.STATUS IS '状态业务取值含义：''0''  待审核 ''1''  已审核';

COMMENT ON COLUMN ROM_WF_TASK.TASK_NAME IS '任务名称';

COMMENT ON COLUMN ROM_WF_TASK.REMARK IS '备注';


CREATE UNIQUE INDEX IDK1_ROM_WF_TASK ON ROM_WF_TASK
(TASK_ID);

/*==============================================================*/
/* Table:  ROM_WF_TASK 湖北移动分支需求： 任务信息表*/  
/*==============================================================*/

DROP TABLE ROM_WF_TASK_OP CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_TASK_OP
(
  TASK_ID      VARCHAR2(30 BYTE)                NOT NULL,
  OP_TYPE      VARCHAR2(1 BYTE)                 NOT NULL,
  ENV_INST_ID  VARCHAR2(30 BYTE)                NOT NULL,
  OP_INFO      VARCHAR2(1024 BYTE),
  REMARK       VARCHAR2(256 BYTE)
);

COMMENT ON COLUMN ROM_WF_TASK_OP.TASK_ID IS '任务ID';

COMMENT ON COLUMN ROM_WF_TASK_OP.OP_TYPE IS '''0'' 开始 ''1'' 停止 ''2'' 暂停 ''3'' 取消 ''4'' 重做';

COMMENT ON COLUMN ROM_WF_TASK_OP.ENV_INST_ID IS '主机ID';

COMMENT ON COLUMN ROM_WF_TASK_OP.OP_INFO IS '操作备注';


CREATE UNIQUE INDEX PK_ROM_WF_TASK_OP ON ROM_WF_TASK_OP
(TASK_ID,OP_TYPE);


/*==============================================================*/
/* Table:  ROM_WF_TASK 湖北移动分支需求：             任务操作表*/  
/*==============================================================*/

DROP TABLE ROM_WF_TASK_OP CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_TASK_OP
(
  TASK_ID      VARCHAR2(30 BYTE)                NOT NULL,
  OP_TYPE      VARCHAR2(1 BYTE)                 NOT NULL,
  ENV_INS_ID   VARCHAR2(30 BYTE)                NOT NULL,
  OP_INFO      VARCHAR2(1024 BYTE),
  REMARK       VARCHAR2(256 BYTE)
);

COMMENT ON COLUMN ROM_WF_TASK_OP.TASK_ID IS '任务ID';

COMMENT ON COLUMN ROM_WF_TASK_OP.OP_TYPE IS '''0'' 开始 ''1'' 停止 ''2'' 暂停 ''3'' 取消 ''4'' 重做';

COMMENT ON COLUMN ROM_WF_TASK_OP.ENV_INS_ID IS '主机ID';

COMMENT ON COLUMN ROM_WF_TASK_OP.OP_INFO IS '操作备注';


CREATE UNIQUE INDEX PK_ROM_WF_TASK_OP ON ROM_WF_TASK_OP
(TASK_ID, OP_TYPE);

/*==============================================================*/
/* Table:  ROM_WF_FLOW 湖北移动分支需求： 流程表                */
/*==============================================================*/
 
 
DROP TABLE  ROM_WF_FLOW CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_FLOW
(
  FLOW_ID     VARCHAR2(30 BYTE)                 NOT NULL,
  PRODUCT_ID  INTEGER                           NOT NULL,
  STATUS      VARCHAR2(1 BYTE),
  FLOW_NAME   VARCHAR2(100 BYTE),
  REMARK      VARCHAR2(256 BYTE)
);

COMMENT ON COLUMN  ROM_WF_FLOW.FLOW_ID IS '流程ID';
COMMENT ON COLUMN  ROM_WF_FLOW.PRODUCT_ID IS '产品ID';
COMMENT ON COLUMN  ROM_WF_FLOW.STATUS IS '状态业务取值含义：''0''  待审核 ''1''  已审核';
COMMENT ON COLUMN  ROM_WF_FLOW.FLOW_NAME IS '流程名称';
COMMENT ON COLUMN  ROM_WF_FLOW.REMARK IS '备注';

CREATE UNIQUE INDEX  IDK1_ROM_WF_FLOW ON  ROM_WF_FLOW
(FLOW_ID);


/*==============================================================*/
/* Table:  ROM_WF_FLOW_TASK 湖北移动分支需求： 流程任务关系表    */
/*==============================================================*/

DROP TABLE  ROM_WF_FLOW_TASK CASCADE CONSTRAINTS;

CREATE TABLE  ROM_WF_FLOW_TASK
(
  FLOW_ID       VARCHAR2(30 BYTE)               NOT NULL,
  TASK_ID_FROM  VARCHAR2(30 BYTE),
  TASK_ID_TO    VARCHAR2(30 BYTE)
);
 

COMMENT ON COLUMN ROM_WF_FLOW_TASK.FLOW_ID IS '流程ID';
COMMENT ON COLUMN ROM_WF_FLOW_TASK.TASK_ID_FROM IS '前置任务ID';
COMMENT ON COLUMN ROM_WF_FLOW_TASK.TASK_ID_TO IS '后置任务ID';


CREATE INDEX IDK1_ROM_WF_FLOW_TASK ON ROM_WF_FLOW_TASK
(FLOW_ID,TASK_ID_FROM,TASK_ID_TO);
 
/*==============================================================*/
/* Table:  ROM_WF_FLOW_TASK_GUI 湖北移动分支需求： 流程任务坐标表    */
/*==============================================================*/

DROP TABLE  ROM_WF_FLOW_TASK_GUI CASCADE CONSTRAINTS;

CREATE TABLE  ROM_WF_FLOW_TASK_GUI
(
  FLOW_ID       VARCHAR2(30 BYTE)               NOT NULL,
  TASK_ID       VARCHAR2(30 BYTE)               NOT NULL,
  GUI_X         VARCHAR2(30 BYTE),
  GUI_Y         VARCHAR2(30 BYTE)
);
 

COMMENT ON COLUMN ROM_WF_FLOW_TASK_GUI.FLOW_ID IS '流程ID';
COMMENT ON COLUMN ROM_WF_FLOW_TASK_GUI.TASK_ID IS '任务ID';
COMMENT ON COLUMN ROM_WF_FLOW_TASK_GUI.GUI_X IS 'GUI界面X轴坐标';
COMMENT ON COLUMN ROM_WF_FLOW_TASK_GUI.GUI_Y IS 'GUI界面Y轴坐标';


CREATE INDEX IDK1_ROM_WF_FLOW_TASK_GUI ON ROM_WF_FLOW_TASK_GUI
(FLOW_ID,TASK_ID);


/*==============================================================*/
/* Table:  ROM_WF_TEMPLATE 湖北移动分支需求： 模板信息表*/  
/*==============================================================*/ 
 
 
DROP TABLE ROM_WF_TEMPLATE CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_TEMPLATE
(
  TEMPLATE_ID    VARCHAR2(30 BYTE)              NOT NULL,
  PRODUCT_ID     INTEGER                        NOT NULL,
  STATUS         VARCHAR2(1 BYTE)               NOT NULL,
  TEMPLATE_NAME  VARCHAR2(100 BYTE),
  REMARK         VARCHAR2(256 BYTE)
);

COMMENT ON COLUMN ROM_WF_TEMPLATE.TEMPLATE_ID IS '模板ID';

COMMENT ON COLUMN ROM_WF_TEMPLATE.PRODUCT_ID IS '产品ID';

COMMENT ON COLUMN ROM_WF_TEMPLATE.STATUS IS '状态业务取值含义：''0''  待审核 ''1''  已审核';

COMMENT ON COLUMN ROM_WF_TEMPLATE.TEMPLATE_NAME IS '模板名称';

COMMENT ON COLUMN ROM_WF_TEMPLATE.REMARK IS '备注';


CREATE UNIQUE INDEX IDK1_ROM_WF_TEMPLATE ON ROM_WF_TEMPLATE
(TEMPLATE_ID);


/*==============================================================*/
/* Table:  ROM_WF_TEMPLATE_FLOW 湖北移动分支需求： 出账模板流程关系表*/  
/*==============================================================*/ 
 
DROP TABLE ROM_WF_TEMPLATE_FLOW CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_TEMPLATE_FLOW
(
  TEMPLATE_ID   VARCHAR2(30 BYTE)               NOT NULL,
  FLOW_ID_FROM  VARCHAR2(30 BYTE),
  FLOW_ID_TO    VARCHAR2(30 BYTE)
);

COMMENT ON COLUMN ROM_WF_TEMPLATE_FLOW.TEMPLATE_ID IS '模板ID';

COMMENT ON COLUMN ROM_WF_TEMPLATE_FLOW.FLOW_ID_FROM IS '前置流程ID';

COMMENT ON COLUMN ROM_WF_TEMPLATE_FLOW.FLOW_ID_TO IS '后置流程ID';

CREATE UNIQUE INDEX PK_ROM_WF_TEMPLATE_FLOW ON ROM_WF_TEMPLATE_FLOW
(TEMPLATE_ID,  FLOW_ID_FROM, FLOW_ID_TO);


/*==============================================================*/
/* Table:  ROM_WF_TEMPLATE_FLOW_GUI 湖北移动分支需求： 出账模板流程坐标表*/  
/*==============================================================*/ 
 
DROP TABLE ROM_WF_TEMPLATE_FLOW_GUI CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_TEMPLATE_FLOW_GUI
(
  TEMPLATE_ID   VARCHAR2(30 BYTE)               NOT NULL,
  FLOW_ID       VARCHAR2(30 BYTE)               NOT NULL,
  GUI_X         VARCHAR2(30 BYTE),
  GUI_Y         VARCHAR2(30 BYTE)
);

COMMENT ON COLUMN ROM_WF_TEMPLATE_FLOW_GUI.TEMPLATE_ID IS '模板ID';

COMMENT ON COLUMN ROM_WF_TEMPLATE_FLOW_GUI.FLOW_ID IS '流程ID';

COMMENT ON COLUMN ROM_WF_TEMPLATE_FLOW_GUI.GUI_X IS '流程界面X轴坐标';

COMMENT ON COLUMN ROM_WF_TEMPLATE_FLOW_GUI.GUI_Y IS '流程界面Y轴坐标';

CREATE UNIQUE INDEX PK_ROM_WF_TEMPLATE_FLOW_GUI ON ROM_WF_TEMPLATE_FLOW_GUI
(TEMPLATE_ID , FLOW_ID);

/*==============================================================*/
/* Table:  ROM_WF_INS 湖北移动分支需求： 实例信息表            */
/*==============================================================*/
 
DROP TABLE ROM_WF_INS CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_INS
(
  INS_ID       VARCHAR2(30 BYTE)                NOT NULL,
  PRODUCT_ID   INTEGER                          NOT NULL,
  INS_NAME     VARCHAR2(100 BYTE),
  STATUS       VARCHAR2(1 BYTE)                 NOT NULL,
  ACCT_MON     VARCHAR2(6 BYTE),
  TEMPLATE_ID  VARCHAR2(30 BYTE),
  CREATE_TIME  VARCHAR2(14 BYTE),
  EFF_TIME     VARCHAR2(14 BYTE),
  EXP_TIME     VARCHAR2(14 BYTE),
  REMARK       VARCHAR2(256 BYTE)
); 
COMMENT ON COLUMN ROM_WF_INS.INS_ID IS '出账实例ID';
COMMENT ON COLUMN ROM_WF_INS.PRODUCT_ID IS '产品ID';
COMMENT ON COLUMN ROM_WF_INS.INS_NAME IS '实例的名称';
COMMENT ON COLUMN ROM_WF_INS.STATUS IS '''0'' 未实例化  ''1'' 已实例化  ''2'' 审核通过  ''3'' 执行未开始  ''4'' 执行进行中';
COMMENT ON COLUMN ROM_WF_INS.ACCT_MON IS '账期,6位的月份数字';
COMMENT ON COLUMN ROM_WF_INS.TEMPLATE_ID IS '继承的模板ID';
COMMENT ON COLUMN ROM_WF_INS.CREATE_TIME IS '创建时间（格式为：yyyymmddhhmiss）';
COMMENT ON COLUMN ROM_WF_INS.EFF_TIME IS '生效开始时间（不在有效期内的实例不能被执行）';
COMMENT ON COLUMN ROM_WF_INS.EXP_TIME IS '生效结束时间';
COMMENT ON COLUMN ROM_WF_INS.REMARK IS '备注';


CREATE UNIQUE INDEX IDK1_ROM_WF_INS ON ROM_WF_INS
(INS_ID);



/*==============================================================*/
/* Table:  ROM_WF_INS_FLOW_REL 湖北移动分支需求： 出账实例流程表 */
/*==============================================================*/
DROP TABLE ROM_WF_INS_FLOW_REL CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_INS_FLOW_REL
(
  INS_ID         VARCHAR2(30 BYTE)              NOT NULL,
  FLOW_ID        VARCHAR2(30 BYTE)              NOT NULL,
  INS_FLOW_TYPE  VARCHAR2(10 BYTE)              NOT NULL,
  INS_TIME       VARCHAR2(14 BYTE)              NOT NULL,
  INS_LOGIN_NO   VARCHAR2(30 BYTE)              NOT NULL
);

COMMENT ON COLUMN ROM_WF_INS_FLOW_REL.INS_ID IS '出账实例ID';
COMMENT ON COLUMN ROM_WF_INS_FLOW_REL.FLOW_ID IS '流程ID';
COMMENT ON COLUMN ROM_WF_INS_FLOW_REL.INS_FLOW_TYPE IS '流程类型 0-通过模板初始化,1-初始化时新增流程,2-运行时新增流程';
COMMENT ON COLUMN ROM_WF_INS_FLOW_REL.INS_TIME IS '实例化时间';
COMMENT ON COLUMN ROM_WF_INS_FLOW_REL.INS_LOGIN_NO IS '实例化人的工号';

CREATE UNIQUE INDEX IDK1_ROM_WF_INS_FLOW_REL ON ROM_WF_INS_FLOW_REL
(INS_ID, FLOW_ID);


/*==============================================================*/
/* Table:  ROM_WF_INS_FLOW 湖北移动分支需求： 出账实例流程关系表 */
/*==============================================================*/
 
DROP TABLE ROM_WF_INS_FLOW CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_INS_FLOW
(
  INS_ID         VARCHAR2(30 BYTE)              NOT NULL,
  FLOW_ID_FROM   VARCHAR2(30 BYTE),
  FLOW_ID_TO     VARCHAR2(30 BYTE)
) ;

COMMENT ON COLUMN ROM_WF_INS_FLOW.INS_ID IS '出账实例ID';
COMMENT ON COLUMN ROM_WF_INS_FLOW.FLOW_ID_FROM IS '前置任务ID';
COMMENT ON COLUMN ROM_WF_INS_FLOW.FLOW_ID_TO IS '后置任务ID';
 


CREATE UNIQUE INDEX IDK1_ROM_WF_INS_FLOW_ID ON ROM_WF_INS_FLOW
(INS_ID, FLOW_ID_FROM, FLOW_ID_TO );


/*==============================================================*/
/* Table:  ROM_WF_INS_FLOW_GUI 湖北移动分支需求： 出账实例流程坐标表 */
/*==============================================================*/
DROP TABLE ROM_WF_INS_FLOW_GUI CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_INS_FLOW_GUI
(
  INS_ID   VARCHAR2(30 BYTE),
  FLOW_ID  VARCHAR2(30 BYTE),
  GUI_X    VARCHAR2(30 BYTE),
  GUI_Y    VARCHAR2(30 BYTE)
);

COMMENT ON COLUMN ROM_WF_INS_FLOW_GUI.INS_ID IS '出账实例ID';
COMMENT ON COLUMN ROM_WF_INS_FLOW_GUI.FLOW_ID IS '流程ID';
COMMENT ON COLUMN ROM_WF_INS_FLOW_GUI.GUI_X IS '流程X坐标';
COMMENT ON COLUMN ROM_WF_INS_FLOW_GUI.GUI_Y IS '流程Y坐标';
 

CREATE UNIQUE INDEX IDK1_ROM_WF_INS_FLOW_GUI ON ROM_WF_INS_FLOW_GUI
(INS_ID, FLOW_ID);

 
/*==============================================================*/
/* Table:  ROM_WF_INS_FLOW_TASK 湖北移动分支需求：出账实例流程任务表 */
/*==============================================================*/
  
 
DROP TABLE ROM_WF_INS_FLOW_TASK CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_INS_FLOW_TASK
(
  INS_ID        VARCHAR2(30 BYTE)               NOT NULL,
  FLOW_ID       VARCHAR2(30 BYTE)               NOT NULL,
  TASK_ID_FROM  VARCHAR2(30 BYTE)               NOT NULL,
  TASK_ID_TO    VARCHAR2(30 BYTE)               NOT NULL
);

COMMENT ON COLUMN ROM_WF_INS_FLOW_TASK.INS_ID IS '出账实例ID';
COMMENT ON COLUMN ROM_WF_INS_FLOW_TASK.FLOW_ID IS '流程ID';
COMMENT ON COLUMN ROM_WF_INS_FLOW_TASK.TASK_ID_FROM IS '前置任务ID';
COMMENT ON COLUMN ROM_WF_INS_FLOW_TASK.TASK_ID_TO IS '后置任务ID';


CREATE UNIQUE INDEX IDK1_ROM_WF_INS_FLOW_TASK_ID ON ROM_WF_INS_FLOW_TASK
(INS_ID, FLOW_ID, TASK_ID_FROM, TASK_ID_TO);


/*==============================================================*/
/* Table:  ROM_WF_INS_TASK_GUI 湖北移动分支需求：流程任务坐标表 */
/*==============================================================*/
  
 
DROP TABLE ROM_WF_INS_TASK_GUI CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_INS_TASK_GUI
(
  INS_ID        VARCHAR2(30 BYTE)               NOT NULL,
  FLOW_ID       VARCHAR2(30 BYTE)               NOT NULL,
  TASK_ID       VARCHAR2(30 BYTE)               NOT NULL,
  GUI_X         VARCHAR2(30 BYTE)               NOT NULL,
  GUI_Y         VARCHAR2(30 BYTE)               NOT NULL
);

COMMENT ON COLUMN ROM_WF_INS_TASK_GUI.INS_ID IS '出账实例ID';
COMMENT ON COLUMN ROM_WF_INS_TASK_GUI.FLOW_ID IS '流程ID';
COMMENT ON COLUMN ROM_WF_INS_TASK_GUI.FLOW_ID IS '流程ID';
COMMENT ON COLUMN ROM_WF_INS_TASK_GUI.GUI_X IS 'GUI界面X轴坐标';
COMMENT ON COLUMN ROM_WF_INS_TASK_GUI.GUI_Y IS 'GUI界面Y轴坐标';


CREATE UNIQUE INDEX IDK1_ROM_WF_INS_TASK_GUI ON ROM_WF_INS_TASK_GUI
(INS_ID,FLOW_ID,TASK_ID);


/*==============================================================*/
/* Table:  ROM_WF_INS_FLOW_RUN 湖北移动分支需求：出账实例流程运行信息表 */
/*==============================================================*/
 
DROP TABLE  ROM_WF_INS_FLOW_RUN CASCADE CONSTRAINTS;

CREATE TABLE  ROM_WF_INS_FLOW_RUN
(
  INS_ID      VARCHAR2(30 BYTE)                 NOT NULL,
  FLOW_ID     VARCHAR2(30 BYTE)                 NOT NULL,
  START_TIME  VARCHAR2(14 BYTE)                 NOT NULL,
  END_TIME    VARCHAR2(14 BYTE)                 NOT NULL,
  OP_STATUS   VARCHAR2(1 BYTE)                  NOT NULL,
  OP_TIME     VARCHAR2(14 BYTE)                 NOT NULL
);

COMMENT ON COLUMN  ROM_WF_INS_FLOW_RUN.INS_ID IS '出账实例ID';
COMMENT ON COLUMN  ROM_WF_INS_FLOW_RUN.FLOW_ID IS '流程ID';
COMMENT ON COLUMN  ROM_WF_INS_FLOW_RUN.START_TIME IS '开始时间';
COMMENT ON COLUMN  ROM_WF_INS_FLOW_RUN.END_TIME IS '结束时间';
COMMENT ON COLUMN  ROM_WF_INS_FLOW_RUN.OP_STATUS IS '流程操作状态 0-未开始,1-进行中,2-出错,3-未出错已完成,4-出错已完成';
COMMENT ON COLUMN  ROM_WF_INS_FLOW_RUN.OP_TIME IS '操作时间';


CREATE UNIQUE INDEX  IDK1_ROM_WF_INS_FLOW_RUN_ID ON ROM_WF_INS_FLOW_RUN
(INS_ID, FLOW_ID);


/*==============================================================*/
/* Table:  ROM_WF_INS_TASK_RUN 湖北移动分支需求： 出账实例任务运行信息表 */  
/*==============================================================*/
 
DROP TABLE ROM_WF_INS_TASK_RUN CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_INS_TASK_RUN
(
  INS_ID       VARCHAR2(30 BYTE)                NOT NULL,
  FLOW_ID      VARCHAR2(30 BYTE)                NOT NULL,
  TASK_ID      VARCHAR2(30 BYTE)                NOT NULL,
  ENV_INS_ID  VARCHAR2(30 BYTE)                NOT NULL,
  START_TIME   VARCHAR2(14 BYTE),
  END_TIME     VARCHAR2(14 BYTE),
  OP_STATUS    VARCHAR2(1 BYTE)                 NOT NULL,
  PERCENT      NUMBER(3)                        NOT NULL,
  OP_TIME      VARCHAR2(14 BYTE)                NOT NULL
);

COMMENT ON COLUMN ROM_WF_INS_TASK_RUN.INS_ID IS '出账实例ID';

COMMENT ON COLUMN ROM_WF_INS_TASK_RUN.FLOW_ID IS '流程ID';

COMMENT ON COLUMN ROM_WF_INS_TASK_RUN.TASK_ID IS '任务ID';

COMMENT ON COLUMN ROM_WF_INS_TASK_RUN.ENV_INS_ID IS '主机标识';

COMMENT ON COLUMN ROM_WF_INS_TASK_RUN.START_TIME IS '开始时间';

COMMENT ON COLUMN ROM_WF_INS_TASK_RUN.END_TIME IS '结束时间';

COMMENT ON COLUMN ROM_WF_INS_TASK_RUN.OP_STATUS IS '流程操作状态 0-未开始,1-进行中,2-出错,3-未出错已完成,4-出错已完成';

COMMENT ON COLUMN ROM_WF_INS_TASK_RUN.PERCENT IS '进度，完成百分比；两位整数，如23表示23%';

COMMENT ON COLUMN ROM_WF_INS_TASK_RUN.OP_TIME IS '操作时间';


CREATE UNIQUE INDEX IDK1_ROM_WF_INS_TASK_RUN ON ROM_WF_INS_TASK_RUN
(INS_ID, FLOW_ID, TASK_ID);


/*==============================================================*/
/* Table:  ROM_WF_INS_TASKOP_RUN 湖北移动分支需求：出账实例任务操作信息表 */
/*==============================================================*/
DROP TABLE ROM_WF_INS_TASKOP_RUN CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_INS_TASKOP_RUN
(
  INS_ID       VARCHAR2(30 BYTE)                NOT NULL,
  FLOW_ID      VARCHAR2(30 BYTE)                NOT NULL,
  TASK_ID      VARCHAR2(30 BYTE)                NOT NULL,
  OP_TYPE      VARCHAR2(1 BYTE)                 NOT NULL,
  STATUS       VARCHAR2(1 BYTE)                 NOT NULL, 
  ENV_INS_ID 	VARCHAR(30) not null, -- defalut 'XXX', 
  OP_REMARK    VARCHAR2(100 BYTE),           
  OP_TIME      VARCHAR2(14 BYTE)                NOT NULL,
  OP_LOGIN_NO   VARCHAR2(30 BYTE)               NOT NULL
);

COMMENT ON COLUMN ROM_WF_INS_TASKOP_RUN.INS_ID IS '出账实例ID';

COMMENT ON COLUMN ROM_WF_INS_TASKOP_RUN.FLOW_ID IS '流程ID';

COMMENT ON COLUMN ROM_WF_INS_TASKOP_RUN.TASK_ID IS '任务ID';

COMMENT ON COLUMN ROM_WF_INS_TASKOP_RUN.OP_TYPE IS '操作类型：0-开始 1-停止 2-暂停3-取消 4-重做 5-跳过';

COMMENT ON COLUMN ROM_WF_INS_TASKOP_RUN.STATUS IS  '状态：0-未处理，表示前台把数据插入到后台,A-待处理，已经接收操作任务,B-处理开始,C-处理成功,D-处理失败 ';

COMMENT ON COLUMN ROM_WF_INS_TASKOP_RUN.OP_REMARK IS '备注';

COMMENT ON COLUMN ROM_WF_INS_TASKOP_RUN.OP_TIME IS '操作时间';

COMMENT ON COLUMN ROM_WF_INS_TASKOP_RUN.OP_LOGIN_NO IS '操作工号';


CREATE UNIQUE INDEX IDK1_ROM_WF_INS_TASKOP_RUN ON ROM_WF_INS_TASKOP_RUN
(INS_ID,FLOW_ID,TASK_ID,OP_TYPE);



/*==============================================================*/
/* Table:  ROM_WF_INS_RUN_LOG 湖北移动分支需求：出账实例运行日志表 */
/*==============================================================*/
DROP TABLE ROM_WF_INS_RUN_LOG CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_INS_RUN_LOG
(
  LOG_ID       INTEGER                          NOT NULL,
  INS_ID       VARCHAR2(30 BYTE)                NOT NULL,
  FLOW_ID      VARCHAR2(30 BYTE)                NOT NULL,
  TASK_ID      VARCHAR2(30 BYTE)                NOT NULL,
  LOG_TYPE     VARCHAR2(1 BYTE)                 NOT NULL,
  op_type VARCHAR2(1) not null,
  LOG_INFO     VARCHAR2(1024 BYTE),
  OP_TIME      VARCHAR2(25 BYTE)                NOT NULL,
  OP_LOGIN_NO  VARCHAR2(30 BYTE)                NOT NULL
);

COMMENT ON COLUMN ROM_WF_INS_RUN_LOG.LOG_ID IS '流水ID，使用序列生成';

COMMENT ON COLUMN ROM_WF_INS_RUN_LOG.INS_ID IS '出账实例ID';

COMMENT ON COLUMN ROM_WF_INS_RUN_LOG.FLOW_ID IS '流程ID';

COMMENT ON COLUMN ROM_WF_INS_RUN_LOG.TASK_ID IS '任务ID';

COMMENT ON COLUMN ROM_WF_INS_RUN_LOG.LOG_TYPE IS '0-正常日志记录 ,1-异常日志记录';

COMMENT ON COLUMN ROM_WF_INS_RUN_LOG.LOG_INFO IS '日志信息';

COMMENT ON COLUMN ROM_WF_INS_RUN_LOG.OP_TIME IS '操作时间';

COMMENT ON COLUMN ROM_WF_INS_RUN_LOG.OP_LOGIN_NO IS '操作工号';


CREATE UNIQUE INDEX IDK1_ROM_WF_INS_RUN_LOG ON ROM_WF_INS_RUN_LOG
(LOG_ID);
 
/*==============================================================*/
/* Table:  ROM_WF_HOST_INFO 湖北移动分支需求： 主机信息表    */
/*==============================================================*/

DROP TABLE ROM_WF_HOST_INFO CASCADE CONSTRAINTS;

CREATE TABLE ROM_WF_HOST_INFO
(
  ENV_INS_ID   VARCHAR2(30 BYTE),
  HOST_IP      VARCHAR2(30 BYTE),
  CPU          VARCHAR2(30 BYTE),
  MEM          VARCHAR2(30 BYTE),
  OP_REMARK    VARCHAR2(100 BYTE),
  OP_TIME      VARCHAR2(14 BYTE)
);

COMMENT ON COLUMN ROM_WF_HOST_INFO.ENV_INS_ID IS '主机ID';
COMMENT ON COLUMN ROM_WF_HOST_INFO.HOST_IP IS '主机IP';
COMMENT ON COLUMN ROM_WF_HOST_INFO.CPU IS 'CPU信息';
COMMENT ON COLUMN ROM_WF_HOST_INFO.MEM IS '内存信息';
COMMENT ON COLUMN ROM_WF_HOST_INFO.OP_REMARK IS '操作备注';
COMMENT ON COLUMN ROM_WF_HOST_INFO.OP_TIME IS '操作时间';


CREATE UNIQUE INDEX IDK1_ROM_WF_HOST_INFO ON ROM_WF_HOST_INFO
(ENV_INS_ID);



