

环境搭建说明：
   这是一个包含用户角色管理和功能模块管理的web框架系统， 基于spring+ibatis
  依赖 tomcat mysql
  
  1.  mysql 的数据初始化， 使用 TableCreate_mysql.sql 和 TableInit_mysql.sql 这两个脚本文件，
             文件中可能有部分错误， 手工整理后没有完全验证过
  2.  tomcat的配置， 在conf/Catalina/localhost目录下新加一个文件 rom.xml, 内容如下即可：
    <Context docBase="D:/worksrc/ws2/rom/WebRoot" path="/rom" reloadable="true" />
    根据实际情况修改一下里面的值
  3. web入口： http://localhost:<port>/rom/npage/login/login.htm, 
        初始的用户密码是： admin / 111111