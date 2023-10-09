<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="User.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP Bulletin Board System</title>
</head>
<body>
	<%
		session.invalidate();	
	%>
	<script>
		location.href = 'main.jsp';
	</script>

</body>
</html>