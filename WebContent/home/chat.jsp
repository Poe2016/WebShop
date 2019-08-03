<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user = (String)session.getAttribute("onlineuser");
	if(user==null || user.equals("")){
		response.sendRedirect("passport.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%= request.getContextPath()%>/home/chatcss.css" rel="stylesheet" type="text/css">
<title>互撩</title>
<link rel="shortcut icon" href="imgs/favicon.ico"/>
</head>
<body>
	<div class="wrapper">
		<div class="im-content" style="margin-left: -600px; width: 1200px;">
			<div class="im-main-content">
				<!-- 左部分 -->
				<div class="im-left-sidebar">
					<div class="user-info"> 
				       <div class="info-lcol"> 
				        <div class="u-pic"> 
				                    <img alt="用户头像" src="//i.jd.com/commons/img/no-img_mid_.jpg" width="52" height="52"> 
				                            <a id="accountImg" href="//i.jd.com/user/userinfo/showImg.html" target="_blank">
				                   <div class="mask"></div> </a>
				                 </div>
				        <div class="info-m"> 
				         <div class="u-name"> 
				                      <a href="//me.jd.com" target="_blank">jd_501*****8375c</a> 
				                   </div>
				                  <div class="u-level">
				            <span class="rank">
				            <a href="//usergrade.jd.com/user/grade" target="_blank"><s></s></a><a href="//plus.jd.com/index" target="_blank"><i class="i0"></i></a></span>
				            </div>
				                 </div>
				       </div> 
				       <div class="u-search"> 
				        <a href="javascript:;" clstag="pageclick|keycount|w_web_201701061|1"></a> 
				        <input value="搜索最近联系人" onfocus="this.value='';" type="text"> 
				       </div> 
					</div><!-- user-info -->
					
					<div class="u-wrap" id="listDetails"> 
				    	<ul class="u-lst">
				    		<li appid="im.waiter" venderid="szsmsz" vendername="京东Apple产品旗舰店" title="京东Apple产品旗舰店" class="no-msg current" isccp="0" ccpflag="" ccphead="" isgetflag="200" pin="iPhone-xqkf-0116">
				    			<a href="javascript:;">
				    				<span class="icon icon_1"><em class="em em_2"></em></span>
			    					<div class="category">
			    						<span>京东Apple产品旗舰店</span>
			    						<em style="display: none;"></em>
			    					</div>
			    					<p class="tips">
				    					<span class="s02">16:42</span>
				    					<i class="i01"></i>
				    					<span class="s01">您好有什么可以帮您的吗</span>
				    				</p>
					    		</a>
					    	</li>
					    </ul> 
				    </div><!-- id="listDetails" -->
					
				</div><!-- class="im-left-sidebar" -->
				
				<!-- 右部分 -->
				<div id="im-middle" class="im-middle">
					<!-- 顶部店名 -->
					<div class="im-header im-chat-t"> 
				       <div class="im-shop">
				        <a href="#" class="enter"></a> 
				                  <h1><em class="em em_2"></em><span class="im-chat-object" id="logoTitle">京东Apple产品旗舰店</span><i class="shop-on"></i></h1> 
				                <p class="im-shop-des" id="logoDet">京东自营，国货</p> 
				       </div> 
				       <div class="im-ads">
				       </div> 
				    </div><!-- 店名结束 -->
				    
				    <!-- 中下部聊天显示框 -->
				    <div class="im-chat-window" style="margin-right: 340px;"> 
				       <!-- -- scrollDiv 消息渲染区域 -- --> 
				       <div class="im-chat-list" id="scrollDiv"> 
				        <div class="chat-more" id="clickMore">
				         <p class=""><span class="icon"></span><span class="txt">没有聊天纪录了</span></p>
				        </div> 
				       <div class="chat-txt chat-time" time="1525855328956"><p class="time">16:42</p></div><div class="chat-txt" time="1525855328956"><div class="chat-area customer"><p class="name">jd_501879918375c</p><div class="dialog"><i class="i_arr"></i><span class="e_tips"></span><span class="err" id="err_1525855328956" style="display: none;"></span><table cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="lt"></td><td class="tt"></td><td class="rt"></td></tr><tr><td class="lm"></td><td class="mm"><div class="cont"><div class="list p-list"><div class="list-li"><a class="list-li-a" href="//item.jd.com/5089237.html" target="_blank"><span class="list-tmb"><img src="//img10.360buyimg.com/n6/jfs/t7297/154/3413903491/65679/45ae4902/59e42830N9da56c41.jpg" width="60" height="60"></span><span class="list-txt"><span>商品编号：5089237</span><span>商品名称：Apple iPhone X (A1865) 256GB 银色 移动联通电信4G手机</span></span></a></div></div></div></td><td class="rm"></td></tr><tr><td class="lb"></td><td class="bm"></td><td class="rb"></td></tr></tbody></table></div></div></div><div class="chat-txt chat-tips " logictype="chat_create" data-rel="once-chat_create"><div class="chat-msg i-success"><i class="i-tips"></i><p class="cont">您好，<strong>京东Apple产品旗舰店</strong>客服很高兴为您服务！</p><div class="mask"><span class="tl"></span><span class="tr"></span><span class="bl"></span><span class="br"></span></div></div></div><div class="chat-txt chat-time" time="1525855333976"><p class="time">16:42</p></div><div class="chat-txt" time="1525855333976"><div class="chat-area service"><p class="name">京东Apple产品旗舰店</p><div class="dialog"><i class="i_arr"></i><span class="e_tips"></span><table cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="lt"></td><td class="tt"></td><td class="rt"></td></tr><tr><td class="lm"></td><td class="mm"><div class="cont">您好，请问今天是想选购一款我们最新的iPhone 吗？</div></td><td class="rm"></td></tr><tr><td class="lb"></td><td class="bm"></td><td class="rb"></td></tr></tbody></table></div></div></div><div class="chat-txt" time="1525855340140"><div class="chat-area service"><p class="name">京东Apple产品旗舰店</p><div class="dialog"><i class="i_arr"></i><span class="e_tips"></span><table cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="lt"></td><td class="tt"></td><td class="rt"></td></tr><tr><td class="lm"></td><td class="mm"><div class="cont">您好有什么可以帮您的吗</div></td><td class="rm"></td></tr><tr><td class="lb"></td><td class="bm"></td><td class="rb"></td></tr></tbody></table></div></div></div></div> 
				       <div class="im-edit-area"> 
				        <div class="im-edit-toolbar"> 
				         <p class="im-icon-out"> <a clstag="pageclick|keycount|w_web_201701061|24" href="javascript:;" class="rule" id="ruleBtn"> <i class="im-rule"></i> <span class="im-txt">怎么发截图？</span></a><a clstag="pageclick|keycount|w_web_201701061|3" href="javascript:;" class="face" title="选择表情" id="expressionButton"><i class="im-face"></i></a> <a clstag="pageclick|keycount|w_web_201701061|4" href="javascript:;" class="pic" title="贴图" style="position: relative; z-index: 1;"> <i class="im-pic" id="sendImageButton"></i> <form method="POST" id="fileForm" name="fileForm" enctype="multipart/form-data"><input accept="image/*" name="upFile" id="upFile" type="file"></form></a> <a href="javascript:;" class="bell" title="震客服一下" id="actionVibrationButton"><i class="im-bell"></i></a> <a clstag="pageclick|keycount|w_web_201701061|5" href="javascript:;" class="star" id="degreeButton"> <i class="im-star"></i> <span class="im-txt">满意度评价</span> </a> </p> 
				         <!-- 表情弹出层 --> 
				         <div class="im-pop-face" id="j_popFace" style="display:none"><table class="im-table-face" type="classic" style="display: table;" cellspacing="0" cellpadding="0"><tbody><tr><td><span id="_aixin_" class="im-face-item-classic" style="background-position:0 0"></span></td><td><span id="_anwei_" class="im-face-item-classic" style="background-position:-38px 0"></span></td><td><span id="_bishi_" class="im-face-item-classic" style="background-position:-75px 0"></span></td><td><span id="_daku_" class="im-face-item-classic" style="background-position:-114px 0"></span></td><td><span id="_deyi_" class="im-face-item-classic" style="background-position:-152px 0"></span></td><td><span id="_dangao_" class="im-face-item-classic" style="background-position:-190px 0"></span></td><td><span id="_feiwen_" class="im-face-item-classic" style="background-position:-228px 0"></span></td><td><span id="_fennu_" class="im-face-item-classic" style="background-position:-266px 0"></span></td><td><span id="_guzhang_" class="im-face-item-classic" style="background-position:-304px 0"></span></td><td><span id="_guilian_" class="im-face-item-classic" style="background-position:-342px 0"></span></td><td><span id="_haixiu_" class="im-face-item-classic" style="background-position:-380px 0"></span></td><td><span id="_liuhan_" class="im-face-item-classic" style="background-position:-418px 0"></span></td></tr><tr><td><span id="_heixian_" class="im-face-item-classic" style="background-position:0 -37px"></span></td><td><span id="_aoman_" class="im-face-item-classic" style="background-position:-38px -37px"></span></td><td><span id="_jianxiao_" class="im-face-item-classic" style="background-position:-75px -37px"></span></td><td><span id="_jingya_" class="im-face-item-classic" style="background-position:-114px -37px"></span></td><td><span id="_kelian_" class="im-face-item-classic" style="background-position:-152px -37px"></span></td><td><span id="_kuku_" class="im-face-item-classic" style="background-position:-190px -37px"></span></td><td><span id="_liwu_" class="im-face-item-classic" style="background-position:-228px -37px"></span></td><td><span id="_hanxiao_" class="im-face-item-classic" style="background-position:-266px -37px"></span></td><td><span id="_huaduo_" class="im-face-item-classic" style="background-position:-304px -37px"></span></td><td><span id="_xiangwen_" class="im-face-item-classic" style="background-position:-342px -37px"></span></td><td><span id="_sese_" class="im-face-item-classic" style="background-position:-380px -37px"></span></td><td><span id="_shengbing_" class="im-face-item-classic" style="background-position:-418px -37px"></span></td></tr><tr><td><span id="_shuaiyang_" class="im-face-item-classic" style="background-position:0 -76px"></span></td><td><span id="_keshui_" class="im-face-item-classic" style="background-position:-38px -76px"></span></td><td><span id="_tanqi_" class="im-face-item-classic" style="background-position:-75px -76px"></span></td><td><span id="_touxiao_" class="im-face-item-classic" style="background-position:-114px -76px"></span></td><td><span id="_outu_" class="im-face-item-classic" style="background-position:-152px -76px"></span></td><td><span id="_tiaopi_" class="im-face-item-classic" style="background-position:-190px -76px"></span></td><td><span id="_weixiao_" class="im-face-item-classic" style="background-position:-228px -76px"></span></td><td><span id="_beishang_" class="im-face-item-classic" style="background-position:-266px -76px"></span></td><td><span id="_woshou_" class="im-face-item-classic" style="background-position:-304px -76px"></span></td><td><span id="_wenhao_" class="im-face-item-classic" style="background-position:-342px -76px"></span></td><td><span id="_yinxian_" class="im-face-item-classic" style="background-position:-380px -76px"></span></td><td><span id="_yongbao_" class="im-face-item-classic" style="background-position:-418px -76px"></span></td></tr><tr><td><span id="_xuanyun_" class="im-face-item-classic" style="background-position:0 -114px"></span></td><td><span id="_baibai_" class="im-face-item-classic" style="background-position:-38px -114px"></span></td><td><span id="_henbang_" class="im-face-item-classic" style="background-position:-75px -114px"></span></td><td><span id="_zhuakuang_" class="im-face-item-classic" style="background-position:-114px -114px"></span></td><td><span id="_baiyan_" class="im-face-item-classic" style="background-position:-152px -114px"></span></td><td><span id="_bizui_" class="im-face-item-classic" style="background-position:-190px -114px"></span></td><td><span id="_dabing_" class="im-face-item-classic" style="background-position:-228px -114px"></span></td><td><span id="_dengpao_" class="im-face-item-classic" style="background-position:-266px -114px"></span></td><td><span id="_dianhua_" class="im-face-item-classic" style="background-position:-304px -114px"></span></td><td><span id="_fadai_" class="im-face-item-classic" style="background-position:-342px -114px"></span></td><td><span id="_fankun_" class="im-face-item-classic" style="background-position:-380px -114px"></span></td><td><span id="_feiniao_" class="im-face-item-classic" style="background-position:-418px -114px"></span></td></tr><tr><td><span id="_fendou_" class="im-face-item-classic" style="background-position:0 -152px"></span></td><td><span id="_fengkuang_" class="im-face-item-classic" style="background-position:-38px -152px"></span></td><td><span id="_ganga_" class="im-face-item-classic" style="background-position:-75px -152px"></span></td><td><span id="_gaoxing_" class="im-face-item-classic" style="background-position:-114px -152px"></span></td><td><span id="_jida_" class="im-face-item-classic" style="background-position:-152px -152px"></span></td><td><span id="_jie_" class="im-face-item-classic" style="background-position:-190px -152px"></span></td><td><span id="_jingkong_" class="im-face-item-classic" style="background-position:-228px -152px"></span></td><td><span id="_kafei_" class="im-face-item-classic" style="background-position:-266px -152px"></span></td><td><span id="_keai_" class="im-face-item-classic" style="background-position:-304px -152px"></span></td><td><span id="_kele_" class="im-face-item-classic" style="background-position:-342px -152px"></span></td><td><span id="_kouzhao_" class="im-face-item-classic" style="background-position:-380px -152px"></span></td><td><span id="_kulou_" class="im-face-item-classic" style="background-position:-418px -152px"></span></td></tr><tr><td><span id="_liulei_" class="im-face-item-classic" style="background-position:0 -189px"></span></td><td><span id="_mifan_" class="im-face-item-classic" style="background-position:-38px -189px"></span></td><td><span id="_ningmeng_" class="im-face-item-classic" style="background-position:-75px -189px"></span></td><td><span id="_nuhuo_" class="im-face-item-classic" style="background-position:-114px -189px"></span></td><td><span id="_peizui_" class="im-face-item-classic" style="background-position:-152px -189px"></span></td><td><span id="_shengli_" class="im-face-item-classic" style="background-position:-190px -189px"></span></td><td><span id="_shijian_" class="im-face-item-classic" style="background-position:-228px -189px"></span></td><td><span id="_taiyang_" class="im-face-item-classic" style="background-position:-266px -189px"></span></td><td><span id="_zhouma_" class="im-face-item-classic" style="background-position:-304px -189px"></span></td><td><span id="_zhuzhu_" class="im-face-item-classic" style="background-position:-342px -189px"></span></td><td><span id="_zuqiu_" class="im-face-item-classic" style="background-position:-380px -189px"></span></td><td><span id="_zhenjing_" class="im-face-item-classic" style="background-position:-418px -189px"></span></td></tr></tbody></table><table class="im-table-face" type="dongdong" style="display: none;" cellspacing="0" cellpadding="0"><tbody><tr><td><span id="_b01_" class="im-face-item-dongdong" style="background-position:0 0"></span></td><td><span id="_b02_" class="im-face-item-dongdong" style="background-position:-76px 0"></span></td><td><span id="_b03_" class="im-face-item-dongdong" style="background-position:-156px 0"></span></td><td><span id="_b04_" class="im-face-item-dongdong" style="background-position:-235px 0"></span></td><td><span id="_b05_" class="im-face-item-dongdong" style="background-position:-313px 0"></span></td><td><span id="_b06_" class="im-face-item-dongdong" style="background-position:-393px -1px"></span></td></tr><tr><td><span id="_b07_" class="im-face-item-dongdong" style="background-position:0 -79px"></span></td><td><span id="_b08_" class="im-face-item-dongdong" style="background-position:-76px -79px"></span></td><td><span id="_b09_" class="im-face-item-dongdong" style="background-position:-156px -79px"></span></td><td><span id="_b10_" class="im-face-item-dongdong" style="background-position:-235px -79px"></span></td><td><span id="_b11_" class="im-face-item-dongdong" style="background-position:-313px -79px"></span></td><td><span id="_b12_" class="im-face-item-dongdong" style="background-position:-393px -79px"></span></td></tr><tr><td><span id="_b13_" class="im-face-item-dongdong" style="background-position:0 -160px"></span></td><td><span id="_b14_" class="im-face-item-dongdong" style="background-position:-76px -160px"></span></td><td><span id="_b15_" class="im-face-item-dongdong" style="background-position:-156px -160px"></span></td><td><span id="_b16_" class="im-face-item-dongdong" style="background-position:-235px -160px"></span></td></tr></tbody></table><div id="__view_div__" style="display:none;"></div><div class="im-face-tab"><a href="javascript:void(0)" class="im-face-switch-tab current" type="classic">经典</a><a href="javascript:void(0)" class="im-face-switch-tab" type="dongdong">咚咚</a></div></div> 
				         <div class="im-pop-recommend j_recommend" style="display:none;"></div>
				        <div class="im-pop-rule"><div class="sub"><div class="close"><a href="javascript:;"></a></div><p>将您已截好的图片直接粘贴至输入框中即可（说明：目前暂不支持IE浏览器）</p></div></div></div> 
				        <div class="im-edit-ipt-area"> 
				         <div id="text_in" class="im-edit-ipt" style="overflow-y: auto; font-weight: normal; font-size: 12px; overflow-x: hidden; word-break: break-all; font-style: normal; outline: none;" hidefocus="true" tabindex="0" contenteditable="true"></div> 
				        </div> 
				        <!--  <div class="im-edit-btn-area im-edit-btn-no"> --> 
				        <div class="im-edit-btn-area"> 
				         <div class="im-link-area"></div> 
				         <div class="im-btn-send-area" title="按Enter键发送,按Ctrl+Enter键换行"> 
				          <a href="javascript:;" class="im-btn im-btn-send" id="sendMsg"> <span class="im-txt">发送</span> <span class="im-btn-l"></span> </a> 
				          <a href="javascript:;" class="im-btn im-btn-send-set" title="发送设置" id="change"> <i class="im-icon-arrow-down"></i> <span class="im-btn-r"></span> </a> 
				          <!-- 编辑发送浮层 --> 
				          <div class="im-pop-send-set cbut" style="position: absolute; top: 0; right: -250px;display:none;"> 
				           <ul class="im-send-set-list"> 
				            <!-- 当前高亮加class current --> 
				            <li class="im-item current" id="hotkey1"> <a href="javascript:;" class="im-item-content"> <i class="im-icon-right"></i> <span class="im-txt">按Enter键发送消息，Ctrl+Enter换行</span> </a> </li> 
				            <li class="im-item" id="hotkey2"> <a href="javascript:;" class="im-item-content"> <i class="im-icon-right"></i> <span class="im-txt">按Ctrl+Enter键发送消息，Enter换行</span> </a> </li> 
				           </ul> 
				          </div> 
				         </div> 
				         <a href="javascript:;" class="im-btn im-btn-close" id="talk_c"> <span class="im-txt">结束对话</span> <span class="im-btn-l"></span> <span class="im-btn-r"></span> </a> 
				         <div class="im-edit-tip" id="chat_count">
				          还可以输入
				          <span class="im-word-num">360</span>字
				         </div> 
				        </div> 
				       <div class="im-star-tips" id="star_tips" style="display: none;"><div class="sub"><div class="close"><a clstag="pageclick|keycount|w_web_201701061|12" href="javascript:;"></a></div><p>聊完记得给客服MM一个评价哟</p></div></div></div> 
				      </div><!-- 中下部聊天显示框结束 -->
				
					<!-- 右部最近浏览 -->
					<div class="im-right-sidebar" style="width: 339px;">
						<ul class="im-tab">
							<li class="im-item current"><div class="im-item-content">正在咨询</div></li>
							<li class="im-item"><div class="im-item-content">常见问题</div></li>
						</ul>
						<div class="im-tab-contents">
							<div class="im-tab-content im-my-asking im-show">
								<ul class="im-list01 im-list02 im-list-pinfo">
									<li>
										<div class="sub">
											<div class="pic"><img src=""></div>
											<div class="txt">
												<p class="name">Apple iPhone X (A1865) 256GB 银色 移动联通电信4G手机</p>
												<p class="price">¥9605.00</p>
											</div>
										</div>
										<div class="btn">
											<a name="Apple iPhone X (A1865) 256GB 银色 移动联通电信4G手机" src="//img10.360buyimg.com/n6/jfs/t7297/154/3413903491/65679/45ae4902/59e42830N9da56c41.jpg" href="javascript:;" class="btn-1 J_pid_send">发送</a>
										</div>
									</li>
								</ul>
								<div class="im-list-out">
									<ul class="im-tab">
										<li class="im-item lastviews current"><i ></i><div class="im-item-s">最近浏览</div></li>
										<li class="im-item advise" style="display: none;"><i></i><div class="im-item-s">店铺推荐</div></li>
									</ul>
									<div class="im-tab-contents im-tab-list">
										<div class="im-tab-content ask-lastviews im-show" style="height: 290px;">
											<ul class="im-list01 im-list02">
												<li>
													<div class="sub">
														<div class="pic">
															<a href="" target="_blank"><img src=""></a>
														</div>
														<div class="txt">
															<p class="name"><a href="" target="_blank">Apple iPhone X (A1865) 256GB 银色 移动联通电信4G手机</a></p>
															<p class="price">¥9605.00</p>
														</div>
													</div>
												</li>
											</ul>
											<div class="comonMore">
												<p><span class="icon"></span><span class="txt">点击加载更多</span></p>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 最近浏览结束 -->
				</div><!-- id="im-middle" -->
			</div><!-- class="im-main-content" -->
		</div><!-- class="im-content" -->
	</div><!-- class="wrapper" -->

</body>
</html>