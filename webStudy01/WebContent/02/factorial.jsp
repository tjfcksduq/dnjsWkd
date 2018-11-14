<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%!
	BigDecimal factorial(int operand){
	if(operand<0){
		throw new IllegalArgumentException("음수는 펙토리얼 연산 불가");
	}else if(operand <=1){
			return new BigDecimal(operand);
		}else{
		return new BigDecimal(operand).multiply(factorial(operand-1));
		}
}
%>    
    
<%
	String opStr = request.getParameter("operand");
	boolean flag = false;
	if(opStr !=null && opStr.matches("\\d{2}|100")){
		flag = true;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>02/factorial.jsp</title>
</head>
<body>
<form action="<%= request.getContextPath() %>/02/factorial.jsp">
	Factoral operand : <input type="number" min="1" max="100" name="operand" value="opStr" />
	
	<button type="submit">전송</button>

</form>


<%

if(flag){
	int operand = Integer.parseInt(opStr);

%>
<div>
	<%=factorial(operand) %>
	
</div>

<%
}
%>

</body>
</html>