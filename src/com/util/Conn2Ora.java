package com.util;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

/*
 * 连接oracle数据库
 */
public class Conn2Ora implements Serializable{
	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static Conn2Ora instance=null;
	 public static Connection con = null;
	 public static Statement st = null;
	 
//	 public static
	
	public static Conn2Ora getInstance() {
        if(instance==null){
        	synchronized (Conn2Ora.class) {  //延迟加载要考虑并发的问题，要给此类加锁
        		if(instance==null){
        			instance=new Conn2Ora();
        			}
               }
        }
        return instance;
	}
	static {

		try {
			System.out.println("开始连接");
			Class.forName("oracle.jdbc.driver.OracleDriver");// 加载Oracle驱动程序
			System.out.println("开始尝试连接数据库！");
			String url = "jdbc:oracle:" + "thin:@Poe:1521:PORACLE";// 127.0.0.1是本机地址，XE是精简版Oracle的默认数据库名
			String user = "special";// 用户名,系统默认的账户名
			String password = "special";// 你安装时选设置的密码
			con = DriverManager.getConnection(url, user, password);// 获取连接
			st=con.createStatement();
			con.setAutoCommit(false);
			System.out.println("连接成功！");

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	

}
