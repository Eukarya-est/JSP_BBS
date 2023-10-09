<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>    
<%@ page import="bbs.Bb0" %>    
<%@ page import="bbs.Bb0DAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP Bulletin Board System</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Please Sign-in to continue')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int bb0_ID = 0;
		if (request.getParameter("bb0_ID") != null){
			bb0_ID = Integer.parseInt(request.getParameter("bb0_ID"));
		}
		if (bb0_ID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Invalid Content')");
			script.println("location.href = 'bbs.jsp'");
			script.println("<script>");
		}
		Bb0 bb0 = new Bb0DAO().getBb0(bb0_ID);
		if (!userID.equals(bb0.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Invalid authority')");
			script.println("location.href = 'bbs.jsp'");
			script.println("<script>");
		} else {
					Bb0DAO bb0DAO = new Bb0DAO();
					int result = bb0DAO.delete(bb0_ID);
					if(result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('Deleting Failed')");
						script.println("history.back()");
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'bbs.jsp'");
						script.println("</script>");
					}	
				}
		
	%>

</body>
</html>