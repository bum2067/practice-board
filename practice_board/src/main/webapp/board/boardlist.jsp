<%@page import="com.pb.dtos.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="com.pb.daos.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html;charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글목록 조회</title>
<style>
    table {
        width: 80%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }
    th {
        background-color: #f2f2f2;
    }
</style>
<script type="text/javascript">
	function boardwriteform(){
		location.href=
	        "boardcontroller.jsp?command=boardwriteform";
	}
	
	//전체선택 체크박스 기능
	function allSel(bool){
		const seqs=document.getElementsByName("seq");
		for (let i = 0; i < seqs.length; i++) {
			seqs[i].checked=bool;
		}
	}
	
	// 삭제 체크박스 유효값 처리 기능
	function isAllCheck() { 
		let chks = document.querySelectorAll("input[name=seq]:checked");
		document.querySelector("#msg").textContent = ""; // 메시지 초기화
		
		if (chks.length == 0) {
			document.querySelector("#msg").textContent = "하나 이상 체크하세요.";
			return false;
		}else {
			if (confirm("정말 삭제하시겠습니까?")){
				return true;
			}else{
				document.querySelector("#msg").textContent = "";
				return false;
			}
		}
	}
</script>
</head>
<%
    // BoardDao 객체 생성
	BoardDao dao = new BoardDao();
    
    // getAllList() 메서드를 호출하여 게시글 목록을 가져옴
	List<BoardDto> list = dao.getAllList();
%>
<body>
<h1>게시판</h1>
<h2>글목록</h2>
<form action="boardcontroller.jsp" method="post" onsubmit="return isAllCheck()">
<input type="hidden" name="command" value="muldel"/>
<table border="1">
	<col width="50px"/>
	<col width="50px"/>
	<col width="100px"/>
	<col width="300px"/>
	<col width="200px"/>
	<thead>
		<tr>
            <th><input type="checkbox" name="all" onclick="allSel(this.checked)"></th>
			<th>번호</th>
            <th>작성자</th>
            <th>제목</th>
            <th>작성일</th>
		</tr>
	</thead>
	<tbody>
	<%
        if (list == null || list.isEmpty()) {
    %>
            <tr>
                <td colspan="5">게시글이 없습니다.</td>
            </tr>
    <%
        } else {
            for(BoardDto dto : list){
    %>
			<tr>
				<td><input type="checkbox" name="seq" value="<%=dto.getTseq()%>" /></td>
				<td><%=dto.getTseq()%></td>
				<td><%=dto.getTid()%></td>
				<td><a href="boardcontroller.jsp?command=boarddetail&tseq=<%=dto.getTseq()%>"><%=dto.getTtitle()%></a></td>
				<td><%=dto.getTregDate()%></td>
			</tr>
			<%
		    }
        }
	%>
	</tbody>
</table>
<span id="msg" style="color:red;"></span>
<br>
<button type="button" onclick="boardwriteform()">글추가</button>	
<button type="submit">선택 글 삭제</button>
</form>
</body>
</html>