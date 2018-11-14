package kr.or.ddit.web;

import java.io.IOException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.Session;
import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.vo.AlbasengVO;

@WebServlet(value="/albamon", loadOnStartup=1)
public class SimpleFormProcessServlet extends HttpServlet {
   public  Map<String, String> gradeMap;
   public  Map<String, String> licenseMap;
    {
      gradeMap = new HashMap<String, String>();
      licenseMap = new LinkedHashMap<>();
      
      gradeMap.put("G001", "고졸");
      gradeMap.put("G002", "대졸");
      gradeMap.put("G003", "석사");
      gradeMap.put("G004", "박사");
      
      licenseMap.put("L001", "정보처리산업기사");
      licenseMap.put("L002", "정보처리기사");
      licenseMap.put("L003", "정보보안산업기사");
      licenseMap.put("L004", "정보보안기사");
      licenseMap.put("L005", "SQLD");
      licenseMap.put("L006", "SQLP");
   }
   public Map<String, AlbasengVO> albasengs = new LinkedHashMap<>();
   
   @Override
   public void init(ServletConfig config) throws ServletException {
      super.init(config);
      getServletContext().setAttribute("gradeMap", gradeMap);
      getServletContext().setAttribute("licenseMap", licenseMap);
      getServletContext().setAttribute("albasengs", albasengs);
      System.out.println(getClass().getSimpleName()+" 초기화");
   }
   
   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      
      req.setCharacterEncoding("utf-8");
      //resp.setContentType("text/html;charset=UTF-8");
      
   /*      
       1)하드코딩
   */
      String name =  req.getParameter("name");
      String age =  req.getParameter("age");
      String tel =  req.getParameter("tel");
      String addr =  req.getParameter("address");
      String gender =  req.getParameter("gender");
      String grade =  req.getParameter("grade");
      String career =  req.getParameter("career");
      String[] license = req.getParameterValues("license");
      AlbasengVO vo = new AlbasengVO();
      
      vo.setName(name);
      if(age!=null && age.matches("\\d{1,2}")) {
         vo.setAge(new Integer(age));
      } 
      vo.setAddress(addr);
      vo.setTel(tel);
      vo.setGender(gender);
      vo.setGrade(grade);
      vo.setLicense(license);
      vo.setCareer(career);
      boolean valid = true;
      Map<String, String> errors = new LinkedHashMap<>();
      req.setAttribute("errors", errors);
      if(StringUtils.isBlank(vo.getName())) {
         valid = false;
         errors.put("name", "이름누락");
      }
      if(StringUtils.isBlank(vo.getTel())) {
         valid = false;
         errors.put("tel", "전화번호누락");
      }
      if(StringUtils.isBlank(vo.getAddress())) {
         valid = false;
         errors.put("address", "주소누락");
      }
      boolean redirect = false;
      String goPage = null;
      if(valid) {
         vo.setCode(String.format("alba_%03d", albasengs.size()+1));
         albasengs.put(vo.getCode(), vo);
         goPage = "/05/albaList.jsp";
         redirect = true;
      }else {
         goPage = "/01/simpleForm.jsp";
         req.setAttribute("albaVO", vo);
         
      }
      if(redirect) {
         resp.sendRedirect(req.getContextPath() + goPage);
      }else {
         RequestDispatcher rd = req.getRequestDispatcher(goPage);
         rd.forward(req, resp);
      }

//      //2) getParameterMap
//      Map<String, String[]> params = req.getParameterMap();
//      
//      /*      
//      Iterator it = params.keySet().iterator();
//      
//      String key = null;
//      String[] value = null;
//      while (it.hasNext()) {
//         key = (String) it.next();
//         value = params.get(key);
//         
//         for(int i=0; i< value.length ; i++) {
//            System.out.println("key = "+key+"| value = "+value[i]);
//         }
//      }
//      */
//      
//      for(Entry<String, String[]> entry : params.entrySet()) {
//         String name = entry.getKey();
//         String[] values = entry.getValue();
//         System.out.printf("%s : %s", name, Arrays.toString(values)+"\n");
//      }
//      
//      System.out.println("***************************************************");
//      
//      //3) getParametarNames
//      Enumeration<String> names = req.getParameterNames(); 
//      while (names.hasMoreElements()) {
//         String name = (String) names.nextElement();
//         String[] values = req.getParameterValues(name);
//         System.out.printf("%s : %s", name, Arrays.toString(values)+"\n");
//      }

      
   }

}