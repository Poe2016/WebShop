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
ArrayList<String> caregood = new ArrayList<String>();//用户关注商品的商品编号
String uid=null;
if(onuser!=null){//登录状态
	sql = "select userid from users where mail=\'"+onuser+"\'";
	try{
		ResultSet careset = st.executeQuery(sql);
		if(careset.next()){
			uid=careset.getString("userid");
		}
		sql="select goodno from caregood_t"+uid;
		careset = st.executeQuery(sql);
		while(careset.next()){
			String gn = careset.getString("goodno");
			caregood.add(gn);
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	String search_table=(String)session.getAttribute("searchtable");
	String history_table=(String)session.getAttribute("historytable");
   longinmesg=onuser;
   cart=(ShopCart)session.getAttribute("cart");
   goodsAmount=cart.getTotal();
   addToCart = "../addToCartAction";
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
	   ArrayList<Good> temp=(ArrayList<Good>)goodslist.clone();
   	   final String temp_str = search_key_most;
	   Collections.sort(temp, new Comparator<Good>() {
           public int compare(Good g1, Good g2) {
        	Similarity s=new Similarity();
           	float simi1=s.similarity_g_key(g1,temp_str);
           	float simi2=s.similarity_g_key(g2,temp_str);
           	return ((Float)simi2).compareTo((Float)simi1);
           }
       });
	   rec_good1=temp.get(0);
	   picture_name=rec_good1.getPicture_name();
   }
   
}else if(onuser==null){//未登录状态，先登录
	addToCart="passport.jsp";
	session.setAttribute("loginstate", "addToCart");
}


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品搜索</title>
<link rel="shortcut icon" href="imgs/favicon.ico"/>
<link href="<%= request.getContextPath()%>/home/css.css" rel="stylesheet" type="text/css">
<link href="<%= request.getContextPath()%>/home/searchcss.css" rel="stylesheet" type="text/css">
<script src="http://api.map.baidu.com/api?v=1.5&ak=CqSmd95LZGbKrsshOnjTNUB3" type="text/javascript"></script>
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
			    
			    	 <div style="float:left;">	
			    		<a id="logo" href="http://localhost:8080/WebShop/" >
			    			<img alt="商城首页" src="imgs/logo.jpg" style="width:300px;height:70px;">
			    		</a>
			    	</div>
			    
			    	<div class="search-m">
			    		<div class="form">
			    			<form id="search-img-upload" method="get" action="../searchAction" enctype="multipart/form-data" target="_self">
			          		
			          		<input id="key" name="key" class="text" type="text">
			          		
			          		<span class="photo-search-btn">
			          		<span class="upload-bg"></span>
			          		<input name="file" class="upload-trigger" accept="image/png,image/jpeg,image/jpg" type="file">
			          		</span>
			          		<button class="button"  >
			          			搜
			          		</button>
			          		</form>
			    			
			    			
			        </div>
			      	</div>
			    </div>
			    
			    <div id="settleup" class="dropdown" clstag="h|keycount|head|cart_null">
			    	<div class="cw-icon">
			        	<i class="ci-left"></i>
			        	<i class="ci-right">&gt;</i><i class="ci-count" id="shopping-amount"><%=goodsAmount %></i>
			        	<i class="iconfont"></i>
			        	<a target="_blank" href="cart.jsp">我的购物车</a>
			      	</div>
			    </div>
			    
			    
			    <div id="navitems">  
			    	
			    </div>
			    <div id="treasure" ></div>
			  
			  </div><!-- w -->
			  
			</div>
	
	
	
	<div class="fs">
      <div class="grid_c1 fs_inner">
        <div class="fs_col1">
			<div id="J_cate" class="cate J_cate">
			  <ul class="JS_navCtn cate_menu">
				<li class="cate_menu_item" data-index="1" >
					<a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=iphone">iphone系列</a>
				</li>
	    		<li class="cate_menu_item" data-index="2" >
				    <a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=iphone&detail=iphoneX">X</a>
					<span class="cate_menu_line">/</span>
					<a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=iphone&detail=iphone8">8</a>
					<span class="cate_menu_line">/</span>
					<a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=iphone&detail=iphone7">7</a>
					<span class="cate_menu_line">/</span>
					<a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=iphone&detail=其他">其他</a>
					<span class="cate_menu_line">/</span>
					
				</li>
	    		<li class="cate_menu_item" data-index="4" >
				    <a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=华为">华为系列</a>
				</li>
	    		<li class="cate_menu_item" data-index="5" >
				    <a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=华为&detail=Mate">Mate</a>
					<span class="cate_menu_line">/</span>
					<a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=华为&detail=P系">P系</a>
					<span class="cate_menu_line">/</span>				     
					<a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=华为&detail=荣耀">荣耀</a>
				</li>
	    		<li class="cate_menu_item" data-index="6" >
				    <a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=小米">小米系列</a>
				</li>
	    		<li class="cate_menu_item" data-index="7" >
				    <a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=小米&detail=MIX">MIX</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=小米&detail=红米">红米</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=小米&detail=Note">Note</a>
				</li>
	    		<li class="cate_menu_item" data-index="8" >
				    <a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=OPPO">OPPO系列</a>
				</li>
	    		<li class="cate_menu_item" data-index="9" >
				    <a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=OPPO&detail=A">A</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=OPPO&detail=R">R</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=OPPO&detail=Find">Find</a>
				</li>
	    		<li class="cate_menu_item" data-index="10" >
				    <a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=vivo">vivo系列</a>
				</li>
	    		<li class="cate_menu_item" data-index="11">
				    <a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=vivo&detail=Xplay">Xplay</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=vivo&detail=X">X</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=vivo&detail=Y">Y</a>
				</li>
	    		<li class="cate_menu_item" data-index="12" >
				    <a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=魅族">魅族系列</a>
				</li>
	    		<li class="cate_menu_item" data-index="13">
				    <a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=魅族&detail=Pro">Pro</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=魅族&detail=魅蓝">魅蓝</a>
				</li>
	    		<li class="cate_menu_item" data-index="14" >
				    <a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=一加">一加系列</a>
				</li>
	    		<li class="cate_menu_item" data-index="15" >
				    <a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=一加&detail=X">X</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=一加&detail=T">T</a>
				</li>
	    		<li class="cate_menu_item" data-index="16">
				    <a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=金立">金立系列</a>
				</li>
				<li class="cate_menu_item" data-index="15" >
				    <a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=金立&detail=M">M</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="aa_aaiphone.jsp?type=金立&detail=S">S</a>
				</li>
				
	  		  </ul>
 </div>

        </div>
    	
    	<!-- 显示搜索商品区 -->
    	<div class="my_fs_col2">
    		<div class="mygoodslist">
    			<ul class="">
    			<% 
    				if(goodsearchlist!=null){
    				for(Good g:goodsearchlist){ 
    					String caremsg = "关注商品";
    					if(!caregood.isEmpty() && caregood.contains(g.getGoodNo())){//用户已关注该商品
    						caremsg = "取消关注";
    					}
    					String goodfilename=g.getGoodNo()+"+"+g.getGoodfilename();
    					String des = g.getGoodDescription();
    					if(des.length()>50){
    						des = des.substring(0,32);
    					}
    					//String goodNo=goodsfilename[i].split("\\+")[0];//商品编号,然后创建一个商品实例
    					
    				%>
    			<li class="goodsitem">
    					<div class="goodsinfo" >
    						<div class="imgdiv">
    							<a target="_blank" href="gooditem.jsp?goodno=<%= g.getGoodNo() %>">
    								<img class="lazyimg_img" src="goodsimgs/<%=goodfilename%>">
    							</a>
    						</div>
    						<!-- 价格等信息 -->
    						<div class="priceinfo"><strong><em>￥</em><i><%=g.getGoodPrice() %></i></strong></div>
    						<div class="nameinfo"><%=g.getGoodName() %>&nbsp&nbsp&nbsp<%=des %></div>
    						<div class="nameinfo">卖家: <%=g.getGoodUserSale() %></div>
    						<div class="stockCart">
    							<div class="stock">库存：<%=g.getGoodNum() %>件</div>
    							<div class="care-cart">
	    							<div class="p-focus">
	    							
	    							<script type="text/javascript">
		    								var req;
		    								var onuser = "<%=longinmesg%>";
		    								function caregood(goodno,id){
		    									var msg = document.getElementById(id).innerText;
		    									if( onuser != "你好，请登录"){
		    										var reqstate;
		    										if(msg == "取消关注"){
		    											reqstate = "notcare";
		    											document.getElementById(id).innerText = "关注商品";
		    										}else{
		    											reqstate = "caregood";
		    											document.getElementById(id).innerText = "取消关注";
		    										}
		    										var goodno = ("00000000" + goodno).substr(-8);// 获取商品编号
			    									var url = "/WebShop/UtilServlet?mailno=<%=onuser%>&goodno=" + goodno +"&uid=<%=uid%>&reqstate="+reqstate;
			    									if (window.XMLHttpRequest) {
			    										req = new XMLHttpRequest();// IE7, Firefox, Opera支持
			    									} else if (window.ActiveXObject) {
			    										req = new ActiveXObject("Microsoft.XMLHTTP");// IE5,IE6支持
			    									}
			    									req.open("get", url, true);
			    									req.onreadystatechange = callback;
			    									req.send(null);
			    									
			    									alert(msg+"成功");
		    									}else{
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
	    							
		    							<a class="J_focus" title="点击关注" >
		    								<span id="caremsgid<%=goodsearchlist.indexOf(g)%>" onclick = "caregood(<%=g.getGoodNo()%>,this.id)"><%=caremsg %></span>
		    							</a>
		    							
	    							</div>
	    							<div class="cart">
	    								<a href="<%=addToCart%>?goodno=<%=g.getGoodNo()%>">加入购物车</a>
	    							</div>
    							</div>
    						</div>
    					</div>
    				</li>
    			
    			<%		
    				}}
    			%>
    			
    			
    				
    				
    			</ul>
    			
    			
    		
    		
    		
    		</div>
    		
    		
    	
    	</div>
        
    
        
    
        <div id="J_fs_col4" class="fs_col4" style="width:240px;">
        	<b>给您推荐如下：</b>
        	<ul>
        		<li class="goodsitem">
    					<div class="goodsinfo">
    						<div class="imgdiv">
    						<a target="_blank" href="gooditem.jsp?goodno=<%= rec_good1.getGoodNo() %>">
    							<img class="lazyimg_img" src="goodsimgs/<%=picture_name%>">
    						</a>
    						</div>
    						<!-- 价格等信息 -->
    						<!-- 价格等信息 -->
    						<div class="priceinfo"><strong><em>￥</em><i><%=rec_good1.getGoodPrice() %></i></strong></div>
    						<div class="nameinfo"><%=rec_good1.getGoodName() %>&nbsp&nbsp&nbsp<%=rec_good1.getGoodDescription() %></div>
    						<div class="nameinfo">卖家: <%=rec_good1.getGoodUserSale() %></div>
    						<div class="stockCart">
    							<div class="stock">库存：<%=rec_good1.getGoodNum() %>件</div>
    							<div class="cart">
    								<a href="<%=addToCart%>?goodno=<%=rec_good1.getGoodNo()%>">加入购物车</a>
    							</div>
    						</div>
    					</div>
    				</li>
        	</ul>
        </div>
      </div>
      
    </div>
	</div><!-- bigContainer -->

</body>
</html>