package com.util;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * 购物车类，每个用户对应一个购物车，每个购物车拥有商品总数、每个商品的详细信息
 * 
 * @author Poe
 *
 */
public class ShopCart implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4558876142427402513L;
	private String mail;// 该用户名
	private int total;// 商品总类数
	private ArrayList<Good> goodList;// 所有商品集合
	private ArrayList<Integer> numList;// 各商品对应购买的数量
	private Conn2Ora conn2ora;
	// private Connection con;

	// 根据用户名来创建购物车
	public ShopCart(String mail) {
		this.mail = mail;
		this.goodList = new ArrayList<Good>();
		this.numList = new ArrayList<Integer>();
		this.conn2ora = Conn2Ora.getInstance();// 获取与数据库的连接，方便后面验证用户名与密码
		// this.con = conn2ora.con;
	}

	public String getMail() {
		return mail;
	}

	// 往购物车中添加商品
	public void addGoods(Good g) {
		if (!this.goodList.contains(g)) {
			this.goodList.add(g);
			this.numList.add(1);// 计入初始数量
			this.total++;
		} else {
			System.out.println("商品已存在购物车中");
		}
	}

	// 根据序号获取商品
	public Good getGoods(int i) {
		return this.goodList.get(i);
	}

	// 购物车中获取商品
	public Good getGoods(String goodNo) {
		for (Good g : goodList) {
			if (g.getGoodNo().equals(goodNo)) {
				return g;
			}
		}
		System.out.println("购物车中无该商品");
		return null;
	}

	// 往购物车中删除商品
	public void deleteGoods(Good g) {
		if (!this.goodList.contains(g)) {
			int index = this.goodList.indexOf(g);
			this.numList.remove(index);
			this.goodList.remove(g);
			this.total--;
		} else {
			System.out.println("商品不在购物车中");
		}
	}

	// 根据商品编号删除商品
	public boolean deleteGoods(String goodno) {
		if (!contain(goodno)) {
			System.out.println("该商品不在购物车中");
			return false;
		} else {
			for (int i = 0; i < this.goodList.size(); i++) {
				if (this.goodList.get(i).getGoodNo().equals(goodno)) {
					this.goodList.remove(i);
					this.numList.remove(i);
					this.total--;
					return true;
				}
			}
			return false;
		}
	}

	// 获取购物车中商品总数
	public int getTotal() {
		// String sqlstatement = "select count(*) total from cart where mail=\'"
		// + this.mail + "\'";
		// PreparedStatement pst = null;
		// ResultSet res = null;
		// try {
		// pst = con.prepareStatement(sqlstatement);
		// res = pst.executeQuery();
		// if(res.next()){
		// this.total = res.getInt("total");
		// }
		// } catch (SQLException e) {
		// e.printStackTrace();
		// }
		total = this.goodList.size();
		return total;
	}

	// 获取购物车中的所有商品的集合
	public ArrayList<Good> getGoodList() {
		String sqlstatement = "select goodno from cart where mail= \'" + this.mail + "\'";
		PreparedStatement pst = null;
		ResultSet res = null;
		Connection con = this.conn2ora.con;
		try {
			pst = con.prepareStatement(sqlstatement);
			res = pst.executeQuery();
			while (res.next()) {
				String goodNo = res.getString("goodno");
				Good g = new Good(goodNo);
				this.goodList.add(g);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return goodList;
	}

	public ArrayList<Integer> getNumList() {
		return this.numList;
	}

	// 根据商品编号获取商品购买的数量
	public int getBuyNum(String goodno) {
		int num = 0;
		for (int i = 0; i < this.goodList.size(); i++) {
			if (this.goodList.get(i).getGoodNo().equals(goodno)) {
				num = this.numList.get(i);
				System.out.println("数量为：" + num);
				break;
			}
		}
		return num;
	}

	public void addNum(int i) {
		int now_num = this.numList.get(i) + 1;
		this.numList.set(i, now_num);
	}

	public void decreaseNum(int i) {
		int now_num = this.numList.get(i) - 1;
		this.numList.set(i, now_num);
	}

	// 判断购物车中是否含有某个商品
	public boolean contain(String goodNo) {
		for (Good g : this.goodList) {
			if (g.getGoodNo().equals(goodNo)) {
				return true;// 已经存在
			}
		}
		return false;
	}

}
