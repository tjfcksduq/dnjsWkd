<%@page import="java.util.Map.Entry"%>
<%@page import="kr.or.ddit.web.SimpleFormProcessServlet"%>
<%@page import="kr.or.ddit.vo.AlbasengVO"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
	<thead>
		<tr>
			<th>알바생코드</th>
			<th>이름</th>
			<th>주소</th>
			<th>연락처</th>
		
		</tr>
	</thead>

<tbody>
<%
	Map<String, AlbasengVO> albaMap = SimpleFormProcessServlet.albasengs;
	for(Entry<String, AlbasengVO> entry : albaMap.entrySet()){
		String pattern = "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>";
		AlbasengVO alba = entry.getValue();
		out.println(String.format(pattern, alba.getCode(), alba.getName(), alba.getAddress(), alba.getTel()));
		
	}
%>

</tbody>

</table>



</body>
</html>