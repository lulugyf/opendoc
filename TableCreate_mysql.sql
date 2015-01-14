/*======================================================================================*/
/* 维护操作平台oracle数据库建表语句，默认表空间(OBOSS_DATA)和索引表空间(OBOSS_IDX)请根据*/
/*实际情况修改本脚本.在建立数据库对象之前会先删除该对象，仅用于初始化数据库，一次性使用 */
/*======================================================================================*/


/*==============================================================*/
/* SEQUENCE: SEQ_EXPAND             扩展信息表用的序列                        */
/*==============================================================*/
DROP TABLE IF EXISTS rom_sequence;  
CREATE TABLE rom_sequence (  
name              VARCHAR(50) NOT NULL,  
current_value bigint NOT NULL,  
increment       bigint NOT NULL DEFAULT 1,  
PRIMARY KEY (name)  
) ENGINE=InnoDB;

insert into rom_sequence values('SEQ_EXPAND', 1, 1);
insert into rom_sequence values('SEQ_COMMON', 1, 1);
insert into rom_sequence values('SEQ_HOSTCHECK', 1, 1);

delimiter //
CREATE function nextval (seq_name VARCHAR(50))
returns bigint
MODIFIES SQL DATA 
BEGIN
   declare val bigint;
   UPDATE rom_sequence  SET  current_value = current_value + increment  
   WHERE name = seq_name;  
   if ROW_COUNT() < 1 then
	insert into rom_sequence values(seq_name, 1, 1);
	return 1;
   else
     select current_value into val from rom_sequence where name=seq_name;
     return val;
   end if;
END//
delimiter ;

/*==============================================================*/
/* Table: ROM_CRON_TASK_CONF      定时任务配置表                */
/*==============================================================*/
-- drop table
drop table if exists ROM_CRON_TASK_CONF;
-- Create table
create table ROM_CRON_TASK_CONF
(
  task_id       INTEGER,
  pro_code      VARCHAR(8) not null comment '产品编码',
  func_code     VARCHAR(8) not null comment '功能代码',
  scripts_id    INTEGER not null   comment '脚本编码',
  begin_time    DATETIME,
  end_time      DATETIME,
  interval_time INTEGER   comment '任务执行间隔',
  next_run_time DATE,
  task_state    CHAR(1)   comment '任务执行状态 0：未执行；1：正在执行；2：执行完成',
  user_flag     CHAR(1),
  remark        VARCHAR(2048),
  primary key (PRO_CODE, FUNC_CODE, SCRIPTS_ID)
) ;

/*==============================================================*/
/* Table: ROM_CRON_TASK_DATA      定时任务执行结果表            */
/*==============================================================*/
drop table if exists ROM_CRON_TASK_DATA;
-- Create table
create table ROM_CRON_TASK_DATA
(
  task_id        INTEGER,
  create_date    DATE,
  item_name      VARCHAR(64) comment '结果项名称',
  item_desc      VARCHAR(64) comment '结果项描述',
  item_data      VARCHAR(8)  comment '结果项数据',
  item_dimension VARCHAR(8)  comment '结果项单位',
  remark         VARCHAR(2048)
) ;

/*==============================================================*/
/* Table: ROM_SCRIPTS_CONFIG     远程脚本配置表                 */
/*==============================================================*/
drop table ROM_SCRIPTS_CONFIG;
create table ROM_SCRIPTS_CONFIG
(
  scripts_id   INTEGER not null,
  host_id      INTEGER,
  scripts_dir  VARCHAR(256),
  scripts_name VARCHAR(512),
  scripts_type CHAR(1),
  req_url      VARCHAR(128),
  visit_user   VARCHAR(8),
  visit_pswd   VARCHAR(128),
  remarks      VARCHAR(2048),
  primary key (SCRIPTS_ID)
) ;


 
 
/*==============================================================*/
/* Table: ROM_LOGIN_ROLE_RELATION     工号角色关系表            */
/*==============================================================*/
drop table if exists ROM_LOGIN_ROLE_RELATION;
-- Create table
create table ROM_LOGIN_ROLE_RELATION
(
  login_no VARCHAR(8) not null,
  role_id  INTEGER not null,
  remarks  VARCHAR(256),
  primary key (LOGIN_NO, ROLE_ID)
) ;

/*==============================================================*/
/* Table: ROM_OPERA_CODE     操作编码表 
'操作代码,1：新增
2：删除
3：修改
4：赋权
5：启动或停止
6：文件上传下载'                        */
/*==============================================================*/
drop table if exists ROM_OPERA_CODE;
create table ROM_OPERA_CODE
(
  opera_code VARCHAR(2) not null,
  opera_name VARCHAR(64),
  remarks    VARCHAR(256),
  primary key (OPERA_CODE)
) ;


/*==============================================================*/
/* Table: ROM_PROVINCE_CODE      省份代码表                     */
/*==============================================================*/
drop table if exists ROM_PROVINCE_CODE;
create table ROM_PROVINCE_CODE
(
  province_code VARCHAR(3),
  province_name VARCHAR(64),
  remarks       VARCHAR(256),
  primary key (province_code)
) ;


/*==============================================================*/
/* Table: ROM_PRO_CODE   产品代码表                             */
/*==============================================================*/
drop table if exists ROM_PRO_CODE;
create table ROM_PRO_CODE
(
  pro_code    VARCHAR(8) not null,
  pro_name    VARCHAR(64),
  pro_version VARCHAR(10),
  remarks     VARCHAR(256),
  primary key (PRO_CODE)
) ;

/*==============================================================*/
/* Table: ROM_SYS_FUNCTION    系统功能表                        */
/*==============================================================*/
drop table ROM_SYS_FUNCTION;
create table ROM_SYS_FUNCTION
(
  function_code  VARCHAR(64) not null,
  function_name  VARCHAR(64),
  action_name    VARCHAR(1024),
  node_type      CHAR(1),
  parent_code    VARCHAR(8),
  operation_code VARCHAR(32),
  remarks        VARCHAR(256),
  note_seq       INTEGER default 0,
  open_type char(1),
  primary key (FUNCTION_CODE)
) ;

/*==============================================================*/
/* Table: ROM_SYS_LOGIN    系统工号表                           */
/*==============================================================*/
drop table ROM_SYS_LOGIN;
create table ROM_SYS_LOGIN
(
  login_no    VARCHAR(8) not null,
  login_name  VARCHAR(64),
  login_pwd   VARCHAR(128),
  use_flg     CHAR(1),
  expire_time DATE,
  login_flg   CHAR(1),
  phone_no    VARCHAR(15),
  login_ip    VARCHAR(128),
  remark      VARCHAR(64),
  province_code VARCHAR(4),
  primary key (LOGIN_NO)
) ;


/*==============================================================*/
/* Table: ROM_SYS_OP_LOG   操作日志表                           */
/*==============================================================*/
drop table ROM_SYS_OP_LOG;
create table ROM_SYS_OP_LOG
(
  op_date       VARCHAR(8),
  op_staff      VARCHAR(64),
  staff_name    VARCHAR(64),
  pro_code      VARCHAR(8),
  function_code VARCHAR(8),
  op_time       DATE,
  op_content    VARCHAR(1024),
  remarks       VARCHAR(256)
) ;
create index PK_OP_DATE_OP_LOG on ROM_SYS_OP_LOG (OP_DATE);

/*==============================================================*/
/* Table: ROM_SYS_POPEDOM     权限注册表                        */
/*==============================================================*/
drop table if exists ROM_SYS_POPEDOM;
create table ROM_SYS_POPEDOM
(
  function_code  VARCHAR(8) not null,
  action_name    VARCHAR(256) not null comment '功能点url',
  operation_code VARCHAR(32)
) ;
create index pk_ROM_SYS_POPEDOM on ROM_SYS_POPEDOM(function_code, action_name);
create index IDX_ROM_SYS_POPEDOM on ROM_SYS_POPEDOM (FUNCTION_CODE);

/*==============================================================*/
/* Table: ROM_SYS_PRO_FUNCTION    产品功能关系表                */
/*==============================================================*/
drop table ROM_SYS_PRO_FUNCTION;
create table ROM_SYS_PRO_FUNCTION
(
  pro_code      VARCHAR(8) not null,
  function_code VARCHAR(8) not null,
  remarks       VARCHAR(256),
  primary key (PRO_CODE, FUNCTION_CODE)
) ;

/*==============================================================*/
/* Table: ROM_SYS_ROLE                    角色信息表            */
/*==============================================================*/  
drop table ROM_SYS_ROLE;
create table ROM_SYS_ROLE
(
  role_id       INTEGER not null,
  role_name     VARCHAR(64),
  role_type     CHAR(1),
  role_state    CHAR(1),
  pro_code      VARCHAR(8),
  province_code VARCHAR(3),
  tell_type     CHAR(1),
  remarks       VARCHAR(256),
  primary key (ROLE_ID)
) ;


/*==============================================================*/
/* Table: ROM_SYS_ROLE_FUNCTION       角色功能关系表            */
/*==============================================================*/
drop table ROM_SYS_ROLE_FUNCTION;
create table ROM_SYS_ROLE_FUNCTION
(
  role_id        INTEGER not null,
  function_code  VARCHAR(8) not null,
  operation_code VARCHAR(32) not null,
  primary key (ROLE_ID, FUNCTION_CODE, OPERATION_CODE)
) ;
create index IDX_ROM_SYS_ROLE_FUNCTION on ROM_SYS_ROLE_FUNCTION (ROLE_ID);

/*==============================================================*/
/* Table: ROM_TELLCORP_CODE  运营商代码表                       */
/*==============================================================*/
drop table ROM_TELLCORP_CODE;
create table ROM_TELLCORP_CODE
(
  tellcorp_code VARCHAR(1),
  tellcorp_name VARCHAR(64),
  remarks       VARCHAR(256),
  primary key (tellcorp_code)
) ;


ALTER TABLE ROM_LOGIN_ROLE_RELATION CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ROM_OPERA_CODE CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ROM_PROVINCE_CODE CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ROM_PRO_CODE CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ROM_SYS_FUNCTION CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ROM_SYS_LOGIN CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ROM_SYS_OP_LOG CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ROM_SYS_POPEDOM CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ROM_SYS_PRO_FUNCTION CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ROM_SYS_ROLE CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ROM_SYS_ROLE_FUNCTION CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ROM_TELLCORP_CODE CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


/*
** deleted:
Table: ONEBOSS_BUSIGRO_RELATION    一级BOSS业务与分组关系表
Table: ONEBOSS_BUSI_GROUPS               一级BOSS业务分组表 
Table: ONEBOSS_BUSI_NOTES               一级BOSS交易节点表 
Table: ROM_CRON_DATA_REPORT            重点业务监控报表
Table: ROM_FTPSITES_INFO      FTP站点表
Table: ROM_FTP_SCRIPT_RELATION      FTP远程脚本关系表
Table: ROM_HOST_INFO      远程主机管理表
Table: ROM_PRO_FTPSITE_RELATION      产品FTP站点关系表
Table: ROM_PRO_HOST_RELATION  产品远程主机关系表
Table: ROM_USER_INFO      远程用户管理表
Table: EAI_APP_RULES       APPID规则表
Table: EAI_BUS_ADAPT_RELATION       总线与适配器关系表
Table: EAI_CONF_INST_RELATION       EAI配置实例关系表
Table: EAI_NODES_CONFINFO       EAI节点配置信息表
Table: EAI_NODES_INSTANCE       EAI节点实例表
Table: ROM_DAYMONITOR_CONF       日常巡检项目定义表
Table: ROM_DAYMONITOR_DATA       日常巡检项目实例表
Table: ROM_BUSICHECK_DATA       进程监控实例表
Table: ROM_NETCELL_INFO       网元信息表
Table: ROM_EXPAND_CODE       扩展属性代码表
Table: ROM_EXPAND_INFO       扩展属性实例表
Table:  ROM_BUSICHECK_CONF      业务监控配置表
Table:  CMSWORKORDERSAVERULE      网元与网元日志表的对应关系配置表   
Table:  ROM_OBSMONITOR_CFG      山西业支需求：显示异常金额或频次的交易核查记录或监控记录；该表是监控策略的配置表
Table:  WOBSPANPROVOPRALL      山西业支需求：显示异常金额或频次的交易核查记录或监控记录；该表是要查询的数据来源表 
ROM_COPYTABLE_HOST
TABLE ROM_COPYTABLE_ALL IS '全量同步表关系配置表';
TABLE ROM_COPYTABLE_ADD IS '全量增量同步查询配置表';
TABLE ROM_BUSICHECK_DATA IS '进程监控表';
Table:  ROM_DATASCRIPT_CONFIG 山西业支需求： 脚本提取数据配置表
Table:  ROM_DATASQL_CONFIG 山西业支需求：SQL提取数据配置表
Table:  ROM_DATATITLE_CONFIG 山西业支需求：数据库标识配置表
Table:  ROM_WF_PRODUCT 湖北移动分支需求： 产品信息表
Table:  ROM_WF_TASK 湖北移动分支需求： 任务信息表
Table:  ROM_WF_TASK 湖北移动分支需求： 任务信息表
Table:  ROM_WF_TASK 湖北移动分支需求：             任务操作表
Table:  ROM_WF_FLOW 湖北移动分支需求： 流程表
Table:  ROM_WF_FLOW_TASK 湖北移动分支需求： 流程任务关系表
Table:  ROM_WF_FLOW_TASK_GUI 湖北移动分支需求： 流程任务坐标表
Table:  ROM_WF_TEMPLATE 湖北移动分支需求： 模板信息表
Table:  ROM_WF_TEMPLATE_FLOW 湖北移动分支需求： 出账模板流程关系表
Table:  ROM_WF_TEMPLATE_FLOW_GUI 湖北移动分支需求： 出账模板流程坐标表
Table:  ROM_WF_INS 湖北移动分支需求： 实例信息表
Table:  ROM_WF_INS_FLOW_REL 湖北移动分支需求： 出账实例流程表
Table:  ROM_WF_INS_FLOW 湖北移动分支需求： 出账实例流程关系表
Table:  ROM_WF_INS_FLOW_GUI 湖北移动分支需求： 出账实例流程坐标表
Table:  ROM_WF_INS_FLOW_TASK 湖北移动分支需求：出账实例流程任务表
Table:  ROM_WF_INS_TASK_GUI 湖北移动分支需求：流程任务坐标表
Table:  ROM_WF_INS_FLOW_RUN 湖北移动分支需求：出账实例流程运行信息表
Table:  ROM_WF_INS_TASK_RUN 湖北移动分支需求： 出账实例任务运行信息表
Table:  ROM_WF_INS_TASKOP_RUN 湖北移动分支需求：出账实例任务操作信息表
Table:  ROM_WF_INS_RUN_LOG 湖北移动分支需求：出账实例运行日志表
Table:  ROM_WF_HOST_INFO 湖北移动分支需求： 主机信息表

*/

drop table if exists t_dbconns;
create table t_dbconns(
  label varchar(60) primary key, 
  host varchar(64) not null,
  user varchar(32) not null, 
  pswd varchar(64) not null,
  db varchar(64),
  dbtype varchar(20) not null,
  remarks varchar(128)
);

create table t_dbtypes(
  dbtype varchar(20) primary key
);
insert into t_dbtypes values('mysql');
insert into t_dbtypes values('oracle');
insert into t_dbtypes values('sybase');
insert into t_dbtypes values('mssql');





-- 报表参数类型
drop table if exists t_paramtype;
create table t_paramtype(
   typeid int primary key,
   name varchar(60) comment '名称',
   datatype varchar(10) comment '数据类型  String Long Float Date',
   remarks varchar(128) null  comment '备注'
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE t_paramtype CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 参数数据表， 以树形表达参数的递归关系
drop table if exists t_paramdata;
create table t_paramdata(
   paramid int comment '使用序列产生， 不重复',
   typeid int  comment 'referenced by t_paramtype.typeid',
   paramValue varchar(128) comment '参数值，如区域编码， 部门编码',
   paramName  varchar(60) comment '参数名称， 如区域名称， 部门名称等',
   parentid int comment '上级id， 0为root',
   remarks varchar(60) comment '参数值',
   primary key (paramid, typeid)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
create index idx1_paramdata on t_paramdata(parentid);

-- 参数值与登录用户(ROM_SYS_LOGIN)关系表
drop table if exists t_paramuser_rel;
create table t_paramuser_rel
(
	typeid int comment '参数类型id',
	paramid int comment '参数id，因为在参数表中paramid是唯一的， 所以没有加入 typeid',
	login_no varchar(8),
	primary key (paramid, login_no)
);

alter table t_paramuser_rel add typeid int comment '参数类型id' default 0;

-- 参数值与登录用户(ROM_SYS_LOGIN) 及 报表（t_doc）关系表 ， 这个与t_paramuser_rel相对而言的例外设置， 有这个配置时， 可对默认的关系做补充
drop table if exists t_paramuser_rel_ex;
create table t_paramuser_rel_ex
(
	docid  int  comment '报表id',
	typeid int comment '参数类型id',
	paramid int comment '参数id',
	login_no varchar(8) comment '登录工号',
	ex_flag char(1) comment '例外方式，1为添加 0为排除',
	primary key (paramid, login_no)
) comment '参数值与登录用户(ROM_SYS_LOGIN) 及 报表（t_doc）关系表 ， 这个与t_paramuser_rel相对而言的例外设置， 有这个配置时， 可对默认的关系做补充';
create index idx1_t_paramuser_rel_ex on t_paramuser_rel_ex(docid, typeid);

/*参数配置, 保存部分配置参数*/
drop table if exists t_parameters;
create table t_parameters(
	pname varchar(64) primary key,
	pvalue varchar(128) not null,
	remarks varchar(64)
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- bo服务器的地址 以及用户名密码配置， 以 sapbo.为前缀的key, value的格式为：  server:port;user;password

insert into t_parameters values('sap.user', 'test1', 'sap登录用户名');
insert into t_parameters values('sap.password', '1qaz2wsx', 'sap登录密码');
insert into t_parameters values('sap.cmsport', 'redtree1:6400', 'sap的cms地址');

insert into t_parameters values('doc.basefunc', 'RPTROOT', '报表挂载的功能树根节点');
insert into t_parameters values('doc.defaultrole', 'report1', '增加产品树时使用默认的用户角色');
insert into t_parameters values('doc.defaultaction', '../rptdoc_main.do', '报表文档查看的control名称，所有的报表都是用这个');
insert into t_parameters values('doc.popedoms', 'rptdoc_main.do,getparamtree.do', '报表访问需要设置的control名称，多个以,分隔');


/*SAP open document 报表配置表
报表的展示为两级， 有一层分组， 暂不支持多级分组
*/
drop table if exists t_doc;
create table t_doc(
	docid int primary key,
	group_func  varchar(64) comment '报表所属功能分组的功能代码',
	function_code  VARCHAR(64) comment '对应功能树的代码',
	docname varchar(60) comment '报表名称',
	baseurl varchar(256) comment 'url of open document, include document id',
	
	boid int null comment '对应 t_boserver 中的boid',
	opendocid varchar(64) null comment 'sap文档id',
	remarks varchar(60) comment '备注'
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
create index idx1_t_doc on t_doc(function_code);


/*报表参数， 需要在报表展示的url中拼入的参数*/
drop table if exists t_docparam;
create table t_docparam(
	docid int,
	param varchar(40)          comment '拼在url里的参数名称',
	default_value varchar(60)  comment '参数默认值',
	typeid int comment 'referenced by t_paramtype.typeid, 参数类型， 如果为0，则为手工输入',
	allowchange int DEFAULT '1' comment '是否允许修改参数值，为0的话，则查看报表时不显示该参数',
	filterflag char    comment '是否根据登录用户过滤可选参数值 1-yes， 0-no',
	remarks varchar(60)   comment '备注'
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
create index idx_docparam1 on t_docparam(docid);




/*==============================================================*/
/* Table: etl_host_msg      数据源Host配置表                    */
/*==============================================================*/
-- drop table
drop table if exists etl_host_msg;
-- Create table
create table etl_host_msg
(
order_id  int primary key comment '连接序号',
serv_ip	  varchar(20) comment '数据库IP',
serv_name varchar(20) comment '主机名',
serv_user varchar(20) comment '主机用户名',
serv_pwd  varchar(20) comment '主机密码',
db_type 	varchar(10) comment '源数据库类型',
db_name	  varchar(20) comment '数据库名',
db_port	  int comment '数据库端口',
db_user 	varchar(20) comment '数据库用户名',
db_pwd 	  varchar(20) comment '数据库密码',
data_dir  varchar(50) comment '导出数据文件路径'
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


/*==============================================================*/
/* Table: etl_job_msg      作业配置表                   */
/*==============================================================*/
-- drop table
drop table if exists etl_job_msg;
-- Create table
create table etl_job_msg
(
job_id	      int primary key comment '作业ID，从1001开始编号',
job_name	    varchar(20) comment '作业名称',
job_mode      char(1) comment '作业类型，日作业：D，月作业：M，实时作业：S',
job_run_freq	int comment '运行频次  0：不限制，其余数字代表最多运行次数，如果是定时，一般配置为1，实时配置为0',
job_run_mode	char(1) comment '定时方式  1:定时，2：实时   目前不用',
job_enable	  char(1) comment '可否运行标志 0：不可运行，1：可运行',
job_type	    char(1) comment '运行类型  0:全量，1：增量',
job_run_time	varchar(14) comment '配置作业开始运行时间，如果是日作业，格式为：103000,即上午10：30，月作业格式为01103000，即每月1号上午10:30，如果是实时，则为间隔时间，以秒为单位',
h_order_id    int comment '作业对应的数据库主机连接配置',
s_tab         varchar(20) comment '导出的数据源表',
d_tab         varchar(20) comment '导入的目的表',
etl_sql       varchar(2000) comment '导出语句'
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


/*==============================================================*/
/* Table: etl_job_log      作业日志表                   */
/*==============================================================*/
-- drop table
drop table if exists etl_job_log;
-- Create table
create table etl_job_log
(
job_seq      varchar(20) primary key comment '作业执行序列',
op_date      varchar(8) comment '作业执行日期yyyymmdd',
job_id       int comment '作业ID',
start_time   varchar(14) comment '作业开始时间',
end_time     varchar(14) comment '作业结束时间',
run_status   char(1) comment '作业运行状态，0：等待运行，1：开始导出，2：导出成功，3：导出失败，4，开始导入，5：导入成功，6：导入失败',
run_msg      varchar(2000) comment '作业运行情况说明 '         
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- etl配置部分
insert into rom_sys_popedom values('2204', 'taskresult.do', '1');
insert into rom_sys_popedom values('2204', 'taskresultList.do', '1');
insert into rom_sys_popedom values('2202', 'gotoAddTask.do', '1');
insert into rom_sys_popedom values('2202', 'addTask.do', '1');
insert into rom_sys_popedom values('2202', 'gotoUpdateTask.do', '1');
insert into rom_sys_popedom values('2202', 'updateTask.do', '1');
insert into rom_sys_popedom values('2202', 'delTask.do', '1');
insert into rom_sys_popedom values('2205', 'gotoUpdateDBConn.do', '1');





---------------------------------
----  update  2015-1-10
alter table t_doc add	boid int null comment '对应 t_boserver 中的boid';
alter table t_doc add	opendocid varchar(64) null comment 'sap文档id';
/*
增加配置模块
RPTCFG 下： BOCONF (BO服务器配置)
INSERT INTO `rom_sys_function` VALUES ('BOCONF', 'BO服务器配置', '../boservermain.do', '0', 'RPTCFG', '1;2;3;', NULL, NULL, '1');
权限配置：
addBOServer.do 	BOCONF 	1	
boserverList.do 	BOCONF 	新增 	
boservermain.do 	BOCONF 	新增 	
delBOServer.do 	BOCONF 	新增 	
gotoAddBOServer.do 	BOCONF 	新增 	
gotoUpdateBOServer.do 	BOCONF 	新增 	
updateBOServer.do 	BOCONF 	新增
*/

/*
  BO服务器配置参数， 包括密码验证服务器端口
*/
create table t_boserver(
  boid int primary key,
  boname varchar(64) comment '命名',
  authaddr varchar(64) comment '密码验证地址, 如： redtree1:6400',
  username varchar(64) comment '用户名',
  password varchar(64) comment '密码',
  opendocaddr varchar(64) comment '文档地址端口, 如 redtree1:8080',
  remarks varchar(60)  comment '备注'
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

delete from t_paramtype where typeid=0;

truncate table t_docparam;
ALTER TABLE `t_docparam`
ADD COLUMN `paramid`  int(10) NOT NULL FIRST ,
ADD COLUMN `pnametype`  varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL COMMENT '拼在参数名称前面的值，lsS：单值,，lsM：多值 ，lsR：范围' AFTER `docid`,
ADD PRIMARY KEY (`paramid`);