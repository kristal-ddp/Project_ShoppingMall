package com.orders;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.member.MemberDAO;
import com.member.MemberDTO;
import com.util.DBConn;

public class OrdersServlet extends HttpServlet {

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
		String uri = req.getRequestURI();
		String url;
		String cp = req.getContextPath();
		PrintWriter out = resp.getWriter();

		Connection conn = DBConn.getConnection();
		OrdersDAO dao = new OrdersDAO(conn);
		DeliveryDAO ddao = new DeliveryDAO(conn);
		
		String sessionUserId = (String) req.getSession().getAttribute("userId");
		String userId = null;

		if (sessionUserId != null) {
			userId = sessionUserId;
		}

		
		if (userId == null || userId.equals("")) {
			out.print("<script>");
			out.print("alert('로그인을 해주세요');");
			out.print("location.href='/sub/shop/member/login.do';");
			out.print("</script>");
			return;
		}

		// cart/wish 추가
		if (uri.indexOf("addOrder_ok.do") != -1) {

//			String referer = (String) req.getHeader("REFERER");

			int orderNum = dao.getMaxNum() + 1;
			int productNum = Integer.parseInt(req.getParameter("productNum"));
			String orderColor = req.getParameter("orderColor");
			String orderSize = req.getParameter("orderSize");
			String progress = req.getParameter("progress");

			String quantity = req.getParameter("orderQuantity");
			int orderQuantity = 0;
			if (quantity != null) {
				orderQuantity = Integer.parseInt(quantity);
			}

			OrdersDTO dto = new OrdersDTO();

			dto.setOrderNum(orderNum);
			dto.setUserId(userId);
			dto.setProductNum(productNum);
			dto.setOrderQuantity(orderQuantity);
			dto.setOrderColor(orderColor);
			dto.setOrderSize(orderSize);
			dto.setProgress(progress);

			int result = dao.insertData(dto);

			if (result == 0) {
				out.print("<script>");
				out.print("alert('오류');");
				out.print("history.back()");
				out.print("</script>");
			}

			url = cp +"/shop/orders/" + progress +".do";
			resp.sendRedirect(url);
//			resp.sendRedirect(referer);

			// cart/wish/order/cancel 수정
		} else if (uri.indexOf("changeOrder_ok.do") != -1) {

			String referer = (String) req.getHeader("REFERER");
			int result = 0;

			int orderNum = Integer.parseInt(req.getParameter("orderNum"));
			String orderQuantity = req.getParameter("orderQuantity");
			String orderColor = req.getParameter("orderColor");
			String orderSize = req.getParameter("orderSize");
			String progress = req.getParameter("progress");

			OrdersDTO dto = dao.getReadData(orderNum);
			
			if (orderQuantity != null && !orderQuantity.equals(""))
				dto.setOrderQuantity(Integer.parseInt(orderQuantity));
			if (orderColor != null && !orderColor.equals(""))
				dto.setOrderColor(orderColor);
			if (orderSize != null && !orderSize.equals(""))
				dto.setOrderSize(orderSize);
			if (progress != null && !progress.equals(""))
				dto.setProgress(progress);

			if (dto.getOrderQuantity() == 0) {
				result = dao.deleteData(orderNum);
			} else {
				result = dao.updateData(dto);
			}

			if (result == 0) {
				out.print("<script>");
				out.print("alert('오류');");
				out.print("history.back()");
				out.print("</script>");
				return;
			}

			resp.sendRedirect(referer);

			// cart/wish 삭제
		} else if (uri.indexOf("deleteOrder_ok.do") != -1) {

			String referer = (String) req.getHeader("REFERER");

			int orderNum = Integer.parseInt(req.getParameter("orderNum"));

			int result = dao.deleteData(orderNum);

			if (result == 0) {
				out.print("<script>");
				out.print("alert('오류');");
				out.print("history.back()");
				out.print("</script>");
				return;
			}

			resp.sendRedirect(referer);

			// 장바구니 목록
		} else if (uri.indexOf("cartList.do") != -1) {

			String progress = "cartList";
			List<OrdersDTO> list = dao.getList(userId, progress);

			req.setAttribute("list", list);
			req.setAttribute("userId", userId);

			url = "/orders/cartList.jsp";
			forward(req, resp, url);

			// 찜 목록
		} else if (uri.indexOf("wishList.do") != -1) {

			String progress = "wishList";
			List<OrdersDTO> list = new ArrayList<>();

			list = dao.getList(userId, progress);

			req.setAttribute("list", list);

			url = "/orders/wishList.jsp";
			forward(req, resp, url);

			// 주문/결제
		} else if (uri.indexOf("orderPayment.do") != -1) {

			// 주문상품
			String[] orderNum = req.getParameterValues("orderNum");
			
			if (orderNum == null) {
				out.print("<script>");
				out.print("alert('주문할 상품을 선택해 주세요');");
				out.print("history.back()");
				out.print("</script>");
				return;
			}
			
			List<OrdersDTO> list = new ArrayList<>();

			list = dao.getList(orderNum);

			// 회원정보
			MemberDTO memberDTO = new MemberDAO(conn).getReadData(userId);

			req.setAttribute("list", list);
			req.setAttribute("memberDTO", memberDTO);

			url = "/orders/orderPayment.jsp";
			forward(req, resp, url);

			// 결제 처리
		} else if (uri.indexOf("orderPayment_ok.do") != -1) {
			
			String[] orderNum = req.getParameterValues("orderNum");
			String deliveryName = req.getParameter("deliveryName");
			String[] deliveryAddr = req.getParameterValues("deliveryAddr");
			String deliveryTel = req.getParameter("deliveryTel");
			String deliveryEmail = req.getParameter("deliveryEmail");
			int totalPrice = Integer.parseInt(req.getParameter("tot"));
			String progress = "orderList";
			
			OrdersDTO dto = new OrdersDTO();
				
			for (int i = 0; i < orderNum.length; i++) {
				dto = dao.getReadData(Integer.parseInt(orderNum[i]));
				dto.setProgress("orderList");
				dao.updateData(dto);
			}
			
			DeliveryDTO ddto = new DeliveryDTO();
			
			ddto.setDeliveryNum(ddao.getMaxNum() + 1);
			ddto.setUserId(userId);
			ddto.setOrderNum(orderNum);
			ddto.setDeliveryName(deliveryName);
			ddto.setDeliveryTel(deliveryTel);
			ddto.setDeliveryAddr(deliveryAddr);
			ddto.setDeliveryEmail(deliveryEmail);
			ddto.setTotalPrice(totalPrice);
			ddto.setProgress(progress);
			
			int result = ddao.insertData(ddto);
			
			if (result == 0) {
				out.print("<script>");
				out.print("alert('오류');");
				out.print("history.back()");
				out.print("</script>");
				return;
			}
			
			url = cp + "/shop/orders/orderComplete.do";
			resp.sendRedirect(url);
			
			// 주문 완료
		} else if (uri.indexOf("orderComplete.do") != -1) {

			int deliveryNum = ddao.getMaxNum();
			DeliveryDTO ddto = ddao.getReadData(deliveryNum);
			
			req.setAttribute("ddto", ddto);

			url = "/orders/orderComplete.jsp";
			forward(req, resp, url);

			// 주문 목록
		} else if (uri.indexOf("orderList.do") != -1) {

			String progress = "orderList";
			List<DeliveryDTO> list = new ArrayList<>();

			list = ddao.getList(userId, progress);

			req.setAttribute("list", list);

			url = "/orders/orderList.jsp";
			forward(req, resp, url);

			// 취소 목록
		} else if (uri.indexOf("cancelList.do") != -1) {

			String progress = "cancelList";
			List<DeliveryDTO> list = new ArrayList<>();

			list = ddao.getList(userId, progress);

			req.setAttribute("list", list);

			url = "/orders/cancelList.jsp";
			forward(req, resp, url);

			// delivery 수정
		} else if (uri.indexOf("changeDelivery_ok.do") != -1) {

			String referer = (String) req.getHeader("REFERER");
			int result = 0;

			int deliveryNum = Integer.parseInt(req.getParameter("deliveryNum"));
			String deliveryName = req.getParameter("deliveryName");
			String deliveryTel = req.getParameter("deliveryTel");
			String[] deliveryAddr = req.getParameterValues("deliveryAddr");
			String progress = req.getParameter("progress");

			DeliveryDTO ddto = ddao.getReadData(deliveryNum);
			
			if (deliveryName != null && !deliveryName.equals(""))
				ddto.setDeliveryName(deliveryName);
			if (deliveryTel != null && !deliveryTel.equals(""))
				ddto.setDeliveryTel(deliveryTel);
			if (deliveryAddr != null && !deliveryAddr.equals(""))
				ddto.setDeliveryAddr(deliveryAddr);
			if (progress != null && !progress.equals("")) {
				ddto.setProgress(progress);
				
				String[] orderNum =  ddto.getOrderNum();
				
				for (int i = 0; i < orderNum.length; i++) {
					OrdersDTO dto = dao.getReadData(Integer.parseInt(orderNum[i]));
					dto.setProgress(progress);
					dao.updateData(dto);
				}
			
			}

			result = ddao.updateData(ddto);

			if (result == 0) {
				out.print("<script>");
				out.print("alert('오류');");
				out.print("history.back()");
				out.print("</script>");
				return;
			}

			resp.sendRedirect(referer);
			
		} 

	}

}
