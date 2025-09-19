package com.pb.dtos;

import java.io.Serializable;
import java.util.Date;

public class UserDto implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String tid;
	private String tpassword;
	private String tname;
	private String taddress;
	private String tphone;
	private String temail;
	private String tenabled;
	private String trole;
	private Date regDate;
	
	public UserDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public UserDto(String tid, String tpassword, String tname, String taddress, String tphone, String temail,
			String tenabled, String trole, Date regDate) {
		super();
		this.tid = tid;
		this.tpassword = tpassword;
		this.tname = tname;
		this.taddress = taddress;
		this.tphone = tphone;
		this.temail = temail;
		this.tenabled = tenabled;
		this.trole = trole;
		this.regDate = regDate;
	}
	
	public UserDto(String tid, String tname, String tpassword, String taddress, String temail) {
		super();
		this.tid = tid;
		this.tname = tname;
		this.tpassword = tpassword;
		this.taddress = taddress;
		this.temail = temail;
	}
	
	public UserDto(String tid, String taddress, String temail) {
		super();
		this.tid = tid;
		this.taddress = taddress;
		this.temail = temail;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getTpassword() {
		return tpassword;
	}

	public void setTpassword(String tpassword) {
		this.tpassword = tpassword;
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	public String getTaddress() {
		return taddress;
	}

	public void setTaddress(String taddress) {
		this.taddress = taddress;
	}

	public String getTphone() {
		return tphone;
	}

	public void setTphone(String tphone) {
		this.tphone = tphone;
	}

	public String getTemail() {
		return temail;
	}

	public void setTemail(String temail) {
		this.temail = temail;
	}

	public String getTenabled() {
		return tenabled;
	}

	public void setTenabled(String tenabled) {
		this.tenabled = tenabled;
	}

	public String getTrole() {
		return trole;
	}

	public void setTrole(String trole) {
		this.trole = trole;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "UserDto [tid=" + tid + ", tpassword=" + tpassword + ", tname=" + tname + ", taddress=" + taddress
				+ ", tphone=" + tphone + ", temail=" + temail + ", tenabled=" + tenabled + ", trole=" + trole
				+ ", regDate=" + regDate + "]";
	}
	
}
