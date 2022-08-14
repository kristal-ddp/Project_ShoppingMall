package com.orders;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DeliveryDAO {

	private Connection conn;

	public DeliveryDAO(Connection conn) {
		this.conn = conn;

	}

	public int getMaxNum() {

		int result = 0;
		PreparedStatement pstmt;
		ResultSet rs;
		String sql;

		try {

			sql = "SELECT NVL(MAX(DELIVERYNUM), 0) FROM DELIVERY";

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

	public int insertData(DeliveryDTO dto) {

		int result = 0;
		PreparedStatement pstmt;
		String sql;

		try {

			sql = "INSERT INTO DELIVERY(DELIVERYNUM, USERID, ORDERNUM, DELIVERYNAME, DELIVERYTEL, ";
			sql += "DELIVERYADDR, DELIVERYEMAIL, TOTALPRICE, DELIVERYDATE, ARRIVEDATE, PROGRESS) ";
			sql += "VALUES(?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, ROUND(SYSDATE + 3), ?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getDeliveryNum());
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, String.join(",", dto.getOrderNum()));
			pstmt.setString(4, dto.getDeliveryName());
			pstmt.setString(5, dto.getDeliveryTel());
			pstmt.setString(6, String.join("/", dto.getDeliveryAddr()));
			pstmt.setString(7, dto.getDeliveryEmail());
			pstmt.setInt(8, dto.getTotalPrice());
			pstmt.setString(9, dto.getProgress());

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}

	public int updateData(DeliveryDTO dto) {

		int result = 0;
		PreparedStatement pstmt;
		String sql;

		try {
			
			String str = "";
			if (dto.getProgress() == "orderList") {
				str = " DELIVERYDATE = SYSDATE, ARRIVEDATE = ROUND(SYSDATE + 3),";
			} else if (dto.getProgress() == "cancelList") {
				str = " ARRIVEDATE = TO_DATE(SYSDATE, 'YYYY-MM-DD HH24:MI:SS' ),";
			} 
			
			sql = "UPDATE DELIVERY SET DELIVERYNAME = ?, DELIVERYTEL = ?, DELIVERYADDR = ?, DELIVERYEMAIL = ?," + str + " PROGRESS = ? ";
			sql += "WHERE DELIVERYNUM = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getDeliveryName());
			pstmt.setString(2, dto.getDeliveryTel());
			pstmt.setString(3, String.join("/", dto.getDeliveryAddr()));
			pstmt.setString(4, dto.getDeliveryEmail());
			
			if (dto.getProgress() == "orderList") {
				pstmt.setString(5, dto.getDeliveryDate());
				pstmt.setString(6, dto.getArriveDate());
				pstmt.setString(7, dto.getProgress());
				pstmt.setInt(8, dto.getDeliveryNum());
			} else {
				pstmt.setString(5, dto.getProgress());
				pstmt.setInt(6, dto.getDeliveryNum());
			}
			

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}

	public List<DeliveryDTO> getList(String userId, String progress) {

		List<DeliveryDTO> list = new ArrayList<>();
		PreparedStatement pstmt;
		ResultSet rs;
		String sql;

		try {

			String str = "";
			if (progress == "cancelList") {
				str = " TO_CHAR(ARRIVEDATE, 'YYYY-MM-DD HH24:MI'),";
			} else {
				str = " TO_CHAR(ARRIVEDATE, 'YYYY-MM-DD'),";
			}
			
			sql = "SELECT DELIVERYNUM, USERID, ORDERNUM, DELIVERYNAME, DELIVERYTEL, DELIVERYADDR, DELIVERYEMAIL, ";
			sql += "TOTALPRICE, TO_CHAR(DELIVERYDATE, 'YYYY-MM-DD HH24:MI')," + str +" PROGRESS ";
			sql += "FROM DELIVERY WHERE USERID = ? AND PROGRESS = ? ORDER BY DELIVERYNUM DESC";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, progress);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				DeliveryDTO dto = new DeliveryDTO();

				dto.setDeliveryNum(rs.getInt("DELIVERYNUM"));
				dto.setUserId(rs.getString("USERID"));
				dto.setOrderNum(rs.getString("ORDERNUM").split(","));
				dto.setDeliveryName(rs.getString("DELIVERYNAME"));
				dto.setDeliveryTel(rs.getString("DELIVERYTEL"));
				dto.setDeliveryAddr(rs.getString("DELIVERYADDR").split("/"));
				dto.setDeliveryEmail(rs.getString("DELIVERYEMAIL"));
				dto.setTotalPrice(rs.getInt("TOTALPRICE"));
				dto.setDeliveryDate(rs.getString(9));
				dto.setArriveDate(rs.getString(10));
				dto.setProgress(rs.getString("PROGRESS"));
				
				dto.setOrderList(new OrdersDAO(conn).getList(rs.getString("ORDERNUM").split(",")));

				list.add(dto);

			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return list;

	}

	public DeliveryDTO getReadData(int deliveryNum) {

		DeliveryDTO dto = null;
		PreparedStatement pstmt;
		ResultSet rs;
		String sql;

		try {

			sql = "SELECT DELIVERYNUM, USERID, ORDERNUM, DELIVERYNAME, DELIVERYTEL, DELIVERYADDR, DELIVERYEMAIL,";
			sql += "TOTALPRICE, TO_CHAR(DELIVERYDATE, 'YYYY-MM-DD HH24:MI'), TO_CHAR(ARRIVEDATE, 'YYYY-MM-DD'), PROGRESS ";
			sql += "FROM DELIVERY WHERE DELIVERYNUM = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, deliveryNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				dto = new DeliveryDTO();

				dto.setDeliveryNum(rs.getInt("DELIVERYNUM"));
				dto.setUserId(rs.getString("USERID"));
				dto.setOrderNum(rs.getString("ORDERNUM").split(","));
				dto.setDeliveryName(rs.getString("DELIVERYNAME"));
				dto.setDeliveryTel(rs.getString("DELIVERYTEL"));
				dto.setDeliveryAddr(rs.getString("DELIVERYADDR").split("/"));
				dto.setDeliveryEmail(rs.getString("DELIVERYEMAIL"));
				dto.setTotalPrice(rs.getInt("TOTALPRICE"));
				dto.setDeliveryDate(rs.getString(9));
				dto.setArriveDate(rs.getString(10));
				dto.setProgress(rs.getString("PROGRESS"));

				dto.setOrderList(new OrdersDAO(conn).getList(rs.getString("ORDERNUM").split(",")));
				
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;

	}

}
