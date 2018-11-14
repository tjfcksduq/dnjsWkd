<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--     1. 파라미터 확보 -->
<!--     2. 검증(필수데이터 검증, 유효데이터 검증) -->
<!--     3. 불통 -->
<!--     	1) 필수데이터 누락 : 400 -->
<!--     	2) 우리가 관리하지 않는 멤버를 요구한 경우 : 404 -->
<!--     4. 통과 -->
<!--     	이동(맵에 있는 개인 페이지, 클라이언트가 멤버 개인페이지의 주소를 모르도록) -->
<!--     	이동(맵에 있는 개인 페이지, getNa에서 원본 요청을 모두 처리했을 경우, UI 페이지로 이동할 떄) -->
<%!
	public Map<String,String[]> singerMap = new LinkedHashMap<>();
{
	singerMap.put("B001", new String[]{"고장환","/WEB-INF/namolla/go.jsp"});
	singerMap.put("B002", new String[]{"김경욱","/WEB-INF/namolla/kimKyoun.jsp"});
	singerMap.put("B003", new String[]{"김태환","/WEB-INF/namolla/kimTae.jsp"});
}

%>

<%
	String a = request.getParameter("member");

	int statusCode=0;
	if(a == null || a.trim().length()==0){
		statusCode=HttpServletResponse.SC_BAD_REQUEST;
			
	}else if(!singerMap.containsKey(a)){	//정상처리 불가능 400에러 발생
		statusCode = HttpServletResponse.SC_NOT_FOUND;
	}
	if(statusCode!=0){
		response.sendError(statusCode);
		return;
	}

	String[] value = singerMap.get(a);
	String goPage = value[1];
	
// 	response.sendRedirect(request.getContextPath() + goPage);
	
	
	
	RequestDispatcher rd = request.getRequestDispatcher(goPage);
	rd.forward(request, response);
	
// 	RequestDispatcher rd =  request.getRequestDispatcher(singerMap.get(a)[1]);
	
// 	rd.forward(request, response);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getNa.jsp</title>
</head>
<body>

</body>
</html>