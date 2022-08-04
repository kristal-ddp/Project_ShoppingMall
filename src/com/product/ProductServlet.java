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
		
		if(uri.indexOf("list.do")!=-1) {
			
			String pageNum = req.getParameter("pageNum");
			
			int currentPage = 1;
			
			if(pageNum!=null) {
				currentPage = Integer.parseInt(pageNum);
			}
			
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			
			if(searchValue==null) {
				searchKey = "productName";
				searchValue = "";
			}else {
				if(req.getMethod().equalsIgnoreCase("GET")){
					searchValue = URLDecoder.decode(searchValue, "UTF-8");
				}
			}
			
			int dataCount = dao.getDataCount(searchKey, searchValue);
			
			int numPerPage = 3;
			
			int totalPage = myPage.getPageCount(numPerPage, dataCount);
			
			if(currentPage>totalPage) {
				currentPage = totalPage;
			}
			
			int start = (currentPage-1) * numPerPage+1;
			int end = currentPage * numPerPage;
			
			List<ProductDTO> lists =
					dao.getLists(start, end, searchKey, searchValue);
			
			String param = "";
			if(searchValue!=null && !searchValue.equals("")) {
				param = "searchKey=" + searchKey;
				param+= "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
			}
			
			String imagePath = cp + "/image/top";
			
			String listUrl = cp + "/shop/product/list.do";
			
			if(!param.equals("")) {
				listUrl += "?" + param;
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

			System.out.println(dto);
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
			
			req.setAttribute("dto", dto);
			req.setAttribute("params", param);
			req.setAttribute("pageNum", pageNum);
			req.setAttribute("imagePath", imagePath);
			
			url = "/product/detail.jsp";
			forward(req, resp, url);
			
		}
		
	}

}
