package com.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.Conn2Ora;
import com.util.Good;
import com.util.ShopCart;

public class AddToCartServlet extends HttpServlet {
	/**
	 * 用于向购物车中添加商品
	 */

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ArrayList<Good> list = (ArrayList<Good>) session.getAttribute("goodslist");// 获取商品列表
		ShopCart cart = (ShopCart) session.getAttribute("cart");// 获取该用户的购物车
		String goodNo = request.getParameter("goodno");// 获取商品编号
		System.out.println(goodNo);
		if (!cart.contain(goodNo)) {
			for (Good g : list) {
				if (g.getGoodNo().equals(goodNo)) {
					cart.addGoods(g);// 向购物车中添加商品
					LoginServlet.updateCart(Conn2Ora.con, cart);
					System.out.println("加入购物车成功");
					break;
				}
			}
			response.sendRedirect("http://localhost:8080/WebShop/home/addsuccess.jsp?goodno="+goodNo);
		} else {
			System.out.println("商品已经存在购物车中");
			response.sendRedirect("http://localhost:8080/WebShop/home/carthave.jsp?goodno="+goodNo);
		}

		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
