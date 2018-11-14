<%@page import="java.util.Calendar"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
// 	response.setHeader("ContentType", "text/html;charset=UTF-8");
	response.setContentType("text/html;charset=UTF-8");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>04/responseDesc.jsp</title>
</head>
<body>
<h4>Http Response</h4>
<pre>
	Http의 response 패키징 방식
	1) Response Line : Response statusm Protocol/ver
		Response Status Code (응답 상태 코드)
		-100  : ing ... Http1.1 부터 하위 프로토콜로 websocket이 사용됨(connectful)
			** Http : Connectless, Statusless 
		-200 : OK, SUCCESS (정상처리)
		-300 : 클라이언트위 추가 액션이 필요한 경우
			304(Not Modified)
			302/307(Moved)
		-400 : Client 쪽 문제로 처리 실패
			404(Not Found), 400(Bad Request),
			405(Method Not Allowed),
			401(UnAuthorlized), 403(Forbiden)
		-500 : Server 쪽 문제로 처리 실패
			500(Internal Server Error)
			
	2) Response Header : 서버나 응답데이터에 대한 부가정보 (meradata)
		response header name : header value
		
	3) Response Body(Message Body) : 응답 컨텐츠
	
		** httpServerResponse를 통한 응답 제어
			: 서버에서 클라이언트로 전송되는 응답에 대한 모든 데이터를 가진 객체
		1) 응답데이터를 전송하기 위한 출력 스트림 확보
			char stream(PrintWrite) getWriter(), 
			byte stream(ServletOutputStream) getOutputStream()
		2) setStatus(status_code) : 200/300 사용
		   sendError(status_code) : 400/500 사용, 서버의 에러페이지로 자동 연결
		3) setHeader(header_name, header_value)
		   setIntHeader(header_name, header_value)	
		   setDateHeader(header_name, long header_value)
		   
		   응답 헤더를 설정하는 경우
		   a) MIME 설정 : Content-Type
		   	  setHeader, serContentType, page 지사자의 contentType 속성
		   b) Cache 제어 : Cache-Control(HTTP/1.1), Pragma(HTTP/1.0), ExPires
		    <%
		    //  캐시를 저장하지 않도록 설정
// 		    	response.setHeader("Pragma", "no-cache");
// 		    	response.setHeader("Cache-control", "no-cache");
// 		    	response.addHeader("Cache-control", "no-store");
// 		    	response.setDateHeader("Expires", 0);
		    
		    //  캐시를 저장하도록 설정
		    int maxAge = 60*60*24*7;
		    response.setHeader("Pragma", "public;max-age="+maxAge);
		    response.setHeader("Cache-Control", "public;max-age="+maxAge);
		    Calendar today =  Calendar.getInstance();
		    today.add(Calendar.SECOND ,maxAge);
		    response.setDateHeader("Expires", today.getTimeInMillis());
		    %>
		   c) Auto Request : Refresh
		   
		   d) Page Move(Flow Control) : Location
		   
		   

</pre>
</body>
</html>