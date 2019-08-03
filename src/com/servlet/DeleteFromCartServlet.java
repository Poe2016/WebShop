package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.Conn2Ora;
import com.util.ShopCart;

/**
 * Servlet implementation class DeleteFromCartServlet
 */
public class DeleteFromCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DeleteFromCartServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		ShopCart cart = (ShopCart) session.getAttribute("cart");// 获取用户购物车
		int index = Integer.parseInt(request.getParameter("index"));// 序号
		String flag = request.getParameter("state");
		System.out.println("flag "+flag);
		System.out.println("car: "+cart.getNumList().size());
		if (flag != null && flag != "") {
			if (flag.equals("add")) {// 增加数量
				cart.addNum(index);
				LoginServlet.updateCart(Conn2Ora.con, cart);
				response.sendRedirect("http://localhost:8080/WebShop/home/cart.jsp");
			} else if (flag.equals("decrease")) {// 减小数量
				cart.decreaseNum(index);
				LoginServlet.updateCart(Conn2Ora.con, cart);
				response.sendRedirect("http://localhost:8080/WebShop/home/cart.jsp");
			}
		} else {// 删除商品
			System.out.println("删除商品");
			String goodno = request.getParameter("goodno");// 获取待删除商品编号
			boolean state = cart.deleteGoods(goodno);// 删除商品
			LoginServlet.updateCart(Conn2Ora.con, cart);
			session.setAttribute("cart", cart);
			if (state) {
				System.out.println("商品从购物车中删除成功");
				session.setAttribute("delete_state", "success");
				response.sendRedirect("http://localhost:8080/WebShop/home/cart.jsp");
			} else {
				System.out.println("错误");
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
