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
	if(mail==null){
		session.setAttribute("loginstate", "buyer_order");//从myStore前的登录
		response.sendRedirect("passport.jsp");
	}else{
		longinmesg=mail;
		cart = (ShopCart)session.getAttribute("cart");
		if(cart!=null){
			total = cart.getTotal();
		}
	}
	Connection con = Conn2Ora.con;
	Statement st = Conn2Ora.st;
	ResultSet rs = null;
	int onum = 0;//指待付款订单的条数
	int rec_num = 0;//指待收货数
	//后面要显示商品信息(goodno)、购买数量（ord_num)、购买单价、购买总价、购买时间
	String sql=null;
	

%>




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的买入订单-追加评论</title>
<link rel="shortcut icon" href="imgs/favicon.ico"/>
<link href="<%= request.getContextPath()%>/home/css.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/myStorecss.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/cartcss.css" rel="stylesheet" type="text/css">
<script src="http://api.map.baidu.com/api?v=1.5&ak=CqSmd95LZGbKrsshOnjTNUB3" type="text/javascript"></script>
<script type="text/javascript" src="js.js"></script>
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
			
		</dd>
		<dd class="fore1_5" id="_MYJD_comments">
			<a  href="history_order.jsp" target="_self">历史订单</a>
		</dd>
                <dd class="fore1_7 curr" id="_MYJD_alwaysbuy">
			<a href="evaluate_add.jsp" target="_self">评价晒单</a>
		</dd>
	</dl>
	<dl class="fore2">
		<dt id="_MYJD_gz">关注中心</dt>
		<dd class="fore2_1" id="_MYJD_product">
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
				 	<div id="order02" class="mod-main mod-comm lefta-box">
				 		<div class="mt">
	                       
                      	</div><!-- mt -->
                      	<div class="mc">
                      		<table class="td-void order-tb">
                      			<colgroup>
	                                <col class="number-col">
	                                <col class="consignee-col">
	                                <col class="amount-col">
	                                <col class="status-col">
	                                <col class="operate-col">
                            	</colgroup>
                            	<thead>
                                	<tr>
                                    	<th>
                                    		<div class="ordertime-cont">
												<div class="time-txt">所有历史订单<b></b>
													<span class="blank"></span>
												</div>
											</div>
											<div class="order-detail-txt ac">订单详情</div>
										</th>
                                    	<th>收货人</th>
                                    	<th>金额</th>
                                    	<th>状态</th>
                                    	<th>售后</th>
                                	</tr>
                            	</thead>
                            	<%
                            		sql = "select distinct ord_id,mail from evaluation where mail=\'"+mail+"\'";
                            		try{
                            			rs = st.executeQuery(sql);
                            			while(rs.next()){
                            				int ord_id = rs.getInt("ord_id");
                            				String goodno = null;//商品编号
                            				String date = null;
                            				int ord_num = 0;//数量
                            				int money = 0;//总价
                            				String receiver = null;//收货人
                            				String address = null;//收货地址
                            				
                            				sql = "select * from order_t where ord_id="+ord_id;//查询该订单详细信息
                            				ResultSet result = st.executeQuery(sql);
                            				if(result.next()){
                            					goodno = result.getString("goodno");//商品编号
                                				date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(result.getDate("ord_date"));
                                				ord_num = result.getInt("ord_num");//数量
                                				money = result.getInt("money");//总价
                                				receiver = result.getString("receiver");//收货人
                                				address = result.getString("ord_address");//收货地址
                            				}
                            				
                            				
                            				Good g_ord = null;
                            				//获取该商品
                            				for(int j=0;j<goodslist.size();j++){
                            					if(goodslist.get(j).getGoodNo().equals(goodno)){
                            						g_ord = goodslist.get(j);
                            						break;
                            					}
                            				}
                            		%>
                            		
                            		<tbody id="tb<%=ord_id%>">
        								<tr class="sep-row"><td colspan="5"></td></tr>
                						<tr class="tr-th">
                    						<td colspan="5">
										    	<span class="gap"></span>
										    	<span class="dealtime" title="<%=date%>"><%=date%></span>
										        <span class="number">订单号：
										        	<a name="orderIdLinks" id="idUrl72873205526" href="" ><%=ord_id %></a>
										        </span>
										     </td>
        								</tr>
								        <tr class="tr-bd" id="track<%=ord_id %>" >
								            <td>
								            	<div class="goods-item p-4765393">
								                    <div class="p-img">
								                        <a href="gooditem.jsp?goodno=<%= goodno %>" target="_blank">
								                        	<img class="" src="goodsimgs/<%=goodno+"+"+g_ord.getGoodfilename()%>" title="<%=g_ord.getGoodName() %>" width="60" height="60">
								                        </a>
								                    </div>
								                    <div class="p-msg">
								                        <div class="p-name">
								                        	<a href="gooditem.jsp?goodno=<%= goodno %>" class="a-link" target="_blank" title="<%=g_ord.getGoodName() %>"><%=g_ord.getGoodName()+"  "+g_ord.getGoodDescription() %></a>
								                        </div>
								                    </div>
								                </div>
								                <div class="goods-number">x<%=ord_num %></div>
												<div class="clr"></div>
								            </td>
								            <td rowspan="1">
								                <div class="consignee tooltip">
								                    <span class="txt"><%=receiver %></span><b></b>
								                    <div class="prompt-01 prompt-02" style="display: none;">
									                	<div class="pc">
									                    	<strong><%=receiver %></strong>
								                            <p><%=address %></p>
									                    </div>
									                    <div class="p-arrow p-arrow-left"></div>
									                 </div>
								                 </div>
								            </td>
								            <td rowspan="1">
								                <div class="amount">
								                	<span>总额 ¥<%=money %></span>
								                	<br>
								                 </div>
								            </td>
								            <td rowspan="1">
								                <div class="status">
								                    <span class="order-status ftx-03">
								            			已评论，还可继续追加评论
								                    </span>
								                    <br>
								                 </div>
								            </td>
								            <td rowspan="1" id="operate<%=ord_id%>">
								                <div class="operate">
								                	<div id="pay-button-<%=ord_id %>" _baina="0"></div>
								                    <br>
								                    
								                    <a href="evaluate_order.jsp?ord_id=<%=ord_id %>"  class="btn-again btn-again-show" target="_blank">
								                    	<b></b>
														追加评论
													</a>
													
													
													<br>
								                 </div>
								             </td>
								         </tr>
            						</tbody>
                            		<%
                            				
                            			}
                            		}catch(SQLException e){
                            			e.printStackTrace();
                            		}
                            	
                            	%>
                      		</table>
                      	</div><!-- mc -->
				 	</div><!-- order02 -->
				 </div>
			</div><!-- w -->
		
		</div><!-- container -->
		
		
	</div><!-- bigContainer -->

		
</body>
</html>