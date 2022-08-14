package com.orders;

public class OrdersDTO {

	private int orderNum;
	private String userId;
	private int productNum;
	private int orderQuantity;
	private String orderColor;
	private String orderSize;
	private String updatedDate;
	private String progress;
	private int review;

	private String productName;
	private int productPrice;
	private String productCategory;
	private String[] saveFileName;

	public int getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getProductNum() {
		return productNum;
	}

	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}

	public int getOrderQuantity() {
		return orderQuantity;
	}

	public void setOrderQuantity(int orderQuantity) {
		this.orderQuantity = orderQuantity;
	}

	public String getOrderColor() {
		return orderColor;
	}

	public void setOrderColor(String orderColor) {
		this.orderColor = orderColor;
	}

	public String getOrderSize() {
		return orderSize;
	}

	public void setOrderSize(String orderSize) {
		this.orderSize = orderSize;
	}

	public String getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(String updatedDate) {
		this.updatedDate = updatedDate;
	}

	public String getProgress() {
		return progress;
	}

	public void setProgress(String progress) {
		this.progress = progress;
	}

	public int getReview() {
		return review;
	}

	public void setReview(int review) {
		this.review = review;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public String getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}

	public String[] getSaveFileName() {
		return saveFileName;
	}

	public void setSaveFileName(String[] saveFileName) {
		this.saveFileName = saveFileName;
	}

}
