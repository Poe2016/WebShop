package com.servlet;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.Conn2Ora;
import com.util.Good;

import oracle.sql.BLOB;

public class WelcomeServlet extends HttpServlet {
	/**
	 * 访问首页前先访问welcomeServlet，进行一些初始化
	 */

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Conn2Ora conn2ora = Conn2Ora.getInstance();
		Connection con = conn2ora.con;// 与数据库的连接
//		saveList(con);//存入goodslist
		ArrayList<Good> list = getList(con);// 获取整个系统的商品容器
		System.out.println(list.size()+" 大琐琐碎碎");
		System.out.println(list.get(0).getGoodfilename()+" "+list.get(0).getGoodDescription());
		HttpSession session = request.getSession();
		session.setAttribute("goodslist", list);// 保存，方便客户端获取

		session.getServletContext().getRequestDispatcher(response.encodeURL("/home/home.jsp")).forward(request,
				response);// 跳转到首页
		
		
		/*System.out.println("总量："+list.size());
		Good g=new Good("00000001","iphone", 6888, "123@qq.com", "iphone最新款",4,"11.jpg");
		list.add(g);
		updateGoodList(con,list);//更新
		list = getList(con);
		System.out.println("总量："+list.size());
		
		list.get(0).setGoodfilename("11.png");
		
		list = getList(con);
		
		list.add(g);
		updateGoodList(con,list);//更新
		list = getList(con);*/

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	// 将装Good对象的ArrayList存入数据库
	@SuppressWarnings("deprecation")
	public void saveList(Connection con) {
		ArrayList<Good> goodslist=new ArrayList<Good>();
		try {
			ByteArrayOutputStream byteOut = new ByteArrayOutputStream();
			ObjectOutputStream outObj = new ObjectOutputStream(byteOut);
			outObj.writeObject(goodslist);
			final byte[] objbytes = byteOut.toByteArray();

			Statement st = con.createStatement();
			st.executeUpdate("insert into listtable (list) values (empty_blob())");
			ResultSet rs = st.executeQuery("select list from listtable for update");
			if (rs.next()) {
				BLOB blob = (BLOB) rs.getBlob("list");
				OutputStream outStream = blob.getBinaryOutputStream();
				outStream.write(objbytes, 0, objbytes.length);
				outStream.flush();
				outStream.close();
			}
			byteOut.close();
			outObj.close();
			con.commit();
			System.out.println("goodslist存入成功");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void updateGoodList(Connection con, ArrayList<Good> list) {
		try {
			ByteArrayOutputStream byteOut = new ByteArrayOutputStream();
			ObjectOutputStream outObj = new ObjectOutputStream(byteOut);
			outObj.writeObject(list);
			final byte[] objbytes = byteOut.toByteArray();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select list from listtable for update");
			if (rs.next()) {
				BLOB blob = (BLOB) rs.getBlob("list");
				OutputStream outStream = blob.getBinaryOutputStream();
				outStream.write(objbytes, 0, objbytes.length);
				outStream.flush();
				outStream.close();
			}
			byteOut.close();
			outObj.close();
			con.commit();
			System.out.println("goodlist更新成功");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 获取ArrayList对象
	public static ArrayList<Good> getList(Connection con) {
		ArrayList<Good> list = null;
		Statement st = null;
		ResultSet rs = null;
		try {

			con.setAutoCommit(false);
			st = con.createStatement();
			// 取出blob字段中的对象，并恢复
			rs = st.executeQuery("select list from listtable");
			BLOB inblob = null;
			if (rs.next()) {
				inblob = (BLOB) rs.getBlob("list");
				System.out.println(inblob);
			}
			if (inblob != null) {
				// list = (ArrayList<Good>)inblob.toJdbc();
				InputStream is = inblob.getBinaryStream();
				ObjectInputStream in = new ObjectInputStream(is);
				list = (ArrayList<Good>) in.readObject();
				// BufferedInputStream input = new BufferedInputStream(is);
				//
				// byte[] buff = new byte[inblob.getBufferSize()];
				// while (-1 != (input.read(buff, 0, buff.length)))
				// ;
				//
				// ObjectInputStream in = new ObjectInputStream(new
				// ByteArrayInputStream(buff));
				// list = (ArrayList<Good>) in.readObject();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("获取list成功");
		return list;
	}

}
