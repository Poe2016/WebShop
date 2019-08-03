<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.util.ShopCart" %>
<% String path=request.getContextPath(); %>
<%
request.setCharacterEncoding("UTF-8") ; 
response.setContentType("text/html;charset=UTF-8");
int goodsAmount = 0;//我的购物车中的商品总类数
String onuser = (String)session.getAttribute("onlineuser");//在线用户
ShopCart cart=null;//购物车
if(onuser==null){
	onuser="你好，请登录";
}else{
	cart=(ShopCart)session.getAttribute("cart");//获取登录用户的购物车
	goodsAmount=cart.getTotal();
}


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SpecialShop</title>
<link rel="shortcut icon" href="home/imgs/favicon.ico"/>
<link href="<%=path %>/home/css.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="home/boom/css/style.css" media="screen" type="text/css" />
<script src="http://api.map.baidu.com/api?v=1.5&ak=CqSmd95LZGbKrsshOnjTNUB3" type="text/javascript"></script>

  
<script type="text/javascript" src="home/jquery-2.1.0.js"></script>  
<style type="text/css">  
*{margin:0;padding:0;list-style-type:none;}  
body{font:12px/180% Arial, Helvetica, sans-serif, "宋体";color:#333;background:#f0f0f0;}  
a,img{border:0;}  
/* demo */  
.demo{width:590px;margin:0 auto;}  
.demo h2{height:70px;line-height:50px;font-size:22px;font-weight:normal;font-family:"Microsoft YaHei",SimHei;text-align:center;}  
/* focus */  
#focus{position:relative;width:590px;height:470px;overflow:hidden;}  
#focus ul{height:470px;position:absolute;}  
#focus ul li{float:left;width:590px;height:470px;overflow:hidden;position:relative;background:#000;}  
#focus ul li div{position:absolute;overflow:hidden;}  
#focus .btnBg{position:absolute;width:590px;height:40px;left:0;bottom:0;background:#000;}  
#focus .btn{position:absolute;height:30px;left:10px;bottom:4px;}  
#focus .btn span{  
    float:left;display:inline-block;width:30px;height:30px;line-height:30px;text-align:center;font-size:16px;margin-right:10px;cursor:pointer;background:#716564;color:#ffffff;  
    border-radius:15px;  
    -moz-border-radius:15px;  
    -webkit-border-radius:15px;  
}  
#focus .btn span.on{background:#B91919;color:#ffffff;}  
</style> 
<script type="text/javascript">  
$(function(){  
    var sWidth = $("#focus").width();   
    var len = $("#focus ul li").length;   
    var index = 0;  
    var picTimer;  
  
    var btn = "<div class='btnBg'></div><div class='btn'>";  
    for(var i=0; i < len; i++){  
        btn += "<span>" + (i+1) + "</span>";  
    }  
    btn += "</div>"  
    $("#focus").append(btn);  
    $("#focus .btnBg").css("opacity",0.3);  
  
      
    $("#focus .btn span").mouseenter(function(){  
        index = $("#focus .btn span").index(this);  
        showPics(index);  
    }).eq(0).trigger("mouseenter");  
  
      
    $("#focus ul").css("width",sWidth * (len + 1));  
  
      
    $("#focus ul li div").hover(function(){  
        $(this).siblings().css("opacity",0.7);  
    },function() {  
        $("#focus ul li div").css("opacity",1);  
    });  
  
  
    $("#focus").hover(function(){  
        clearInterval(picTimer);  
    },function(){  
        picTimer = setInterval(function(){  
            if(index == len){   
                showFirPic();  
                index = 0;  
            }else{   
                showPics(index);  
            }  
            index++;  
        },1000);   
    }).trigger("mouseleave");  
  
      
    function showPics(index){    
        var nowLeft = -index*sWidth;  
        $("#focus ul").stop(true,false).animate({"left":nowLeft},500);   
        $("#focus .btn span").removeClass("on").eq(index).addClass("on");   
    }  
  
    function showFirPic(){   
        $("#focus ul").append($("#focus ul li:first").clone());  
        var nowLeft = -len*sWidth;   
        $("#focus ul").stop(true,false).animate({"left":nowLeft},500,function(){  
              
            $("#focus ul").css("left","0");  
            $("#focus ul li:last").remove();  
        });   
        $("#focus .btn span").removeClass("on").eq(0).addClass("on");   
    }  
      
});  
</script>  

<link rel="stylesheet" href="home/newmenu/css/style.css" media="screen" type="text/css" />
<script src="home/newmenu/js/index.js" type="text/javascript"></script>

</head>
<body class="index">
	<!-- 最外层 div-->
	<div id=show class="bigContainer">
		<!-- 登陆栏 -->
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
						
						<a class="linklogin" href="home/passport.jsp"><%=onuser %></a>
						<a class="linkregist" href="home/regist.jsp">免费注册</a>
					</li><!-- loginbutton -->
					<li class="spacer"></li>
					<li class="mygoods">
						<a class="linkmygoods" href="home/cart.jsp">我的购物车</a>
					</li>
					<li class="spacer"></li>
					<li class="mystore">
						<a class="linkmystore" href="home/myStore.jsp">我的商城</a>
					</li>
				</ul><!--rowright  -->
			</div><!--logrow  -->
			<div style="background-color: rgb(59, 20, 75);">
				<a href="home/aa_aaiphone.jsp?type=华为" style="margin:0; pading:0;" target="_blank">
					<img alt="标语1" src="home/head/head1.jpg" >
				</a>
			</div>
			
		</div><!-- shortcut -->
		
		<div id="header">
			  <div class="w">
			    
			    <div id="search" class="">
			    <div style="float:left;">	
		    		<a id="logo" href="http://localhost:8080/WebShop/" >
		    			<img alt="商城首页" src="home/imgs/logo.jpg" style="width:300px;height:70px;">
		    		</a>
		    	</div>
			    	<div class="search-m">
			    		<div class="form">
			    		
			    		<form id="search-img-upload" method="get" action="searchAction" enctype="multipart/form-data" target="_self">
			          		
			          		<input autocomplete="off" id="key" name="key" accesskey="s" class="text" type="text">
			          		
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
			    
			    <div id="settleup" class="dropdown">
			    	<div class="cw-icon">
			        	
			        	<i class="ci-count" id="shopping-amount"><%=goodsAmount %></i>
			        	
			        	
			        	<a target="_blank" href="home/cart.jsp">我的购物车</a>
			      	</div>
			    </div>
			    
			    
			    <div id="navitems">  
			    	<ul id="navitems-group1">
						        <li class="fore1"><a target="_blank" href="home/aa_aaiphone.jsp?type=iphone">iphone系列</a></li>
						        <li class="fore2"><a target="_blank" href="home/aa_aaiphone.jsp?type=华为">华为系列</a></li>
						        <li class="fore3"><a target="_blank" href="home/aa_aaiphone.jsp?type=小米">小米系列</a></li>
						        <li class="fore4"><a target="_blank" href="home/aa_aaiphone.jsp?type=OPPO">OPPO系列</a></li>
					</ul>
			        <div class="spacer"></div>
					<ul id="navitems-group2">
						        <li class="fore1"><a target="_blank" href="home/aa_aaiphone.jsp?type=vivo">vivo系列</a></li>
						        <li class="fore2"><a target="_blank" href="home/aa_aaiphone.jsp?type=魅族">魅族系列</a></li>
						        <li class="fore3"><a target="_blank" href="home/aa_aaiphone.jsp?type=一加">一加系列</a></li>
						        <li class="fore4"><a target="_blank" href="home/aa_aaiphone.jsp?type=金立">金立系列</a></li>
					</ul>
			        <div class="spacer"></div>
					
			    </div>
			    <div id="treasure" ></div>
			  
			  </div><!-- w -->
			  
			</div><!-- header -->

		
		<div class="fs">
      <div class="grid_c1 fs_inner">
        <div class="fs_col1">
        	  
			<div id="J_cate" class="cate J_cate" style="background:url('home/imgs/menubg.png');border-right: 10px solid #d00355;">
			<ul class="JS_navCtn cate_menu">
				<li class="cate_menu_item" data-index="1" >
					<a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=iphone">iphone系列</a>
				</li>
	    		<li class="cate_menu_item" data-index="2" >
				    <a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=iphone&detail=iphoneX">X</a>
					<span class="cate_menu_line">/</span>
					<a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=iphone&detail=iphone8">8</a>
					<span class="cate_menu_line">/</span>
					<a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=iphone&detail=iphone7">7</a>
					<span class="cate_menu_line">/</span>
					<a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=iphone&detail=其他">其他</a>
					<span class="cate_menu_line">/</span>
					
				</li>
	    		<li class="cate_menu_item" data-index="4" >
				    <a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=华为">华为系列</a>
				</li>
	    		<li class="cate_menu_item" data-index="5" >
				    <a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=华为&detail=Mate">Mate</a>
					<span class="cate_menu_line">/</span>
					<a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=华为&detail=P系">P系</a>
					<span class="cate_menu_line">/</span>				     
					<a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=华为&detail=荣耀">荣耀</a>
				</li>
	    		<li class="cate_menu_item" data-index="6" >
				    <a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=小米">小米系列</a>
				</li>
	    		<li class="cate_menu_item" data-index="7" >
				    <a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=小米&detail=MIX">MIX</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=小米&detail=红米">红米</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=小米&detail=Note">Note</a>
				</li>
	    		<li class="cate_menu_item" data-index="8" >
				    <a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=OPPO">OPPO系列</a>
				</li>
	    		<li class="cate_menu_item" data-index="9" >
				    <a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=OPPO&detail=A">A</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=OPPO&detail=R">R</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=OPPO&detail=Find">Find</a>
				</li>
	    		<li class="cate_menu_item" data-index="10" >
				    <a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=vivo">vivo系列</a>
				</li>
	    		<li class="cate_menu_item" data-index="11">
				    <a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=vivo&detail=Xplay">Xplay</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=vivo&detail=X">X</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=vivo&detail=Y">Y</a>
				</li>
	    		<li class="cate_menu_item" data-index="12" >
				    <a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=魅族">魅族系列</a>
				</li>
	    		<li class="cate_menu_item" data-index="13">
				    <a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=魅族&detail=Pro">Pro</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=魅族&detail=魅蓝">魅蓝</a>
				</li>
	    		<li class="cate_menu_item" data-index="14" >
				    <a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=一加">一加系列</a>
				</li>
	    		<li class="cate_menu_item" data-index="15" >
				    <a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=一加&detail=X">X</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=一加&detail=T">T</a>
				</li>
	    		<li class="cate_menu_item" data-index="16">
				    <a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=金立">金立系列</a>
				</li>
				<li class="cate_menu_item" data-index="15" >
				    <a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=金立&detail=M">M</a>
					<span class="cate_menu_line">/</span>				      
					<a target="_blank" class="cate_menu_lk" href="home/aa_aaiphone.jsp?type=金立&detail=S">S</a>
				</li>
	  </ul>
  </div>
 

        </div>
    
        <div class="fs_col2">
			<div id="J_focus" class="J_focus focus">
			<div class="J_focus_main focus_main">
			<div class="slider focus_list J_focus_list">
			<div class="slider_list" style="overflow: hidden;">
			<div id="focus">  
		        <ul>  
		            <li>  
		                <div style="left:0;top:0;">
		                	<a href="home/aa_aaiphone.jsp?type=小米"><img width="590" height="470" src="home/promote/center1.jpg"  /></a>
		                </div>  
		            </li>  
		            <li>  
		                <div style="left:0;top:0;"><a href="home/aa_aaiphone.jsp?type=iphone"><img width="590" height="470" src="home/promote/center2.jpg" /></a></div>  
		            </li>  
	                <li>  
	                	<div style="right:0;top:0;"><a href="home/aa_aaiphone.jsp?type=华为"><img width="590" height="470" src="home/promote/cent3.jpg"  /></a></div>  
	                </li>  
	                <li>  
	               		<div style="right:0;top:0px;"><a href="home/aa_aaiphone.jsp?type=vivo"><img width="590" height="470" src="home/promote/center4.jpg"  /></a></div>  
	                </li>  
	                <li>  
	                	<div style="right:0;bottom:0;"><a href="home/aa_aaiphone.jsp?type=OPPO"><img width="590" height="470" src="home/promote/center5.jpg"  /></a></div>  
	                </li>  
	                <li>  
	                	<div style="right:0;bottom:0;"><a href="home/aa_aaiphone.jsp?type=OPPO"><img width="590" height="470" src="home/promote/center6.jpg"  /></a></div>  
	                </li>  
		              
		        </ul>  
		    </div>  
			
			</div>
			</div>
			</div>
			</div>
        </div>
    
        <div class="fs_col3">
			<div id="J_rec" class="J_rec rec">
				<div class="rec_inner">
					<div class="rec_item">
						<a class="rec_lk mod_loading" href="home/aa_aaiphone.jsp?type=iphone" target="_blank">
							<div class="lazyimg lazyimg_loaded J_rec_img rec_img">
								<img src="home/promote/r1.jpg" style="width:190px;height:150px;" class="lazyimg_img">
							</div>
						</a>
					</div>
					<div class="rec_item">
						<a class="rec_lk mod_loading" href="home/aa_aaiphone.jsp?type=iphone" target="_blank">
							<div class="lazyimg lazyimg_loaded J_rec_img rec_img">
								<img src="home/promote/r2.jpg" style="width:190px;height:150px;" class="lazyimg_img">
							</div>
						</a>
					</div>
					<div class="rec_item">
						<a class="rec_lk mod_loading" href="home/aa_aaiphone.jsp?type=iphone" target="_blank">
							<div class="lazyimg lazyimg_loaded J_rec_img rec_img">
								<img src="home/promote/r3.jpg" style="width:190px;height:150px;" class="lazyimg_img">
							</div>
						</a>
					</div>
				</div>
			</div>
        </div>
    
        <div id="J_fs_col4" class="fs_col4" style="width:190px;height:480px;background:#fff;">
			<div id="J_user" class="J_user user">
				<div class="user_inner user_level1 user_plus0">
					<div class="J_user_avatar user_avatar">
						<a class="user_avatar_lk" href="home/passport.jsp" target="_blank" >
							<img src="home/imgs/no_login.jpg">
						</a>
					</div>
					<div class="user_show">
						<p class="user_tip">Hi~欢迎来到SpecialShop！</p>
						<p>
							<a href="home/passport.jsp" class="user_login">登录</a>
							<a href="home/regist.jsp" class="user_reg">注册</a>
						</p>
					</div>
				</div>
        	</div>
        	<div id="boom" style="width:190px;height:340px;">
				<canvas id="canvas"></canvas>
				<script src="home/boom/js/index.js"></script>

        	
        	</div><!-- boom -->
      	</div>
    </div>
	</div><!--bigContainer  -->
</body>
</html>