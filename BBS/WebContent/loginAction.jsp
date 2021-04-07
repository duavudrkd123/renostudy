<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="user" class="user.User" scope="page"/>
    <jsp:setProperty name="user" property="userID"/>
    <jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1"> <!--반응형 웹 만들때 사용. 화면 크기에 따라 바뀜-->
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
	if( session.getAttribute("userID") != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	} else {
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserID(), user.getUserPassword());
	if (result == 1) {
		session.setAttribute("userID", user.getUserID()); //여기서 세션에 담아준다. 로그인 정보가 맞으면
		System.out.println("세션에 담긴 아이디" + session.getAttribute("userID"));
		%>
		
		<script>
		alert('<%=session.getAttribute("userID")%>')
		location.href = 'main.jsp';
		</script>
		
		<%  

	} else if (result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('No ID.')");
		script.println("history.back()");
		script.println("</script>");
	} else if (result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('SDB error.')");
		script.println("history.back()");
		script.println("</script>");
	}
}
	%>
</body>
</html>