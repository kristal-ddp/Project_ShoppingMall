package com.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.DBConn;

public class MemberServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url)
			throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		String cp = req.getContextPath();
		String uri = req.getRequestURI();

		Connection conn = DBConn.getConnection();
		MemberDAO dao = new MemberDAO(conn);

		String url;

		String sessionUserId = (String) req.getSession().getAttribute("userId");
		String userId = null;
		
		if (sessionUserId != null) {
			userId = sessionUserId;
		}

		

		// 로그아웃상태
		if (userId == null) {
			
			// 회원가입 화면
			if (uri.indexOf("join.do") != -1) {

				url = "/member/join.jsp";
				forward(req, resp, url);

			// 회원가입 실행
			} else if (uri.indexOf("join_ok.do") != -1) {

				int result;
				MemberDTO dto = new MemberDTO();

				dto.setUserId(req.getParameter("userId"));
				dto.setUserPwd(req.getParameter("userPwd"));
				dto.setUserName(req.getParameter("userName"));
				dto.setUserGender(req.getParameter("userGender"));
				dto.setUserBirth(req.getParameter("userBirth"));
				dto.setUserAddress(req.getParameter("userAddress"));
				dto.setUserEmail(req.getParameter("userEmail"));
				dto.setUserTel(req.getParameter("userTel"));
				

				result = dao.insert(dto);

				if (result == 0) {

					out.print("<script>");
					out.print("alert('가입실패');");
					out.print("history.back()");
					out.print("</script>");

				} else {

					url = cp +"/main/main.jsp";
					resp.sendRedirect(url);

				}
			
			// 로그인 화면
			} else if (uri.indexOf("login.do") != -1) {

				url = "/member/login.jsp";
				forward(req, resp, url);

			// 로그인 실행
			} else if (uri.indexOf("login_ok.do") != -1) {

				userId = req.getParameter("userId");
				String userPwd = req.getParameter("userPwd");

				MemberDTO dto = dao.getReadData(userId);

				if (dto == null || !dto.getUserPwd().equals(userPwd)) {

					out.print("<script>");
					out.print("alert('로그인실패');");
					out.print("history.back()");
					out.print("</script>");

				} else {

					req.getSession().setAttribute("userId", userId);

					url = cp ;
					resp.sendRedirect(url);

				}

			// 오류
			} else {

				out.print("<script>");
				out.print("alert('잘못된 접근 : 로그인을 해주세요');");
				out.print("locasion:href='" + cp + "/member/login.jsp';");
				out.print("</script>");
				
			}

		// 로그인 상태
		} else {

			// 로그아웃 실행
			if (uri.indexOf("logout_ok.do") != -1) {

				HttpSession session = req.getSession();

				session.removeAttribute("userId");
				session.invalidate();

				url = cp + "/shop/member/main.do";
				resp.sendRedirect(url);

			// 회원정보 화면
			} else if (uri.indexOf("myPage.do") != -1) {

				MemberDTO dto = dao.getReadData(userId);

				req.setAttribute("dto", dto);

				url = "/member/myPage.jsp";
				forward(req, resp, url);

			// 회원정보수정 화면
			} else if (uri.indexOf("update.do") != -1) {

				MemberDTO dto = dao.getReadData(userId);

				req.setAttribute("dto", dto);

				url = "/member/update.jsp";
				forward(req, resp, url);

			// 회원정보수정 실행
			} else if (uri.indexOf("update_ok.do") != -1) {

				MemberDTO dto = dao.getReadData(userId);

				dto.setUserPwd(req.getParameter("userPwd"));
				dto.setUserName(req.getParameter("userName"));
				dto.setUserGender(req.getParameter("userGender"));
				dto.setUserBirth(req.getParameter("userBirth"));
				dto.setUserAddress(req.getParameter("userAddress"));
				dto.setUserEmail(req.getParameter("userEmail"));
				dto.setUserTel(req.getParameter("userTel"));				
				
				dao.update(dto);

				url = cp + "/shop/member/myPage.do";
				resp.sendRedirect(url);

			// 탈퇴 실행
			} else if (uri.indexOf("delete_ok.do") != -1) {

				MemberDTO dto = dao.getReadData(userId);
							
				dao.delete(dto);

				HttpSession session = req.getSession();
				session.removeAttribute("userId");
				session.invalidate();

				url = cp + "/shop/member/main.do";
				resp.sendRedirect(url);

			// 오류
			} else {

				out.print("<script>");
				out.print("alert('잘못된 접근 : 이미 로그인 상태입니다.');");
				out.print("history.back()");
				out.print("</script>");
				
			}

		}

	}

}