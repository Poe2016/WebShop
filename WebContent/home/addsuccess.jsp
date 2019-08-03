<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.util.Good" %>
<%@page import="com.util.ShopCart" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Collections" %>
<%@page import="java.util.Comparator" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.SQLException" %>
<%@page import="com.util.Conn2Ora" %>
<%@page import="com.util.Similarity" %>
<%
String item_no = request.getParameter("goodno");
Good item=null;//加入购物车中的商品
ArrayList<Good> goodslist=(ArrayList<Good>)session.getAttribute("goodslist");//所有商品列表
ArrayList<Good> goodsearchlist=(ArrayList<Good>)session.getAttribute("searchlist");//搜索商品列表
Good rec_good1=goodslist.get(0);
Good rec_good2=goodslist.get(1);
//Good rec_good3=goodslist.get(2);
String picture_name=rec_good1.getPicture_name();//推荐商品的图片名
String longinmesg="你好，请登录";
String addToCart = "#";
int goodsAmount = 0;//我的购物车中的商品总类数
ShopCart cart = null;
Statement st=Conn2Ora.st;
ResultSet rs=null;
String sql=null;
String search_key_most=null;
String onuser = (String)session.getAttribute("onlineuser");
String[] goodsfilename = (String[])request.getAttribute("result"); 
int pages = 0;//页数
if(onuser!=null){//登录状态
	String search_table=(String)session.getAttribute("searchtable");
	String history_table=(String)session.getAttribute("historytable");
   longinmesg=onuser;
   cart=(ShopCart)session.getAttribute("cart");
   item = cart.getGoods(item_no);
   goodsAmount=cart.getTotal();
   addToCart = "addToCartAction";
   sql="select keyword from "+search_table+" order by amount desc";
   try{
   		rs=st.executeQuery(sql);
   		if(rs.next()){//只需选取最常搜索的关键字
   			search_key_most=rs.getString("keyword");
   		}
   }catch(SQLException e){
	   e.printStackTrace();
   }
   if(search_key_most!=null){//存在最常搜索关键字，需将goodslist排序
	   ArrayList<Good> temp=goodslist;
   	   final String temp_str = search_key_most;
	   Collections.sort(goodslist, new Comparator<Good>() {
           public int compare(Good g1, Good g2) {
        	Similarity s=new Similarity();
           	float simi1=s.similarity_g_key(g1,temp_str);
           	float simi2=s.similarity_g_key(g2,temp_str);
           	return ((Float)simi2).compareTo((Float)simi1);
           }
       });
	   rec_good1=goodslist.get(0);
	   picture_name=rec_good1.getPicture_name();
   }
}else if(onuser==null){//未登录状态，先登录
	response.sendRedirect("passport.jsp");
}


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>成功加入购物车</title>
<link rel="shortcut icon" href="imgs/favicon.ico"/>
<link href="<%= request.getContextPath()%>/home/css.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/searchcss.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/addsuccesscss.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/home/othergoodscss.css" rel="stylesheet" type="text/css">
<script src="http://api.map.baidu.com/api?v=1.5&ak=CqSmd95LZGbKrsshOnjTNUB3" type="text/javascript"></script>
<script type="text/javascript" src="jquery-2.1.0.js"></script>
<script type="text/javascript" src="js.js"></script>
</head>
<body class="index">
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
						
						<a class="linklogin" href="passport.jsp"><%=longinmesg %></a>
						<a class="linkregist" href="regist.jsp">免费注册</a>
					</li><!-- loginbutton -->
					<li class="spacer"></li>
					<li class="mygoods">
						<a class="linkmygoods" href="cart.jsp">我的购物车</a>
					</li>
					<li class="spacer"></li>
					<li class="mystore">
						<a class="linkmystore" href="myStore.jsp">我的商城</a>
					</li>
				</ul><!--rowright  -->
			</div><!--logrow  -->
		</div><!-- shortcut -->
	
	
		<div id="header">
			  <div class="w">
			    
			    <div id="search" class="">
			    	<div class="search-m">
			    		<div class="form">
			    			<form id="search-img-upload" method="get" action="../searchAction" enctype="multipart/form-data" target="_self">
			          		
			          		<input clstag="h|keycount|head|search_a" autocomplete="off" id="key" name="key" accesskey="s" class="text" type="text">
			          		
			          		<span class="photo-search-btn">
			          		<span class="upload-bg"></span>
			          		<input name="file" class="upload-trigger" accept="image/png,image/jpeg,image/jpg" type="file">
			          		</span>
			          		<button class="button"  ><!-- onclick="window.location.href='http://localhost:8080/WebShop/home/search.jsp'" -->
			          			<i class="iconfont"></i>
			          		</button>
			          		</form>
			    			
			    			
			        </div>
			      	</div>
			    </div>
			    
			    <div id="settleup" class="dropdown" clstag="h|keycount|head|cart_null">
			    	<div class="cw-icon">
			        	<i class="ci-left"></i>
			        	<i class="ci-right">&gt;</i><i class="ci-count" id="shopping-amount"><%=goodsAmount %></i>
			        	<i class="iconfont"></i>
			        	<a target="_blank" href="cart.jsp">我的购物车</a>
			      	</div>
			    </div>
			    
			    
			    <div id="navitems">  
			    	
			    </div>
			    <div id="treasure" ></div>
			  
			  </div><!-- w -->
			  
			</div>
	
		<div class="main">
			<div class="success-wrap">
				<div class="w" id="result">
					<div class="m succeed-box">
						<div class="mc success-cont">
							<div class="success-lcol">
								<div class="success-top">
									<b class="succ-icon"></b>
									<h3 class="ftx-02">商品已成功加入购物车！</h3>
								</div>
								<div class="p-item">
									<div class="p-img" >
										<a href="" target="_blank">
											<img style="width:60px;height:60px;" src="goodsimgs/<%=cart.getGoods(item_no).getPicture_name() %>">
										</a>
									</div>
									<div class="p-info">
										<div class="p-name">
											<a href="" target="_blank" title="APPLE 苹果X iPhoneX 全面屏手机 深空灰色 全网通 64G"><%=item.getGoodName()+"  "+item.getGoodDescription() %></a>
										</div>
										<div class="p-extra">
											<span class="txt" title="深空灰色">颜色：深空灰色</span>
											<span class="txt" title="全网通 64G">尺码：全网通 64G</span>
											<span class="txt">/  数量：1</span>
										</div>
									</div>
									<div class="clr"></div>
								</div>
							</div>
							<div class="success-btns success-btns-new">
								<div class="success-ad">
									<a href="#none"></a>
								</div><div class="clr"></div>
								<div stytle="width:336px;height:36px;">
									<a class="btn-tobback" href=" gooditem.jsp?goodno=<%=item_no %> " target="_blank" >查看商品详情</a>
									<a class="btn-addtocart" href="cart.jsp" id="GotoShoppingCart" >
										<b></b>去购物车结算
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
	</div>
	
	<!-- 推荐部分 -->
	<div class="w" style="height: 340px;">
	<div class="m m1" id="similar">
		<div class="mt"><h3>为您推荐其他好评商品</h3></div>
		<div style="position: relative;">
			<%
			//从数据库中选出其他人浏览的商品
			ArrayList<Good> nolist = new ArrayList<Good>();//待显示商品列表
			sql = "select distinct mail from his_table where goodno=\'"+item_no+"\' and mail<>\'"+onuser+"\'";//选出浏览过该商品的用户
			try{
				ResultSet mset = st.executeQuery(sql);
				while(mset.next()){
					String seer = mset.getString("mail");//浏览者
					String nsql = "select distinct goodno from his_table where mail=\'"+seer+"\' and goodno<>\'"+item_no+"\'";
					ResultSet gset = st.executeQuery(nsql);//goodno集合
					while(gset.next()){
						String gno = gset.getString("goodno");//商品编号
						for(Good g:goodslist){
							if(g.getGoodNo().equals(gno)){
								nolist.add(g);
								break;
							}
						}
						if(nolist.size()==32)
							break;
					}
					if(nolist.size()==32)
						break;
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
			int temp = nolist.size()/8;
			pages = nolist.size() - 8*temp == 0 ? temp:temp+1;//总页数
			for(int p=0;p<pages;p++){
			%>
			
			<div name="pages" class="mc s-panel-main" style="width: 4840px; left: <%=p*1190%>px; position: absolute;">
				<div class="goods-list s-panel ui-switchable-panel-selected" style="float: left; display: block;">
					<ul>
					<%
					
					for(int i=p*8;i<nolist.size() && i<8*(p+1);i++){
						Good g = nolist.get(i);
					%>
					<li>
						<div class="item">
							<div class="p-img" >
								<a target="_blank" href="gooditem.jsp?goodno=<%= g.getGoodNo() %>">
									<img  src="goodsimgs/<%=g.getPicture_name()%>" alt="未显示商品图片" width="88" height="88">
								</a>
							</div>
							<div class="p-name" title="">
								<a target="_blank" href=""><%=g.getGoodName() %>&nbsp&nbsp<%=g.getGoodDescription() %></a>
							</div>
							<div class="p-price" id="tag-5342586">
								<strong><em>￥</em><i><%=g.getGoodPrice() %></i></strong>
							</div>
							<div class="p-btn" >
								<a href="../addToCartAction?goodno=<%=g.getGoodNo() %>" class="btn-append" ><b></b>加入购物车</a>
							</div>
						</div>
					</li>
					<%
					}
					%>
					</ul>
				
				</div><!-- class="goods-list s-panel ui-switchable-panel-selected" -->
			</div><!-- class="mc s-panel-main" -->
			<%
			}
			%>
		</div>
		<div class="s-panel-nav">
			<ul>
			<%
			for(int i=0;i<pages;i++){
				String curr="";
				if(i==0){
					curr=" curr";
				}else{
					curr="";
				}
			%>
			
			
				<li class="s-nav-item<%=curr%>" name="pageli" onmouseover="turnpages(<%=i %>)" ><%=i %></li>
			<%
			}
			%>
				
			</ul>
		</div>
	</div><!-- id="similar" -->
	</div>
			
		</div><!-- main -->
	
	
	</div><!-- bigContainer -->

</body>
</html>