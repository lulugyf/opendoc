package com.sitech.rom.user.service;

import java.util.List;

import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.common.dto.RomSysProFunction;

public interface ProductSvc {
	public boolean addProduct(RomProCode romProCode);
	public boolean updateProduct(RomProCode romProCode);
	public boolean delProduct(RomProCode romProCode);
	public List<RomProCode> getProList(RomProCode romProCode);
	public RomProCode getPro(RomProCode romProCode);
	
	public void setProductFunction(String productCode,String[] funcs);
}
