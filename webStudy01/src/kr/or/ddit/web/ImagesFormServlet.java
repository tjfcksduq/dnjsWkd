package kr.or.ddit.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ImagesFormServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html;charset=UTF-8"); // 출력스트림을 개방하기 전에 해야한다
		ServletContext context =  req.getServletContext();
		String contentFolder = context.getInitParameter("contentFolder");
		
		
		
		
		File folder = new File("d:/contents");
		String[] filenames =  folder.list(new FilenameFilter() {
			
			@Override
			public boolean accept(File dir, String name) {
				String mime = context.getMimeType(name);
				return mime.startsWith("image/");
			}
		});
		
		// action 속성의 값은 context/imageService, method="get"
		

		resp.setContentType("text/html;charset=UTF-8");
		InputStream in = this.getClass().getResourceAsStream("image.html"); // 바이트스트림을 가져옴
		InputStreamReader isr = new InputStreamReader(in,"UTF-8"); // 가져온 바이트스트림을 UTF-8로 (캐릭터스트림으로 변경)
		BufferedReader br = new BufferedReader(isr); // Reader은 캐릭터스트림의 상위
		StringBuffer html = new StringBuffer(); //  탬플릿을 관리하기 위함, 탬플릿 코드가 담겨있다
		
		
		String temp = null;
		while ((temp = br.readLine()) != null) {
			html.append(temp); // 계속해서 temp의 상태를 변경

		}

		StringBuffer sb = new StringBuffer(); // sb안에 
		
		/* 	String pattern = "<option>%s</option>\n";
		for(String name : filenames) {
			sb.append(String.format(pattern,name));
		}
		*/
		
		for(int i=0; i<filenames.length; i++) {
			sb.append("<option value="+ filenames[i]+">" + filenames[i]+"</option>" );
		}
		
		
		int start = html.indexOf("@imageList"); // 어디서부터 시작인가
		int end = start + "@imageList".length(); // 길이를 더해줘서 end를 찾는다
	//	String replacetext = sb.toString();

		html.replace(start, end, sb.toString()); // s,e 바꿀위치 , re -> imageList들을 찾아서 바꿔줌

		PrintWriter out = resp.getWriter();
		out.println(html); // 완성본이 html안에 담겨있다.
		out.close();
		
		
		
	}
}


















