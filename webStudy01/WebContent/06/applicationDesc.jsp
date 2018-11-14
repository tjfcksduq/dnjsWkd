<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8http://localhost/webStudy01/06/implicitObject.jsp">
<title>applicationDesc.jsp</title>
</head>
<body>
<h4>ServletContext</h4>
<pre>
	<%=application.hashCode() %>
	<a href="<%=request.getContextPath()%>/06/implicitObject.jsp">implicitObject.jsp로 이동</a>
	<a href="<%=request.getContextPath()%>/desc">DescriptionServlet으로 가기</a>
	: 컨텍스트와 해당 컨텍스트를 운영(관리)중인 서버에 대한 정보를 가진 객체
	
	1. 서버에 대한 정보를 획득
		<%=application.getServerInfo() %>
		<%=application.getMajorVersion() %>.<%=application.getMinorVersion() %>
		<%=application.getMimeType("test.hwp") %>
		
	2. 로그를 기록
		<%
			application.log("명시적으로 기록한 로그 메시지");
		%>
	3. 컨텍스트 파라미터(어플리케이션의 초기화 파라미터) 획득
	<%=application.getInitParameter("param1") %>
	<%
	Enumeration<String> names=  application.getInitParameterNames(); 
	while(names.hasMoreElements()){
		out.println(application.getInitParameter(names.nextElement()));
	}
	%>
		
	4. 웹리소스를 획득 : http://localhost/webStudy01/images/Koala.jpg
	
	<%=application.getRealPath("/images/Koala.jpg") %>
	
	<%
		String fileSystemPath = application.getRealPath("/images/Koala.jpg");
		File srcFile = new File(fileSystemPath);
// 		out.println(srcFile.getAbsolutePath());
		File targetFolder = new File(application.getRealPath("/06"));
		File targetFile = new File(targetFolder,srcFile.getName());
		System.out.println(targetFile.exists());
		int pointer = -1;
		byte[] buffer = new byte[1024];
		try(
			//FileInputStream fis = new FileInputStream(srcFile);
			InputStream fis = application.getResourceAsStream("/images/Koala.jpg");
			FileOutputStream fos = new FileOutputStream(targetFile);
		){
			while((pointer = fis.read(buffer))!=-1){
				fos.write(buffer,0,pointer);
			}
		}
		System.out.println(targetFile.exists());
		
		//FileInputStream fis = new FileInputStream(srcFile);
		//FileOutputStream fos= new FileOutputStream(targetFolder);
		
		
		
		
	/*	
		FileInputStream fis = null;
		FileOutputStream fos = null;
		String newFile = application.getRealPath("/06/Koala.jpg"); // 임의의 경로를 만든다
		byte[] buffer = new byte[1024];
		int po = -1;
		
		
		try{
			fis = new FileInputStream(srcFile);
			fos = new FileOutputStream(newFile);
			
			while((po= fis.read(buffer)) != -1){
				fos.write(buffer,0,po);
			}

		}catch(Exception e){
		      fis.close();
		      fos.close();
		}
*/		
		
		
		
		
		
		
		
		
		
		
		
	%>
	
	
	
</pre>
<img src="<%=request.getContextPath() %>/06/Koala.jpg" />
<img src="<%=request.getContextPath() %>/images/Koala.jpg" />

</body>
</html>