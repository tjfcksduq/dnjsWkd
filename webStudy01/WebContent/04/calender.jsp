<%@page import="java.util.Locale"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.util.Calendar"%>
<%@page import="static java.util.Calendar.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>04/calendar.jsp</title>
<style>
   .sunday{
      background-color: red;
   }
   .saturday{
      background-color: blue;
   }
   table{
      width: 100%;
      height: 500px;
      border-collapse: collapse;
   }
   td,th{
      border: 1px solid black;
   }
</style>
<script type="text/javascript">
   function eventHandler(year, month) {		// year과 month의 eventHandler
      var form = document.forms[0];			// form을 가져온다
      if((year && month) || month==0 ){		// year, month가 값을 가지고 있다 -> true // month==0 -> true 
         form.year.value=year;				// form 안에 year에 year값을 넣어준다
         form.month.value=month;			// form 안에 month에 month 값을 넣어준다
      }
      form.submit();						// form에 submit
      return false;							// 위의 조건을 만족하지 못한다면 false 값을 반환한다
   }
</script>
</head>
<body>
<%
   request.setCharacterEncoding("UTF-8");				// UTF-8로 셋팅
   String yearStr = request.getParameter("year");		// year 셋팅
   String monthStr = request.getParameter("month"); 	// month 셋팅
   String language = request.getParameter("language");	// language 셋팅
   Locale clinetLocale = request.getLocale();			// 국가들을 가져온다
   
   //언어를 선택하면 그 언어로 바뀌게 설정
   if(language!=null && language.trim().length()>0){
	   // 언어를 선택했을 때, 선택한 언어로 바뀐다
      clinetLocale = Locale.forLanguageTag(language);
   }
   
   // 월~일(요일)을 가져와서 셋팅해준다
   DateFormatSymbols symbols = new DateFormatSymbols(clinetLocale);
   
   // calender 객체를 가져온다
   Calendar cal = getInstance();
   
   //if문에 속하면 파라미터값으로 받은 년/월로 셋팅된다.
   if(yearStr !=null && yearStr.matches("\\d{4}")	// 년도를 4개의 숫자로 매치
         && monthStr != null && monthStr.matches("1[0-1]|\\d")){	// 월을 셋팅 (첫숫자는 0~1)
      cal.set(YEAR, Integer.parseInt(yearStr));		// 캘린더에 년도를 셋팅해준다
      cal.set(MONTH, Integer.parseInt(monthStr));	// 캘린더에 월을 셋팅해준다
   }
   int currentYear = cal.get(YEAR);
   int currentMonth = cal.get(MONTH);
   
   cal.set(DAY_OF_MONTH, 1);	// 달력의 날짜를 1일로 셋팅한다
   int firstDayOfWeek = cal.get(DAY_OF_WEEK); // 처음 시작하는 요일을 가져온다
   int offset = firstDayOfWeek -1;	// 공백을 처리한다
   int lastDate = cal.getActualMaximum(DAY_OF_MONTH);	// 마지막 일을 셋팅한다
   
   //이전달
   cal.add(MONTH, -1);	
   int beforeYear = cal.get(YEAR);	
   int beforeMonth = cal.get(MONTH);
   
   //다음달                
   cal.add(MONTH, 2);
   int nextYear = cal.get(YEAR);
   int nextMonth = cal.get(MONTH);
   
   //현재 시스템에서 제공하는 모든 locale정보 제공
   Locale[] locales = Locale.getAvailableLocales();
%>
<form>
<h4>
<a href="javascript:eventHandler(<%=beforeYear %>, <%=beforeMonth%>);">이전달</a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="number" name="year" value="<%=currentYear%>"
   onblur="eventHandler();"
/>년
<select name="month" onchange="eventHandler();">
   <%
      String[] monthStrings = symbols.getShortMonths();		// getShortMonths->월 // getLongMonths
      for(int idx = 0; idx < monthStrings.length; idx++){	// 
         out.println(String.format("<option value='%d' %s>%s</option>", 
               idx, idx==currentMonth?"selected":"" ,monthStrings[idx]));
      }
   %>
</select>
<select name="language" onchange="eventHandler();">
   <%
      //언어선택 UI   
      for(Locale tmp : locales){
         out.println(String.format("<option value='%s' %s>%s</option>", tmp.toLanguageTag(),
               tmp.equals(clinetLocale)?"selected":"",tmp.getDisplayLanguage(clinetLocale)));         
      }
   %>
</select>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a onclick="eventHandler(<%=nextYear%>,<%=nextMonth%>);">다음달</a>
</h4>
</form>
<table>
<thead>
   <tr>
      <%
         //요일출력
         String[] dateStrings = symbols.getShortWeekdays();
         for(int idx = Calendar.SUNDAY; idx<=Calendar.SATURDAY; idx++){
            out.println(String.format("<th>%s</th>", dateStrings[idx]));
         }
      %>
   </tr>
</thead>
<tbody>

<%
   //날짜 출력
   int dayCount = 1;
   for(int row=1; row <=6; row++){
      %>
      <tr>
      <%
      for(int col=1; col <=7; col++){
         int dateChar = dayCount++ - offset; //날짜를 맞게 출력
         if(dateChar < 1 || dateChar > lastDate){
            out.println("<td>&nbsp;</td>");
         }else{   
            String clzValue = "normal";
            if(col==1){
               clzValue = "sunday";
            }else if(col==7){
               clzValue = "saturday";
            }
         out.println(String.format(
               "<td class='%s'>%d</td>", clzValue, dateChar
               ));
         }
      }
      %>
      </tr>
      <%
   }
%>
</tbody>
</table>
</body>
</html>