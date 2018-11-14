<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	public Map<String,String[]> singerMap = new LinkedHashMap<>();
{
	singerMap.put("B001", new String[]{"고장환","/WEB-INF/namolla/go.jsp"});
	singerMap.put("B002", new String[]{"김경욱","/WEB-INF/namolla/kimKyoun.jsp"});
	singerMap.put("B003", new String[]{"김태환","/WEB-INF/namolla/kimTae.jsp"});
}
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>05/namoiiaForm.jsp</title>
<script type="text/javascript">
	function eventhandler(){
// 		document.forms[0].submit();
		document.naForm.submit();
	}

</script>

</head>
<body>
<form name ="naForm" action="<%=request.getContextPath() %>/05/getNa.jsp">
<select name="member" onchange="eventhandler()">
	<option value=""> 멤버 선택 </option>
	
	<%
	for(Entry<String,String[]> tmp :singerMap.entrySet()){
        out.println(String.format(
                "<option value=%s>%s</option>", tmp.getKey(), tmp.getValue()[0]
                   ));
	}
	
	 %>

	
	<option value="B001">고장환</option>
</select>




</form>

</body>
</html>