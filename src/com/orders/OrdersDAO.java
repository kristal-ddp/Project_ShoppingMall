package com.orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class OrdersDAO {

	private Connection conn = DBConn.getConnection();

	public OrdersDAO(Connection conn) {
		this.conn = conn;
	}

	public int getMaxNum() {

		int result = 0;
		PreparedStatement pstmt;
		ResultSet rs;
		String sql;

		try {

			sql = "SELECT NVL(MAX(ORDERNUM), 0) FROM ORDERS";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}
	
	public int getDataCount(String userId) {
		
		int dataCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "SELECT NVL(COUNT(*),0) FROM ORDERS ";
			sql+= "WHERE USERID = ? AND PROGRESS = 'cartLIst'";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dataCount = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dataCount;
	}

	/*
	public int getDataCount(String searchKey,String searchValue) {
		
		int dataCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			searchValue = "%" + searchValue + "%";
			
			sql = "SELECT NVL(COUNT(*),0) FROM ORDERS ";
			sql+= "WHERE " + searchKey + " LIKE ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dataCount = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dataCount;
		
	}
	 */

	public int insertData(OrdersDTO dto) {

		int result = 0;
		PreparedStatement pstmt;
		String sql;

		try {

			sql = "INSERT INTO ORDERS(ORDERNUM, USERID, PRODUCTNUM, ORDERQUANTITY, ORDERCOLOR, ORDERSIZE, UPDATEDDATE, PROGRESS, REVIEW) ";
			sql += "VALUES(?, ?, ?, ?, ?, ?, SYSDATE, ?, 0)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getOrderNum());
			pstmt.setString(2, dto.getUserId());
			pstmt.setInt(3, dto.getProductNum());
			pstmt.setInt(4, dto.getOrderQuantity());
			pstmt.setString(5, dto.getOrderColor());
			pstmt.setString(6, dto.getOrderSize());
			pstmt.setString(7, dto.getProgress());

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}

	public int updateData(OrdersDTO dto) {

		int result = 0;
		PreparedStatement pstmt;
		String sql;

		try {

			sql = "UPDATE ORDERS SET ORDERQUANTITY = ?, ORDERCOLOR = ?, ORDERSIZE = ?, UPDATEDDATE = SYSDATE, PROGRESS = ?, REVIEW = ? ";
			sql += "WHERE ORDERNUM = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getOrderQuantity());
			pstmt.setString(2, dto.getOrderColor());
			pstmt.setString(3, dto.getOrderSize());
			pstmt.setString(4, dto.getProgress());
			pstmt.setInt(5, dto.getReview());
			pstmt.setInt(6, dto.getOrderNum());

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}

	public int deleteData(int orderNum) {

		int result = 0;
		PreparedStatement pstmt;
		String sql;

		try {

			sql = "DELETE ORDERS WHERE ORDERNUM = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, orderNum);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}

	public List<OrdersDTO> getList(String userId, String progress) {

		List<OrdersDTO> list = new ArrayList<>();
		PreparedStatement pstmt;
		ResultSet rs;
		String sql;

		try {

			sql = "SELECT ORDERNUM, USERID, O.PRODUCTNUM, ORDERQUANTITY, ORDERCOLOR, ORDERSIZE, UPDATEDDATE, PROGRESS, REVIEW, ";
			sql += "PRODUCTNAME, PRODUCTPRICE, PRODUCTCATEGORY, SAVEFILENAME ";
			sql += "FROM ORDERS O, PRODUCT P ";
			sql += "WHERE O.PRODUCTNUM = P.PRODUCTNUM AND USERID = ? AND PROGRESS = ? ORDER BY ORDERNUM DESC";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, progress);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				OrdersDTO dto = new OrdersDTO();

				dto.setOrderNum(rs.getInt("ORDERNUM"));
				dto.setUserId(rs.getString("USERID"));
				dto.setProductNum(rs.getInt("PRODUCTNUM"));
				dto.setOrderQuantity(rs.getInt("ORDERQUANTITY"));
				dto.setOrderColor(rs.getString("ORDERCOLOR"));
				dto.setOrderSize(rs.getString("ORDERSIZE"));
				dto.setUpdatedDate(rs.getString("UPDATEDDATE"));
				dto.setProgress(rs.getString("PROGRESS"));
				dto.setReview(rs.getInt("REVIEW"));

				dto.setProductName(rs.getString("PRODUCTNAME"));
				dto.setProductPrice(rs.getInt("PRODUCTPRICE"));
				dto.setProductCategory(rs.getString("PRODUCTCATEGORY"));
				dto.setSaveFileName(rs.getString("SAVEFILENAME").split(","));

				list.add(dto);

			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return list;

	}

	public List<OrdersDTO> getList(String[] orderNum) {

		List<OrdersDTO> list = new ArrayList<>();
		PreparedStatement pstmt;
		ResultSet rs;
		String sql;

		try {

			String n = "?";
			for (int i = 0; i < orderNum.length - 1; i++) {
				n += ", ?";
			}

			sql = "SELECT ORDERNUM, USERID, O.PRODUCTNUM, ORDERQUANTITY, ORDERCOLOR, ORDERSIZE, UPDATEDDATE, PROGRESS, REVIEW";
			sql += "PRODUCTNAME, PRODUCTPRICE, PRODUCTCATEGORY, SAVEFILENAME ";
			sql += "FROM ORDERS O, PRODUCT P ";
			sql += "WHERE O.PRODUCTNUM = P.PRODUCTNUM AND ORDERNUM IN (" + n + ") ORDER BY ORDERNUM DESC";

			pstmt = conn.prepareStatement(sql);
			for (int i = 0; i < orderNum.length; i++) {
				pstmt.setString(i + 1, orderNum[i]);
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {

				OrdersDTO dto = new OrdersDTO();

				dto.setOrderNum(rs.getInt("ORDERNUM"));
				dto.setUserId(rs.getString("USERID"));
				dto.setProductNum(rs.getInt("PRODUCTNUM"));
				dto.setOrderQuantity(rs.getInt("ORDERQUANTITY"));
				dto.setOrderColor(rs.getString("ORDERCOLOR"));
				dto.setOrderSize(rs.getString("ORDERSIZE"));
				dto.setUpdatedDate(rs.getString("UPDATEDDATE"));
				dto.setProgress(rs.getString("PROGRESS"));
				dto.setReview(rs.getInt("REVIEW"));

				dto.setProductName(rs.getString("PRODUCTNAME"));
				dto.setProductPrice(rs.getInt("PRODUCTPRICE"));
				dto.setProductCategory(rs.getString("PRODUCTCATEGORY"));
				dto.setSaveFileName(rs.getString("SAVEFILENAME").split(","));

				list.add(dto);

			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return list;

	}
	
	/*
	public List<OrdersDTO> getList(int start, int end, String searchKey,String searchValue, String userId, String progress) {

		List<OrdersDTO> list = new ArrayList<>();
		PreparedStatement pstmt;
		ResultSet rs;
		String sql;

		try {

			searchValue = "%" + searchValue + "%";

			sql = "SELECT * FROM (";
			sql += "SELECT ROWNUM RNUM, DATA.* FROM (";
			sql += "SELECT ORDERNUM, USERID, O.PRODUCTNUM, ORDERQUANTITY, ORDERCOLOR, ORDERSIZE, UPDATEDDATE, PROGRESS, ";
			sql += "PRODUCTNAME, PRODUCTPRICE, PRODUCTCATEGORY, SAVEFILENAME ";
			sql += "FROM ORDERS O, PRODUCT P ";
			sql += "WHERE O.PRODUCTNUM = P.PRODUCTNUM AND " + searchKey + " LIKE ? AND USERID = ? AND PROGRESS = ? ORDER BY ORDERNUM DESC) DATA) ";
			sql += "WHERE RNUM >= ? AND RNUM <= ?";	

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			pstmt.setString(2, userId);
			pstmt.setString(3, progress);
			pstmt.setInt(4, start);
			pstmt.setInt(5, end);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				OrdersDTO dto = new OrdersDTO();

				dto.setOrderNum(rs.getInt("ORDERNUM"));
				dto.setUserId(rs.getString("USERID"));
				dto.setProductNum(rs.getInt("PRODUCTNUM"));
				dto.setOrderQuantity(rs.getInt("ORDERQUANTITY"));
				dto.setOrderColor(rs.getString("ORDERCOLOR"));
				dto.setOrderSize(rs.getString("ORDERSIZE"));
				dto.setUpdatedDate(rs.getString("UPDATEDDATE"));
				dto.setProgress(rs.getString("PROGRESS"));

				dto.setProductName(rs.getString("PRODUCTNAME"));
				dto.setProductPrice(rs.getInt("PRODUCTPRICE"));
				dto.setProductCategory(rs.getString("PRODUCTCATEGORY"));
				dto.setSaveFileName(rs.getString("SAVEFILENAME").split(","));

				list.add(dto);

			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return list;

	}
	 */
	
	public OrdersDTO getReadData(int orderNum) {

		OrdersDTO dto = null;
		PreparedStatement pstmt;
		ResultSet rs;
		String sql;

		try {

			sql = "SELECT ORDERNUM, USERID, P.PRODUCTNUM, ORDERQUANTITY, ORDERCOLOR, ORDERSIZE, UPDATEDDATE, PROGRESS, REVIEW, ";
			sql += "PRODUCTNAME, PRODUCTPRICE, PRODUCTCATEGORY, SAVEFILENAME ";
			sql += "FROM ORDERS O, PRODUCT P ";
			sql += "WHERE O.PRODUCTNUM = P.PRODUCTNUM AND ORDERNUM = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, orderNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				dto = new OrdersDTO();

				dto.setOrderNum(rs.getInt("ORDERNUM"));
				dto.setUserId(rs.getString("USERID"));
				dto.setProductNum(rs.getInt("PRODUCTNUM"));
				dto.setOrderQuantity(rs.getInt("ORDERQUANTITY"));
				dto.setOrderColor(rs.getString("ORDERCOLOR"));
				dto.setOrderSize(rs.getString("ORDERSIZE"));
				dto.setUpdatedDate(rs.getString("UPDATEDDATE"));
				dto.setProgress(rs.getString("PROGRESS"));
				dto.setReview(rs.getInt("REVIEW"));

				dto.setProductName(rs.getString("PRODUCTNAME"));
				dto.setProductPrice(rs.getInt("PRODUCTPRICE"));
				dto.setProductCategory(rs.getString("PRODUCTCATEGORY"));
				dto.setSaveFileName(rs.getString("SAVEFILENAME").split(","));

			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;

	}

}
