<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.Bb0DAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bb0_bean" class="bbs.Bb0" scope="page" />
<jsp:setProperty name="bb0_bean" property="bb0_Title" />
<jsp:setProperty name="bb0_bean" property="bb0_Content" />
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
		} else {
			if(bb0_bean.getBb0_Title() == null || bb0_bean.getBb0_Content() == null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('Please fill out every field')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					Bb0DAO bb0DAO = new Bb0DAO();
					int result = bb0DAO.write(bb0_bean.getBb0_Title(), userID, bb0_bean.getBb0_Content());
					if(result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('Writing Failed')");
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
		}
		
	%>

</body>
</html>