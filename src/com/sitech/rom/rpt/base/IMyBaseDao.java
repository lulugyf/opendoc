package com.sitech.rom.rpt.base;


import java.sql.Connection;
import java.util.List;
import java.util.Map;

public abstract interface IMyBaseDao
{
  public abstract IMyBaseDao getBaseDaoImpl();

  public abstract void setBaseDaoImpl(IMyBaseDao paramIBaseDao);

  public abstract Connection getConnection();

  public abstract String getSeq(String paramString);

  public abstract Object insert(String paramString);

  public abstract Object insert(String paramString, Object paramObject);

  public abstract int update(String paramString);

  public abstract int update(String paramString, Object paramObject);

  public abstract int delete(String paramString);

  public abstract int delete(String paramString, Object paramObject);

  public abstract Object queryForObject(String paramString);

  public abstract Object queryForObject(String paramString, Object paramObject);

  public abstract Object queryForObject(String paramString, Object paramObject1, Object paramObject2);

  public abstract List queryForList(String paramString);
  
  public abstract List queryForPageList(String paramString, Object paramObject);

  public abstract List queryForList(String paramString, Object paramObject);

  public abstract Map queryForPagingList(String sqlid, int rowskip, int rowmax);

  public abstract Map queryForPagingList(String sqlid, Object param, int rowskip, int rowmax);
  
  public abstract List queryForLimitList(String sqlid, int rowskip, int rowmax);

  public abstract List queryForLimitList(String sqlid, Object param, int rowskip, int rowmax);
  
  public abstract long nextval(String name);
  public abstract int count(String sqlid, Object param);
  
}