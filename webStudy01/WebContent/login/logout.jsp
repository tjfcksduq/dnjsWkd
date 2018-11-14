<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//   	session.removeAttribute("authMember");
	session.invalidate();
  	// 이동(index.jsp, redirct)
   	response.sendRedirect(request.getContextPath() + "/");
   
%>

    