package kr.or.ddit.web;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.util.*;
import javax.servlet.annotation.*;

@WebServlet(value = "/gugudan.do")
public class GugudanServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String minDabnStr = req.getParameter("minDan");
		String maxDabnStr = req.getParameter("maxDan");

		int minDan = 2;
		int maxDan = 9;

		if (minDabnStr != null && minDabnStr.matches("\\d")) {
			minDan = Integer.parseInt(minDabnStr);
		}
		if (maxDabnStr != null && maxDabnStr.matches("[0-9]")) {
			maxDan = Integer.parseInt(maxDabnStr);
		}

		// 2~5단까지의 구구단을 table 태그를 이용하여 출력
		// 단, 한 행에 한 단씩
		// 테스트시에 /gugudan.do 요청을 사용
		// web.xml을 사용하지 말것
		resp.setContentType("text/html;charset=UTF-8");
		InputStream in = this.getClass().getResourceAsStream("gugudan.205");
		InputStreamReader isr = new InputStreamReader(in, "UTF-8");
		BufferedReader br = new BufferedReader(isr);
		StringBuffer html = new StringBuffer();
		String temp = null;
		while ((temp = br.readLine()) != null) {
			html.append(temp);

		}

		StringBuffer sb = new StringBuffer(); // 실제 구구단을 가지고있는 sb

		for (int dan = minDan; dan <= maxDan; dan++) {
			sb.append("<tr>");
			for (int mul = 1; mul <= 9; mul++) {
				sb.append(String.format("<td>%d * %d = %d</td>", dan, mul, dan * mul));
			}
			sb.append("</tr>");
		}

		int start = html.indexOf("@gugudan");
		int end = start + "@gugudan".length();
		String replacetext = sb.toString();

		html.replace(start, end, replacetext);

		PrintWriter out = resp.getWriter();
		out.println(html.toString());
		out.close();
	}


}
