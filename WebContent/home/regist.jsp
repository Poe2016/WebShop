<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>账号注册</title>
<link rel="shortcut icon" href="imgs/favicon.ico"/>
<link href="registcss.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js.js"></script>
</head>
<body >
	<div class="header">
		<div class="headcenter">
			<a class="logo" href="http://localhost:8080/WebShop/">
				<img alt="商城首页" src="imgs/logo.jpg" style="width:160px;height:50px;">
			</a>
			<div class="logotitle">欢迎注册</div>
			<div class="havaaccount">
				已有账号，
				<a href="http://localhost:8080/WebShop/home/passport.jsp">请登录</a>
			</div>
		</div>
	</div><!-- header -->
	<div class="steps">
		<ol>
			
			<li>
				
				<span class="ts1"></span>
			</li>
			 
			  
			<li  class="active">
				<span class="ts1">填写注册信息</span>
			</li>
			<!-- 
			<li>
				<i class="iconfont">3</i>
				<span class="ts1">注册成功</span>
			</li>
			-->
		</ol>
	</div><!-- steps -->
	<div class="content">
		<form action="../regist" id="mailnumber" method="get">
			<div class="form-list form-main-list">
				<div class="form-group">
					<div class="form-item">
						<span class="form-label ts1">邮箱号</span>
						<div class="mailtext">
							<input id="mail" class="form-text mail-input err-input" autocomplete="off" name="mail" value="" placeholder="请输入你的邮箱" onblur='check("mail")'>
							<div id="mailCheck" class="checkdiv" hidden="true">请输入正确的qq邮箱</div>
						</div>
						
						<div style="height:20px;width:500px;"></div>
						<span class="form-label ts1">密&nbsp&nbsp&nbsp&nbsp码</span>
						<div class="mailtext">
							<input id="password" class="form-text mail-input err-input" name="password" value="" placeholder="请输入密码" type="password">
						</div>
						
					</div>
				</div>
				
				<!-- form-group -->
				<div class="form-group">
					<div class="form-item form-item-short">
                        <button type="submit" class="btn btn-large tsl btn-disabled" id="J_BtnMobileForm">注&nbsp&nbsp册</button>
                    </div>
				</div><!-- form-group -->
			</div>
		</form>
	</div>
	
</body>
</html>