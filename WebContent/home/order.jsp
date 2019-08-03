<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.util.Good"  %>
<%@ page import="com.util.ShopCart"  %>
<%@ page import="com.util.Conn2Ora"  %>
<%@ page import="java.sql.Statement"  %>
<%@ page import="java.sql.Connection"  %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%	String ord_goods = request.getParameter("order_goods");
	String[] goods_list = ord_goods.split(",");
	int order_num = goods_list.length;
	String mail=(String)session.getAttribute("onlineuser");
	Connection con = Conn2Ora.con;
	Statement st = Conn2Ora.st;
	ResultSet rs=null;
	String address="请输入收货地址";
	String nickname = "请输入用户名";
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
		try{
			String sql = "select address,nickname from users where mail=\'"+mail+"\'";
			rs = st.executeQuery(sql);
			if(rs.next()){
				String temp1 = rs.getString("address");
				String temp2 = rs.getString("nickname");
				if(temp1!=null&& !temp1.equals("")){
					address = temp1;
				}
				if(temp2!=null&& !temp2.equals("")){
					nickname = temp2;
				}
			}
		}catch(SQLException e1){
			e1.printStackTrace();
		}
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单结算页面</title>
<link rel="shortcut icon" href="imgs/favicon.ico"/>
<script type="text/javascript" src="js.js"></script>
<link href="<%= request.getContextPath()%>/home/css.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/ordercss.css" rel="stylesheet" type="text/css">
<script src="http://api.map.baidu.com/api?v=1.5&ak=CqSmd95LZGbKrsshOnjTNUB3" type="text/javascript"></script>

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
		<div class="w">
		<div class="checkout-tit">
			<span class="tit-txt">填写并核对订单信息</span>
		</div>
		<div class="checkout-steps">
			<div class="step-tit">
				<h3>商品信息</h3>
			</div>
			<%for(int i=0;i<order_num;i++){
				Good good = cart.getGoods(goods_list[i]);//goods_list[i]为商品编号
			%>
			<div class="step-cont">
				<span class="lt">商品编号：</span>
				<input type="text" name="ord_goodnos" disabled value="<%=goods_list[i]%>">
				<span>商品名：</span>
				<input type="text" disabled value="<%=good.getGoodName()%>">
				<span>购买数量：</span>
				<input type="text" disabled value="<%=cart.getBuyNum(goods_list[i])%>">
				<span>商品描述：</span>
				<input type="text" disabled value="<%=good.getGoodDescription()%>" size=50>
			</div>
			<%} %>
			<div class="hr"></div>
			<div class="step-tit">
				<h3>收货人信息</h3>
			</div>
			<div class="step-cont">
				<span class="lt">用户邮箱：</span>
				<input type="text" name="" disabled value="<%=mail%>" size=30 id="mailid">
				<span class="">用户名：</span>
				<input type="text" name="nickname" value="<%=nickname%>" size=30 id="nicknameid">
				<span class="">收货地址：</span>
				<input type="text" name="address" value="<%=address%>" size=30 id="addressid">
				<input type="button" value="确定" onclick="modify_info()">
				<input name="mailno" type="hidden" value="<%=mail%>" >
				<input name="order_modify" type="hidden" value="1" >
			</div>
			<div class="hr"></div>
			<div class="step-tit">
				<h3>付款方式</h3>
			</div>
			<div class="step-cont">
				<input type="button" value="立即付款" class="lt" onclick="pay_right()" style="width:200px;margin-right:50px;">
				<input type="button" value="稍后付款" style="width:200px;" onclick="pay_after()">
			</div>
		</div>
		
		
		</div><!-- confirm_order -->
	</div><!-- bigContainer -->

</body>
</html>