<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>Liste des Personnes</h1>
<br/>

<table border="1">
<%
ArrayList<String[]> l = (ArrayList<String[]>)request.getAttribute("list");
if (l!= null)
for (String[] row : l) {
		out.println("<tr>");
		for (String s : row) {
			out.println("<td>"+s+"</td>");
		}
		out.println("</tr>");
}
%>
</table> 

</body>
</html>