<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html;charset=UTF-8"); %>
<%@ page import="com.pb.daos.BoardDao" %>
<%@ page import="com.pb.dtos.BoardDto" %>

<%
    // 게시글 번호를 받아 DAO를 통해 해당 글의 정보를 가져옵니다.
    // 이 페이지는 boarddetail.jsp에서 수정 버튼을 눌러 이동하게 됩니다.
    int tseq = Integer.parseInt(request.getParameter("tseq"));
    
    BoardDao dao = new BoardDao();
    BoardDto boardDto = dao.getBoard(tseq);
    
    // request 객체에 게시글 정보를 담아 JSTL이 사용할 수 있게 합니다.
    request.setAttribute("boardDto", boardDto);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<style>
    table {
        width: 60%;
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
    input[type="text"], textarea {
        width: 98%;
    }
</style>
<script type="text/javascript">
    function updateForm() {
        if (confirm("정말 수정하시겠습니까?")) {
            document.getElementById("updateForm").submit();
        }
    }
</script>
</head>
<body>

    <h3>게시글 수정</h3>
    <form id="updateForm" action="boardcontroller.jsp" method="post">
        <input type="hidden" name="command" value="update">
        <input type="hidden" name="tseq" value="${boardDto.tseq}">
        
        <table border="1">
            <tr>
                <th>번호</th>
                <td>${boardDto.tseq}</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>${boardDto.tid}</td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="ttitle" value="${boardDto.ttitle}" required="required"></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="tcontent" rows="10" cols="50" required="required">${boardDto.tcontent}</textarea></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;">
                    <button type="button" onclick="updateForm()">수정하기</button>
                    <button type="button" onclick="history.back()">취소</button>
                </td>
            </tr>
        </table>
    </form>

</body>
</html>