package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.ShopCart;
/**
 * 付款servlet，处理完后跳向付款页面
 * @author Poe
 *
 */

public class PayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PayServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String[] che_boxs = request.getParameterValues("checkItem");//获取复选框的值
		ShopCart cart = (ShopCart)session.getAttribute("cart");
		if(che_boxs==null){
			System.out.println("nll");
		}
		for(int i=0;i<che_boxs.length;i++){
			System.out.println(che_boxs[i]);
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
