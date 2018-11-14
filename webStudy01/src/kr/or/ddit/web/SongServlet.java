package kr.or.ddit.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SongServlet extends HttpServlet {
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      resp.setContentType("text/html;charset=UTF-8"); // 요청에 대한 응답을 html로 보내줍니다.

      ServletContext context = req.getServletContext(); 
      File folder = new File("d:/contents");	// 경로
      String[] filenames = folder.list(new FilenameFilter() { // 필터가 된 text 형식의 파일을 filenames에 담는다.

         @Override
         public boolean accept(File dir, String name) {
            String mime = context.getMimeType(name); // 폴더에 있는 파일의 이름을 가져온다.(전체)
            return mime.startsWith("text/");  // <필터> text 형식만 가져올 수 있도록 필터를 생성
         }
      });

      InputStream is = this.getClass().getResourceAsStream("song.html"); // song.html을 가져온다.
      InputStreamReader isr = new InputStreamReader(is);	
      BufferedReader br = new BufferedReader(isr);
      StringBuffer html = new StringBuffer();
      String temp = null;

      while ((temp = br.readLine()) != null) {
         html.append(temp);
      }

      StringBuffer code = new StringBuffer(); // code가 담겨있는 탬플릿을 관리하기위함
      String pattern = "<option>%s</option>\n";	// pattern을 <option>%s</option>\n 형식으로 정의

      for (int i = 0; i < filenames.length; i++) {	//  filenames에 담긴 파일의 갯수만큼 반복문을 돌려준다.
         code.append(String.format(pattern, filenames[i])); // 위에서 정의된 패턴으로 filenames를 하나하나 넣어준다.
      }

      int start = html.indexOf("@musicList");	// @musicList 알파벳 하나하나의 갯수=숫자로 해준다
      int end = start + "@musicList".length(); 
      String replaceText = code.toString();	// code를 String으로 변환해준다

      html.replace(start, end, replaceText);

      PrintWriter out = resp.getWriter();
      out.print(html.toString());
      out.close();
   }
   
   //<form action="songs" method="post"> 에 method를 실행시킨다. 
   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      req.setCharacterEncoding("UTF-8");
      resp.setContentType("text/html;charset=UTF-8");
      // server-side 데이터 검증
      // 요청 파라미터 확보 : 파라미터명(image)
      String musicName = req.getParameter("music");
      if (musicName == null || musicName.trim().length() == 0) {	// 오류 검증
         resp.sendError(400);
         return;
      }
      File folder = new File("d:/contents");
      File lyricsFile = new File(folder, musicName); 
      if (!lyricsFile.exists()) {	// <오류검증> 선택하지 않았을때 오류로 처리한다.
         resp.sendError(404);
         return;
      }
      
      // 이미지 스트리밍....
      FileInputStream fis = new FileInputStream(lyricsFile);
      InputStreamReader isr = new InputStreamReader(fis, "EUC-KR");	// text의 한글을 읽어오기 위함
      BufferedReader br = new BufferedReader(isr);
      String pattern = "%s %s"; // 패턴을 정의
      String temp = null;
      
      StringBuffer html = new StringBuffer();
      html.append("<html>");	
      html.append("<head>");
      html.append("</head>");
      html.append("<body>");
      while ((temp = br.readLine()) != null) {
         html.append(String.format(pattern, temp,"<br>"));	// 패턴안에 text안에있는 한 줄을 넣고 <br>을 추가하여 한줄이 끝나면 다음줄로 넘어가게 한다.
      }
      br.close();	
      html.append("</body>");
      html.append("</html>");
      
      PrintWriter out = resp.getWriter();
      out.print(html);
      out.close();
   }
}