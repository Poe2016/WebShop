package com.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.Conn2Ora;
import com.util.Good;
import com.util.Similarity;


public class SearchServlet extends HttpServlet {
	
	 public static String [] getFileName(String path)
	    {
	        File file = new File(path);
	        String [] fileName = file.list();
	        return fileName;
	    }
	    public static void getAllFileName(String path,ArrayList<String> fileName)
	    {
	        File file = new File(path);
	        File [] files = file.listFiles();
	        String [] names = file.list();
	        if(names != null)
	        fileName.addAll(Arrays.asList(names));
	        for(File a:files)
	        {
	            if(a.isDirectory())
	            {
	                getAllFileName(a.getAbsolutePath(),fileName);
	            }
	        }
	    }
	
	
	/**
	 * request ： 请求对象，包含发给服务器的参数
	 * 
	 * response 响应对象
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Conn2Ora conn2ora=Conn2Ora.getInstance();
		Connection con = conn2ora.con;
		Statement st=conn2ora.st;
		ResultSet rs=null;
		String sql=null;//sql语句
		int num=0;//指count(*)选出的别名
		int search_amount=0;//表示某个关键字以前搜索的次数
		
		//商品图片文件夹路径
		String goodspath=this.getServletContext().getRealPath("/")+"home\\goodsimgs";
		//商品在服务器中的文件名是由"编号+图片名"组成,在获取图片名后要进行分离
		 String [] goodsName = getFileName(goodspath);//商品图片文件名,商品在服务器中
//		 List<String> goodNoList = new ArrayList<String>();//图片商品编号
//		 for(String s:goodsName){
//			 String[] temp=s.split("\\+");
//			 goodNoList.add(temp[0]);
//		 }
		 String searchtable=(String)session.getAttribute("searchtable");//用于存储搜索关键字的表名
		// 管理员登录验证
		request.setCharacterEncoding("utf-8");
		final String keyword = request.getParameter("key"); // 获取关键字
		System.out.println("关键字"+keyword);
		if(searchtable!=null && keyword!="" && keyword!=null){//登录状态，存入搜素关键字
			sql="select count(*) num from "+searchtable+" where keyword=\'"+keyword+"\'";
			try {
				rs=st.executeQuery(sql);
				if(rs.next()){
					num=rs.getInt("num");
				}
				if(num==0){//表示表中无此关键字，应该插入该关键字
					sql="insert into "+searchtable+" values(\'"+keyword+"\',1)";
					st.execute(sql);
					con.commit();
				}else{//表示表中有该关键字
					sql="select amount from "+searchtable+" where keyword=\'"+keyword+"\'";
					rs=st.executeQuery(sql);
					if(rs.next()){
						search_amount=rs.getInt("amount")+1;
					}
					sql="update "+searchtable+" set amount="+search_amount+" where keyword=\'"+keyword+"\'";
					st.execute(sql);
					con.commit();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		ArrayList<Good> list = (ArrayList<Good>)session.getAttribute("goodslist");//获取所有商品列表
		if(keyword!=null){//关键字非空，安关键字对list进行排序
			Collections.sort(list, new Comparator<Good>() {
	            public int compare(Good g1, Good g2) {
	            	float simi1=similarity_g_key(g1,keyword);
	            	float simi2=similarity_g_key(g2,keyword);
	            	return ((Float)simi2).compareTo((Float)simi1);
	            }
	        });
		}
		session.setAttribute("searchlist", list);
		
		
		request.setAttribute("result", goodsName);//设置返回值
		//request.setAttribute("goodnolist", goodNoList);//设置商品编号返回值
		
//		request.getRequestDispatcher("home/search.jsp").forward(request, response);
		response.sendRedirect("home/search.jsp");
			
		//request.getRequestDispatcher("/login.jsp").forward(request, response);

		
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	/**
	 * 计算两个字符串之间的相似度，该算法按照
	 * @param info表示商品的名字或者商品的描述
	 * @param key搜素的关键字
	 * @return返回一个介于0~1之间的小数，表示相似度
	 */
	private float similarity_info_key(String info,String key){
		float similarity=0;
		Similarity s=new Similarity();
		similarity=s.getSimilarityRatio(info, key);
		return similarity;
	}
	/**
	 * 计算商品和关键字之间的相似度，该算法按商品名的相似度*0.5+商品描述的像素度*0.5计算
	 * @param g表示商品
	 * @param key表示所搜的关键字
	 * @return返回相似度，为一个介于0~1之间的小数
	 */
	public float similarity_g_key(Good g,String key){
		float similarity=0;
		similarity=(similarity_info_key(g.getGoodName(),key)+similarity_info_key(g.getGoodDescription(),key))/2;
		return similarity;
	}
	
	
	
}
