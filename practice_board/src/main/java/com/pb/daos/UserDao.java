package com.pb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.pb.datasource.Database;
import com.pb.dtos.RoleStatus;
import com.pb.dtos.UserDto;

// 싱글톤 패턴 : 객체를 한번만 생성해서 사용하자
public class UserDao extends Database{

	private static UserDao userDao;
	//new를 사용못하게 생성자에 private을 선언한다.
	private UserDao() {}
	//객체를 한번만 생성해서 사용하는 기능을 구현
	public static UserDao getUserDao() {
		if(userDao==null) {
			userDao=new UserDao();
		}
		return userDao;
	}
	
	//사용자 기능
	
	//1. 회원가입 기능(enabled:"Y", role:"USER",regDate:SYSDATE())
	// insert문
	public boolean insertUser(UserDto dto) {
		int count=0;
		
		Connection conn=null;
		PreparedStatement psmt=null;
		
		String sql=" INSERT INTO T_USER(TID, TPASSWORD, TNAME, TADDRESS, TPHONE, TEMAIL, TENABLED, TROLE, TREGDATE) "
				 + " VALUES(?,?,?,?,?,?,?,'USER',SYSDATE()) ";
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, dto.getTid());
			psmt.setString(2, dto.getTpassword());
			psmt.setString(3, dto.getTname());
			psmt.setString(4, dto.getTaddress());
			psmt.setString(5, dto.getTphone());
			psmt.setString(6, dto.getTemail());
			psmt.setString(7, "Y");
			count=psmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(null, psmt, conn);
		}
		return count > 0;
	}
	
	//2.ID 중복체크하기
	public String idCheck(String tid) {
		String resultId=null;
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		String sql="SELECT tid FROM T_USER WHERE tid=?";
		
		try {
			conn=getConnection();
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, tid);
			rs=psmt.executeQuery();
			if(rs.next()) {
				resultId=rs.getString("tid");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs, psmt, conn);
		}

		return resultId;
	}
	
	//3.로그인 기능 : 파리미터 TID, TPASSWORD
	public UserDto getLogin(String tid, String tpassword) {
		UserDto dto = null;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT TID, TNAME, TROLE FROM T_USER "
				 + " WHERE TID=? AND TPASSWORD=? AND TENABLED='Y' ";
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, tid);
			psmt.setString(2, tpassword);
			rs = psmt.executeQuery();
			if (rs.next()) {
				dto = new UserDto();
				dto.setTid(rs.getString("TID"));
				dto.setTname(rs.getString("TNAME"));
				dto.setTrole(rs.getString("TROLE"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, psmt, conn);
		}
		return dto;
	}
	
	//4. 나의 정보 조회
	public UserDto getUser(String tid) {
		UserDto dto = null;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT TID, TNAME, TADDRESS, TPHONE, TEMAIL, TROLE, TREGDATE "
				 + " FROM T_USER WHERE TID=? ";
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, tid);
			rs = psmt.executeQuery();
			if (rs.next()) {
				dto = new UserDto();
				dto.setTid(rs.getString("TID"));
				dto.setTname(rs.getString("TNAME"));
				dto.setTaddress(rs.getString("TADDRESS"));
				dto.setTphone(rs.getString("TPHONE"));
				dto.setTemail(rs.getString("TEMAIL"));
				dto.setTrole(rs.getString("TROLE"));
				dto.setRegDate(rs.getDate("TREGDATE"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, psmt, conn);
		}
		return dto;
	}
	
	//5.나의 정보 수정하기
	public boolean updateUser(UserDto dto) {
		int count = 0;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		String sql = " UPDATE T_USER SET TADDRESS=? , TPHONE=?, TEMAIL=? "
				 + " WHERE TID=? ";
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getTaddress());
			psmt.setString(2, dto.getTphone());
			psmt.setString(3, dto.getTemail());
			psmt.setString(4, dto.getTid());

			count = psmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, psmt, conn);
		}
		return count > 0;
	}
	
	//6.탈퇴하기
	public boolean delUser(String tid) {
		int count = 0;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		String sql = " UPDATE T_USER SET TENABLED='N' "
				 + " WHERE TID=? ";
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, tid);

			count = psmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, psmt, conn);
		}
		return count > 0;
	}
}