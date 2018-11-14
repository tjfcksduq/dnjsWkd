<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" buffer="1kb" autoFlush="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>06/bufferDesc.jsp</title>
</head>
<body>
<h4>출력 버퍼의 활용</h4>
<pre>
	기본으로 제공되는 8KB의 버퍼, 출력스트림을 통한 응답 전송 속도 향상
						   버퍼 방출전에는 헤더나 버퍼의 내용 변경이 가능
						   (에러페이지나 Dispatch방식의 이동이 가능) 
	버퍼의 확인 및 제어에 out 기본 객체 활용

	<%=out.getRemaining() %> bytes	
	<%
		for(int count =1; count<=200; count++){
			out.println("빈복돌때마다 얼마씩 버퍼가 사용될까?" + count+"번째");
			if(count%20==0){
				out.flush();
			}
			if(count==190){
// 				throw new NullPointerException("강제 발생 예외");
				RequestDispatcher rd =  request.getRequestDispatcher("/05/distination.jsp");
				rd.forward(request, response);
				
			}
			
		}
	
	%>
	
	
</pre>
</body>
</html>












