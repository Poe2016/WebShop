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
	String ord_id = request.getParameter("ord_id");//评价订单编号
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
	String ord_date = null;//订单产生时间
	String goodno = null;//商品编号
	int ord_num = 0;//数量
	int money = 0;//总额
	//后面要显示商品信息(goodno)、购买数量（ord_num)、购买单价、购买总价、购买时间
	String sql = "select goodno,ord_date,ord_num,money from order_t where ord_id="+ord_id;//根据订单编号查询商品信息，联合查询
	try{
		rs = st.executeQuery(sql);
		if(rs.next()){
			goodno = rs.getString("goodno");
			ord_date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(rs.getDate("ord_date"));
			ord_num = rs.getInt("ord_num");
			money = rs.getInt("money");
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	Good g = null;//商品
	for(Good go:goodslist){
		if(go.getGoodNo().equals(goodno)){
			g = go;
			break;
		}
	}
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>评价晒单</title>
<link rel="shortcut icon" href="imgs/favicon.ico"/>
<link href="<%= request.getContextPath()%>/home/css.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/myStorecss.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/cartcss.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/evaluatecss.css" rel="stylesheet" type="text/css">
<script src="http://api.map.baidu.com/api?v=1.5&ak=CqSmd95LZGbKrsshOnjTNUB3" type="text/javascript"></script>
<script type="text/javascript" src="js.js"></script>
<script type="text/javascript" src="jquery-2.1.0.js"></script>
<script type="text/javascript"> 
	function myeval(ord_id){
		var stars = document.getElementsByClassName("star");// 打分标签
		var tag_items = document.getElementsByClassName("tag-item");// 选框标签
		var e_define = document.getElementById("def-inp-id");// 自定义输入框
		var e_words = document.getElementById("shareword");// 文字输入框
		var e_anonymous = document.getElementById("check1");//匿名评价
		var pkscore = 0,spscore = 0,atscore = 0,goscore = 0;//分别是包装、速度、态度、商品评分
		var tags="";//标签，以“，”连接的字符串
		var def_text="",words="";//自定义标签和文字输入框
		var anony = 0;//匿名评价，默认为否（0）1-是
		
		//获取打分
		for(var i=0;i<stars.length;i++){
			var class_name = stars[i].className;//标签的类名
			if(i<5 ){
				if(class_name.indexOf("active")!=-1){
					pkscore = class_name[9];
				}
			}else if(i<10){
				if(class_name.indexOf("active")!=-1){
					spscore = class_name[9];
				}
			}else if(i<15){
				if(class_name.indexOf("active")!=-1){
					atscore = class_name[9];
				}
			}else{
				if(class_name.indexOf("active")!=-1){
					goscore = class_name[9];
				}
			}
		}
		//获取标签
		for(var i=0;i<tag_items.length;i++){
			if(tag_items[i].className.indexOf("tag-checked")!=-1){//选中
				tags+=tag_items[i].innerText+",";
			}
		}
		if(e_define.value!=null){
			def_text = e_define.value;
		}
		if(e_words.value!=null){
			words = e_words.value;
		}
		if(e_anonymous.checked){
			anony = 1;
		}
		$.ajax({
			url:"../PayAndDelete",
			type:"post",
			data:{
				condition : "evaluate",
				ord_id : ord_id,
				pkscore : pkscore,
				spscore : spscore,
				atscore : atscore,
				goscore : goscore,
				tags : tags,
				def_text : def_text,
				words : words,
				anony : anony
			},
			success:function(data){
				
				   },
			error:function(){
				
			}
		});
		location.href="evaluate_success.jsp?ord_id="+ord_id;
	}

</script>
</head>
<body>
	<div>
	
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
					<a href="//localhost:8080/WebShop/" target="_blank" class="fore1" ></a>
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
		</div><!-- nav -->
		<div class="container">
			<div class="w" onmouseover="star_hover()" id="wid">
				<div class="mycomment-detail">
					<div class="detail-hd" id="o-info-orderinfo" >
						<div class="orderinfo">
							<h3 class="o-title">评价订单</h3>
							<div class="o-info">
								<span class="mr20">订单号：
									<a target="_blank" class="gray1"><%=ord_id %></a>
								</span>
								<span><%=ord_date %></span>
							</div>
						</div>
					</div><!-- id="o-info-orderinfo" -->
					
					<div class="mycomment-form">
						<!-- page -->
						<div class="form-part1">
							<div id="activityVoucher" style="" class="f-item f-service">
								<div class="fi-info">
									<div class="comment-service">    
										<div class="s-img">        
											<a href="javascript:void(0)">            
												<img src="" alt="">        
											</a>    
										</div>    
										<div class="s-main">        
											<div class="s-name s-name-delivery">
												物流服务评价
											</div>        
											<div class="s-info">&nbsp;&nbsp;</div>        
											<div class="s-info">员工</div>    
										</div>
									</div>
								</div>
								<div class="fi-operate   z-tip-warn">    
									<div class="fop-item fop-star z-tip-warn">        
										<div class="commstar-group commstar-group-hasweaklabel">            
											<div class="item" >                
												<span class="label">快递包装</span>                
												<span class="commstar">                    
													<span title="非常不满意" class="star star1">
														<i class="face"></i>
													</span>                    
													<span title="不满意" class="star star2"><i class="face"></i></span>                    
													<span title="一般" class="star star3"><i class="face"></i></span>                    
													<span title="满意" class="star star4"><i class="face"></i></span>                    
													<span title="非常满意" class="star star5"><i class="face"></i></span>             
													<span class="star-info">0分</span>                
												</span>            
											</div>            
											<div class="item" >                
												<span class="label">送货速度</span>                
												<span class="commstar">                    
													<span title="非常不满意" class="star star1"><i class="face"></i></span>                    
													<span title="不满意" class="star star2"><i class="face"></i></span>                    
													<span title="一般" class="star star3"><i class="face"></i></span>                    
													<span title="满意" class="star star4"><i class="face"></i></span>                    
													<span title="非常满意" class="star star5"><i class="face"></i></span>             
													<span class="star-info">0分</span>                
												</span>            
											</div>            
											<div class="item" >                
												<span class="label">配送员服务态度</span>                
												<span class="commstar">                    
													<span title="非常不满意" class="star star1"><i class="face"></i></span>                    
													<span title="不满意" class="star star2"><i class="face"></i></span>                    
													<span title="一般" class="star star3"><i class="face"></i></span>                    
													<span title="满意" class="star star4"><i class="face"></i></span>                    
													<span title="非常满意" class="star star5"><i class="face"></i></span>             
													<span class="star-info">0分</span>                
												</span>            
											</div>        
										</div>
									</div>         
								</div>
							</div>
						<div class="f-cutline"></div>
						<div class="f-item f-goods product-4765393">
							<div class="fi-info">
								<div class="comment-goods">
									<div class="p-img">
										<a href="gooditem.jsp?goodno=<%= goodno %>" target="_blank">
											<img src="goodsimgs/<%=goodno+"+"+g.getGoodfilename()%>" >
										</a>
									</div>
									<div class="p-name">
										<a href="gooditem.jsp?goodno=<%= goodno %>" target="_blank"><%=g.getGoodName()+"  "+g.getGoodDescription() %></a>
									</div>
									<div class="p-price"><strong>¥<%=money %></strong></div>
									<div class="p-attr"><%=g.getGoodName() %>&nbsp&nbspx<%=ord_num %> </div>
								</div>
							</div>
							<div class="fi-operate">
								<div class="fop-item fop-star   z-tip-warn">
									<div class="fop-label">商品评分</div>
									<div class="fop-main">
										<span class="commstar">
											<span class="star star1"><i class="face"></i></span>
											<span class="star star2"><i class="face"></i></span>
											<span class="star star3"><i class="face"></i></span>
											<span class="star star4"><i class="face"></i></span>
											<span class="star star5"><i class="face"></i></span>
											<span class="star-info">0分</span>
										</span>
									</div>
									<div class="fop-tip"><i class="tip-icon"></i><em class="tip-text"></em></div>
									<div class="fi-tip"><i class="tip-icon"></i><em class="tip-text">请至少填写一件商品的评价</em></div>
								</div>
								<div class="fop-item J-mjyx">    
									<div class="fop-label">买家印象</div>    
									<div class="fop-main">        
										<div class="m-tagbox m-multi-tag" onmouseover = "select_advantage()" id="selectid">            
											<a  class="tag-item">质量不错<i class="t-check"></i></a>            
											<a  class="tag-item">样式精美<i class="t-check"></i></a>            
											<a  class="tag-item">绝对正版<i class="t-check"></i></a>            
											<a  class="tag-item">手感极好<i class="t-check"></i></a>          
											<a  class="tag-item" >摔地不坏<i class="t-check"></i></a>            
											<a  class="tag-item" >进水不坏<i class="t-check"></i></a>           
											<a  class="tag-item" >价格实惠<i class="t-check"></i></a>            
											<a  class="tag-item" >very good<i class="t-check"></i></a>            
											<a  class="tag-item" >还行吧<i class="t-check"></i></a>             
											<a class="tag-define" id="defineid">                
												<span class="define-label" ><i class="i-pen define"></i><em class="define">自定义标签</em></span>                
												<input class="define-input" id="def-inp-id" type="text">            
											</a>        
										</div>        
									</div> 
									<div class="fop-tip"><i class="tip-icon"></i><em class="tip-text"></em></div>
								</div>
								
								<div class="fop-item ">
									<div class="fop-label">评价晒单</div>
									<div class="fop-main">
										<div class="f-textarea">
											<textarea name="shareword" id="shareword" placeholder="分享体验心得，给万千想买的人一个参考~" ></textarea>
											<div class="textarea-ext"><em class="textarea-num"></em></div>
										</div>
									</div>
									<div class="fop-tip"><i class="tip-icon"></i><em class="tip-text"></em></div>
								</div>
							</div>
						</div>
				<!-- page -->
						<div class="f-btnbox">
							<a onclick = "myeval(<%=ord_id %>)" class="btn-submit">提交</a>
							<span class="f-checkbox">
								<input id="check1" class="i-check"  type="checkbox">
								<label for="check1">匿名评价</label>
							</span>
						</div>	
					</div>
				</div><!-- class="mycomment-detail" -->
			</div><!-- w -->
		
		</div><!-- container -->
	
	</div>

</body>
</html>