<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	String id = request.getParameter("id");
	if(id != null){
		session.setAttribute("user",id);
	}
	response.sendRedirect("view.jsp");
%>
