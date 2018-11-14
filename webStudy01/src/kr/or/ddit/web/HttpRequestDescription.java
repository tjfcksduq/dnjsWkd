package kr.or.ddit.web;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jdk.nashorn.internal.ir.RuntimeNode.Request;

/**
 * Http 프로토콜의 request package 규칙
 * Request Line : URL, Http Method, Protocol/version
 * Http Method(Request Method) : 햔재 요청의 목적/의도/수단/방식
 * GET : 조회 (R)
 * 	   : body가 존재하지 않기때문에, 전송할 최소한의 데이터를 Line의 URL에 덧붙임
 * 	   : ex) http://localhost/webStudy01/gugudan.do?minDan=3&maxDan=8
 * 	    	주소:포트넘버/세부경로?QueryString
 * 	   		QueryString : segment&segment2&...
 * 	   		segment : param_name=param_value
 * POST : (신규) 전송 및 등록 (C)
 * PUT : 전송 및 수정 (U)
 * DELETE : 삭제 (D)
 * TRACE : 디버깅
 * OPTION : ex) http method의 지원여부 확인
 * HEAD : 응답데이터를 body가 없는 형태로 받는다
 * Request Header : 클라이언트와 요청에 관한 부가정보(metadata)
 * 				      헤더명 : 헤더값 ....  
 * Request Body(Contents, Message body) : method가 POST일 경우, 형성
 * 		: 클라이언트가 서버로 전송할 데이터들 ....(요청 파라미터)
 * 
 * ** client의 요청정보를 서버에서 확인하는 방법
 * HttpServletRequest의 활용
 * 1) 파라미터 확보 : 기본적으로 모든 파라미터는 문자열의 형태로 전송됨.
 * 		String getParameter(name) : 하나의 파라미터명으로 하나의 값이 전송
 * 		String[] getParameterValues(name) : 동일한 파라미터명으로 여러개의 값이 전송
 * 		Enumeration getParameterNames() 
 * 		** Map<String,String[]> getParameterMap()
 * 2) 요청 해더의 확보
 * 		String getHeader(name) : 모든 헤더는 문저열로 전송
 * 		getIntHeader(name)
 * 		long getDateHeader(name) : 날짜 확인시, new Date(long)
 * 		Enumeration getHeaders(name)
 * 		Enumeration getHeaderNames()
 * 3) 기타 요청과 관련된 메소드들 ...
 * 		service 메소드에 기술됨 (참고)
 * 
 * 		
 * 
 * 
 * 
 * 
 * 		
 */
@WebServlet("/httpReq.do")


public class HttpRequestDescription extends HttpServlet {

	public void init(ServletConfig config) throws ServletException {
		// 객체 초기화 직후
	}


	public void destroy() {
		// 객체 소멸전 
	}


	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println(req.getCharacterEncoding());
		System.out.println(req.getContentType());
		System.out.println(req.getContentLength());
		System.out.println(req.getContextPath());
		System.out.println(req.getLocalAddr());
		System.out.println(req.getRemoteAddr());
		System.out.println(req.getRemotePort());
		System.out.println(req.getMethod());
		System.out.println(req.getRequestURI());
		System.out.println(req.getProtocol());
		
		
		
		
		// 매 요청시 마다 호출
		// Http method에 사오간없이 실행될 코드를 넣는다
		super.service(req, resp);
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

}
