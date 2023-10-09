<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bb0" %>
<%@ page import="bbs.Bb0DAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP Bulletin Board System</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int bb0_ID = 0;
		if (request.getParameter("bb0_ID") != null){
			bb0_ID = Integer.parseInt(request.getParameter("bb0_ID"));
		}
		if (bb0_ID == 0){
			PrintWriter script  = response.getWriter ();
			script.println("<script>");
			script.println("alert('Ivalidate Content')");
			script.println("locatin.href = 'bbs.jsp'");
			script.println("</script");
		}
		Bb0 bb0 = new Bb0DAO().getBb0(bb0_ID);
	%>
	<nav class="navbar navber-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-traget="#bs-example-navbar-collaspe-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP Bulletin Board Web Site</a>
		</div>
		<div class="collapse navbar-collapse" id="bs=example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">Main</a></li>
				<li class="active"><a href="bbs.jsp">Board</a></li>
			</ul>
			<%
				if(userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Connect<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">Sign-in</a></li>
						<li><a href="join.jsp">Sign-up</a></li>
					</ul>
				</li>
			</ul>			
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Account Menu<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">Sign-out</a></li>
					</ul>
				</li>
			</ul>	
			<%
				}
			%>
			
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align : center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">Content View</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">Title</td>
							<td colspan="2"><%= bb0.getBb0_Title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\n","<br>") %></td>
						</tr>
						<tr>
							<td>User</td>
							<td colspan="2"><%= bb0.getUserID() %></td>
						</tr>
						<tr>
							<td>Date</td>
							<td colspan="2"><%= bb0.getBb0_Date().substring(0, 16) %></td>
						</tr>
						<tr>
							<td>Content</td>
							<td colspan="2" style="min-height: 200px; text-align: left;">
							<%= bb0.getBb0_Content().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\n","<br>") %></td>
						</tr>
					</tbody>
				</table>
				<a href="bbs.jsp" class="btn btn-primary">List</a>
				<%
					if(userID != null && userID.equals(bb0.getUserID())) {
				%>
					<a href="update.jsp?bb0_ID=<%= bb0_ID %>" class="btn btn-primary">Modify</a>
					<a onclick="return confirm('Do you delete this content?')" href="deleteAction.jsp?bb0_ID=<%= bb0_ID %>" class="btn btn-primary">Delete</a>
				<%
					}
				%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>