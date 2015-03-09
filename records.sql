select * from t_paramdata

select * from t_paramtype
select * from rom_sys_role_function
select * from t_paramuser_rel
select * from rom_sys_function


insert into t_paramdata values(3, 13, '11', '11', 0, '0');
insert into t_paramdata values(4, 13, '22', '22', 3, '0');

select * from rom_sys_popedom where function_code='PARAMUSR'



insert into rom_sys_popedom values('PARAMCFG', 'getparamdata.do', '1');
insert into rom_sys_popedom values('PARAMCFG', 'addparamdata.do', '1');
insert into rom_sys_popedom values('PARAMUSR', 'paramusr_main.do', '1');
insert into rom_sys_popedom values('PARAMUSR', 'getparamusr.do', '1');
insert into rom_sys_popedom values('PARAMUSR', 'getparamtree.do', '1');
insert into rom_sys_popedom values('PARAMUSR', 'setparamuser.do', '1');
insert into rom_sys_popedom values('RPTCONF', 'rptconf_main.do', '1');
insert into rom_sys_popedom values('RPTCONF', 'getrpttree.do', '1');
insert into rom_sys_popedom values('RPTCONF', 'addrptgroup.do', '1');
insert into rom_sys_popedom values('RPTCONF', 'modrptgroup.do', '1');
insert into rom_sys_popedom values('RPTCONF', 'delrptgroup.do', '1');

insert into rom_sys_popedom values('RPTCONF', 'addrptdoc.do', '1');
insert into rom_sys_popedom values('RPTCONF', 'modrptdoc.do', '1');
insert into rom_sys_popedom values('RPTCONF', 'delrptdoc.do', '1');
insert into rom_sys_popedom values('RPTCONF', 'adddocparam.do', '1');
insert into rom_sys_popedom values('RPTCONF', 'moddocparam.do', '1');
insert into rom_sys_popedom values('RPTCONF', 'deldocparam.do', '1');
insert into rom_sys_popedom values('RPTCONF', 'getrptparam.do', '1');
insert into rom_sys_popedom values('RPTCONF', 'getparamtree.do', '1');
insert into rom_sys_popedom values('RPTCONF', 'setparamuserex.do', '1');

insert into rom_sys_popedom values('DOC0007', 'getparamtree.do', '1');

-- etl配置部分
insert into rom_sys_popedom values('2204', 'taskresult.do', '1');
insert into rom_sys_popedom values('2204', 'taskresultList.do', '1');
insert into rom_sys_popedom values('2202', 'gotoAddTask.do', '1');
insert into rom_sys_popedom values('2202', 'addTask.do', '1');
insert into rom_sys_popedom values('2202', 'gotoUpdateTask.do', '1');
insert into rom_sys_popedom values('2202', 'updateTask.do', '1');
insert into rom_sys_popedom values('2202', 'delTask.do', '1');
insert into rom_sys_popedom values('2205', 'gotoUpdateDBConn.do', '1');

select * from etl_job_msg


delete from rom_sys_popedom where function_code='2204' and action_name='addTask.do'

/*新增模块需要下面3个表插入数据*/
insert into rom_sys_pro_function(pro_code, function_code, remarks)
	values('P001', 'RPTCONF', ' ');
insert into rom_sys_function(function_code, function_name, action_name, node_type,, parent_code, operation_code, remarks, note_seq, open_type)
	values('RPTCONF', '报表配置', '../rptcfg_main.do', '0', 'RPTCFG', '1;2;3;4;', null, null, '1');
insert into rom_sys_role_function(role_id, function_code, operation_code)
	values(5, 'RPTCONF', '1;2;3;');

create index idx1_paramdata on t_paramdata(parentid);

select nextval('paramdata')

update rom_sys_function set function_name='参数与用户关联' where function_code='PARAMUSR';

insert into t_paramuser_rel value(18, 'abc');

select a.paramid, a.login_no loginno, b.login_name loginname, d.name typename, c.typeid typeid, c.paramName, c.paramValue
 from t_paramuser_rel a, rom_sys_login b, t_paramdata c, t_paramtype d
where a.login_no=b.login_no and a.paramid=c.paramid and c.typeid=d.typeid


select a.paramid, typeid, paramValue, paramName, parentid, remarks, b.login_no
	from t_paramdata a 
	left outer join t_paramuser_rel b on a.paramid=b.paramid and b.login_no='abc'
		where typeid=16
		order by parentid, paramid

select * from rom_login_role_relation
select * from rom_sys_role_function
select * from rom_sys_pro_function
select * from rom_sys_login
select * from rom_sys_role
select * from rom_pro_code

select a.function_code, a.function_name, a.action_name, a.parent_code, a.operation_code, e.pro_code 
from rom_sys_function a, rom_login_role_relation b, rom_sys_role_function c, rom_sys_role d, rom_sys_pro_function e
where c.function_code=a.function_code and c.role_id=b.role_id and b.role_id=d.role_id and e.pro_code=e.pro_code
and e.function_code=a.function_code
and b.login_no='abc'
order by e.pro_code, parent_code, function_code

delete from rom_sys_function where function_code='DOCG0000011'

select * from rom_sys_function where parent_code='RPTROOT'
select * from rom_sys_function where function_code like 'DOC%'
select * from rom_sys_pro_function where pro_code='P001' and function_code like 'DOC%'
select * from rom_sys_role_function where function_code like 'DOC%'

insert into t_parameters values('doc.defaultaction', '../rptdoc_main.do', '报表文档查看的control名称，所有的报表都是用这个');

select nextval('t_doc') as value

select * from t_doc
select * from t_docparam
select * from t_paramtype
select * from t_parameters
select * from t_paramuser_rel
select * from t_paramuser_rel_ex


insert into t_paramtype values(0, '[手工输入]', 'String', '初始化生成你');

insert into t_parameters values('sapbo.redtree', 'redtree1:6400;test1;1qaz2wsx', 'bo登录参数');
update t_parameters set pvalue='rptdoc_main.do,getparamtree.do' where pname='doc.popedoms'

update t_docparam set allowchange=1

alter table t_docparam add allowchange int comment '是否允许修改参数值，为0的话，则查看报表时不显示该参数'


select a.paramid, a.typeid, paramValue, paramName, parentid, remarks, b.login_no as loginno
	from t_paramdata a 
	left outer join t_paramuser_rel b on a.paramid=b.paramid and b.login_no='abc'
		where a.typeid=16
		
select a.paramid, b.paramValue
 from t_paramuser_rel a, t_paramdata b
where a.login_no='abc' and a.paramid=b.paramid and a.typeid=11

select a.paramid, b.paramValue, a.ex_flag
 from t_paramuser_rel_ex a, t_paramdata b
where a.login_no='abc' and a.paramid=b.paramid and a.typeid=11 and a.docid=17

insert into etl_job_log values
('2014121213344418291','20141212',1001,'20141212101010','20141212101010','1','成功');

select * from rom_sys_function where function_code='BOCONF'
delete from t_paramtype where typeid=0
update t_doc set boid=373

INSERT INTO `rom_sys_function` VALUES ('BOCONF', 'BO服务器配置', '../boservermain.do', '0', 'RPTCFG', '1;2;3;', NULL, NULL, '1');
select * from t_paramuser_rel