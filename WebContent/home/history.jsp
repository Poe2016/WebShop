<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.util.Good"  %>
<%@ page import="com.util.ShopCart"  %>    
<%@ page import="com.util.Conn2Ora"  %>    
<%@ page import="java.sql.Statement"  %>    
<%@ page import="java.sql.ResultSet"  %>    
<%@ page import="java.sql.SQLException"  %>    
<%@ page import="java.util.Date"  %>    
<%@ page import="java.util.ArrayList"  %>    
<%@ page import="java.text.SimpleDateFormat" %>
<%	String longinmesg="你好，请登录";
	String mail=(String)session.getAttribute("onlineuser");
	ArrayList<Good> goodslist=(ArrayList<Good>)session.getAttribute("goodslist");//获取所有商品列表
	int total=0;
	ShopCart cart=null;
	String uid = null;
	Statement st = Conn2Ora.st;
	ResultSet rs = null;
	String sql = null;//sql语句
	if(mail==null){
		session.setAttribute("loginstate", "history");//从myStore前的登录
		response.sendRedirect("passport.jsp");
	}else{
		sql = "select userid from users where mail=\'"+mail+"\'";//获取登录用户id
		try{
			ResultSet careset = st.executeQuery(sql);
			if(careset.next()){
				uid=careset.getString("userid");
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		longinmesg=mail;
		cart = (ShopCart)session.getAttribute("cart");
		if(cart!=null){
			total = cart.getTotal();
		}
	}

%>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>浏览记录</title>
<link rel="shortcut icon" href="imgs/favicon.ico"/>
<link href="<%= request.getContextPath()%>/home/css.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/myStorecss.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/cartcss.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/historycss.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="bigContainer">
		
		<div id="shortcut">
			<div class="logrow">
				<ul class="rowleft">
					<!-- 显示城市 -->
					<li id="mycity" calss="city">
						<div class="citydiv">
							<i class="citylogo"></i>
							<script type="text/javascript">
							   // 百度地图API功能
							   var map = new BMap.Map("bdMapBox");
							   var nowCity = new BMap.LocalCity();
							   nowCity.get(bdGetPosition);
							   function bdGetPosition(result){
							   var cityName = result.name; //当前的城市名
							  /*自定义代码*/
							   atCity.innerHTML = cityName;
						   		}
							</script>
							<span id="atCity">北京</span>
							<!-- 下拉城市菜单********未完******** -->
							<div class="citylist">
								<div class="item">北京</div>
								<div class="item">上海</div>
							</div><!-- citylist -->
						</div>
					</li>
					
				</ul><!--rowleft  -->
				<!-- 右边登录注册处 -->
				<ul class="rowright">
					<li class="loginbutton">
						
						<a class="linklogin" href="home/passport.jsp"><%=longinmesg %></a>
						<a class="linkregist" href="home/regist.jsp">免费注册</a>
					</li><!-- loginbutton -->
					<li class="spacer"></li>
					<li class="mygoods">
						<a class="linkmygoods">我的购物车</a>
					</li>
					<li class="spacer"></li>
					<li class="mystore">
						<a class="linkmystore">我的商城</a>
					</li>
				</ul><!--rowright  -->
			</div><!--logrow  -->
		</div><!-- shortcut -->
		
		<div id="nav">
			<div class="w">
				<div class="logo">
					<a href="//localhost:8080/WebShop/" target="_blank" class="fore1" >
						<img alt="商城首页" src="imgs/logo.jpg" style="width:158px;height:80px;">
					</a>
					<a href="//localhost:8080/WebShop/home/myStore.jsp" target="_self" class="fore2" >我的商城</a>
					<a href="//localhost:8080/WebShop/" target="_blank" class="fore3" >返回商城首页</a>
				</div>
				<div class="navitems">
					<ul>
						<li class="fore-1">
							<a target="_self" href="//localhost:8080/WebShop/home/myStore.jsp" clstag="homepage|keycount|home2013|Homeindex">首页</a>
						</li>
						
								</ul>
							</div>
							<div class="nav-r">
								<div id="search-2014" style="margin: 20px 5px;">
										<ul id="shelper" class="hide"></ul>
										<div class="form">
											<input onkeydown="javascript:if(event.keyCode==13) search('key');" autocomplete="off" id="key" accesskey="s" class="text blurcolor" type="text">
											<button onclick="search('key');return false;" class="button cw-icon" type="button"><i></i>搜索</button>
										</div>
								    </div>
								 
								<div id="settleup-2014" class="dorpdown" style="margin-top: 20px;">
										<div class="cw-icon">
											<i class="ci-left"></i>
											<i class="ci-right">&gt;</i><i class="ci-count" id="shopping-amount">0</i>
											<a target="_blank" href="//cart.jd.com/cart.action">我的购物车</a>
										</div>
										<div class="dorpdown-layer"><div class="spacer"></div><div id="settleup-content"><span class="loading"></span></div></div>
									</div>
								    <div id="hotwords-2014"></div>
							</div>
							<div class="clr"></div>
				</div>
		</div>
		
		<div id="content-history" class="w">
			<div class="goods">
				<div class="m">
					<div class="nav-history"> 
						<div class="nh-left main-curr">
							<a>全部分类</a>
						</div>
					</div>
				</div><!-- m -->
				<div class="goods-content">
					<div class="p-line" style="height: 1230px;"></div>
					<div class="p-line-red" style="height: 242px;"></div>
					<div id="p-list">
						<%
						sql = "select see_date  from his_table"+uid+" group by see_date order by see_date desc";
						try{
							ResultSet bigset = st.executeQuery(sql);
							while(bigset.next()){
								Date date = bigset.getDate("see_date");
								Date today = new Date();//当前时间
								int distance = (int)(today.getTime() - date.getTime()) / (1000*3600*24);//计算两个时间的相隔天数
								String msg = null;
								if(distance==0){//今天
									msg = "今天";
								}else if(distance == 1){
									msg = "昨天";
								}else if(distance == 2){
									msg = "前天";
								}else{
									msg = "其他记录";
								}
								
						%>
						<div id="T<%=date%>" class="m goods-item">
							<div class="mt">                    
								<h2><%=msg %></h2>                    
								<strong><%=date %></strong>                    
								<span class="del-all"  >删除</span>                    
								<i class="line-cur line-b"></i>                
							</div>
							<div class="mc">
								<ul class="hide" style="display: block;">
									<%
									sql = "select goodno from his_table"+uid+" where see_date=to_date(\'"+date+"\',\'yyyy-mm-dd\')";    
									ResultSet smallset = st.executeQuery(sql);
									while(smallset.next()){
										String goodno = smallset.getString("goodno");//关注商品编号
										Good good = null;
										for(Good g:goodslist){
											if(g.getGoodNo().equals(goodno)){
												good = g;
												break;
											}
										}
									%>
									<li  class="">                
										<div class="p-img">                    
											<a href="gooditem.jsp?goodno=<%=goodno %>" target="_blank" title="<%=good.getGoodName()%>&nbsp&nbsp<%=good.getGoodDescription()%>">                        
												<img src="goodsimgs/<%=good.getPicture_name() %>" width="220" height="220">                    
											</a>                
										</div>                
										<div class="p-price">                    
											<i class="J-p-12441277700">￥<%=good.getGoodPrice() %></i>                
										</div>                
										<div class="p-same" >                    
											<a href="" target="_blank">看相似</a>                
										</div>                
									</li>
									<%
										
									}
									
									%>
								</ul>
							</div><!-- class="mc" -->
						</div><!-- class="m goods-item" -->
						<%
								
							}
						}catch(SQLException e){
							e.printStackTrace();
						}
						%>
					</div>
					
					
				</div><!-- goods-content -->
			</div><!-- goods -->
		
		</div><!-- content-history -->
		
	</div><!-- bigContainer -->

</body>
</html>