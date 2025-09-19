package com.pb.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.pb.dtos.BoardDto;
import com.pb.datasource.Database;

public class BoardDao extends Database{

    public BoardDao() {
        super();
    }
    
    // 글목록 조회 기능: Tdelflag가 'N'인 글만 조회
    public List<BoardDto> getAllList(){
        List<BoardDto> list=new ArrayList<>();
        
        Connection conn=null;
        PreparedStatement psmt=null;
        ResultSet rs=null;
        
        String sql=" SELECT TSEQ, TID, TTITLE, TCONTENT, TREGDATE, Tdelflag "
                + " FROM T_BOARD WHERE Tdelflag = 'N' ORDER BY TREGDATE DESC ";
        
        try {
            conn=getConnection();
            psmt=conn.prepareStatement(sql);
            rs=psmt.executeQuery();
            while(rs.next()) {
                BoardDto dto=new BoardDto();
                dto.setTseq(rs.getInt("TSEQ"));
                dto.setTid(rs.getString("TID"));
                dto.setTtitle(rs.getString("TTITLE"));
                dto.setTcontent(rs.getString("TCONTENT"));
                dto.setTregDate(rs.getDate("TREGDATE"));
                dto.setTdelflag(rs.getString("Tdelflag"));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            close(rs, psmt, conn);
        }
        return list;
    }
    
    // 글 추가하기: Tdelflag 컬럼에 'N'값 추가
    public boolean insertBoard(BoardDto dto) {
        int count=0;
        
        Connection conn=null;
        PreparedStatement psmt=null;
        
        String sql=" INSERT INTO T_BOARD(TSEQ, TID, TTITLE, TCONTENT, Tdelflag, TREGDATE) "
                + " VALUES(NULL,?,?,?,'N',SYSDATE()) ";
        
        try {
            conn=getConnection();
            psmt=conn.prepareStatement(sql);
            psmt.setString(1, dto.getTid());
            psmt.setString(2, dto.getTtitle());
            psmt.setString(3, dto.getTcontent());
            
            count=psmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            close(null, psmt, conn);
        }
        
        return count > 0;
    }
    
    // 글 상세보기: TSEQ 사용 및 Tdelflag 값 조회
    public BoardDto getBoard(int tseq) {
        BoardDto dto = null;
        
        Connection conn=null;
        PreparedStatement psmt=null;
        ResultSet rs=null;
        
        String sql=" SELECT TSEQ, TID, TTITLE, TCONTENT, TREGDATE, Tdelflag "
                + " FROM T_BOARD WHERE TSEQ = ? ";
        
        try {
            conn=getConnection();
            psmt=conn.prepareStatement(sql);
            psmt.setInt(1, tseq);
            rs=psmt.executeQuery();
            if(rs.next()) {
                dto = new BoardDto();
                dto.setTseq(rs.getInt("TSEQ"));
                dto.setTid(rs.getString("TID"));
                dto.setTtitle(rs.getString("TTITLE"));
                dto.setTcontent(rs.getString("TCONTENT"));
                dto.setTregDate(rs.getDate("TREGDATE"));
                dto.setTdelflag(rs.getString("Tdelflag"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            close(rs, psmt, conn);
        }
        return dto;
    }
    
    // 글 수정하기
    public boolean updateBoard(BoardDto dto) {
        int count=0;
        
        Connection conn=null;
        PreparedStatement psmt=null;
        
        String sql=" UPDATE T_BOARD SET "
                 + " TTITLE=? , "
                 + " TCONTENT=? "
                 + " WHERE TSEQ=? ";
        
        try {
            conn=getConnection();
            
            psmt=conn.prepareStatement(sql);
            psmt.setString(1, dto.getTtitle());
            psmt.setString(2, dto.getTcontent());
            psmt.setInt(3, dto.getTseq());
            
            count=psmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            close(null, psmt, conn);
        }
        
        return count > 0;
    }
    
    // 글 삭제하기: 논리적 삭제(Logical Delete)
    public boolean deleteBoard(int tseq) {
        int count=0;
        
        Connection conn=null;
        PreparedStatement psmt=null;
        
        String sql=" UPDATE T_BOARD SET Tdelflag='Y' WHERE TSEQ=? ";
        
        try {
            conn=getConnection();
            psmt=conn.prepareStatement(sql);
            psmt.setInt(1, tseq);
            count=psmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            close(null, psmt, conn);
        }
        
        return count > 0;
    }
}