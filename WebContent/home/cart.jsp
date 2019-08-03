<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.util.Good"  %>
<%@ page import="com.util.ShopCart"  %>
<%	String mail=(String)session.getAttribute("onlineuser");
	int total=0;
	ShopCart cart=null;
	if(mail==null){
		session.setAttribute("loginstate", "cart");//购物车前的登录
		response.sendRedirect("passport.jsp");
	}else{
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
<title>购物车</title>
<link rel="shortcut icon" href="imgs/favicon.ico"/>
<script type="text/javascript" src="js.js"></script>
<link href="<%= request.getContextPath()%>/home/css.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/cartcss.css" rel="stylesheet" type="text/css">
<script src="http://api.map.baidu.com/api?v=1.5&ak=CqSmd95LZGbKrsshOnjTNUB3" type="text/javascript"></script>

</head>
<body class="index" onload="load_fun()">
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
						<%
			        	String onuser = (String)session.getAttribute("onlineuser");
			        	if(onuser==null){
			        		onuser="你好，请登录";
			        	}else{
			        		//ShopCart
			        	}
						%>
						<a class="linklogin" href="passport.jsp"><%=onuser %></a>
						<a class="linkregist" href="regist.jsp">免费注册</a>
					</li><!-- loginbutton -->
					<li class="spacer"></li>
					<li class="mygoods">
						<a class="linkmygoods">我的购物车<%=total %></a>
					</li>
					<li class="spacer"></li>
					<li class="mystore">
						<a class="linkmystore" href="myStore.jsp">我的商城</a>
					</li>
				</ul><!--rowright  -->
			</div><!--logrow  -->
		</div><!-- shortcut -->
		
		<div class="w w1 header clearfix">
			<div id="logo-2014">
					<a href="http://localhost:8080/WebShop" >
						<img alt="商城首页" src="imgs/logo.jpg" style="padding-top:13px;width:134px;height:42px;">
					</a>
					<a href="#none" class="link2"><b></b>购物车</a>
			</div>
			<div class="cart-search">
					<div class="form">
						<input id="key" class="itxt" autocomplete="off" accesskey="s" style="color: rgb(153, 153, 153);" type="text">
						<input class="button" value="搜索"  onclick="javascript:void(0);" type="button">
					</div>
			</div>
		</div><!-- w w1 header clearfix -->
		
	
		
		<div id="content">
		
		<div id="container" class="cart">
			<div class="w">
				<div class="cart-filter-bar">
					<ul class="switch-cart">
						<li class="switch-cart-item curr">
							<a >
								<em>全部商品</em>
								<span class="number"><%=total %></span>
							</a>
					</ul>
					
						<div class="clr"></div>
						<div class="w-line">
							<div class="floater" style="width: 89px; left: 0px;"></div>
						</div>
						<div class="tab-con ui-switchable-panel-selected" style="display: block;"></div>
						<div class="tab-con hide" style="display: none;"></div>
				</div><!-- class="cart-filter-bar" -->		
			</div><!-- class="w" -->
			
			<div class="cart-warp">
				<div class="w">
					<div id="jd-cart">
						<div class="cart-main cart-main-new">
							
							<div class="cart-thead">
											
										
												<div class="column t-checkbox">
										<div class="cart-checkbox">
											<input name="toggle-checkboxes" class="jdcheckbox" type="checkbox" onclick="selectAll('checkItem')" title="全选/取消全选">
										</div>
										全选
									</div>
									<div class="column t-goods">商品</div>
									<div class="column t-props"></div>
									<div class="column t-price">单价</div>
									<div class="column t-quantity">数量</div>
									<div class="column t-sum">小计</div>
									<div class="column t-action">操作</div>
								</div><!-- class="cart-thead" -->
								
								<!-- cart-list -->
									
								<div id="cart-list" name="cart-list">
												<input id="allSkuIds" value="5089275,11835226,12214299,11676087,11870863,3455612,13161183458,1192114615,12318280747,1229424878,10654428114" type="hidden">
									<input id="outSkus" value="" type="hidden">
									<input id="isLogin" value="1" type="hidden">
									<input id="isNoSearchStockState" value="0" type="hidden">
									<input id="isNoDD" value="0" type="hidden">
									<input id="isNoCoupon" value="0" type="hidden">
									<input id="isFavoriteDowngrade" value="0" type="hidden">
									<input id="isUnmarketDowngrade" value="0" type="hidden">
									<input id="isPriceNoticeDowngrade" value="0" type="hidden">
									<input id="isInstallmentDowngrade" value="0" type="hidden">
									<input id="headNoticeDg" value="0" type="hidden">
									<input id="isNoVenderFreight" value="0" type="hidden">
									<input id="isNoZyDelivery" value="0" type="hidden">
									<input id="isNoPopDelivery" value="0" type="hidden">
									<input id="isNoXzyf" value="0" type="hidden">
									<input id="isNoXzyfCd" value="0" type="hidden">
									<input id="isGiftServiceDowngrade" value="0" type="hidden">
									<input id="hiddenLocationId" type="hidden">
									<input id="hiddenLocation" type="hidden">
									<input id="ids" value="" type="hidden">
									<input id="isNgsdg" value="0" type="hidden">
									<input id="isCssdg" value="0" type="hidden">
									<input id="isCsudg" value="0" type="hidden">
									<input id="isRgdg" value="0" type="hidden">
									<input id="isOpdg" value="0" type="hidden">
									<input id="isYydg" value="1" type="hidden">
									<input id="overseasLoc" value="0" type="hidden">
									<input id="isOadg" value="0" type="hidden">
									<input id="isMdxxdg" value="0" type="hidden">
									<input id="isWmdg" value="0" type="hidden">
									<input id="isLdg" value="0" type="hidden">
									<input id="isPsydg" value="0" type="hidden">
									<!-- 修改数量之前的值 -->
									<input id="changeBeforeValue" value="" type="hidden">
									<input id="changeBeforeId" value="" type="hidden">
									<input value="4" id="checkedCartState" type="hidden">
									<input value="685438,41083,80550,136794" id="venderIds" type="hidden">
									<input value="5089275_655_0,11835226_6603_0,12214299_6601_0,11676087_6602_0,11870863_6602_0,3455612_11303_0" id="zySkuCid" type="hidden">
									<input value="8888,685438,41083,80550,136794" id="venderFreightIds" type="hidden">
									<input value="0,0,0,0,0" id="venderTotals" type="hidden">
									<input value="2" id="uclass" type="hidden">
									<input value="0.00" id="freshTotalPrice" autocomplete="off" type="hidden">
									<input value="0.00" id="notFreshTotalPrice" autocomplete="off" type="hidden">
									<input value="0.00" id="walmartTotalPrice" autocomplete="off" type="hidden">
									<input value="1523237138418" id="currentTime" type="hidden">
									<!-- 需要引用的全局信息 -->
									
									<!-- 商品列表 -->
									<% 
										for(int i=0;i<total;i++){
											Good g=cart.getGoods(i);
											String goodfilename = g.getGoodNo()+"+"+g.getGoodfilename();
										
									%>
									<div class="cart-item-list" id="cart-item-list-0<%=i%>">
										<div class="cart-tbody" id="vender_<%=i%>">
										<div class="shop">
											<div class="shop-extra-r shop-freight" id="shop-extra-r_<%=i%>"></div>
										</div>
										<div class="item-list">	 
										 	<div class="item-give item-full " id="product_promo_<%=i%>">
												<input value="meet-give" type="hidden">
												<div class="item-header">
													<div class="f-price">
														<strong></strong>
													</div>
												</div>
												<div class="  item-last  item-item " id="product_<%=i%>" >
													<div class="item-form">
														<div class="cell p-checkbox">
															<div class="cart-checkbox">
													    		<input type="checkbox" value="<%=g.getGoodNo() %>" name="checkItem" id="checkItem<%=i %>" class="jdcheckbox"  onclick="selectOne(<%=i%>)">
													    		
													    		<span class="line-circle"></span>
															</div>
														</div>
														<div class="cell p-goods">
															<div class="goods-item">
																<div class="p-img">
																	<a target="_blank" href="gooditem.jsp?goodno=<%= g.getGoodNo() %>">
																		<img alt="<%=g.getGoodDescription() %>"  src="../home/goodsimgs/<%=goodfilename%>" style="width:80px;height:80px;">
																	</a>
																	<div class="cart-similar" name="cs_5089275">
																		<div class="cs-tit">找相似<b></b></div>
																		<div class="cs-cont">
																			<div class="cs-empty">
																		</div>
																	</div>
																</div>
															</div>
															<div class="item-msg">
																<div class="p-name">
																	<a id="item_name_id<%=i %>" target="_blank" href="gooditem.jsp?goodno=<%= g.getGoodNo() %>">
																				<%=g.getGoodName() %>
																	</a>
																	<div id="item_desc_id<%=i%>"><%=g.getGoodDescription() %></div>
																</div>
																<div class="p-extend p-extend-new">
																	<span class="promise return-y" title="支持7天无理由退货（激活后不支持）">
																		<i class="return-y-icon"></i>
																		<a href="#none" class="ftx-08">支持7天无理由退货</a>
																	</span>																											
																	<span class="promise" _giftcard="giftcard_5089275">
																		<i class="jd-giftcard-icon"></i>
																		<a data-tips="选包装" title="选包装"  class="ftx-03 gift-packing" href="javascript:void(0);">选包装</a>
																	</span>																															
																	<span class="promise" _yanbao="yanbao_5089275_216031432"></span>
																</div>
															</div>
														</div>
													</div>
													<div class="cell p-props p-props-new">
														<div class="props-txt" title="深空灰色">颜色：深空灰色</div>
														<div class="props-txt" title="公开版">尺码：公开版</div>
													</div>
													<div class="cell p-price p-price-new " id="unitPrice<%=i%>">
														<strong>¥<%=g.getGoodPrice() %></strong>
														<p class="mt5" jj=""></p>
														<p class="mt5" bt=""></p>
													</div>
													<div class="cell p-quantity">
														<div class="quantity-form">
															<a href="javascript:deleteNum(<%=i %>,<%=g.getGoodNo() %>);" class="decrement" id="decrement<%=i%>">-</a>
															<input name="quantity<%=i %>" class="itxt" value="<%=cart.getNumList().get(i) %>" id="quantity<%=i %>" minnum="1" type="text" onchange="caculatePrice(<%=i%>)">
															<a href="javascript:addNum(<%=i %>);" class="increment" id="increment<%=i%>">+</a>
														</div>
														<div class="ac ftx-03 quantity-txt" _stock="stock_5089275">有货</div>
													</div>
													<div class="cell p-sum" >
														<strong id="totalPrice<%=i%>"><%=g.getGoodPrice()*cart.getNumList().get(i) %></strong>
													</div>
													<div class="cell p-ops">
														<a id="remove<%=i %>"  class="cart-remove" href="../DeleteFromCartServlet?goodno=<%=g.getGoodNo()%>&index=<%=i%>">删除</a>
														<a href="" class="cart-follow" id="follow_8888_5089275_13_216031432" >移到我的关注</a>
														<a href="" class="add-follow" id="add-follow_5089275" >加到我的关注</a>
													</div>
												</div>
											</div>
										</div>					
									</div>
								</div>
							</div>
						<%} %>
					</div>	
				<!-- cart-list -->
				</div><!-- class="cart-main cart-main-new" -->
			</div><!-- jd-cart -->
					
			<!-- cart-floatbar -->
			<div id="cart-floatbar">
				<div class="ui-ceilinglamp-1" style="width: 990px; height: 52px;">
					<div class="cart-toolbar" style="width: 988px; height: 50px;">
						<div class="toolbar-wrap">
							<div class="options-box">
								<div class="select-all">
									<div class="cart-checkbox">
										<input id="toggle-checkboxes_down" name="toggle-checkboxes" class="jdcheckbox" type="checkbox" onclick="selectAll('checkItem')" title="全选/取消全选">
									</div>
									全选
								</div>
								<div class="operation">
									<a href="#none"  class="remove-batch">删除选中的商品</a>
									<a href="#none" class="follow-batch" >移到我的关注</a>
								</div>
								<div class="clr"></div>
								<div class="toolbar-right">
									<div class="normal">
										<div class="comm-right">
											<div class="btn-area">
												<a onclick="balance();" class="submit-btn" data-bind="4">
													去结算<b></b>
												</a>
											</div>
											<div class="price-sum">
												<div>
													<span class="txt txt-new">总价：</span>
													<span class="price sumPrice"><em id="total_money">¥0.00</em></span>
													<b class="ml5 price-tips"></b>
													<br>
												</div>
											</div>
											<div class="amount-sum">
												已选择<em id="selected_num">0</em>件商品<b class="up" ></b>
											</div>
											<div class="clr"></div>
										</div>
									</div>
							
						</div>
						
					</div>
				</div>
			</div>
			</div>
		</div>
		<!-- cart-floatbar -->
					<div class="cart-warp"></div>
					
				</div><!-- w -->
			
			</div><!-- cart-warp --> 
			
		
		</div><!-- container -->			
			
			
		</div><!-- content -->
		
		
			
			
		
	</div><!-- bigContainer -->

</body>
</html>