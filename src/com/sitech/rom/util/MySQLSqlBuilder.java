package com.sitech.rom.util;

import com.sitech.jcf.ijdbc.support.DataBaseSqlBuilder;

public class MySQLSqlBuilder implements DataBaseSqlBuilder {

	public String genSql(String sql, int rowskip, int rowmax) {
		if ((rowskip != -2147483648) || (rowmax != 2147483647)){
			System.out.println("++++limit:"+rowskip+"-"+rowmax);
			return String.format("%s limit %d, %d", sql, rowskip, rowskip+rowmax);
		}
		return sql;
	}

	public boolean ignoreCol(String paramString) {
		//return "ROWNUM_".equals(paramString);
		return false;
	}

	public boolean isCursor() {
		return false;
	}

	
	/*
DROP TABLE IF EXISTS sequence;  
CREATE TABLE sequence (  
name              VARCHAR(50) NOT NULL,  
current_value INT NOT NULL,  
increment       INT NOT NULL DEFAULT 1,  
PRIMARY KEY (name)  
) ENGINE=InnoDB;  
 


delimiter //
CREATE function nextval (seq_name VARCHAR(50))
returns integer
MODIFIES SQL DATA 
BEGIN
   declare val integer;
   UPDATE sequence  
   SET          current_value = current_value + increment  
   WHERE name = seq_name;  
   select current_value into val from sequence where name=seq_name;
   return val; 
END//

INSERT INTO sequence VALUES ('seq',1,1); 
	 * @see com.sitech.jcf.ijdbc.support.DataBaseSqlBuilder#sequenceSql(java.lang.String)
	 */
	
	public String sequenceSql(String seqName) {
		return "select nextval('" + seqName + "')";
	}
}
