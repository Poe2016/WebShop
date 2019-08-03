package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.Conn2Ora;

/**
 * 修改用户信息
 */
public class ModifyInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ModifyInfoServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String nickname = request.getParameter("nickname");
		String address = request.getParameter("address");
		String mailno = request.getParameter("mailno");
		Connection con = Conn2Ora.con;
		Statement st = Conn2Ora.st;
		String sql = "update users set nickname=\'" + nickname + "\',address=\'" + address + "\' where mail=\'" + mailno
				+ "\'";
		System.out.println(sql);
		try {
			st.execute(sql);
			con.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
