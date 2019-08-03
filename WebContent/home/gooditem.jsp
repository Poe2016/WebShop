<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.util.Good"%>
<%@ page import="com.util.ShopCart"%>
<%@ page import="com.util.Conn2Ora"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%
	Connection con = Conn2Ora.con;
	Statement st = Conn2Ora.st;
	ResultSet rs = null;
	ShopCart cart = null;//购物车
	int total = 0;//该用户购物车中商品
	ArrayList<String> caresaler = new ArrayList<String>();//关注店铺的邮箱表
	String uid = null;//该用户的id
	String caremsg = "关注店铺";
	ArrayList<Good> list = (ArrayList<Good>) session.getAttribute("goodslist");//获取所有商品列表
	String onlineuser = (String) session.getAttribute("onlineuser");//获取在线用户名
	String goodNo = request.getParameter("goodno");//商品编号
	String time = null;//当前时间
	String sql = null;//
	int record = 0;//用于count(*)
	int newrecord = 0;//
	int total_record = 0;//总表中的记录数
	int total_newrecord = 0;
	int pages = 0;//推荐商品中的页数
	String table_name = (String) session.getAttribute("historytable");//获取登录用户的记录表
	if (onlineuser != null) {
		cart=(ShopCart)session.getAttribute("cart");//获取该用户的购物车
		total = cart.getTotal();
		sql = "select userid from users where mail=\'" + onlineuser + "\'";//获取登录用户id
		try {
			ResultSet careset = st.executeQuery(sql);
			if (careset.next()) {
				uid = careset.getString("userid");
			}
			sql = "select saler from caresaler_t" + uid;
			careset = st.executeQuery(sql);
			while (careset.next()) {
				String gn = careset.getString("saler");
				caresaler.add(gn);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		time = (new SimpleDateFormat("yyyy-MM-dd")).format(new Date()).toString(); //获取系统时间 
		sql = "select amount from " + table_name + " where goodno=\'" + goodNo + "\' and see_date=to_date(\'"
				+ time + "\',\'yyyy-mm-dd\')";
		//向用户自己的记录表中插入该条记录
		try {
			rs = st.executeQuery(sql);
			if (rs.next()) {
				record = rs.getInt("amount");
				newrecord = record + 1;
			}
			if (record == 0) {//表中无记录，插入
				sql = "insert into " + table_name + " values(\'" + goodNo + "\',+to_date(\'" + time
						+ "\',\'yyyy-mm-dd\'),1)";
				st.execute(sql);
				con.commit();
			} else {//表中有记录，应增加次数
				sql = "update " + table_name + " set amount=" + newrecord + " where goodno=\'" + goodNo
						+ "\' and see_date=to_date(\'" + time + "\',\'yyyy-mm-dd\')";
				st.execute(sql);
				con.commit();
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		sql = "select amount from his_table where mail=\'"+onlineuser+"\' and goodno=\'" + goodNo + "\' and see_date=to_date(\'"
				+ time + "\',\'yyyy-mm-dd\')";
		//向系统总的记录表中插入该条记录
				try {
					rs = st.executeQuery(sql);
					if (rs.next()) {
						total_record = rs.getInt("amount");
						total_newrecord = total_record + 1;
					}
					if (total_record == 0) {//表中无记录，插入
						sql = "insert into his_table values(\'" + onlineuser + "\',\'" + goodNo + "\',+to_date(\'" + time
								+ "\',\'yyyy-mm-dd\'),1)";
						st.execute(sql);
						con.commit();
					} else {//表中有记录，应增加次数
						sql = "update his_table set amount=" + total_newrecord + " where mail=\'"+onlineuser+"\' and goodno=\'" + goodNo
								+ "\' and see_date=to_date(\'" + time + "\',\'yyyy-mm-dd\')";
						st.execute(sql);
						con.commit();
					}
				} catch (SQLException e1) {
					e1.printStackTrace();
				}

	} else {
		onlineuser = "你好，请登录";
	}

	String goodName = null;//商品名
	Integer goodPrice = null;// 商品价格
	String goodUserSale = null;// 商品上传者
	String goodDescription = null;// 商品描述
	Integer goodNum = null;// 商品数量，-指某个用户上传的某一个商品的数量
	String goodfilename = null;//仅只图片的文件名，不包括编号
	String picturename = null;//指商品在服务器中存储的照片名
	Good good = null;//此商品
	if (goodNo != null) {
		for (Good g : list) {
			if (g.getGoodNo().equals(goodNo)) {
				good = g;
				break;
			}
		}
		if (good != null) {
			goodName = good.getGoodName();
			goodPrice = good.getGoodPrice();
			goodUserSale = good.getGoodUserSale();
			goodDescription = good.getGoodDescription();
			goodNum = good.getGoodNum();
			goodfilename = good.getGoodfilename();
			picturename = goodNo + "+" + goodfilename;
			if (!caresaler.isEmpty() && caresaler.contains(goodUserSale)) {
				caremsg = "取消关注店铺";
			}
		} else {
			PrintWriter writer = response.getWriter();
			writer.println("Error: 表单必须包含 enctype=multipart/form-data");
			writer.flush();
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>详细信息</title>
<link rel="shortcut icon" href="imgs/favicon.ico"/>
<link href="<%=request.getContextPath()%>/home/css.css" rel="stylesheet"
	type="text/css">
<link href="<%=request.getContextPath()%>/home/searchcss.css"
	rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/home/gooditemcss.css"
	rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/home/gooditemevacss.css"
	rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/home/gooditemevacss2.css"
	rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/home/othergoodscss.css"
	rel="stylesheet" type="text/css">
<script
	src="http://api.map.baidu.com/api?v=1.5&ak=CqSmd95LZGbKrsshOnjTNUB3"
	type="text/javascript"></script>
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
							<span id="atCity">长沙市</span>
							<!-- 下拉城市菜单********未完******** -->
							<div class="citylist">
								<div class="item">北京</div>
								<div class="item">上海</div>
							</div>
							<!-- citylist -->
						</div>
					</li>

				</ul>
				<!--rowleft  -->
				<!-- 右边登录注册处 -->
				<ul class="rowright">
					<li class="loginbutton"><a class="linklogin"
						href="passport.jsp"><%=onlineuser%></a> <a class="linkregist"
						href="regist.jsp">免费注册</a></li>
					<!-- loginbutton -->
					<li class="spacer"></li>
					<li class="mygoods"><a class="linkmygoods" href="cart.jsp">我的购物车</a>
					</li>
					<li class="spacer"></li>
					<li class="mystore"><a class="linkmystore" href="myStore.jsp">我的商城</a>
					</li>
				</ul>
				<!--rowright  -->
			</div>
			<!--logrow  -->
		</div>
		<!-- shortcut -->


		<div id="header">
			<div class="w">

				<div id="search" class="">
					<div class="search-m">
						<div class="form">
							<form id="search-img-upload" method="get"
								action="../searchAction" enctype="multipart/form-data"
								target="_self">

								<input autocomplete="off" id="key" name="key" accesskey="s"
									class="text" type="text"> <span
									class="photo-search-btn"> <span class="upload-bg"></span>
									<input name="file" class="upload-trigger"
									accept="image/png,image/jpeg,image/jpg" type="file">
								</span>
								<button class="button">
									<!-- onclick="window.location.href='http://localhost:8080/WebShop/home/search.jsp'" -->
									<i class="iconfont"></i>
								</button>
							</form>


						</div>
					</div>
				</div>

				<div id="settleup" class="dropdown">
					<div class="cw-icon">
						<i class="ci-left"></i> <i class="ci-right">&gt;</i><i
							class="ci-count" id="shopping-amount"><%=total %></i> <i class="iconfont"></i>
						<a target="_blank" href="cart.jsp">我的购物车</a>
					</div>
				</div>

				<script type="text/javascript">
					var req;
					var onuser = "<%=onlineuser%>";
					function addcare(saler){
						var msg = document.getElementById("caresalerid").innerText;
						if( onuser != "你好，请登录"){
							var reqstate;
							if(msg == "取消关注店铺"){
								reqstate = "notcaresaler";
								document.getElementById("caresalerid").innerText = "关注店铺";
							}else{
								reqstate = "caresaler";
								document.getElementById("caresalerid").innerText = "取消关注店铺";
							}
							var url = "/WebShop/UtilServlet?mailno=<%=onlineuser%>&saler=" + saler +"&uid=<%=uid%>&reqstate="
									+ reqstate;
							if (window.XMLHttpRequest) {
								req = new XMLHttpRequest();// IE7, Firefox, Opera支持
							} else if (window.ActiveXObject) {
								req = new ActiveXObject("Microsoft.XMLHTTP");// IE5,IE6支持
							}
							req.open("get", url, true);
							req.onreadystatechange = callback;
							req.send(null);

							alert(msg + "成功");
						} else {
							alert("请登录");
						}
					}
					function callback() {
						if (req.readyState == 4 && req.status == 200) {
							return "OK";
						} else {
							return "error";
						}
					}
				</script>

				<div id="treasure"
					style="width: 500px; position: absoluate; left: 0px;">
					<div style="float: left;">
						店铺：<%=goodUserSale%></div>
					<a id="caresalerid" onclick="addcare('<%=goodUserSale%>')"
						style="position: absolute; right: 80px;"><%=caremsg%></a>
					<a href="chat.jsp" style="position: absolute; right: 10px;">互撩</a>

				</div>

			</div>
			<!-- w -->

		</div>

		<div class="w" style="height: 260px;">
			<div class="product-intro clearfix">
				<div class="preview-wrap">
					<div class="preview" id="preview">
						<div id="spec-n1" class="jqzoom main-img">
							<img id="spec-img"
								alt="<%=good.getGoodName()%>&nbsp&nbsp<%=good.getGoodDescription()%>"
								src="goodsimgs/<%=picturename%>" width="220px;">
						</div>

					</div>
					<!-- id="preview" -->
				</div>
				<!-- class="preview-wrap" -->
				<div class="itemInfo-wrap">
					<div class="sku-name"><%=good.getGoodName()%>&nbsp&nbsp<%=good.getGoodDescription()%></div>
					<div class="summary summary-first">
						<div class="summary-price-wrap">
							<div class="summary-price J-summary-price">
								<div class="dt" style="line-height: 33px;">
									<strong>售价</strong>
								</div>
								<div class="dd">
									<span class="p-price">
										<span>￥</span>
										<span class="price J-p-5089237"><%=good.getGoodPrice()%></span>
									</span>
								</div>
							</div>
						</div>

					</div>
					<div>
						<a href="../addToCartAction?goodno=<%=goodNo %>" id="InitCartUrl" class="btn-special1 btn-lg" >加入购物车</a>
					</div>
			</div>
			<!-- class="itemInfo-wrap" -->
		</div>
		<!-- class="product-intro clearfix" -->

	</div>
	<!-- w -->

	<!-- 推荐部分 -->
	<div class="w" style="height: 340px;">
	<div class="m m1" id="similar">
		<div class="mt"><h3>其他人同时还浏览这些商品</h3></div>
		<div style="position: relative;">
			<%
			//从数据库中选出其他人浏览的商品
			ArrayList<Good> nolist = new ArrayList<Good>();//待显示商品列表
			sql = "select distinct mail from his_table where goodno=\'"+goodNo+"\' and mail<>\'"+onlineuser+"\'";//选出浏览过该商品的用户
			try{
				ResultSet mset = st.executeQuery(sql);
				while(mset.next()){
					String seer = mset.getString("mail");//浏览者
					String nsql = "select distinct goodno from his_table where mail=\'"+seer+"\' and goodno<>\'"+goodNo+"\'";
					ResultSet gset = st.executeQuery(nsql);//goodno集合
					while(gset.next()){
						String gno = gset.getString("goodno");//商品编号
						for(Good g:list){
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

	<!-- 评论部分 -->
	<div id="comment" class="m m-content comment"
		style="margin: auto; width: 1190px;">
		<div class="mt">
			<h3>商品评价</h3>
		</div>
		<div class="mc">
			<div class="comment-info J-comment-info">
				<div class="comment-percent">
					<strong class="percent-tit">好评度</strong>
					<div class="percent-con">
						98<span>%</span>
					</div>
				</div>
				<div class="percent-info">
					<div class="tag-list tag-available">
						<span class=" tag-1">质量不错()</span> <span class=" tag-1">very good()</span>
						<span class=" tag-1">样式精美()</span> <span class=" tag-1">还行吧()</span>
						<span class=" tag-1">绝对正版()</span> 
						<span class=" tag-1">手感极好()</span> 
						<span class=" tag-1">摔地不坏()</span> 
						<span class=" tag-1">进水不坏()</span> 
						<span class=" tag-1">价格实惠()</span>
					</div>
				</div>
			</div>
			<div class="J-comments-list comments-list ETab">
				<div class="tab-main small">
					<ul class="filter-list">
						<li class="current" data-num="4500"><a href="">全部评价</a></li>
					</ul>
					<div class="extra">
						<div class="sort-select J-sort-select">
							<div class="current">
								<span class="J-current-sortType">推荐排序</span><i></i>
							</div>
							<div class="others">
								<div class="curr">
									<span class="J-current-sortType">推荐排序</span><i></i>
								</div>
								<ul>
									<li class="J-sortType-item">时间排序</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-con">
					<div id="comment-0" style="display: block;">
						<%
							sql = "select evaluation.mail mail,eva_date,pkscore,spscore,atscore,goscore,tags,def_text,words,anony from evaluation,order_t where evaluation.ord_id=order_t.ord_id and order_t.goodno=\'"
									+ goodNo + "\' order by eva_date desc";
							try {
								ResultSet evaset = st.executeQuery(sql);
								while (evaset.next()) {
									String evaer = evaset.getString("mail");//评论人
									Date eva_date = evaset.getDate("eva_date");//评论时间
									String pkscore = evaset.getString("pkscore");
									String spscore = evaset.getString("spscore");
									String atscore = evaset.getString("atscore");
									String goscore = evaset.getString("goscore");//商品评分
									String tags = evaset.getString("tags");//选中标签，以“,”连接
									String def_text = evaset.getString("def_text");//自定义标签
									String words = evaset.getString("words");//输入文字评论
									String anony = evaset.getString("anony");//是否匿名0-是 1-否

									if (anony.equals("0")) {
										evaer = evaer.substring(0, 2) + "*****@qq.com";
									}
						%>
						<div class="comment-item">
							<div class="user-column">
								<div class="user-info" style="width: 140px; height: 50px;">
									<img src="" alt="该用户未设置头像" class="avatar">
								</div>
								<div class="user-level">
									<span style="color: rgb(136, 136, 136);"><%=evaer%></span>
								</div>
							</div>
							<div class="comment-column J-comment-column">
								<div class="comment-star star5"></div>
								<p class="comment-con"><%=tags%><%=words%></p>
								<div class="J-pic-view-wrap clearfix"></div>
								<div class="comment-message">
									<div class="order-info">
										<span>银色</span><span>64G</span> <span><%=eva_date%></span>
									</div>
								</div>
							</div>
						</div>
						<%
							}
							} catch (SQLException e) {
								e.printStackTrace();
							}
						%>
					</div>
					<!-- id="comment-0" -->
				</div>
				<!-- class="tab-con" -->
			</div>
			<!-- class="J-comments-list comments-list ETab" -->
		</div>
		<!-- mc -->

	</div>
	<!-- id="comment" -->
	<div class="w"></div>







	</div>

</body>
</html>