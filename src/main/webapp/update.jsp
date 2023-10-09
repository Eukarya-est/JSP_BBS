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
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Please Sign-in')");
			script.println("location.href = 'login.jsp'");
			script.println("<script>");
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
		}
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
	
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?bb0_ID=<%= bb0_ID %>">
				<table class="table table-striped" style="text-align : center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">Modify Form</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="Title" name="bb0_Title" maxlength="50" value="<%= bb0.getBb0_Title() %>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="Content" name="bb0_Content" maxlength="2048" style="height: 350px;"><%= bb0.getBb0_Content() %></textarea></td>					
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="Modify">
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>