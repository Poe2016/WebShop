package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.Conn2Ora;

/**
 * 常用servlet，ajax的请求都在这里处理
 * Servlet implementation class UtilServlet
 */
public class UtilServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UtilServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String reqstate = request.getParameter("reqstate");//请求码状态
		
		Connection con = Conn2Ora.con;
		Statement st = Conn2Ora.st;
		ResultSet rs = null;
		
		String sql=null;
		
		if(reqstate.equals("caregood")){//关注商品
			String mail = request.getParameter("mailno");
			String goodno = request.getParameter("goodno");
			String uid = request.getParameter("uid");
			sql = "insert into caregood_t"+uid+"(goodno,mail) values(\'"+goodno+"\',\'"+mail+"\')";
			System.out.println(sql);
			try {
				st.execute(sql);
				con.commit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			
		}else if(reqstate.equals("notcare")){//取消关注
			String mail = request.getParameter("mailno");
			String goodno = request.getParameter("goodno");
			String uid = request.getParameter("uid");
			sql = "delete from caregood_t"+uid+" where goodno=\'"+goodno+"\'";
			System.out.println(sql);
			try {
				st.execute(sql);
				con.commit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if(reqstate.equals("caresaler")){//关注店铺
			String mail = request.getParameter("mailno");
			String saler = request.getParameter("saler");
			String uid = request.getParameter("uid");
			sql = "insert into caresaler_t"+uid+"(saler) values(\'"+saler+"\')";
			System.out.println(sql);
			try {
				st.execute(sql);
				con.commit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if(reqstate.equals("notcaresaler")){//取消关注
			String mail = request.getParameter("mailno");
			String saler = request.getParameter("saler");
			String uid = request.getParameter("uid");
			sql = "delete from caresaler_t"+uid+" where saler=\'"+saler+"\'";
			System.out.println(sql);
			try {
				st.execute(sql);
				con.commit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
