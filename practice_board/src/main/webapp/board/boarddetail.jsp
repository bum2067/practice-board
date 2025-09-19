<%@page import="com.pb.dtos.BoardDto"%>
<%@page import="com.pb.daos.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html;charset=UTF-8"); %>

<%
    // 게시글 번호를 받아 DAO를 통해 해당 글의 정보를 가져옴
    int tseq = Integer.parseInt(request.getParameter("tseq"));
    
    BoardDao dao = new BoardDao();
    BoardDto boardDto = dao.getBoard(tseq);
    
    // 세션에서 로그인된 사용자 ID를 가져옴
    String sId = (String)session.getAttribute("sId");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세 보기</title>
<style>
    table {
        width: 80%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }
</style>
</head>
<body>

    <h3>게시글 상세 보기</h3>
    <table border="1">
        <tr>
            <th>번호</th>
            <td><%=boardDto.getTseq()%></td>
        </tr>
        <tr>
            <th>작성자</th>
            <td><%=boardDto.getTid()%></td>
        </tr>
        <tr>
            <th>제목</th>
            <td><%=boardDto.getTtitle()%></td>
        </tr>
        <tr>
            <th>작성일</th>
            <td><%=boardDto.getTregDate()%></td>
        </tr>
        <tr>
            <th>내용</th>
            <td><%=boardDto.getTcontent()%></td>
        </tr>
    </table>
    
    <br>
    
    <%-- 로그인한 사용자의 ID와 게시글 작성자의 ID가 동일할 때만 버튼을 표시 --%>
    <% 
        if (sId != null && sId.equals(boardDto.getTid())) {
    %>
        <input type="button" value="수정" onclick="location.href='boardupdateform.jsp?tseq=<%=boardDto.getTseq()%>'">
        <input type="button" value="삭제" onclick="location.href='boardcontroller.jsp?command=delete&tseq=<%=boardDto.getTseq()%>'">
    <% 
        }
    %>
    
    <input type="button" value="글목록" onclick="location.href='boardlist.jsp'">

</body>
</html>