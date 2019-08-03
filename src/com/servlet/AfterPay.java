package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.Conn2Ora;
import com.util.Good;
import com.util.ShopCart;

/**
 * 点击立即付款或者稍后付款后跳到该servlet处理数据 1、购物车中删除选中商品 2、所有商品列表中商品的数量减少 3、买家已付款订单或待付款订单表增加
 * 4、卖家待处理订单表增加
 */
public class AfterPay extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AfterPay() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Connection con = Conn2Ora.con;
		Statement st = Conn2Ora.st;
		String mail = (String) session.getAttribute("onlineuser");// 在线用户邮箱
		ShopCart cart = (ShopCart) session.getAttribute("cart");// 购物车
		String address = request.getParameter("address");// 地址
		String nickname = request.getParameter("nickname");// 收货人
		String state = request.getParameter("paystate");// 付款状态，有right和after
		String goodnos_string = request.getParameter("goodnos");
		String[] goodnos = goodnos_string.split(",");// 所有选中商品编号
		// 获取当前时间由Oracle数据库完成
		String sql = null;// sql语句
		// 1、修改买家订单表，每个商品编号对应一个元组
		for (int i = 0; i < goodnos.length; i++) {// 每个商品编号对应订单表中的一条元组
			String goodno = goodnos[i];// 取出商品编号
			Good g = cart.getGoods(goodno);// 获取对应商品
			int ord_price = g.getGoodPrice();// 商品单价
			int ord_num = cart.getBuyNum(goodno);// 购买数量
			int money = ord_price * ord_num;// 总价
			int pay = 0;// 付款状态
			String seller = g.getGoodUserSale();// 卖家邮箱
			if (state.equals("right")) {
				pay = 1;
			} else {
				pay = 0;
			}
			sql = "insert into order_t(ord_id,mail,goodno,ord_date,ord_price,ord_num,money,ord_address,pay,seller,receiver,send_state,receive_state) values(ord_id_seq.nextval,\'"
					+ mail + "\',\'" + goodno + "\',sysdate," + +ord_price + "," + ord_num + "," + money + ",\'"
					+ address + "\'," + pay + ",\'" + seller + "\',\'" + nickname + "\',0,0)";
			System.out.println(sql);
			try {
				st.execute(sql);
				con.commit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// 2、修改数量
			// 3、购物车中删除商品
			cart.deleteGoods(g.getGoodNo());
			LoginServlet.updateCart(con, cart);//更新

		}

		response.sendRedirect("home/buyer_order.jsp");

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
