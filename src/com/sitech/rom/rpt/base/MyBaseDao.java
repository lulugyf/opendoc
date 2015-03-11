package com.sitech.rom.rpt.base;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapException;
import com.ibatis.sqlmap.client.SqlMapExecutor;
import com.ibatis.sqlmap.engine.impl.ExtendedSqlMapClient;
import com.ibatis.sqlmap.engine.impl.SqlMapExecutorDelegate;
import com.sitech.jcf.core.ErrorCode;
import com.sitech.jcf.core.exception.AppException;
import com.sitech.jcf.core.ibatis.CountStatementUtil;
import com.sitech.jcf.ijdbc.SqlFind;
import com.sitech.jcf.ijdbc.support.SqlBuilderFactory;
import com.sitech.jcf.ijdbc.util.DataSourceUtils;
import com.sitech.rom.rpt.bo.MyBaseBO;

@Repository("myBaseDao")
public class MyBaseDao extends AutowiringSqlMapClientDaoSupport implements IMyBaseDao {
	protected static final Log log = LogFactory.getLog(MyBaseDao.class);

	public IMyBaseDao getBaseDaoImpl() {
		throw ErrorCode.ne(AppException.class, "930216",
				new String[] { "getBaseDaoImpl" });
	}

	public void setBaseDaoImpl(IMyBaseDao paramIBaseDao) {
		throw ErrorCode.ne(AppException.class, "930216",
				new String[] { "setBaseDaoImpl" });
	}

	public Connection getConnection() {
		return DataSourceUtils.getConnection(super.getDataSource());
	}

	@Override
	public long nextval(String name){
		Object o = this.queryForObject("rptparam.nextval", name);
		if(o instanceof Long){
			return (Long)o;
		}else{
			return -1;
		}
    }
	
	@Override
	public int count(String sqlid, Object param){
		Object o = this.queryForObject(sqlid, param);
		if(o instanceof Long){
			return (int)((Long)o).longValue();
		}
		if(o instanceof Integer){
			return ((Integer)o).intValue();
		}else{
			return -1;
		}
	}
	
	public String getSeq(String paramString) {
		Connection localConnection = null;
		try {
			localConnection = getConnection();
			SqlFind localSqlFind = new SqlFind();
			String str1 = localSqlFind.findString(localConnection,
					SqlBuilderFactory.newInstance().sequenceSql(paramString));
			DataSourceUtils.commit(localConnection);
			String str2 = str1;
			return str2;
		} catch (AppException localAppException) {
			throw localAppException;
		} catch (Exception localException) {
			DataSourceUtils.rollback(localConnection);
			throw ErrorCode.ne(AppException.class, localException, "930215",
					new String[] { paramString, localException.getMessage() });
		} finally {
			DataSourceUtils.closeConnection(localConnection);
		}
	}

	public Object insert(String paramString) {
		return insert(paramString, null);
	}

	public Object insert(String paramString, Object paramObject) {
		try {
			if ((log.isDebugEnabled()) && (paramObject != null))
				log.debug(paramObject.toString());
			return getSqlMapClientTemplate().insert(paramString, paramObject);
		} catch (Throwable localThrowable1) {
			if ((localThrowable1 instanceof SQLException))
				throw ErrorCode.ne(
						AppException.class,
						localThrowable1,
						"931100",
						new String[] { paramString,
								localThrowable1.getMessage() });
			for (Throwable localThrowable2 = localThrowable1.getCause(); localThrowable2 != null; localThrowable2 = localThrowable2
					.getCause())
				if ((localThrowable2 instanceof SQLException))
					throw ErrorCode.ne(AppException.class, localThrowable1,
							"931100", new String[] { paramString,
									localThrowable2.getMessage() });
			throw ErrorCode.ne(AppException.class, localThrowable1, "931100",
					new String[] { paramString, localThrowable1.getMessage() });
		}
	}

	public int update(String paramString) {
		return update(paramString, null);
	}

	public int update(String paramString, Object paramObject) {
		try {
			if ((log.isDebugEnabled()) && (paramObject != null))
				log.debug(paramObject.toString());
			return getSqlMapClientTemplate().update(paramString, paramObject);
		} catch (Throwable localThrowable1) {
			if ((localThrowable1 instanceof SQLException))
				throw ErrorCode.ne(
						AppException.class,
						localThrowable1,
						"931200",
						new String[] { paramString,
								localThrowable1.getMessage() });
			for (Throwable localThrowable2 = localThrowable1.getCause(); localThrowable2 != null; localThrowable2 = localThrowable2
					.getCause())
				if ((localThrowable2 instanceof SQLException))
					throw ErrorCode.ne(AppException.class, localThrowable1,
							"931200", new String[] { paramString,
									localThrowable2.getMessage() });
			throw ErrorCode.ne(AppException.class, localThrowable1, "931200",
					new String[] { paramString, localThrowable1.getMessage() });
		}
	}

	public int delete(String paramString) {
		return delete(paramString, null);
	}

	public int delete(String paramString, Object paramObject) {
		try {
			if ((log.isDebugEnabled()) && (paramObject != null))
				log.debug(paramObject.toString());
			return getSqlMapClientTemplate().delete(paramString, paramObject);
		} catch (Throwable localThrowable1) {
			if ((localThrowable1 instanceof SQLException))
				throw ErrorCode.ne(
						AppException.class,
						localThrowable1,
						"931300",
						new String[] { paramString,
								localThrowable1.getMessage() });
			for (Throwable localThrowable2 = localThrowable1.getCause(); localThrowable2 != null; localThrowable2 = localThrowable2
					.getCause())
				if ((localThrowable2 instanceof SQLException))
					throw ErrorCode.ne(AppException.class, localThrowable1,
							"931300", new String[] { paramString,
									localThrowable2.getMessage() });
			throw ErrorCode.ne(AppException.class, localThrowable1, "931300",
					new String[] { paramString, localThrowable1.getMessage() });
		}
	}

	public Object queryForObject(String paramString) {
		try {
			return getSqlMapClientTemplate().queryForObject(paramString, null);
		} catch (Throwable localThrowable1) {
			if ((localThrowable1 instanceof SQLException))
				throw ErrorCode.ne(
						AppException.class,
						localThrowable1,
						"931400",
						new String[] { paramString,
								localThrowable1.getMessage() });
			for (Throwable localThrowable2 = localThrowable1.getCause(); localThrowable2 != null; localThrowable2 = localThrowable2
					.getCause())
				if ((localThrowable2 instanceof SQLException))
					throw ErrorCode.ne(AppException.class, localThrowable1,
							"931400", new String[] { paramString,
									localThrowable2.getMessage() });
			throw ErrorCode.ne(AppException.class, localThrowable1, "931400",
					new String[] { paramString, localThrowable1.getMessage() });
		}
	}

	public Object queryForObject(String paramString, Object paramObject) {
		try {
			if ((log.isDebugEnabled()) && (paramObject != null))
				log.debug(paramObject.toString());
			return getSqlMapClientTemplate().queryForObject(paramString,
					paramObject);
		} catch (Throwable localThrowable1) {
			if ((localThrowable1 instanceof SQLException))
				throw ErrorCode.ne(
						AppException.class,
						localThrowable1,
						"931400",
						new String[] { paramString,
								localThrowable1.getMessage() });
			for (Throwable localThrowable2 = localThrowable1.getCause(); localThrowable2 != null; localThrowable2 = localThrowable2
					.getCause())
				if ((localThrowable2 instanceof SQLException))
					throw ErrorCode.ne(AppException.class, localThrowable1,
							"931400", new String[] { paramString,
									localThrowable2.getMessage() });
			throw ErrorCode.ne(AppException.class, localThrowable1, "931400",
					new String[] { paramString, localThrowable1.getMessage() });
		}
	}

	public Object queryForObject(String paramString, Object paramObject1,
			Object paramObject2) {
		try {
			if ((log.isDebugEnabled()) && (paramObject1 != null))
				log.debug(paramObject1.toString());
			return getSqlMapClientTemplate().queryForObject(paramString,
					paramObject1, paramObject2);
		} catch (Throwable localThrowable1) {
			if ((localThrowable1 instanceof SQLException))
				throw ErrorCode.ne(
						AppException.class,
						localThrowable1,
						"931400",
						new String[] { paramString,
								localThrowable1.getMessage() });
			for (Throwable localThrowable2 = localThrowable1.getCause(); localThrowable2 != null; localThrowable2 = localThrowable2
					.getCause())
				if ((localThrowable2 instanceof SQLException))
					throw ErrorCode.ne(AppException.class, localThrowable1,
							"931400", new String[] { paramString,
									localThrowable2.getMessage() });
			throw ErrorCode.ne(AppException.class, localThrowable1, "931400",
					new String[] { paramString, localThrowable1.getMessage() });
		}
	}

	public List queryForList(String paramString) {
		return queryForList(paramString, null);
	}

	public List queryForList(String paramString, Object paramObject) {
		try {
			if ((log.isDebugEnabled()) && (paramObject != null))
				log.debug(paramObject.toString());
			return getSqlMapClientTemplate().queryForList(paramString,
					paramObject);
		} catch (Throwable localThrowable1) {
			if ((localThrowable1 instanceof SQLException))
				throw ErrorCode.ne(
						AppException.class,
						localThrowable1,
						"931401",
						new String[] { paramString,
								localThrowable1.getMessage() });
			for (Throwable localThrowable2 = localThrowable1.getCause(); localThrowable2 != null; localThrowable2 = localThrowable2
					.getCause())
				if ((localThrowable2 instanceof SQLException))
					throw ErrorCode.ne(AppException.class, localThrowable1,
							"931401", new String[] { paramString,
									localThrowable2.getMessage() });
			throw ErrorCode.ne(AppException.class, localThrowable1, "931401",
					new String[] { paramString, localThrowable1.getMessage() });
		}
	}
	
	public List queryForPageList(String paramString, Object paramObject) {
		try {
			if ((log.isDebugEnabled()) && (paramObject != null))
				log.debug(paramObject.toString());
			List<MyBaseBO> list = getSqlMapClientTemplate().queryForList(paramString,
					paramObject);
			MyBaseBO qry = (MyBaseBO)paramObject;
			qry.setTotalCount(list.size());
//			System.out.println("paramObject.getFirstRowNum():" + paramObject.getFirstRowNum());
			return getSqlMapClientTemplate().queryForList(paramString,
					paramObject,qry.getFirstRowNum(),qry.getPageSize());
		} catch (Throwable localThrowable1) {
			if ((localThrowable1 instanceof SQLException))
				throw ErrorCode.ne(
						AppException.class,
						localThrowable1,
						"931401",
						new String[] { paramString,
								localThrowable1.getMessage() });
			for (Throwable localThrowable2 = localThrowable1.getCause(); localThrowable2 != null; localThrowable2 = localThrowable2
					.getCause())
				if ((localThrowable2 instanceof SQLException))
					throw ErrorCode.ne(AppException.class, localThrowable1,
							"931401", new String[] { paramString,
									localThrowable2.getMessage() });
			throw ErrorCode.ne(AppException.class, localThrowable1, "931401",
					new String[] { paramString, localThrowable1.getMessage() });
		}
	}
	
	  public List queryForLimitList(String sqlid, int rowskip, int rowmax){
		  return queryForLimitList(sqlid, null, rowskip, rowmax);
	  }

	  public List queryForLimitList(String sqlid, Object param, int rowskip, int rowmax){
		  return getSqlMapClientTemplate().queryForList(
					sqlid, param, rowskip, rowmax);
	  }

	public Map queryForPagingList(String sqlid, int rowskip, int rowmax) {
		return queryForPagingList(sqlid, null, rowskip, rowmax);
	}

	@SuppressWarnings("unchecked")
	public Map queryForPagingList(final String sqlid, final Object param,
			final int rowskip, final int rowmax) {
		
		try {
			//int i = (int) getObjectTotal(paramString, paramObject);
			Object localObject = getSqlMapClientTemplate().queryForList(
					sqlid, param, rowskip, rowmax);
			Object count = getSqlMapClientTemplate().queryForObject("Seq.FOUND_ROWS");
			HashMap localHashMap = new HashMap();
			localHashMap.put("sum", count);
			localHashMap.put("result", localObject);
			return localHashMap;
			
//			SqlMapClient client = super.getSqlMapClient();
//			//client.startTransaction();
//			Object ret = client.queryForList(sqlid, param, rowskip, rowmax);
//			Object cnt = client.queryForObject("Seq.FOUND_ROWS");
//			HashMap map = new HashMap();
//			map.put("sum", cnt);
//			map.put("result", ret);
//			client.endTransaction();
//			return map;
		} catch (Throwable localThrowable) {
			if ((localThrowable instanceof SQLException))
				throw ErrorCode
						.ne(AppException.class,
								localThrowable,
								"931402",
								new String[] { sqlid,
										localThrowable.getMessage() });
			for (Object localObject = localThrowable.getCause(); localObject != null; localObject = ((Throwable) localObject)
					.getCause())
				if ((localObject instanceof SQLException))
					throw ErrorCode.ne(AppException.class, localThrowable,
							"931402", new String[] { sqlid,
									((Throwable) localObject).getMessage() });
			throw ErrorCode.ne(AppException.class, localThrowable, "931402",
					new String[] { sqlid, localThrowable.getMessage() });
		}
	}

	@SuppressWarnings("unchecked")
	public Object batchUpdate(final String paramString, final List paramList) {
		try {
			return getSqlMapClientTemplate().execute(
					new SqlMapClientCallback() {
						public Object doInSqlMapClient(
								SqlMapExecutor paramAnonymousSqlMapExecutor)
								throws SQLException {
							if (paramList == null)
								throw new SQLException(
										"batchUpdate  parameter list is null !");
							int i = 0;
							paramAnonymousSqlMapExecutor.startBatch();
							int j = paramList.size();
							for (int k = 0; k < j; k++)
								i += paramAnonymousSqlMapExecutor.update(
										paramString, paramList.get(k));
							paramAnonymousSqlMapExecutor.executeBatch();
							return new Integer(i);
						}
					});
		} catch (Throwable localThrowable1) {
			if ((localThrowable1 instanceof SQLException))
				throw ErrorCode.ne(
						AppException.class,
						localThrowable1,
						"931201",
						new String[] { paramString,
								localThrowable1.getMessage() });
			for (Throwable localThrowable2 = localThrowable1.getCause(); localThrowable2 != null; localThrowable2 = localThrowable2
					.getCause())
				if ((localThrowable2 instanceof SQLException))
					throw ErrorCode.ne(AppException.class, localThrowable1,
							"931201", new String[] { paramString,
									localThrowable2.getMessage() });
			throw ErrorCode.ne(AppException.class, localThrowable1, "931201",
					new String[] { paramString, localThrowable1.getMessage() });
		}
	}

	public Object batchInsert(final String paramString, final List paramList) {
		try {
			return getSqlMapClientTemplate().execute(
					new SqlMapClientCallback() {
						public Object doInSqlMapClient(
								SqlMapExecutor paramAnonymousSqlMapExecutor)
								throws SQLException {
							if (paramList == null)
								throw new SQLException(
										"batchInsert  parameter list is null !");
							paramAnonymousSqlMapExecutor.startBatch();
							int i = paramList.size();
							for (int j = 0; j < i; j++)
								paramAnonymousSqlMapExecutor.insert(
										paramString, paramList.get(j));
							paramAnonymousSqlMapExecutor.executeBatch();
							return new Integer(i);
						}
					});
		} catch (Throwable localThrowable1) {
			if ((localThrowable1 instanceof SQLException))
				throw ErrorCode.ne(
						AppException.class,
						localThrowable1,
						"931101",
						new String[] { paramString,
								localThrowable1.getMessage() });
			for (Throwable localThrowable2 = localThrowable1.getCause(); localThrowable2 != null; localThrowable2 = localThrowable2
					.getCause())
				if ((localThrowable2 instanceof SQLException))
					throw ErrorCode.ne(AppException.class, localThrowable1,
							"931101", new String[] { paramString,
									localThrowable2.getMessage() });
			throw ErrorCode.ne(AppException.class, localThrowable1, "931101",
					new String[] { paramString, localThrowable1.getMessage() });
		}
	}

	public long getObjectTotal(String paramString, Object paramObject) {
		prepareCountQuery(paramString);
		return ((Long) getSqlMapClientTemplate().queryForObject(
				CountStatementUtil.getCountStatementId(paramString),
				paramObject)).longValue();
	}

	public long getObjectTotal(String paramString) {
		prepareCountQuery(paramString);
		return ((Long) getSqlMapClientTemplate().queryForObject(
				CountStatementUtil.getCountStatementId(paramString)))
				.longValue();
	}

	protected void prepareCountQuery(String paramString) {
		String str = CountStatementUtil.getCountStatementId(paramString);
		if (this.logger.isDebugEnabled())
			this.logger.debug("Convert " + paramString + " to " + str);
		SqlMapClient localSqlMapClient = getSqlMapClientTemplate()
				.getSqlMapClient();
		if ((localSqlMapClient instanceof ExtendedSqlMapClient)) {
			SqlMapExecutorDelegate localSqlMapExecutorDelegate = ((ExtendedSqlMapClient) localSqlMapClient)
					.getDelegate();
			try {
				localSqlMapExecutorDelegate.getMappedStatement(str);
			} catch (SqlMapException localSqlMapException) {
				localSqlMapExecutorDelegate
						.addMappedStatement(CountStatementUtil
								.createCountStatement(localSqlMapExecutorDelegate
										.getMappedStatement(paramString)));
			}
		}
	}
}