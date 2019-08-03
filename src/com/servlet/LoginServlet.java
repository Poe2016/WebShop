package com.servlet;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.Conn2Ora;
import com.util.Good;
import com.util.ShopCart;

import oracle.sql.BLOB;
//import org.hibernate.Hibernate;  

public class LoginServlet extends HttpServlet {

	/**
	 * request ： 请求对象，包含发给服务器的参数
	 * 
	 * response 响应对象
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String psw = null;// 真实密码
		int act = 0;// 激活标志
		int userid=0;//用户编号
		String history_table_name="his_table";
		String search_table_name="search_key_t";
		PreparedStatement pst = null;
		ResultSet res = null;
		String sqlstatement = null;
		Conn2Ora conn2ora = Conn2Ora.getInstance();// 获取与数据库的连接，方便后面验证用户名与密码
		Connection con = conn2ora.con;
		// saveList(con);
		// System.out.println("list存入成功");

		// Good g=new Good("003");
		// l.add(g);
		// list.clear();
		// Good good = new Good("00000001","iphone8", 6888, "123@qq.com",
		// "iphone最新款",4);
		// list.add(good);//测试样品
		// updateGoodList(con,list);//跟新表中的list
		// System.out.println("大小"+list.size());

		request.setCharacterEncoding("utf-8");
		String mailnumber = request.getParameter("loginname");// 获取账号邮箱
		String password = request.getParameter("nloginpwd");
		sqlstatement = "select password,active,userid from users where mail=\'" + mailnumber + "\'";
		try {
			pst = con.prepareStatement(sqlstatement);
			res = pst.executeQuery();
			if (res.next()) {
				psw = res.getString("password");
				act = res.getInt("active");
				userid=res.getInt("userid");
				if(userid!=0){
					history_table_name+=userid;
					search_table_name+=userid;
				}
			}

			if (psw == null) {// 当数据库中无用户名的时候res也不为空
				System.out.println("无此用户名");
			} else if (psw.equals(password)) {
				if (act == 1) {//登陆成功
					HttpSession session = request.getSession();
					session.setAttribute("onlineuser", mailnumber);// 上线用户名
					session.setAttribute("historytable", history_table_name);
					session.setAttribute("searchtable", search_table_name);
					// 用户上线成功后立即判断该用户是否已有购物车，若没有则创建一个并保存，若有则取出购物车
					ShopCart c = getShopCart(con, mailnumber);
					if (c == null) {// 该用户还不存在购物车
						c = new ShopCart(mailnumber);// 创建购物车实例
						// 保存购物车实例
						saveObject(con, c);
					}else{
						System.out.println("购物车中已有"+c.getTotal());
					}
					session.setAttribute("cart", c);

					// 以下是保存在线用户
					// sqlstatement = "insert into usersOnline
					// values(\'"+mailnumber+"\')";
					// pst = con.prepareStatement(sqlstatement);
					// pst.execute();
					// con.commit();

					String loginState = (String) session.getAttribute("loginstate");// 获取登录是否是在进入购物车时的登录
					// String addToCart = (String)
					// session.getAttribute("addToCart");
					if (loginState == null || loginState.equals("")) {
						System.out.println("平常登录");
						response.sendRedirect("http://localhost:8080/WebShop/");
//						session.getServletContext().getRequestDispatcher(response.encodeURL("/home/home.jsp"))
//								.forward(request, response);
					} else if (loginState.equals("cart")) {
						System.out.println("进购物车");
						session.setAttribute("loginstate", "");
						response.sendRedirect("home/cart.jsp");
//						session.getServletContext().getRequestDispatcher(response.encodeURL("/home/cart.jsp"))
//								.forward(request, response);
					} else if (loginState.equals("myStore")) {
						System.out.println("我的商城前的登录");
						session.setAttribute("loginstate", "");
						response.sendRedirect("home/myStore.jsp");
//						session.getServletContext().getRequestDispatcher(response.encodeURL("/home/myStore.jsp"))
//								.forward(request, response);
					} else if (loginState.equals("addToCart")) {
						System.out.println("加入购物车前的登录");
						session.setAttribute("loginstate", "");
						response.sendRedirect("home/search.jsp");
//						session.getServletContext().getRequestDispatcher(response.encodeURL("/home/search.jsp"))
//								.forward(request, response);
					}else if (loginState.equals("upload")) {
						System.out.println("上传商品前的登录");
						session.setAttribute("loginstate", "");
						response.sendRedirect("home/upload.jsp");
//						session.getServletContext().getRequestDispatcher(response.encodeURL("/home/upload.jsp"))
//								.forward(request, response);
					}
				} else {
					System.out.println("该用户尚未激活");
				}
			} else {
				System.out.println("密码错误");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);

	}

	// 将对象存入数据库
	@SuppressWarnings("deprecation")
	public void saveObject(Connection con, ShopCart c) {
		try {
			ByteArrayOutputStream byteOut = new ByteArrayOutputStream();
			ObjectOutputStream outObj = new ObjectOutputStream(byteOut);
			outObj.writeObject(c);
			final byte[] objbytes = byteOut.toByteArray();
			Statement st = con.createStatement();
			st.executeUpdate("insert into cartofuser (mail, cart) values (\'" + c.getMail() + "\', empty_blob())");
			ResultSet rs = st.executeQuery("select cart from cartofuser where mail=\'" + c.getMail() + "\' for update");
			if (rs.next()) {
				BLOB blob = (BLOB) rs.getBlob("cart");
				OutputStream outStream = blob.getBinaryOutputStream();
				outStream.write(objbytes, 0, objbytes.length);
				outStream.flush();
				outStream.close();
			}
			byteOut.close();
			outObj.close();
			con.commit();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 获取用户的购物车
	public ShopCart getShopCart(Connection con, String mail) {
		ShopCart cart = null;
		Statement st = null;
		ResultSet rs = null;
		try {

			con.setAutoCommit(false);
			st = con.createStatement();
			// 取出blob字段中的对象，并恢复
			rs = st.executeQuery("select cart from cartofuser where mail=\'" + mail + "\'");
			BLOB inblob = null;
			if (rs.next()) {
				inblob = (BLOB) rs.getBlob("cart");
			}
			if (inblob != null) {
				InputStream is = inblob.getBinaryStream();
				BufferedInputStream input = new BufferedInputStream(is);

				byte[] buff = new byte[inblob.getBufferSize()];
				while (-1 != (input.read(buff, 0, buff.length)))
					;

				ObjectInputStream in = new ObjectInputStream(new ByteArrayInputStream(buff));
				cart = (ShopCart) in.readObject();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
//		System.out.println(cart.getMail());
		return cart;
	}
	//更新购物车在数据库中的存储
	public static void updateCart(Connection con, ShopCart cart){
		try {
			ByteArrayOutputStream byteOut = new ByteArrayOutputStream();
			ObjectOutputStream outObj = new ObjectOutputStream(byteOut);
			outObj.writeObject(cart);
			final byte[] objbytes = byteOut.toByteArray();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select cart from cartofuser where mail=\'" + cart.getMail() + "\' for update");
			if (rs.next()) {
				BLOB blob = (BLOB) rs.getBlob("cart");
				OutputStream outStream = blob.getBinaryOutputStream();
				outStream.write(objbytes, 0, objbytes.length);
				outStream.flush();
				outStream.close();
			}
			byteOut.close();
			outObj.close();
			con.commit();
			System.out.println("数据库中的购物车更新成功");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

}
