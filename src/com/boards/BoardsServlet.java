package com.boards;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.orders.OrdersDAO;
import com.orders.OrdersDTO;
import com.product.ProductDAO;
import com.product.ProductDTO;
import com.util.DBConn;
import com.util.MyPage;

public class BoardsServlet extends HttpServlet {

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

	@SuppressWarnings("unused")
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		String cp = req.getContextPath();
		String uri = req.getRequestURI();
		PrintWriter out = resp.getWriter();

		Connection conn = DBConn.getConnection();
		
		NoticeDAO NoticeDAO = new NoticeDAO(conn);
		QnaDAO QnaDAO = new QnaDAO(conn);
		ReviewDAO ReviewDAO = new ReviewDAO(conn);

		MyPage myPage = new MyPage();

		String url;

		String sessionUserId = (String) req.getSession().getAttribute("userId");
		String userId = null;

		if (sessionUserId != null) {
			userId = sessionUserId;
		}

			// notice list
		if (uri.indexOf("notice.do") != -1) {
			
			String community = "notice";
			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue == null) {
				searchKey = "subject";
				searchValue = "";
			} else {
				if (req.getMethod().equalsIgnoreCase("GET")) {
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}
			
			int dataCount = NoticeDAO.getDataCount(searchKey, searchValue);
			
			int numPerPage = 5;

			int totalPage = myPage.getPageCount(numPerPage, dataCount);
			
			if (currentPage > totalPage) {
				currentPage = totalPage;
			}

			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			List<NoticeDTO> lists = NoticeDAO.getLists(start, end, searchKey, searchValue);

			String param = "";

			if (searchValue != null && !searchValue.equals("")) {
				param = "searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}
			
			String listUrl = cp + "/shop/boards/notice.do";

			if (!param.equals("")) {
				listUrl += "?" + param;
			}

			String pageIndexList = myPage.pageIndexList(currentPage, totalPage, listUrl);

			String viewUrl = cp + "/shop/boards/noticeView.do?pageNum=" + currentPage;

			if (!param.equals("")) {
				viewUrl += "&" + param;
			}

			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("viewUrl", viewUrl);
			req.setAttribute("dataCount", dataCount);

			url = "/boards/notice.jsp";
			forward(req, resp, url);
			
		// QnA list
		}else if (uri.indexOf("qna.do") != -1) {
			
			String community = "qna";
			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue == null) {
				searchKey = "subject";
				searchValue = "";
			} else {
				if (req.getMethod().equalsIgnoreCase("GET")) {
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}

			int dataCount = QnaDAO.getDataCount(searchKey, searchValue);

			int numPerPage = 5;

			int totalPage = myPage.getPageCount(numPerPage, dataCount);

			if (currentPage > totalPage) {
				currentPage = totalPage;
			}

			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			List<QnaDTO> lists = QnaDAO.getLists(start, end, searchKey, searchValue);

			String param = "";

			if (searchValue != null && !searchValue.equals("")) {
				param = "searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}
			
			String listUrl = cp + "/shop/boards/qna.do";

			if (!param.equals("")) {
				listUrl += "?" + param;
			}

			String pageIndexList = myPage.pageIndexList(currentPage, totalPage, listUrl);

			String viewUrl = cp + "/shop/boards/qnaView.do?pageNum=" + currentPage;

			if (!param.equals("")) {
				viewUrl += "&" + param;
			}

			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("viewUrl", viewUrl);
			req.setAttribute("dataCount", dataCount);

			url = "/boards/qna.jsp";
			forward(req, resp, url);

			// review list
		} else if (uri.indexOf("review.do") != -1) {

			String community = "review";
			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue == null) {
				searchKey = "subject";
				searchValue = "";
			} else {
				if (req.getMethod().equalsIgnoreCase("GET")) {
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}

			int dataCount = ReviewDAO.getDataCount(searchKey, searchValue);

			int numPerPage = 5;

			int totalPage = myPage.getPageCount(numPerPage, dataCount);

			if (currentPage > totalPage) {
				currentPage = totalPage;
			}

			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			List<ReviewDTO> lists = ReviewDAO.getLists(start, end, searchKey, searchValue);

			String param = "";

			if (searchValue != null && !searchValue.equals("")) {
				param = "searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}
			
			String listUrl = cp + "/shop/boards/review.do";

			if (!param.equals("")) {
				listUrl += "?" + param;
			}

			String pageIndexList = myPage.pageIndexList(currentPage, totalPage, listUrl);

			String viewUrl = cp + "/shop/boards/reviewView.do?pageNum=" + currentPage;

			if (!param.equals("")) {
				viewUrl += "&" + param;
			}

			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("viewUrl", viewUrl);
			req.setAttribute("dataCount", dataCount);

			url = "/boards/review.jsp";
			forward(req, resp, url);

			// notice view
		} else if (uri.indexOf("noticeView.do") != -1) {
			
			int boardNum = Integer.parseInt(req.getParameter("boardNum"));
			String pageNum = req.getParameter("pageNum");

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue != null && !searchValue.equals("")) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}
			
			NoticeDAO.updatehits(boardNum);

			NoticeDTO dto = NoticeDAO.getReadData(boardNum);

			if (dto == null) {
				url = cp + "/shop/notice.do";

				resp.sendRedirect(url);
			}

			int lineSu = dto.getContent().split("\n").length;

			dto.setContent(dto.getContent().replaceAll("\r", "<br/>"));

			String param = "pageNum=" + pageNum;

			if (searchValue != null && !searchValue.equals("")) {

				param += "&searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");

			}

			req.setAttribute("dto", dto);
			req.setAttribute("params", param);
			req.setAttribute("lineSu", lineSu);
			req.setAttribute("pageNum", pageNum);

			url = "/boards/noticeView.jsp";
			forward(req, resp, url);

			// QnA view
		} else if (uri.indexOf("qnaView.do") != -1) {
			
			int boardNum = Integer.parseInt(req.getParameter("boardNum"));
			String pageNum = req.getParameter("pageNum");

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue != null && !searchValue.equals("")) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}
			
			NoticeDAO.updatehits(boardNum);

			NoticeDTO dto = NoticeDAO.getReadData(boardNum);

			if (dto == null) {
				url = cp + "/shop/notice.do";

				resp.sendRedirect(url);
			}

			int lineSu = dto.getContent().split("\n").length;

			dto.setContent(dto.getContent().replaceAll("\r", "<br/>"));

			String param = "pageNum=" + pageNum;

			if (searchValue != null && !searchValue.equals("")) {

				param += "&searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");

			}

			req.setAttribute("dto", dto);
			req.setAttribute("params", param);
			req.setAttribute("lineSu", lineSu);
			req.setAttribute("pageNum", pageNum);

			url = "/boards/noticeView.jsp";
			forward(req, resp, url);
			
			// review view
		} else if (uri.indexOf("reviewView.do") != -1) {
			
			int boardNum = Integer.parseInt(req.getParameter("boardNum"));
			String pageNum = req.getParameter("pageNum");

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue != null && !searchValue.equals("")) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}
			
			ReviewDAO.updatehits(boardNum);

			ReviewDTO dto = ReviewDAO.getReadData(boardNum);

			if (dto == null) {
				url = cp + "/shop/review.do";

				resp.sendRedirect(url);
			}

			int lineSu = dto.getContent().split("\n").length;

			dto.setContent(dto.getContent().replaceAll("\r", "<br/>"));

			String param = "pageNum=" + pageNum;

			if (searchValue != null && !searchValue.equals("")) {

				param += "&searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");

			}

			req.setAttribute("dto", dto);
			req.setAttribute("params", param);
			req.setAttribute("lineSu", lineSu);
			req.setAttribute("pageNum", pageNum);

			url = "/boards/reviewView.jsp";
			forward(req, resp, url);
	
			// notice Delete_ok
		} else if (uri.indexOf("noticeDelete_ok.do") != -1) {
			
			int boardNum = Integer.parseInt(req.getParameter("boardNum"));
			String pageNum = req.getParameter("pageNum");
			
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchValue!=null && !searchValue.equals("")) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}
			
			NoticeDAO.deleteData(boardNum);
			
			String param = "pageNum=" + pageNum;
			
			if(searchValue!=null && !searchValue.equals("")) {
				
				param += "&searchKey=" + searchKey;
				param += "&searchValue=" +URLEncoder.encode(searchValue, "UTF-8");
				
			}
			
			url = "/sub/shop/boards/notice.do";
			resp.sendRedirect(url);
			
			// QnA Delete_ok
		} else if (uri.indexOf("qnaDelete_ok.do") != -1) {
			
			int boardNum = Integer.parseInt(req.getParameter("boardNum"));
			String pageNum = req.getParameter("pageNum");
			
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchValue!=null && !searchValue.equals("")) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}
			
			NoticeDAO.deleteData(boardNum);
			
			String param = "pageNum=" + pageNum;
			
			if(searchValue!=null && !searchValue.equals("")) {
				
				param += "&searchKey=" + searchKey;
				param += "&searchValue=" +URLEncoder.encode(searchValue, "UTF-8");
				
			}
			
			url = "/sub/shop/boards/qna.do";
			resp.sendRedirect(url);		

			// review Delete_ok
		} else if (uri.indexOf("reviewDelete_ok.do") != -1) {

			int boardNum = Integer.parseInt(req.getParameter("boardNum"));
			String pageNum = req.getParameter("pageNum");
			
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchValue!=null && !searchValue.equals("")) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}
			
			NoticeDAO.deleteData(boardNum);
			
			String param = "pageNum=" + pageNum;
			
			if(searchValue!=null && !searchValue.equals("")) {
				
				param += "&searchKey=" + searchKey;
				param += "&searchValue=" +URLEncoder.encode(searchValue, "UTF-8");
				
			}
			
			url = "/sub/shop/boards/review.do";
			resp.sendRedirect(url);			

			// Write
		} 

		if (userId == null) {
			
			out.print("<script>");
			out.print("alert('로그인을 해주세요');");
//			out.print("locasion:href='/sub/shop/member/login.do';");
			out.print("</script>");
			
			url = cp + "/shop/member/login.do";
			resp.sendRedirect(url);
			
		} else {
			
			
			if (uri.indexOf("Write.do") != -1) {
				
				// qna
				String str = req.getParameter("productNum");
	
				if (str != null) {
					int productNum = Integer.parseInt(str);
					ProductDTO ProductDTO = new ProductDAO(conn).getReadData(productNum);
					req.setAttribute("ProductDTO", ProductDTO);
				}
				
				// review
				str = req.getParameter("orderNum");
	
				if (str != null) {
					int orderNum = Integer.parseInt(str);
					OrdersDTO ordersDTO = new OrdersDAO(conn).getReadData(orderNum);
					req.setAttribute("ordersDTO", ordersDTO);
				}
				
				req.setAttribute("userId", userId);
				
				if (uri.indexOf("qnaWrite.do") != -1) {
					url = "/boards/qnaWrite.jsp";
				} else if (uri.indexOf("noticeWrite.do") != -1) {
					url = "/boards/noticeWrite.jsp";
				} else if (uri.indexOf("reviewWrite.do") != -1) {
					url = "/boards/reviewWrite.jsp";
				} else {
					url = "/main/main.jsp";
				}
	
				forward(req, resp, url);
				
	//			// notice Write
	//		} else if (uri.indexOf("noticeWrite.do") != -1) {
	//
	//			// review Write
	//		} else if (uri.indexOf("reviewWrite.do") != -1) {
	
				// qnaWrite_ok
			} else if (uri.indexOf("qnaWrite_ok.do") != -1) {
				
				QnaDAO dao = new QnaDAO(conn);
				
				int boardNum = dao.getMaxNum() + 1;
				String subject = req.getParameter("subject");
				String content = req.getParameter("content");
				int productNum = Integer.parseInt(req.getParameter("productNum"));
				
				QnaDTO dto = dao.getReadData(boardNum);
				
				dto.setBoardNum(boardNum);
				dto.setUserId(userId);
				dto.setSubject(subject);
				dto.setContent(content);
				dto.setProductNum(productNum);
				
				int result = dao.insertData(dto);
	
				if (result == 0) {
					out.print("<script>");
					out.print("alert('오류');");
					out.print("history.back();");
					out.print("</script>");
				}
	
				url =  "/sub/shop/boards/qna.do";
				resp.sendRedirect(url);
				
				// noticeWrite_ok
			} else if (uri.indexOf("noticeWrite_ok.do") != -1) {
				
				NoticeDAO dao = new NoticeDAO(conn);
				
				int boardNum = dao.getMaxNum() + 1;
				String subject = req.getParameter("subject");
				String content = req.getParameter("content");
				
				NoticeDTO dto = dao.getReadData(boardNum);
	
				dto.setBoardNum(boardNum);
				dto.setUserId(userId);
				dto.setSubject(subject);
				dto.setContent(content);
	
				int result = dao.insertData(dto);
	
				if (result == 0) {
					out.print("<script>");
					out.print("alert('오류');");
					out.print("history.back();");
					out.print("</script>");
				}
				
				url =  "/sub/shop/boards/notice.do";
				resp.sendRedirect(url);
				
				// reviewWrite_ok
			} else if (uri.indexOf("reviewWrite_ok.do") != -1) {
				
				ReviewDAO dao = new ReviewDAO(conn);
				
				int boardNum = dao.getMaxNum() + 1;
				String subject = req.getParameter("subject");
				String content = req.getParameter("content");
				int orderNum = Integer.parseInt(req.getParameter("orderNum"));
	
				ReviewDTO dto = new ReviewDTO();
	
				dto.setBoardNum(boardNum);
				dto.setUserId(userId);
				dto.setSubject(subject);
				dto.setContent(content);
				dto.setOrderNum(orderNum);
				
				int result = dao.insertData(dto);
	
				if (result == 0) {
					out.print("<script>");
					out.print("alert('오류');");
					out.print("history.back();");
					out.print("</script>");
				}
	
				url =  "/sub/shop/boards/review.do";
				resp.sendRedirect(url);
				
				// QnA Update
			} else if (uri.indexOf("qnaUpdate.do") != -1) {
	
				QnaDAO dao = new QnaDAO(conn);
				
				int boardNum = Integer.parseInt(req.getParameter("boardNum"));
				QnaDTO dto = dao.getReadData(boardNum);
				
				if (dto == null) {
					out.print("<script>");
					out.print("alert('게시글을 찾을수없습니다.');");
					out.print("history.back();");
					out.print("</script>");
				}
				
				if (!dto.getUserId().equals(userId)) {
					out.print("<script>");
					out.print("alert('권한이 없습니다.');");
					out.print("history.back();");
					out.print("</script>");
				}
				
				ProductDTO productDTO = new ProductDAO(conn).getReadData(dto.getProductNum());

				req.setAttribute("dto", dto);
				req.setAttribute("productDTO", productDTO);
				
				url = "/boards/qnaUpdate.jsp";
				forward(req, resp, url);
				
				// notice Update
			} else if (uri.indexOf("noticeUpdate.do") != -1) {
	
				NoticeDAO dao = new NoticeDAO(conn);
				
				int boardNum = Integer.parseInt(req.getParameter("boardNum"));
				NoticeDTO dto = dao.getReadData(boardNum);
				
				if (dto == null) {
					out.print("<script>");
					out.print("alert('게시글을 찾을수없습니다.');");
					out.print("history.back();");
					out.print("</script>");
				}
				
				if (!dto.getUserId().equals(userId)) {
					out.print("<script>");
					out.print("alert('권한이 없습니다.');");
					out.print("history.back();");
					out.print("</script>");
				}
				
				req.setAttribute("dto", dto);
				
				url = "/boards/noticeUpdate.jsp";
				forward(req, resp, url);
				
				// review Update
			} else if (uri.indexOf("reviewUpdate.do") != -1) {
	
				ReviewDAO dao = new ReviewDAO(conn);
				
				int boardNum = Integer.parseInt(req.getParameter("boardNum"));
				ReviewDTO dto = dao.getReadData(boardNum);
				
				if (dto == null) {
					out.print("<script>");
					out.print("alert('게시글을 찾을수없습니다.');");
					out.print("history.back();");
					out.print("</script>");
				}
				
				if (!dto.getUserId().equals(userId)) {
					out.print("<script>");
					out.print("alert('권한이 없습니다.');");
					out.print("history.back();");
					out.print("</script>");
				}
				
				OrdersDTO ordersDTO = new OrdersDAO(conn).getReadData(dto.getOrderNum());
				
				req.setAttribute("dto", dto);
				req.setAttribute("ordersDTO", ordersDTO);
				
				url = "/boards/reviewUpdate.jsp";
				forward(req, resp, url);
	
				// QnA Update_ok
			} else if (uri.indexOf("qnaUpdate_ok.do") != -1) {
				
				QnaDAO dao = new QnaDAO(conn);
				
				int boardNum = Integer.parseInt(req.getParameter("boardNum"));
				String subject = req.getParameter("subject");
				String content = req.getParameter("content");
				
				QnaDTO dto = dao.getReadData(boardNum);
				
				dto.setSubject(subject);
				dto.setContent(content);
				
				int result = dao.updateData(dto);
	
				if (result == 0) {
					out.print("<script>");
					out.print("alert('오류');");
					out.print("history.back();");
					out.print("</script>");
				}
	
				url =  "/sub/shop/boards/qna.do";
				resp.sendRedirect(url);
				
				// notice Update_ok
			} else if (uri.indexOf("noticeUpdate_ok.do") != -1) {

				NoticeDAO dao = new NoticeDAO(conn);
				
				int boardNum = Integer.parseInt(req.getParameter("boardNum"));
				String subject = req.getParameter("subject");
				String content = req.getParameter("content");
				
				NoticeDTO dto = dao.getReadData(boardNum);
				
				dto.setSubject(subject);
				dto.setContent(content);
				
				int result = dao.updateData(dto);
	
				if (result == 0) {
					out.print("<script>");
					out.print("alert('오류');");
					out.print("history.back();");
					out.print("</script>");
				}
	
				url =  "/sub/shop/boards/notice.do";
				resp.sendRedirect(url);
				
				// review Update_ok
			} else if (uri.indexOf("reviewUpdate_ok.do") != -1) {

				ReviewDAO dao = new ReviewDAO(conn);
				
				int boardNum = Integer.parseInt(req.getParameter("boardNum"));
				String subject = req.getParameter("subject");
				String content = req.getParameter("content");
				
				ReviewDTO dto = dao.getReadData(boardNum);
				
				dto.setSubject(subject);
				dto.setContent(content);
				
				int result = dao.updateData(dto);
	
				if (result == 0) {
					out.print("<script>");
					out.print("alert('오류');");
					out.print("history.back();");
					out.print("</script>");
				}
	
				url =  "/sub/shop/boards/review.do";
				resp.sendRedirect(url);
	
				// QnA SearchList
			} else if (uri.indexOf("qnaSearchList.do") != -1) {
				String community = "qna";
				String pageNum = req.getParameter("pageNum");

				int currentPage = 1;

				if (pageNum != null) {
					currentPage = Integer.parseInt(pageNum);
				}

				String searchKey = req.getParameter("searchKey");
				String searchValue = req.getParameter("searchValue");

				if (searchValue == null) {
					searchKey = "subject";
					searchValue = "";
				} else {
					if (req.getMethod().equalsIgnoreCase("GET")) {
						searchValue = URLDecoder.decode(searchValue, "UTF-8");
					}
				}

				int dataCount = QnaDAO.getDataCount(searchKey, searchValue);

				int numPerPage = 5;

				int totalPage = myPage.getPageCount(numPerPage, dataCount);

				if (currentPage > totalPage) {
					currentPage = totalPage;
				}

				int start = (currentPage - 1) * numPerPage + 1;
				int end = currentPage * numPerPage;

				List<QnaDTO> lists = QnaDAO.getLists(start, end, searchKey, searchValue);

				String param = "";

				if (searchValue != null && !searchValue.equals("")) {
					param = "searchKey=" + searchKey;
					param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
				}
				
				String listUrl = cp + "/shop/boards/qna.do";

				if (!param.equals("")) {
					listUrl += "?" + param;
				}

				String pageIndexList = myPage.pageIndexList(currentPage, totalPage, listUrl);

				String viewUrl = cp + "/shop/boards/qnaView.do?pageNum=" + currentPage;

				if (!param.equals("")) {
					viewUrl += "&" + param;
				}

				ProductDAO productDAO = new ProductDAO(conn);
				List<ProductDTO> list = productDAO.getLists(start, end, searchKey, searchValue);
				
				req.setAttribute("lists", lists);
				req.setAttribute("pageIndexList", pageIndexList);
				req.setAttribute("viewUrl", viewUrl);
				req.setAttribute("dataCount", dataCount);
				
				url = "/boards/qnaSearchList.jsp";
				forward(req, resp, url);
				
				// review SearchList
			} else if (uri.indexOf("reviewSearchList.do") != -1) {

				OrdersDAO ordersDAO = new OrdersDAO(conn);
				List<OrdersDTO> list = ordersDAO.getList(userId, "orderList");
				
				req.setAttribute("list", list);
				
				url = "/boards/reviewSearchList.jsp";
				forward(req, resp, url);
				
			}
	
		}
		
		
		
		/*if (uri.indexOf("write.do") != -1) {

			if (userId == null) {
				url = "/member/login.jsp";
				forward(req, resp, url);
				return;
			}
			
			String community = req.getParameter("community");
			String productNum = req.getParameter("productNum");
			
			req.setAttribute("community", community);
			req.setAttribute("productNum", productNum);

			System.out.println(community);
			System.out.println(productNum);
			
			url = "/boards/write.jsp";
			forward(req, resp, url);
			
		} else if (uri.indexOf("searchList.do") != -1) {

			String community = req.getParameter("community");
			
				
			OrdersDAO ordersDAO = new OrdersDAO(conn);
			List<OrdersDTO> list = ordersDAO.getList(userId, "orderList");
			
			req.setAttribute("list", list);
			
			url = "/boards/searchList.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("write_ok.do") != -1) {
			
			BoardsDTO dto = new BoardsDTO();

			int maxNum = dao.getMaxNum();

			dto.setBoardNum(maxNum + 1);
			dto.setUserId(req.getParameter("userId"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dao.insertData(dto);

			url = cp + "/shop/boards/list.do";
			resp.sendRedirect(url);

		} else if (uri.indexOf("notice.do") != -1) {
			
			String community = "notice";
			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue == null) {
				searchKey = "subject";
				searchValue = "";
			} else {
				if (req.getMethod().equalsIgnoreCase("GET")) {
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}

			int dataCount = dao.getDataCount(searchKey, searchValue, community);
			
			int numPerPage = 5;

			int totalPage = myPage.getPageCount(numPerPage, dataCount);

			if (currentPage > totalPage) {
				currentPage = totalPage;
			}

			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			List<BoardsDTO> lists = dao.getLists(start, end, searchKey, searchValue, community);

			String param = "";

			if (searchValue != null && !searchValue.equals("")) {
				param = "searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}
			
			String listUrl = cp + "/shop/boards/notice.do";

			if (!param.equals("")) {
				listUrl += "?" + param;
			}

			String pageIndexList = myPage.pageIndexList(currentPage, totalPage, listUrl);

			String viewUrl = cp + "/shop/boards/noticeView.do?pageNum=" + currentPage;

			if (!param.equals("")) {
				viewUrl += "&" + param;
			}

			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("viewUrl", viewUrl);
			req.setAttribute("dataCount", dataCount);

			url = "/boards/notice.jsp";
			forward(req, resp, url);

		else if (uri.indexOf("list.do") != -1) {

			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue == null) {
				searchKey = "productName";
				searchValue = "";
			} else {
				if (req.getMethod().equalsIgnoreCase("GET")) {
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}

			int dataCount = dao.getDataCount(searchKey, searchValue);

			int numPerPage = 5;

			int totalPage = myPage.getPageCount(numPerPage, dataCount);

			if (currentPage > totalPage) {
				currentPage = totalPage;
			}

			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			List<BoardsDTO> lists = dao.getLists(start, end, searchKey, searchValue);

			String param = ""; // 검색했던 그 페이지정보로 돌아가준다

			if (searchValue != null && !searchValue.equals("")) {
				param = "searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			} // param: 파라미터 값을 저장하고 있는 저장소
			
			String listUrl = cp + "/shop/boards/list.do";

			if (!param.equals("")) {
				listUrl += "?" + param;
			}

			String pageIndexList = myPage.pageIndexList(currentPage, totalPage, listUrl);

			String articleUrl = cp + "/shop/article.do?pageNum=" + currentPage;

			if (!param.equals("")) {
				articleUrl += "&" + param;
			}

			// 포워딩할 데이터
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("dataCount", dataCount);

			url = "/boards/list.jsp";
			forward(req, resp, url);
		} else if (uri.indexOf("qna.do") != -1) {
			
			String community = "qna";
			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue == null) {
				searchKey = "subject";
				searchValue = "";
			} else {
				if (req.getMethod().equalsIgnoreCase("GET")) {
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}

			int dataCount = dao.getDataCount(searchKey, searchValue, community);

			int numPerPage = 5;

			int totalPage = myPage.getPageCount(numPerPage, dataCount);

			if (currentPage > totalPage) {
				currentPage = totalPage;
			}

			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			List<BoardsDTO> lists = dao.getLists(start, end, searchKey, searchValue, community);

			String param = "";

			if (searchValue != null && !searchValue.equals("")) {
				param = "searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}
			
			String listUrl = cp + "/shop/boards/qna.do";

			if (!param.equals("")) {
				listUrl += "?" + param;
			}

			String pageIndexList = myPage.pageIndexList(currentPage, totalPage, listUrl);

			String viewUrl = cp + "/shop/boards/qnaView.do?pageNum=" + currentPage;

			if (!param.equals("")) {
				viewUrl += "&" + param;
			}

			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("viewUrl", viewUrl);
			req.setAttribute("dataCount", dataCount);

			url = "/boards/qna.jsp";
			forward(req, resp, url);
			
		} else if (uri.indexOf("review.do") != -1) {

			String community = "review";
			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue == null) {
				searchKey = "subject";
				searchValue = "";
			} else {
				if (req.getMethod().equalsIgnoreCase("GET")) {
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}

			int dataCount = dao.getDataCount(searchKey, searchValue, community);

			int numPerPage = 5;

			int totalPage = myPage.getPageCount(numPerPage, dataCount);

			if (currentPage > totalPage) {
				currentPage = totalPage;
			}

			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			List<BoardsDTO> lists = dao.getLists(start, end, searchKey, searchValue, community);

			String param = "";

			if (searchValue != null && !searchValue.equals("")) {
				param = "searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}
			
			String listUrl = cp + "/shop/boards/review.do";

			if (!param.equals("")) {
				listUrl += "?" + param;
			}

			String pageIndexList = myPage.pageIndexList(currentPage, totalPage, listUrl);

			String viewUrl = cp + "/shop/boards/reviewView.do?pageNum=" + currentPage;

			if (!param.equals("")) {
				viewUrl += "&" + param;
			}

			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("viewUrl", viewUrl);
			req.setAttribute("dataCount", dataCount);

			url = "/boards/review.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("article.do") != -1) {

			int boardNum = Integer.parseInt(req.getParameter("boardNum"));
			String pageNum = req.getParameter("pageNum");

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue != null && !searchValue.equals("")) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}

			dao.updatehits(boardNum);

			BoardsDTO dto = dao.getReadData(boardNum);

			if (dto == null) {
				url = cp + "/shop/list.do";

				resp.sendRedirect(url);
			}

			int lineSu = dto.getContent().split("\n").length;

			dto.setContent(dto.getContent().replaceAll("\r", "<br/>"));

			String param = "pageNum=" + pageNum;

			if (searchValue != null && !searchValue.equals("")) {

				param += "&searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");

			}

			req.setAttribute("dto", dto);
			req.setAttribute("params", param);
			req.setAttribute("lineSu", lineSu);
			req.setAttribute("pageNum", pageNum);

			url = "/boards/article.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("updated.do") != -1) {

			m 

		} 
			 * else if(uri.indexOf("updated_ok.do")!=-1) {
			 * 
			 * 
			 * int num = Integer.parseInt(req.getParameter("num")); String pageNum =
			 * req.getParameter("pageNum");
			 * 
			 * String searchKey = req.getParameter("searchKey"); String searchValue =
			 * req.getParameter("searchValue");
			 * 
			 * if(searchValue!=null&&!searchValue.equals("")) { searchValue =
			 * URLDecoder.decode(searchValue,"UTF-8"); }
			 * 
			 * BoardsDTO dto = new BoardsDTO();
			 * 
			 * dto.setNum(Integer.parseInt(req.getParameter("num")));
			 * dto.setSubject(req.getParameter("subject"));
			 * dto.setName(req.getParameter("name"));
			 * dto.setEmail(req.getParameter("email")); dto.setPwd(req.getParameter("pwd"));
			 * dto.setContent(req.getParameter("content"));
			 * 
			 * //수정된 데이터를 보낸다 dao.updateData(dto);
			 * 
			 * String param = "pageNum=" + pageNum;
			 * 
			 * if(searchValue!=null&&!searchValue.equals("")) {
			 * 
			 * param += "&searchKey=" + searchKey; param += "&searchValue=" +
			 * URLEncoder.encode(searchValue, "UTF-8");
			 * 
			 * }
			 * 
			 * url = cp + "/bbs/list.do?" + param; resp.sendRedirect(url);
			 * 
			 * }
			 else if (uri.indexOf("deleted_ok") != -1) {

			int num = Integer.parseInt(req.getParameter("num"));
			String pageNum = req.getParameter("pageNum");

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");

			if (searchValue != null && !searchValue.equals("")) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}

			dao.deleteData(num);

			String param = "pageNum=" + pageNum;

			if (searchValue != null && !searchValue.equals("")) {

				param += "&searchKey=" + searchKey;
				param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");

			}

			url = cp + "/shop/list.do?" + param;
			resp.sendRedirect(url);

		}*/

	}

}