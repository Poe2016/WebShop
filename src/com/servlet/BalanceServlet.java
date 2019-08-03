package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BalanceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public BalanceServlet() {
        super();
    }
    /**
     * 结算，一跳到该Servlet立即产生待处理订单
     */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] tele = request.getParameterValues("teleCheckbox");//获取复选框的值</span>
		System.out.println("结算Servlet");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
