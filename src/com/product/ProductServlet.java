package com.product;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.boards.QnaDAO;
import com.boards.QnaDTO;
import com.boards.ReviewDAO;
import com.boards.ReviewDTO;
import com.util.DBConn;
import com.util.MyPage;

public class ProductServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		Connection conn = DBConn.getConnection();
		ProductDAO dao = new ProductDAO(conn);
		
		String cp = req.getContextPath();
		String uri = req.getRequestURI();
		String url;
		
		MyPage myPage = new MyPage();
		
		//상품 리스트 페이지
		if(uri.indexOf("list.do")!=-1) {
			
			String pageNum = req.getParameter("pageNum");
			
			int currentPage = 1;
			
			if(pageNum!=null) {
				currentPage = Integer.parseInt(pageNum);
			}
			
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			String productCategory = req.getParameter("productCategory");
			
			if(productCategory==null) {
				productCategory = "";
			}
			
			if(searchValue==null) {
				searchKey = "productName";
				searchValue = "";
			}else {
				if(req.getMethod().equalsIgnoreCase("GET")){
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}
			
			int dataCount = dao.getDataCount(searchKey, searchValue, productCategory);
			
			int numPerPage = 6;
			
			int totalPage = myPage.getPageCount(numPerPage, dataCount);
			
			if(currentPage>totalPage) {
				currentPage = totalPage;
			}
			
			int start = (currentPage-1) * numPerPage+1;
			int end = currentPage * numPerPage;
			
			
			List<ProductDTO> lists =
					dao.getLists(start, end, searchKey, searchValue, productCategory);
			
			String param = "";
			if(searchValue!=null && !searchValue.equals("")) {
				param = "searchKey=" + searchKey;
				param+= "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}
			
			String imagePath = cp + "/image/top";
			
			String listUrl = cp + "/shop/product/list.do?productCategory=" + productCategory;
			
			if(!param.equals("")) {
				listUrl += "&" + param;
			}
			
			String pageIndexList =
					myPage.pageIndexList(currentPage, totalPage, listUrl);
			
			String detailUrl = cp + "/product/detail.do?pageNum=" + currentPage;
			
			if(!param.equals("")) {
				detailUrl += "&" + param;
			}
			
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("detailUrl", detailUrl);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("totalPage", totalPage);
			req.setAttribute("currentPage", currentPage);
			req.setAttribute("imagePath", imagePath);
			
			url = "/product/list.jsp";
			forward(req, resp, url);
		
		//상품 상세 페이지
		}else if(uri.indexOf("detail.do")!=-1) {
			
			int productNum = Integer.parseInt(req.getParameter("productNum"));
			String pageNum = req.getParameter("pageNum");
			
			
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			String imagePath = cp + "/image/top";
			
			if(searchValue!=null && !searchValue.equals("")) {
				searchValue = URLDecoder.decode(searchValue, "UTF-8");
			}
			
			ProductDTO dto = dao.getReadData(productNum);

			/*if(dto==null) {
				url = cp + "/shop/product/list.do";
				resp.sendRedirect(url);
				
				return;
			}*/
			
			String param = "pageNum=" + pageNum;
			
			if(searchValue!=null && !searchValue.equals("")) {
				
				param += "&searchKey=" + searchKey;
				param += "&searchValue=" +URLEncoder.encode(searchValue, "UTF-8");
				
			}
			
			int saveLength = dto.getSaveFileName().length;
			int originalLength = dto.getOriginalFileName().length;
			int sizeLength = dto.getProductSize().length;
			int colorLength = dto.getProductColor().length;

			String sessionUserId = (String) req.getSession().getAttribute("userId");
			String userId = null;
			
			if (sessionUserId != null) {
				userId = sessionUserId;
			}
			
			List<QnaDTO> qnaList = new QnaDAO(conn).getLists(productNum);
			List<ReviewDTO> reviewList = new ReviewDAO(conn).getLists(productNum);
			
			req.setAttribute("dto", dto);
			req.setAttribute("params", param);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("imagePath", imagePath);
			req.setAttribute("saveLength", saveLength);
			req.setAttribute("originalLength", originalLength);
			req.setAttribute("sizeLength", sizeLength);
			req.setAttribute("colorLength", colorLength);
			req.setAttribute("userId", userId);
			req.setAttribute("qnaList", qnaList);
			req.setAttribute("reviewList", reviewList);
			
			url = "/product/detail.jsp";
			forward(req, resp, url);
		}
	}
}
