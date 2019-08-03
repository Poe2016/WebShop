package com.util;

import java.io.Serializable;

import javax.swing.ImageIcon;

/**
 * 获取商品信息类 对于每一个商品，有商品编号、商品名、商品价格、商品上传者、商品描述、商品数量等这些属性
 * 
 * @author Poe
 *
 */
public class Good implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4558876127402513L;
	private String goodNo;// 商品编号
	private String goodName;// 商品名
	private Integer goodPrice;// 商品价格
	private String goodUserSale;// 商品上传者
	private String goodDescription;// 商品描述
	private Integer goodNum;// 商品数量，-指某个用户上传的某一个商品的数量
	private String goodfilename;// 仅只图片的文件名，不包括编号
	private String picture_name;// 服务器中图片名，包括编号
	private String type;// 商品所属型号，有：iPhone系列，华为系列，小米系列，OPPO系列，vivo系列，魅族系列，一加系列，金立系列
	private String detil_type;// 商品对应系列里面的型号：
	/*
	 * iphone：iphoneX,iphone8,iphone7,其他 
	 * 华为： Mate / P系 /荣耀； 
	 * 小米： MIX /红米/Note
	 * OPPO:A /R /Find; 
	 * vivo:Xplay /X / Y 
	 * 魅族:Pro /魅蓝 
	 * 一加:X /T
	 * 金立:M/S
	 * 
	 */

	public Good(String goodNo) {
		this.goodNo = goodNo;

	}

	public Good(String goodNo, String goodName, int goodPrice, String goodUserSale, String goodDescription, int goodNum,
			String goodfilename) {
		super();
		this.goodNo = goodNo;
		this.goodName = goodName;
		this.goodPrice = goodPrice;// 自动装箱
		this.goodUserSale = goodUserSale;
		this.goodDescription = goodDescription;
		this.goodNum = goodNum;// 自动装箱
		this.goodfilename = goodfilename;
	}

	public Good(String goodNo, String goodName, int goodPrice, String goodUserSale, String goodDescription, int goodNum,
			String goodfilename, String type) {
		super();
		this.goodNo = goodNo;
		this.goodName = goodName;
		this.goodPrice = goodPrice;// 自动装箱
		this.goodUserSale = goodUserSale;
		this.goodDescription = goodDescription;
		this.goodNum = goodNum;// 自动装箱
		this.goodfilename = goodfilename;
		this.type = type;
	}
	public Good(String goodNo, String goodName, int goodPrice, String goodUserSale, String goodDescription, int goodNum,
			String goodfilename, String type,String detail_type) {
		super();
		this.goodNo = goodNo;
		this.goodName = goodName;
		this.goodPrice = goodPrice;// 自动装箱
		this.goodUserSale = goodUserSale;
		this.goodDescription = goodDescription;
		this.goodNum = goodNum;// 自动装箱
		this.goodfilename = goodfilename;
		this.type = type;
		this.detil_type = detail_type;
	}
	

	public String getDetil_type() {
		return detil_type;
	}

	public void setDetil_type(String detil_type) {
		this.detil_type = detil_type;
	}

	public String getPicture_name() {
		return this.goodNo + "+" + this.goodfilename;
	}

	public void setPicture_name(String picture_name) {
		this.picture_name = picture_name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void setGoodPrice(Integer goodPrice) {
		this.goodPrice = goodPrice;
	}

	public void setGoodNum(Integer goodNum) {
		this.goodNum = goodNum;
	}

	public String getGoodNo() {
		return goodNo;
	}

	public String getGoodfilename() {
		return goodfilename;
	}

	public void setGoodfilename(String goodfilename) {
		this.goodfilename = goodfilename;
	}

	public void setGoodNo(String goodNo) {
		this.goodNo = goodNo;
	}

	public String getGoodName() {
		return goodName;
	}

	public void setGoodName(String goodName) {
		this.goodName = goodName;
	}

	public int getGoodPrice() {
		return goodPrice.intValue();
	}

	public void setGoodPrice(int goodPrice) {
		this.goodPrice = goodPrice;
	}

	public String getGoodUserSale() {
		return goodUserSale;
	}

	public void setGoodUserSale(String goodUserSale) {
		this.goodUserSale = goodUserSale;
	}

	public String getGoodDescription() {
		return goodDescription;
	}

	public void setGoodDescription(String goodDescription) {
		this.goodDescription = goodDescription;
	}

	public int getGoodNum() {
		return goodNum.intValue();
	}

	public void setGoodNum(int goodNum) {
		this.goodNum = goodNum;
	}

}
