<%@page import="java.util.List"%>
<%@page import="com.pb.dtos.BoardDto"%>
<%@page import="com.pb.daos.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html;charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 컨트롤러</title>
</head>
<body>
<%
    String command = request.getParameter("command");
    BoardDao dao = new BoardDao();

    // 1. 글목록 요청 처리
    if(command.equals("boardlist")){
        List<BoardDto> list = dao.getAllList();
        request.setAttribute("list", list);
        pageContext.forward("boardlist.jsp");
        
    // 2. 글쓰기 폼 요청
    } else if(command.equals("boardwrite")){
        response.sendRedirect("boardwriteform.jsp");
        
    // 3. 글쓰기
    } else if(command.equals("insert")){
        String tid = request.getParameter("tid");
        String ttitle = request.getParameter("ttitle");
        String tcontent = request.getParameter("tcontent");
        
        BoardDto boardDto = new BoardDto(tid, ttitle, tcontent);
        boolean isS = dao.insertBoard(boardDto);
        
        if(isS){
            response.sendRedirect("boardcontroller.jsp?command=boardlist");
        } else {
            response.sendRedirect("error.jsp");
        }
        
    // 4. 게시글 상세 보기
    } else if(command.equals("boarddetail")){
        String sseq = request.getParameter("tseq");
        int tseq = Integer.parseInt(sseq);
        
        BoardDto boardDto = dao.getBoard(tseq);
        request.setAttribute("boardDto", boardDto);
        pageContext.forward("boarddetail.jsp");
        
    // 5. 게시글 수정 폼 이동
    } else if(command.equals("boardupdateform")){
        String sseq = request.getParameter("tseq");
        int tseq = Integer.parseInt(sseq);
        
        BoardDto boardDto = dao.getBoard(tseq);
        request.setAttribute("boardDto", boardDto);
        
        pageContext.forward("boardupdateform.jsp");
        
    // 6. 게시글 수정
    } else if(command.equals("update")){
        String sseq = request.getParameter("tseq");
        int tseq = Integer.parseInt(sseq);
        String ttitle = request.getParameter("ttitle");
        String tcontent = request.getParameter("tcontent");
        
        BoardDto boardDto = new BoardDto(tseq, ttitle, tcontent);
        boolean isS = dao.updateBoard(boardDto);
        
        if(isS){
            response.sendRedirect("boardcontroller.jsp?command=boarddetail&tseq=" + tseq);
        } else {
            response.sendRedirect("error.jsp");
        }
        
    // 7. 게시글 삭제
    } else if(command.equals("delete")){
        String sseq = request.getParameter("tseq");
        int tseq = Integer.parseInt(sseq);
        boolean isS = dao.deleteBoard(tseq);
        
        if(isS){
            response.sendRedirect("boardcontroller.jsp?command=boardlist");
        } else {
            response.sendRedirect("error.jsp");
        }
    } // ★ 마지막 if-else 블록 닫아줘야 함
%>
</body>
</html>
