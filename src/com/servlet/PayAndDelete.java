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
 * 立即付款和删除订单处理servlet
 */
public class PayAndDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PayAndDelete() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String state = request.getParameter("condition");// 状态码，pay表示付款，delete表示删除
		String ord_id = request.getParameter("ord_id");// 订单商品编号
		String mail = request.getParameter("mail");// 订单商品编号
		Connection con = Conn2Ora.con;
		Statement st = Conn2Ora.st;
		String sql = null;
		String url = null;// 要跳转的url
		String mial = null;//购买订单的用户邮箱
		try {
			if (state.equals("pay")) {// 付款，在数据库中修改
				sql = "update order_t set pay=1 where ord_id=\'" + ord_id + "\'";
				st.execute(sql);
				System.out.println("订单付款成功");
				con.commit();
				url = "home/buyer_order.jsp";
			} else if (state.equals("delete")) {// 删除订单
				sql = "delete from order_t where ord_id=\'" + ord_id + "\'";
				st.execute(sql);
				System.out.println("订单删除成功");
				con.commit();
				url = "home/buyer_order.jsp";
			} else if (state.equals("confirm_receive")) {// 确认收货
				sql = "update order_t set receive_state=1 where ord_id=\'" + ord_id + "\'";
				st.execute(sql);
				System.out.println("订单收货成功");
				con.commit();
				url = "home/payed_order.jsp";
			} else if (state.equals("confirm_send")) {// 发货
				sql = "update order_t set send_state=1 where ord_id=\'" + ord_id + "\'";
				st.execute(sql);
				System.out.println("订单发货成功");
				con.commit();
				url = "home/send_after_order.jsp";
			} else if (state.equals("evaluate")) {// 评价晒单
				String pkscore = request.getParameter("pkscore");// 包装评分
				String spscore = request.getParameter("spscore");// 速度评分
				String atscore = request.getParameter("atscore");// 态度评分
				String goscore = request.getParameter("goscore");// 商品评分
				String tags = request.getParameter("tags");// 标签字符串，以","连接，直接存入数据库
				String def_text = request.getParameter("def_text");// 自定义标签
				String words = request.getParameter("words");// 文字输入
				String anony = request.getParameter("anony");// 匿名评价，默认为否（0）1-是
				// String[] tagArray = tags.split(",");//标签字符串数组
				sql = "select mail from order_t where ord_id=\'"+ord_id+"\'";
				ResultSet rs = st.executeQuery(sql);//取出用户邮箱
				if(rs.next()){
					mail = rs.getString("mail");
				}

				System.out.println(pkscore + " " + spscore + " " + atscore + " " + goscore + " " + tags + " " + def_text
						+ " " + words + " " + anony);
				sql = "insert into evaluation(eva_id,ord_id,mail,eva_date,pkscore,spscore,atscore,goscore,tags,def_text,words,anony) values(eva_id_seq.nextval,"
						+ ord_id + ",\'" + mail + "\',sysdate,\'" + pkscore + "\',\'" + spscore + "\',\'" + atscore
						+ "\',\'" + goscore + "\',\'" + tags + "\',\'" + def_text + "\',\'" + words + "\',\'" + anony+"\')";
				System.out.println(sql);
				 st.execute(sql);
				 con.commit();
				 url = "home/evaluate_success.jsp?ord_id="+ord_id;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		response.sendRedirect(url);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
