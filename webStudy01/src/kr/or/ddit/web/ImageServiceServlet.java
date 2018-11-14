package kr.or.ddit.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(value = "/imageService") // image.205에서 action이 향하는 방향
public class ImageServiceServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		
		// 요청 파라미터 확보 : 파라미터명(image)
		
		String imgStr = req.getParameter("img");
		if(imgStr==null || imgStr.trim().length()==0) {	 // 파라미터에 대한 검증과정
			resp.sendError(400); // 에러메세지 전송, 400->상태코드
			return;
		}
		
		
		File folder = new File("d:/contents");
		File imgFile = new File(folder, imgStr);
		if(!imgFile.exists()) {   //exists() 존재하는지의 여부에 대한 검증
			resp.sendError(404); // 찾지 못한다
			return;
		}
		
		ServletContext context = req.getServletContext();
		resp.setContentType(context.getMimeType(imgStr));
		

		//File file = new File("D:\\contents\\"+imgStr);
		
		// 이미지 스트리밍...

	    FileInputStream fis = new FileInputStream(imgFile);
	    OutputStream out = resp.getOutputStream();
	    byte[] buffer = new byte[1024];
	    int pointer = -1;
	    while((pointer = fis.read(buffer))!=-1){ // buffer를 파라미터로 넘긴다 . 읽어들이 메소드는 buffer안에 있음 // -1: EOF문자
	    		out.write(buffer,0, pointer); // 읽어들인 만큼만  
	      }
	      fis.close();
	      out.close();
		

		
	}

}

