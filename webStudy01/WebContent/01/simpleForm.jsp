<%@page import="java.util.LinkedHashMap"%>
<%@page import="kr.or.ddit.vo.AlbasengVO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Objects"%>
<%@page import="java.util.Map.Entry"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   Map<String,String> gradeMap = (Map<String,String>)application.getAttribute("gradeMap");
   Map<String,String> licenseMap = (Map<String,String>)application.getAttribute("licenseMap");
   
   AlbasengVO albaVO =  (AlbasengVO)request.getAttribute("albaVO");
   if(albaVO==null) albaVO= new AlbasengVO();
   
   Map<String,String> errors = (Map<String,String>)request.getAttribute("errors");
   if(errors==null) errors= new LinkedHashMap<>();   

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
   .error{
      color: red;
   }
</style>
</head>
<body>
<!-- 알바몬에서 알바생의 프로필을 입력받으려고 함. -->
<form action="<%= request.getContextPath() %>/albamon" method="post">
   <table>
      <tr>
         <th>이름</th>
         <td>
            <input type="text" name="name" value="<%=Objects.toString(albaVO.getName(), "") %>" 
               
            />
            <span class="error">
               <%=Objects.toString( errors.get("name"), "") %>
            </span>
         </td>
      </tr>
      
      <tr>
         <th>나이</th>
         <td>
            <input type="number" name="age" min="15" max="40"
               value="<%=Objects.toString(albaVO.getAge(), "") %>"
            />
         </td>
      </tr>
      
      <tr>
         <th>전화번호</th>
         <td>
            <input type="tel" name="tel" placeholder="000-0000-0000" 
               pattern="\d[3}-[0-9]{3,4}-\d{4}"
               required="required"
               value="<%=Objects.toString(albaVO.getTel(), "") %>"
               />
            <span class="error">
               <%=Objects.toString( errors.get("tel"), "") %>
            </span>
         </td>
      </tr>
      
      <tr>
         <th>주소</th>
         <td>
            <input type="text" name="address"
               required="required"
               value="<%=Objects.toString(albaVO.getAddress(), "") %>"
            />
            <span class="error">
               <%=Objects.toString( errors.get("address"), "") %>
            </span>
         </td>
      </tr>
      
      <tr>
         <th>성별</th>
         <td>
            <label><input type="radio" name="gender" value="M"
                     <%="M".equals(albaVO.getGender())?"checked":"" %>
                  />남</label>
            <label><input type="radio" name="gender" value="F"
                     <%="F".equals(albaVO.getGender())?"checked":"" %>
                  />여</label>
         </td>
      </tr>
      
      <tr>
         <th>학력</th>
         <td>
            <select name="grade">
               <option value="">학력</option>
               <%
                  String pattern = "<option value='%s' %s>%s</option>";
                  for(Entry<String,String> entry : gradeMap.entrySet()){
                     String selected = "";
                     if(entry.getKey().equals(albaVO.getGrade())){
                        selected = "selected";
                     }
                     out.println(String.format(pattern, entry.getKey(), selected ,entry.getValue()));
                  }
               %>
            </select>
         </td>
      </tr>
      
      <tr>
         <th>경력</th>
         <td>
            <textarea name="career" rows="3" cols="100"><%=Objects.toString(albaVO.getCareer(), "") %></textarea>
         </td>
      </tr>
      
      <tr>
         <th>자격증</th>
         <td>
            <select name="license" multiple="multiple" size="10">
               <%
                  if(albaVO.getLicense()!=null){
                     Arrays.sort(albaVO.getLicense());
                  }
                  for(Entry<String,String> entry : licenseMap.entrySet()){
                     String selected = "";
                     if(albaVO.getLicense()!=null && Arrays.binarySearch(albaVO.getLicense(), entry.getKey()) >-1){
                        selected = "selected";
                     }
                     out.println(String.format(pattern, entry.getKey(), selected,entry.getValue()));
                  }
               %>
            </select>
         </td>
      </tr>
      
      <tr>
         <td>
            <input type="submit" value="등록"/>
            <input type="reset" value="취소"/>
            <input type="button" value="걍버튼"/>
         </td>
      </tr>
   
   </table>
</form>
</body>
</html>