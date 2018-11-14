<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>06/scopeDesc.jsp</title>
</head>
<body>
<h4>Scope(영역)</h4>

<pre>
	: 웹어플리케이션에서 데이터를 공윺할 때 사용할 수 있는 메모리
	: 각 영역은 해당 영역을 제어할 때 기본객체를 사용하고
	   그 기본객체와 동일한 생명주기를 가짐
	   속성(attribute) : scope를 통해 공유되는 데이터(이름:값)
	   
	1. page Scope(pageCintext) : 하나의 JSP페이지 내에서 유효한 영역
	2. request Scope(request) : 하나의 request와 동일 생명주기로 관리되는 영역
	3. session Scope(session) : 한 세션 내에서  관리되는 영역
	4. application Scope(application) : 웹 어플리케이션에서 전역 데이터 관리 영억
	<%
		pageContext.setAttribute("pageContextAttr", "페이지영역설정");
		request.setAttribute("requestAttr", "리퀘스트 영역 속성");
		session.setAttribute("sessionAttr", "세션 영역 속성");
		application.setAttribute("applicationAttr", "어플리케이션 영역 속성");
	
// 		pageContext.forward("/05/destination.jsp");
		response.sendRedirect(request.getContextPath() + "/05/destination.jsp");
	%>	
	<%=pageContext.getAttribute("pageContextAttr") %>
	<%=request.getAttribute("requestAttr") %>
	<%=session.getAttribute("sessionAttr") %>
	<%=application.getAttribute("applicationAttr") %>

</pre>
</body>
</html>