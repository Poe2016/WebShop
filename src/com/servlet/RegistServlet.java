package com.servlet;

import com.util.Conn2Ora;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegistServlet extends HttpServlet{
	
	/**
	 * request ： 请求对象，包含发给服务器的参数
	 * 
	 * response 响应对象
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Conn2Ora conn2ora = Conn2Ora.getInstance();
		Connection con = conn2ora.con;
		Statement st=null;
		int userid=0;
		String history_table_name="his_table";//用户浏览记录表，该表中保存了用户浏览的商品编号，时间，次数
		String search_table_name="search_key_t";//用户搜索关键字表
		String caregood_name = "caregood_t";//关注商品列表
		String caresaler_name = "caresaler_t";//关注店铺表名
		ResultSet rs=null;
		String sql=null;
		
		request.setCharacterEncoding("utf-8");
		String mailnumber = request.getParameter("mail");//获取账号邮箱
		String password = request.getParameter("password");//密码
		System.out.println(mailnumber+"  "+password);
		try {
			st = con.createStatement();
			rs=st.executeQuery("select userid_seq.nextval from dual");
			while(rs.next()){
				userid = rs.getInt("nextval");//获取用户id
				history_table_name+=userid;
				search_table_name+=userid;
				caregood_name += userid;
				caresaler_name += userid;
				System.out.println("循环 "+userid);
			}
			System.out.println("id "+userid);
			sql="insert into users(mail,password,active,userid) values(\'"+mailnumber+"\',\'"+password+"\',1,"+userid+")";
			st.execute(sql);//插入注册用户
			sql="create table "+history_table_name+"(goodno char(8),see_date date,amount int,primary key(goodno,see_date))";
			st.execute(sql);//创建历史记录表
			sql="create table "+search_table_name+"(keyword varchar2(20),amount int)";
			st.execute(sql);//创建搜索关键字表
			sql="create table "+caregood_name+"(goodno char(8) primary key,mail VARCHAR2(20) REFERENCES users(mail))";
			st.execute(sql);//创建用户关注商品列表
			sql="create table "+caresaler_name+"(saler VARCHAR2(20) REFERENCES users(mail))";
			st.execute(sql);//创建该用户关注店铺表
			con.commit();
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		

		response.sendRedirect("home/registSuccess.jsp");
			

		
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	

}
