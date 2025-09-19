package com.pb.dtos;

import java.io.Serializable;
import java.util.Date;

public class BoardDto implements Serializable {

	private static final long serialVersionUID = 1L;

	private int tseq;
	private String tid;
	private String ttitle;
	private String tcontent;
	private Date tregDate;
	private String tdelflag;
	
	public BoardDto() {
		super();
	}

	public BoardDto(int tseq, String tid, String ttitle, String tcontent, Date tregDate, String tdelflag) {
		super();
		this.tseq = tseq;
		this.tid = tid;
		this.ttitle = ttitle;
		this.tcontent = tcontent;
		this.tregDate = tregDate;
		this.tdelflag = tdelflag;
	}

	public BoardDto(String tid, String ttitle, String tcontent) {
		super();
		this.tid = tid;
		this.ttitle = ttitle;
		this.tcontent = tcontent;
	}
	
	public BoardDto(int tseq, String ttitle, String tcontent) {
		super();
		this.tseq = tseq;
		this.ttitle = ttitle;
		this.tcontent = tcontent;
	}

	public int getTseq() {
		return tseq;
	}

	public void setTseq(int tseq) {
		this.tseq = tseq;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getTtitle() {
		return ttitle;
	}

	public void setTtitle(String ttitle) {
		this.ttitle = ttitle;
	}

	public String getTcontent() {
		return tcontent;
	}

	public void setTcontent(String tcontent) {
		this.tcontent = tcontent;
	}

	public Date getTregDate() {
		return tregDate;
	}

	public void setTregDate(Date tregDate) {
		this.tregDate = tregDate;
	}

	public String getTdelflag() {
		return tdelflag;
	}

	public void setTdelflag(String tdelflag) {
		this.tdelflag = tdelflag;
	}

	@Override
	public String toString() {
		return "BoardDto [tseq=" + tseq + ", tid=" + tid + ", ttitle=" + ttitle + ", tcontent=" + tcontent
				+ ", tregDate=" + tregDate + ", tdelflag=" + tdelflag + "]";
	}
	
	
}
