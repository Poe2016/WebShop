<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.util.Good"  %>
<%@ page import="com.util.ShopCart"  %>
<%@ page import="com.util.Conn2Ora"  %>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="java.sql.Statement"  %>
<%@ page import="java.sql.Connection"  %>
<%@ page import="java.sql.ResultSet"  %>
<%@ page import="java.sql.SQLException"  %>
<%@ page import="java.text.SimpleDateFormat"  %>
<%	String longinmesg="你好，请登录";
	String mail=(String)session.getAttribute("onlineuser");
	ArrayList<Good> goodslist = (ArrayList<Good>)session.getAttribute("goodslist");
	int total=0;
	ShopCart cart=null;
	String uid = null;//登录用户的id
	Connection con = Conn2Ora.con;
	Statement st = Conn2Ora.st;
	ResultSet rs = null;
	int rec_num = 0;//指待收货数
	//后面要显示商品信息(goodno)、购买数量（ord_num)、购买单价、购买总价、购买时间
	if(mail==null){
		session.setAttribute("loginstate", "buyer_order");//从myStore前的登录
		response.sendRedirect("passport.jsp");
	}else{
		String sqlstr = "select userid from users where mail=\'"+mail+"\'";//获取登录用户的id
		try{
			ResultSet careset = st.executeQuery(sqlstr);
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
	
	String sql = "select count(*) rec_num from order_t where mail=\'"+mail+"\' and pay=1 and receive_state=0";//查询待收货订单
	try{
		rs = st.executeQuery(sql);
		if(rs.next()){
			rec_num = rs.getInt("rec_num");
		}
	}catch(SQLException e){
		e.printStackTrace();
	}

%>




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>关注中心-关注的商品</title>
<link rel="shortcut icon" href="imgs/favicon.ico"/>
<link href="<%= request.getContextPath()%>/home/css.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/myStorecss.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/cartcss.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/caregoodcss.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/f-goods.css" rel="stylesheet" type="text/css">
<script src="http://api.map.baidu.com/api?v=1.5&ak=CqSmd95LZGbKrsshOnjTNUB3" type="text/javascript"></script>
<script type="text/javascript" src="jquery-2.1.0.js"></script>
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
						
						<a class="linklogin" href="passport.jsp"><%=longinmesg %></a>
						<a class="linkregist" href="regist.jsp">免费注册</a>
					</li><!-- loginbutton -->
					<li class="spacer"></li>
					<li class="mygoods">
						<a class="linkmygoods" href="cart.jsp">我的购物车</a>
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
											<i class="ci-right">&gt;</i><i class="ci-count" id="shopping-amount"><%=total %></i>
											<a target="_blank" href="cart.jsp">我的购物车</a>
										</div>
										
									</div>
								    
							</div>
							<div class="clr"></div>
				</div>
		</div>
		
		<div id="container">
			<div class="w">
				<div id="content">
					<div id="sub">
					<!--  /widget/menu/menu.tpl -->
					<div id="menu">
	<dl class="fore1">
		<dt id="_MYJD_order">订单中心</dt>
		<dd class="fore1_1" id="_MYJD_ordercenter" >
			<a href="buyer_order.jsp" target="_self">我的订单(买)</a>
		</dd>
		<dd class="fore1_4" id="_MYJD_yushou">
			<a href="payed_order.jsp" target="_self">待收货</a>
			<a href="payed_order.jsp"><em><%=rec_num %></em></a>
		</dd>
		<dd class="fore1_5" id="_MYJD_comments">
			<a  href="history_order.jsp" target="_self">历史订单</a>
		</dd>
                <dd class="fore1_7" id="_MYJD_alwaysbuy">
			<a href="evaluate_add.jsp" target="_self">评价晒单</a>
		</dd>
		
	</dl>
	<dl class="fore2">
		<dt id="_MYJD_gz">关注中心</dt>
		<dd class="fore2_1 curr" id="_MYJD_product">
			<a href="caregood.jsp" target="_self">关注的商品</a>
		</dd>
		<dd class="fore2_2" id="_MYJD_vender">
			<a href="caresaler.jsp" target="_self">关注的店铺</a>
		</dd>
		<dd class="fore2_7" id="_MYJD_history">
			<a href="history.jsp" target="_blank">浏览历史</a>
		</dd>
	</dl>
	<dl class="fore3">
		<dt id="_MYJD_zc">卖家中心</dt>
		<dd class="fore3_1" id="_MYJD_cashbox">
			<a href="send_pre_order.jsp" target="_self">待发货订单</a>
		</dd>
		<dd class="fore3_1" id="_MYJD_cashbox">
			<a href="send_after_order.jsp" target="_self">已发货订单</a>
		</dd>
		<dd class="fore3_1" id="_MYJD_cashbox">
			<a href="send_received_order.jsp" target="_self">已收货订单</a>
		</dd>
		<dd class="fore3_1" id="_MYJD_cashbox">
			<a href="mygoods.jsp" target="_self">我上架的商品</a>
		</dd>
		<dd class="fore3_2" id="_MYJD_credit">
			<a target="_blank" class=""  href="upload.jsp">上传商品</a>
		</dd>
	</dl>
	
	<dl class="fore6">
		<dt id="_MYJD_sz">设置</dt>
		<dd class="fore6_1" id="_MYJD_info">
			<a href="personalinfo.jsp" target="_self">个人信息</a>
		</dd>
	</dl>
</div>

					<div id="menu-ads">
					    <!--广告全部放这里-->
					
                </div>
				</div><!-- content -->
				<div id="main">
				 	<div class="myfollow-wrap2">
				 		<div class="myfollow-hd">
        					<div class="m-tab-wrap clearfix">
            					<div class="m-tab">
									<ul class="tab-trigger">
										<li class="trig-curr trig-item"><a href="caregood.jsp" class="text" >关注的商品</a></li>
										<li class=" trig-item"><a href="caresaler.jsp" class="text" >关注的店铺</a></li>
									</ul>
									<ul class="tab-others">
                    					<li class=" item" id="f_similar">
                    						<a href="" target="_blank" class="text" >找相似</a>
                    					</li>
        							</ul>
								</div>
        					</div>
   			 			</div>
   			 			<div class="myfollow-bd">
   			 				<div class="mf-selector mf-s-goods">
   			 					<div class="mf-selector-line" id="categoryFilter">
   			 						<div class="s-main"> 
   			 							<ul class="mf-selector-list up">  
   			 								<li class="selected"> <a class="search" cid="0" target="_self" href="javascript:void(0);" clstag="homepage|keycount|guanzhu|class_shp">全部商品</a> </li>    
   			 							</ul> 
   			 						</div> 
   			 					</div>
   			 				</div>
   			 				<div class="myfollow-main mf-goods">
   			 					<div class="mf-goods-list clearfix ">
   			 						<%
   			 							sql = "select goodno from caregood_t"+uid;
   			 							try{
   			 								rs = st.executeQuery(sql);
   			 								while(rs.next()){
   			 									String goodno = rs.getString("goodno");//关注商品的编号
   			 									Good good = null;//该商品
   			 									for(Good g:goodslist){//获取该商品
   			 										if(g.getGoodNo().equals(goodno)){
   			 											good = g;
   			 											break;
   			 										}
   			 									}
   			 						%>
   			 						<div class="mf-goods-item" id="goods<%=good.getGoodNo() %>" style="width:245px;">
                						<div class="item-inner">
                    						<div class="p-img">
                        						<a href="gooditem.jsp?goodno=<%=good.getGoodNo() %>" target="_blank">
                            						<img src="goodsimgs/<%=good.getPicture_name() %>" alt="<%=good.getGoodName() %>&nbsp&nbsp<%=good.getGoodDescription() %>" width="160" height="160">
                        						</a>
                    						</div>
                    						<div class="p-name">
                        						<a href="gooditem.jsp?goodno=<%=good.getGoodNo() %>" target="_blank" title="<%=good.getGoodName() %>&nbsp&nbsp<%=good.getGoodDescription() %>" alt="<%=good.getGoodName() %>&nbsp&nbsp<%=good.getGoodDescription() %>" ><%=good.getGoodName() %>&nbsp&nbsp<%=good.getGoodDescription() %></a>
                    						</div>
                    						<div class="p-price">¥<strong><%=good.getGoodPrice() %></strong></div>
                    						<div class="p-operate" style="position:absolute;bottom:0px;">
                    							<script type="text/javascript">
		    										var req;
		    										function notcaregood(goodno){
		    											var flag = confirm("确定要取消关注该商品？");
		    											if(flag){
				    										var reqstate = "notcare";
				    										var goodno = ("00000000" + goodno).substr(-8);// 获取商品编号
					    									var url = "/WebShop/UtilServlet?mailno=<%=mail%>&goodno=" + goodno +"&uid=<%=uid%>&reqstate="+reqstate;
					    									if (window.XMLHttpRequest) {
					    										req = new XMLHttpRequest();// IE7, Firefox, Opera支持
					    									} else if (window.ActiveXObject) {
					    										req = new ActiveXObject("Microsoft.XMLHTTP");// IE5,IE6支持
					    									}
					    									req.open("get", url, true);
					    									req.onreadystatechange = callback;
					    									req.send(null);
					    									
		    											}
		    										}
				    								function callback() {
				    									if (req.readyState == 4 && req.status == 200) {
				    										location.href="caregood.jsp";
				    										return "OK";
				    									} else {
				    										return "error";
				    									}
				    								}
		    									</script>
                        						<a href="../addToCartAction?goodno=<%=good.getGoodNo() %>" target="_blank" class="op-btn btn-cart"><em class="btntxt">加入购物车</em></a>
                        						<a onclick="notcaregood(<%=good.getGoodNo() %>)" target="_blank" class="op-btn btn-cart" style="float:right;"><em class="btntxt">取消关注</em></a>
                    						</div>
                						</div>
				            		</div>
   			 						<%
   			 								}
   			 							}catch(SQLException e){
   			 								e.printStackTrace();
   			 							}
   			 						%>
   			 					</div><!-- class="mf-goods-list clearfix " -->
   			 				</div><!-- class="myfollow-main mf-goods" -->
   			 			</div><!-- class="myfollow-bd" -->
				 	</div><!-- myfollow-wrap2 -->
				</div><!-- main -->
			</div><!-- w -->
		
		</div><!-- container -->
		
		
	</div><!-- bigContainer -->

		
</body>
</html>