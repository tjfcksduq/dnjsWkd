package kr.or.ddit.web;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.web.calculate.Operator;

public class CalculateServlet extends HttpServlet {
	
	@Override
		public void init(ServletConfig config) throws ServletException {
			super.init(config);
			ServletContext application = getServletContext();
			String contentFolder = application.getInitParameter("contentFolder");
			File folder = new File(contentFolder);
			application.setAttribute("contentFolder", folder);
			System.out.println(getClass().getSimpleName()+"초기화");
		}
//   @FunctionalInterface
//   interface RealOperator{
//      public int operate(int left, int right);
//   }
//   enum Operator{
//      ADD("+",new RealOperator() {
//         @Override
//         public int operate(int left, int right) {
//            return left+right;
//         }
//      }), 
//      MINUS("-",(left,right)->{return left-right;}),
//      MULTIPLY("*",(a,b)->{return a*b;}),
//      DIVIDE("/",(c,d)->{return c/d;});
//      
//      private String sign;
//      private RealOperator realOperator;
//      Operator(String sign,RealOperator realOperator){
//         this.sign = sign;
//         this.realOperator = realOperator;
//      }
//      public String getSign(){
//         return this.sign;
//      }
//      public int operator(int left,int right) {
//         return realOperator.operate(left,right);
//      }
//   }
//   
   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

      
	   //파라미터 확보(입력태그의name 속성값으로 이름 결정)
      String leftOp = req.getParameter("leftOp");
      String rightOp = req.getParameter("rightOp");
      String operatorStr = req.getParameter("operator");
      
      //검증
      //불통 400에러발생
      /*int left=0;
      int right=0;
      try {
         left = Integer.parseInt(leftOp);
         right = Integer.parseInt(rightOp);
      } catch (Exception e) {
         resp.sendError(400); // 에러메세지 전송, 400->상태코드
           return;
      }
      
      if(operator==null || operator.length()==0) {   // 파라미터에 대한 검증과정
            resp.sendError(400); // 에러메세지 전송, 400->상태코드
            return;
       }*/
      int left,right;
      boolean valid=true;
      if(leftOp==null || !leftOp.matches("\\d+")|| rightOp==null||!rightOp.matches("\\d{1,6}")) {
         valid=false;
      }
      Operator operator = null;
      try {
         operator = operator.valueOf(operatorStr.toUpperCase());
      }catch (Exception e) {
         valid=false;
      }
      if(!valid) {
         resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
      }
      //통과
      //연산자에 따라 연산 수행
       //연산결과 : 2*3=6
      
      left = Integer.parseInt(leftOp);
      right = Integer.parseInt(rightOp);
      String pattern = "%d %s %d = %d";
      String result =String.format(pattern,left,operator.getSign(),right,operator.operator(left,right));
      
      String accept = req.getHeader("Accept");
      String mime = null;
    
      if(accept.contains("plain")) {
    	  mime = "text/plain;charset=UTF-8";
      }else if(accept.contains("json")) {
    	  mime = "application/json;charset=UTF-8";
    	  result = "{\"result\":\""+ result+"\"}";
      }else {
    	  mime = "text/html;charset=UTF-8";
    	  result = "<p>"+ result + "</p>";
      }
      
      //일반 텍스트의 형태로 연산결과를 제공
      resp.setContentType(mime);
      
      //출력
      PrintWriter out = resp.getWriter();
      out.println(result);
      out.close();
      
   }
}