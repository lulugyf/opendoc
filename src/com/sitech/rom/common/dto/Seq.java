package com.sitech.rom.common.dto;

import java.io.Serializable;

public class Seq implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String seq;
	private String seq_name;

	public String getSeq_name()
	{
		return seq_name;
	}

	public void setSeq_name(String seq_name)
	{
		this.seq_name = seq_name;
	}

	public String getSeq()
	{
		return seq;
	}

	public void setSeq(String seq)
	{
		this.seq = seq;
	}
}
