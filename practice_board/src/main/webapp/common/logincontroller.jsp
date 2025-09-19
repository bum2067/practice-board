<%@page import="java.net.URLEncoder"%>
<%@page import="com.pb.dtos.UserDto"%>
<%@page import="com.pb.daos.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html;charset=UTF-8");

    String command = request.getParameter("command");
    UserDao dao = UserDao.getUserDao();

    if ("registform".equals(command)) {   // 회원가입 폼 이동
        response.sendRedirect("registform.jsp");

    } else if ("insertuser".equals(command)) {   // 회원가입 처리
        String tid = request.getParameter("tid");
        String tname = request.getParameter("tname");
        String tpassword = request.getParameter("tpassword");

        // 주소 파라미터
        String addr1 = request.getParameter("addr1"); // 우편번호
        String addr2 = request.getParameter("addr2"); // 기본주소
        String addr3 = request.getParameter("addr3"); // 상세주소
        String addr4 = request.getParameter("addr4"); // 참고항목
        String taddress = addr1 + " " + addr2 + " " + addr3 + " " + addr4;

        String temail = request.getParameter("temail");

        boolean isS = dao.insertUser(new UserDto(tid, tname, tpassword, taddress, temail));
        if (isS) {
%>
<script>
    alert("회원가입이 완료되었습니다.");
    location.href = "loginController.jsp";
</script>
<%
        } else {
%>
<script>
    alert("회원가입 실패");
    location.href = "error.jsp";
</script>
<%
        }

    } else if ("idchk".equals(command)) {   // 아이디 중복 체크
        String tid = request.getParameter("tid");
        String resultId = dao.idCheck(tid); // 결과가 null이면 사용 가능

        request.setAttribute("resultId", resultId);
        pageContext.forward("idchkform.jsp");

    } else if ("login".equals(command)) {   // 로그인
        String tid = request.getParameter("tid");
        String tpassword = request.getParameter("tpassword");

        UserDto loginDto = dao.getLogin(tid, tpassword);

        if (loginDto == null || loginDto.getTid() == null) {
            response.sendRedirect("index.jsp?msg=" + URLEncoder.encode("회원가입을 해주세요", "UTF-8"));
        } else {
            // 로그인 성공 → 세션에 저장
            session.setAttribute("loginDto", loginDto);
            session.setMaxInactiveInterval(10 * 60); // 10분 유지

            // 권한(role)에 따라 페이지 분기
            if ("ADMIN".equalsIgnoreCase(loginDto.getTrole())) {
                response.sendRedirect("admin_main.jsp");
            } else if ("MANAGER".equalsIgnoreCase(loginDto.getTrole())) {
                response.sendRedirect("manager_main.jsp");
            } else {
                response.sendRedirect("user_main.jsp");
            }
        }

    } else if ("logout".equals(command)) {   // 로그아웃
        session.invalidate();
        response.sendRedirect("index.jsp");

    } else if ("userinfo".equals(command)) {   // 회원 상세조회
        String tid = request.getParameter("tid");
        UserDto userDto = dao.getUser(tid);

        request.setAttribute("userDto", userDto);
        pageContext.forward("userinfo.jsp");

    } else if ("userupdate".equals(command)) {   // 회원정보 수정
        String tid = request.getParameter("tid");
        String taddress = request.getParameter("taddress");
        String temail = request.getParameter("temail");

        boolean isS = dao.updateUser(new UserDto(tid, taddress, temail));
        if (isS) {
%>
<script>
    alert("수정 완료");
    location.href = "loginController.jsp?command=userinfo&tid=<%=tid%>";
</script>
<%
        } else {
%>
<script>
    alert("수정 실패");
    location.href = "error.jsp";
</script>
<%
        }

    } else if ("deluser".equals(command)) {   // 회원 탈퇴
        String tid = request.getParameter("tid");
        boolean isS = dao.delUser(tid);

        session.invalidate();
        if (isS) {
%>
<script>
    alert("회원 탈퇴가 완료되었습니다.");
    location.href = "index.jsp";
</script>
<%
        } else {
%>
<script>
    alert("회원 탈퇴 실패");
    location.href = "error.jsp";
</script>
<%
        }
    }
%>
