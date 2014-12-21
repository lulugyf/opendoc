package com.sitech.rom.common.dao; 
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sitech.jcf.core.dao.BaseDao;
import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.Seq;

@Repository("seqDao")
public class SeqDao  extends BaseService 
{ 

	@Autowired
	private BaseDao baseDao;
	
	public Long getSeq(Seq seq)
	{
		return (Long) baseDao.queryForObject("Seq.selectseq", seq);
	}
}
