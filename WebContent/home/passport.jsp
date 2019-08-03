<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<base target="_parent">
<title>账号登录</title>
<link rel="shortcut icon" href="imgs/favicon.ico"/>
<link href="passport.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="w">
    	<div>	
    		<a id="logo" href="http://localhost:8080/WebShop/" >
    			<img alt="商城首页" src="imgs/logo.jpg" style="width:300px;height:70px;">
    		</a>
    	</div>
	</div><!-- w -->
	<div id="content">
		
		<div class="tips-wrapper">
			<div class="tips-inner">
				<div class="cont-wrapper">
					
					
				</div>
			</div>
		</div>
		
		
		<div class="login-wrap">
			<div class="w">
            	<div class="login-form">
            		<div class="tips-wrapper">
            			<div class="tips-inner">
            				<div class="cont-wrapper">
            					<i class="icon-tips"></i>
            					<p>SpecialShop不会以任何理由要求您转账汇款。</p>
            				</div>
            			</div>
            		</div><!-- tips-wrapper -->
	                
	                
	                <div class="login-tab login-tab-l">
	                    <a  class=""> </a>
	                </div>
	                
	                
	                <div class="login-tab login-tab-r">
	                    <a href="javascript:void(0)" class="checked">账户登录</a>
	                </div>
	                
	                
	                <div class="login-box" style="display: block; visibility: visible;">
		                    <div class="mt tab-h">
		                    	::after
		                    </div>
		                    <div class="msg-wrap">
								<div class="msg-error hide"><b></b></div>
		                    </div>
		                    <div class="mc">
		                        <div class="form">
		                            <form id="formlogin" method="post" action="../loginAction">
		                                <input id="sa_token" name="sa_token" value="" type="hidden">
										<input id="uuid" name="uuid" value="" type="hidden">
		                                <input name="eid" id="eid" value="" class="hide" type="hidden">
		                                <input name="fp" id="sessionId" value="" class="hide" type="hidden">
		                                <input name="_t" id="token" value="_t" class="hide" type="hidden">
		                                <input name="loginType" id="loginType" value="c" class="hide" type="hidden">
		                                <input name="pubKey" id="pubKey" value="" class="hide" type="hidden">
		                                <input name="awDFDUkiSt" value="sFEGh" type="hidden">
		                                
		                                <div class="item item-fore1">
		                                    <label for="loginname" class="login-label name-label"></label>
		                                    <input id="loginname" class="itxt" name="loginname" tabindex="1"  placeholder="邮箱" type="text">
		                                    <span class="clear-btn" style="display: none;"></span>
		                                </div>
										
										<div id="entry" class="item item-fore2" style="visibility: visible;">
											<label class="login-label pwd-label" for="nloginpwd"></label>
											<input id="nloginpwd" name="nloginpwd" class="itxt itxt-error" tabindex="2"  placeholder="密码" type="password">
											<span class="clear-btn"></span>
											<span class="capslock" style="display: none;">
												<b></b>
												大小写锁定已打开
											</span>
										</div>
										
										<div class="item item-fore4">
											<div class="safe">
												<span>
												</span>
		                                 	</div>
		                                </div>
										
		                                <div class="item item-fore5">
		                                    <div class="login-btn">
		                                    	<button class="btn-img btn-entry" id="loginsubmit" tabindex="6">登&nbsp;&nbsp;&nbsp;&nbsp;录</button>
		                                    </div>
		                                </div>
		                            </form>
		                        </div>
		                        
		                    </div>
	                </div>
					
					<div class="coagent" id="kbCoagent">
	                    <ul>
	                        <li class="extra-r">
	                            <div>
	                                <div class="regist-link">
	                                	<a href="http://localhost:8080/WebShop/home/regist.jsp" clstag="pageclick|keycount|201607144|8" target="_blank">
	                                		<b></b>
	                                		立即注册
	                                	</a>
	                                </div>
	                            </div>
	                        </li>
	                    </ul>
	                </div>            
	              </div><!-- login-form -->
        </div><!-- w -->
        <div class="login-banner" style="background-color: #e93854">
        	<div class="w">			         
        		<div id="banner-bg" class="i-inner" ></div>		              
        	</div>		           
        </div>
    </div><!-- login-wrap -->
		
		
		
	</div><!-- content -->
</body>
</html>