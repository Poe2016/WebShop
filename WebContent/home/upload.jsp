<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.util.Good"%>
<%
	String mail = (String) session.getAttribute("onlineuser");
	if (mail == null) {//未登录状态
		session.setAttribute("loginstate", "upload");//上传商品前的登录
		response.sendRedirect("passport.jsp");
	} else {//已登录状态
				//cart = (ShopCart)session.getAttribute("cart");
			//if(cart!=null){
			//	total = cart.getTotal();
			//}
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传商品</title>
<link rel="shortcut icon" href="imgs/favicon.ico"/>
<link href="<%=request.getContextPath()%>/home/uploadcss.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript" src="js.js"></script>
</head>
<body>

	<ys-navigation ng-show="initDone" class="">
	<div class="fw-main-navigation">
		<div class="fw-main-navigation-slide fw-transition-quick ">
			<div class="fw-main-navigation-slide-main">
				<div ng-repeat="part in data.navList"
					class="fw-main-navigation-part ng-scope">
					<ys-navigationlink ng-repeat="nav in part" data="nav"
						click-link="fClickLink($event, nav)"
						class="ng-scope ng-isolate-scope"> <a
						class="fw-main-navigation-link1 ng-binding"
						ng-class="{selected: data.selected}" href="../"
						ng-click="clickLink({nav: data, $event: $event})"> <span
						class="ico ico-data " type="data"></span>商城首页
					</a> </ys-navigationlink>
					<!-- end ngRepeat: nav in part -->
					<span class="fw-main-navigation-split" ng-hide="$last"> </span>
				</div>
				<!-- end ngRepeat: part in data.navList -->
				<div ng-repeat="part in data.navList"
					class="fw-main-navigation-part ng-scope">
					<ys-navigationlink ng-repeat="nav in part" data="nav"
						click-link="fClickLink($event, nav)"
						class="ng-scope ng-isolate-scope"> <a
						class="fw-main-navigation-link1 ng-binding"
						ng-class="{selected: data.selected}" href="myStore.jsp"
						ng-click="clickLink({nav: data, $event: $event})"> <span
						class="ico ico-trade " type="trade"></span>卖家中心首页 <ys-navigation-link-notification
							ng-if="data.notification" data-type="order"
							class="ng-scope ng-isolate-scope">
						<a class="fw-main-navigation-link-notify " title="0笔待处理订单"
							ng-style="notifystyle" href="#/order?pending=true"
							ng-bind="notifytext" onclick="event.stopPropagation();"
							style="display: none;">0 </a> </ys-navigation-link-notification>
					</a> </ys-navigationlink>
					<!-- end ngRepeat: nav in part -->
					<ys-navigationlink ng-repeat="nav in part" data="nav"
						click-link="fClickLink($event, nav)"
						class="ng-scope ng-isolate-scope"> <a
						class="fw-main-navigation-link1 ng-binding selected"
						ng-class="{selected: data.selected}" href="upload.jsp"
						ng-click="clickLink({nav: data, $event: $event})"> <span
						class="ico ico-product " type="product"></span>增加商品 <!-- ngIf: data.type === 'group' -->
						<!-- ngIf: data.notification -->
					</a> </ys-navigationlink>
					<!-- end ngRepeat: nav in part -->
					<ys-navigationlink ng-repeat="nav in part" data="nav"
						click-link="fClickLink($event, nav)"
						class="ng-scope ng-isolate-scope"> <a
						class="fw-main-navigation-link1 ng-binding"
						ng-class="{selected: data.selected}" href="buyer_order.jsp"
						ng-click="clickLink({nav: data, $event: $event})"> <span
						class="ico ico-customer " type="customer"></span>我的订单(买) <!-- ngIf: data.type === 'group' -->
						<!-- ngIf: data.notification -->
					</a> </ys-navigationlink>
					<!-- end ngRepeat: nav in part -->
					<span class="fw-main-navigation-split" ng-hide="$last"></span>
				</div>
				<!-- end ngRepeat: part in data.navList -->
				<div ng-repeat="part in data.navList"
					class="fw-main-navigation-part ng-scope">
					<!-- ngRepeat: nav in part -->
					<ys-navigationlink ng-repeat="nav in part" data="nav"
						click-link="fClickLink($event, nav)"
						class="ng-scope ng-isolate-scope"> <a
						class="fw-main-navigation-link1 ng-binding"
						ng-class="{selected: data.selected}" href="payed_order.jsp"
						ng-click="clickLink({nav: data, $event: $event})"> <span
						class="ico ico-promotion2 " type="promotion2"></span>待收货 <!-- ngIf: data.type === 'group' -->
						<!-- ngIf: data.notification -->
					</a> </ys-navigationlink>
					<!-- end ngRepeat: nav in part -->
					<ys-navigationlink ng-repeat="nav in part" data="nav"
						click-link="fClickLink($event, nav)"
						class="ng-scope ng-isolate-scope"> <a
						class="fw-main-navigation-link1 ng-binding"
						ng-class="{selected: data.selected}" href="history_order.jsp"
						ng-click="clickLink({nav: data, $event: $event})"> <span
						class="ico ico-coupon " type="coupon"></span>历史订单 <!-- ngIf: data.type === 'group' -->
						<!-- ngIf: data.notification -->
					</a> </ys-navigationlink>
					<!-- end ngRepeat: nav in part -->
					<span class="fw-main-navigation-split" ng-hide="$last"></span>
				</div>
				<!-- end ngRepeat: part in data.navList -->
				<div ng-repeat="part in data.navList"
					class="fw-main-navigation-part ng-scope">
					<!-- ngRepeat: nav in part -->
					<ys-navigationlink ng-repeat="nav in part" data="nav"
						click-link="fClickLink($event, nav)"
						class="ng-scope ng-isolate-scope"> <a
						class="fw-main-navigation-link1 ng-binding"
						ng-class="{selected: data.selected}" href="evaluate_add.jsp"
						ng-click="clickLink({nav: data, $event: $event})"> <span
						class="ico ico-nav " type="nav"></span>评价晒单 <!-- ngIf: data.type === 'group' -->
						<!-- ngIf: data.notification -->
					</a> </ys-navigationlink>
					<!-- end ngRepeat: nav in part -->
					<ys-navigationlink ng-repeat="nav in part" data="nav"
						click-link="fClickLink($event, nav)"
						class="ng-scope ng-isolate-scope"> <a
						class="fw-main-navigation-link1 ng-binding"
						ng-class="{selected: data.selected}" href="caregood.jsp"
						ng-click="clickLink({nav: data, $event: $event})"> <span
						class="ico ico-theme " type="theme"></span>关注的商品 <!-- ngIf: data.type === 'group' -->
						<!-- ngIf: data.notification --> <ys-navigation-link-notification
							ng-if="data.notification" data-type="theme"
							class="ng-scope ng-isolate-scope">
						<a
							class="fw-main-navigation-link-notify fw-main-navigation-link-notify-ico"
							title="" ng-style="notifystyle" href="#/theme"
							ng-bind="notifytext" onclick="event.stopPropagation();"
							style="display: none;"> </a> </ys-navigation-link-notification> <!-- end ngIf: data.notification -->
					</a> </ys-navigationlink>
					<!-- end ngRepeat: nav in part -->
					<ys-navigationlink ng-repeat="nav in part" data="nav"
						click-link="fClickLink($event, nav)"
						class="ng-scope ng-isolate-scope"> <a
						class="fw-main-navigation-link1 ng-binding"
						ng-class="{selected: data.selected}" href="caresaler.jsp"
						ng-click="clickLink({nav: data, $event: $event})"> <span
						class="ico ico-page " type="page"></span>关注的店铺<!-- ngIf: data.type === 'group' -->
						<!-- ngIf: data.notification -->
					</a> </ys-navigationlink>
					<!-- end ngRepeat: nav in part -->
					<span class="fw-main-navigation-split" ng-hide="$last"></span>
				</div>
				<!-- end ngRepeat: part in data.navList -->
				<div ng-repeat="part in data.navList"
					class="fw-main-navigation-part ng-scope">
					<!-- ngRepeat: nav in part -->
					<ys-navigationlink ng-repeat="nav in part" data="nav"
						click-link="fClickLink($event, nav)"
						class="ng-scope ng-isolate-scope"> <a
						class="fw-main-navigation-link1 ng-binding"
						ng-class="{selected: data.selected}" href="history.jsp"
						ng-click="clickLink({nav: data, $event: $event})"> <span
						class="ico ico-apps " type="apps"></span>浏览历史 <!-- ngIf: data.type === 'group' -->
						<!-- ngIf: data.notification -->
					</a> </ys-navigationlink>
					<!-- end ngRepeat: nav in part -->
					<ys-navigationlink ng-repeat="nav in part" data="nav"
						click-link="fClickLink($event, nav)"
						class="ng-scope ng-isolate-scope"> <a
						class="fw-main-navigation-link1 ng-binding"
						ng-class="{selected: data.selected}" href="send_pre_order.jsp"
						ng-click="clickLink({nav: data, $event: $event})"> <span
						class="ico ico-yeeshare " type="yeeshare"></span>待发货订单 <!-- ngIf: data.type === 'group' -->
						<!-- ngIf: data.notification -->
					</a> </ys-navigationlink>
					<!-- end ngRepeat: nav in part -->
					<span class="fw-main-navigation-split" ng-hide="$last"></span>
				</div>
				<!-- end ngRepeat: part in data.navList -->
				<div ng-repeat="part in data.navList"
					class="fw-main-navigation-part ng-scope">
					<!-- ngRepeat: nav in part -->
					<ys-navigationlink ng-repeat="nav in part" data="nav"
						click-link="fClickLink($event, nav)"
						class="ng-scope ng-isolate-scope"> <a
						class="fw-main-navigation-link1 ng-binding"
						ng-class="{selected: data.selected}" href="send_after_order.jsp"
						ng-click="clickLink({nav: data, $event: $event})"> <span
						class="ico ico-cashier " type="cashier"></span>已发货订单<!-- ngIf: data.type === 'group' -->
						<!-- ngIf: data.notification --></a></ys-navigationlink>
					<!-- end ngRepeat: nav in part -->
					<span class="fw-main-navigation-split" ng-hide="$last"></span>
				</div>
				<!-- end ngRepeat: part in data.navList -->
				<div ng-repeat="part in data.navList"
					class="fw-main-navigation-part ng-scope">
					<!-- ngRepeat: nav in part -->
					<ys-navigationlink ng-repeat="nav in part" data="nav"
						click-link="fClickLink($event, nav)"
						class="ng-scope ng-isolate-scope"> <a
						class="fw-main-navigation-link1 ng-binding"
						ng-class="{selected: data.selected}" href="send_received_order.jsp"
						ng-click="clickLink({nav: data, $event: $event})"><span
						class="ico ico-resource " type="resource"></span>已收或订单<!-- ngIf: data.type === 'group' -->
						<span class="ico ico-menuexpand " type="menuexpand"
						ng-if="data.type === 'group'"></span> <!-- end ngIf: data.type === 'group' -->
						<!-- ngIf: data.notification --></a></ys-navigationlink>
					<!-- end ngRepeat: nav in part -->
					<ys-navigationlink ng-repeat="nav in part" data="nav"
						click-link="fClickLink($event, nav)"
						class="ng-scope ng-isolate-scope"> <a
						class="fw-main-navigation-link1 ng-binding"
						ng-class="{selected: data.selected}" href="mygoods.jsp"
						ng-click="clickLink({nav: data, $event: $event})"><span
						class="ico ico-content " type="content"></span>我上传的商品<!-- ngIf: data.type === 'group' -->
						<span class="ico ico-menuexpand " type="menuexpand"
						ng-if="data.type === 'group'"></span> <!-- end ngIf: data.type === 'group' -->
						<!-- ngIf: data.notification --></a></ys-navigationlink>
					<!-- end ngRepeat: nav in part -->
					<ys-navigationlink ng-repeat="nav in part" data="nav"
						click-link="fClickLink($event, nav)"
						class="ng-scope ng-isolate-scope"> <a
						class="fw-main-navigation-link1 ng-binding"
						ng-class="{selected: data.selected}" href="personalinfo.jsp"
						ng-click="clickLink({nav: data, $event: $event})"><span
						class="ico ico-setting " type="setting"></span>个人信息<!-- ngIf: data.type === 'group' -->
						<span class="ico ico-menuexpand " type="menuexpand"
						ng-if="data.type === 'group'"></span> <!-- end ngIf: data.type === 'group' -->
						<!-- ngIf: data.notification --></a></ys-navigationlink>
					<!-- end ngRepeat: nav in part -->
					<span class="fw-main-navigation-split ng-hide" ng-hide="$last"></span>
				</div>
				<!-- end ngRepeat: part in data.navList -->
			</div>
			<!-- ngRepeat: subNavList in data.subNavLists -->
			<div class="fw-main-navigation-slide-sub ng-scope ng-hide"
				ng-repeat="subNavList in data.subNavLists"
				ng-show="data.currentGroup === subNavList.group.name">
				<a
					class="fw-main-navigation-link1 fw-main-navigation-link1-unexpand ysNavigationlink"
					href="javascript:void(0);" ng-click="fUnExpand();"><span
					class="ico ico-back " type="back"></span>返回</a><span
					class="fw-main-navigation-split"></span>
				<div class="fw-main-navigation-slide-sub-title ng-binding">资源管理</div>
				<!-- ngRepeat: nav in subNavList.sub -->
				<ys-navigationlink ng-repeat="nav in subNavList.sub" data="nav"
					click-link="fClickLink($event, nav)"
					class="ng-scope ng-isolate-scope"> <a
					class="fw-main-navigation-link1 ng-binding"
					ng-class="{selected: data.selected}" href="#/imgmanager"
					ng-click="clickLink({nav: data, $event: $event})"><span
					class="ico ico-imgmgr " type="imgmgr"></span>图片管理<!-- ngIf: data.type === 'group' -->
					<!-- ngIf: data.notification --></a></ys-navigationlink>
				<!-- end ngRepeat: nav in subNavList.sub -->
				<ys-navigationlink ng-repeat="nav in subNavList.sub" data="nav"
					click-link="fClickLink($event, nav)"
					class="ng-scope ng-isolate-scope"> <a
					class="fw-main-navigation-link1 ng-binding"
					ng-class="{selected: data.selected}" href="#/filemanager"
					ng-click="clickLink({nav: data, $event: $event})"><span
					class="ico ico-filemgr " type="filemgr"></span>文件管理<!-- ngIf: data.type === 'group' -->
					<!-- ngIf: data.notification --></a></ys-navigationlink>
				<!-- end ngRepeat: nav in subNavList.sub -->
				<ys-navigationlink ng-repeat="nav in subNavList.sub" data="nav"
					click-link="fClickLink($event, nav)"
					class="ng-scope ng-isolate-scope"> <a
					class="fw-main-navigation-link1 ng-binding"
					ng-class="{selected: data.selected}" href="#/multimedia"
					ng-click="clickLink({nav: data, $event: $event})"><span
					class="ico ico-multimedia " type="multimedia"></span>多媒体管理<!-- ngIf: data.type === 'group' -->
					<!-- ngIf: data.notification --></a></ys-navigationlink>
				<!-- end ngRepeat: nav in subNavList.sub -->
			</div>
			<!-- end ngRepeat: subNavList in data.subNavLists -->
			<div class="fw-main-navigation-slide-sub ng-scope ng-hide"
				ng-repeat="subNavList in data.subNavLists"
				ng-show="data.currentGroup === subNavList.group.name">
				<a
					class="fw-main-navigation-link1 fw-main-navigation-link1-unexpand ysNavigationlink"
					href="javascript:void(0);" ng-click="fUnExpand();"><span
					class="ico ico-back " type="back"></span>返回</a><span
					class="fw-main-navigation-split"></span>
				<div class="fw-main-navigation-slide-sub-title ng-binding">内容管理</div>
				<!-- ngRepeat: nav in subNavList.sub -->
				<ys-navigationlink ng-repeat="nav in subNavList.sub" data="nav"
					click-link="fClickLink($event, nav)"
					class="ng-scope ng-isolate-scope"> <a
					class="fw-main-navigation-link1 ng-binding"
					ng-class="{selected: data.selected}" href="#/post"
					ng-click="clickLink({nav: data, $event: $event})"><span
					class="ico ico-post " type="post"></span>文章管理<!-- ngIf: data.type === 'group' -->
					<!-- ngIf: data.notification --></a></ys-navigationlink>
				<!-- end ngRepeat: nav in subNavList.sub -->
				<ys-navigationlink ng-repeat="nav in subNavList.sub" data="nav"
					click-link="fClickLink($event, nav)"
					class="ng-scope ng-isolate-scope"> <a
					class="fw-main-navigation-link1 ng-binding"
					ng-class="{selected: data.selected}" href="#/blog"
					ng-click="clickLink({nav: data, $event: $event})"><span
					class="ico ico-blog " type="blog"></span>轻博客<!-- ngIf: data.type === 'group' -->
					<!-- ngIf: data.notification --></a></ys-navigationlink>
				<!-- end ngRepeat: nav in subNavList.sub -->
			</div>
			<!-- end ngRepeat: subNavList in data.subNavLists -->
			<div class="fw-main-navigation-slide-sub ng-scope ng-hide"
				ng-repeat="subNavList in data.subNavLists"
				ng-show="data.currentGroup === subNavList.group.name">
				<a
					class="fw-main-navigation-link1 fw-main-navigation-link1-unexpand ysNavigationlink"
					href="javascript:void(0);" ng-click="fUnExpand();"><span
					class="ico ico-back " type="back"></span>返回</a><span
					class="fw-main-navigation-split"></span>
				<div class="fw-main-navigation-slide-sub-title ng-binding">相关设置</div>
				<!-- ngRepeat: nav in subNavList.sub -->
				<ys-navigationlink ng-repeat="nav in subNavList.sub" data="nav"
					click-link="fClickLink($event, nav)"
					class="ng-scope ng-isolate-scope"> <a
					class="fw-main-navigation-link1 ng-binding"
					ng-class="{selected: data.selected}" href="#/setting"
					ng-click="clickLink({nav: data, $event: $event})"><span
					class="ico ico-basesetting " type="basesetting"></span>网站设置<!-- ngIf: data.type === 'group' -->
					<!-- ngIf: data.notification --></a></ys-navigationlink>
				<!-- end ngRepeat: nav in subNavList.sub -->
				<ys-navigationlink ng-repeat="nav in subNavList.sub" data="nav"
					click-link="fClickLink($event, nav)"
					class="ng-scope ng-isolate-scope"> <a
					class="fw-main-navigation-link1 ng-binding"
					ng-class="{selected: data.selected}" href="#/domain"
					ng-click="clickLink({nav: data, $event: $event})"><span
					class="ico ico-domain " type="domain"></span>域名设置<!-- ngIf: data.type === 'group' -->
					<!-- ngIf: data.notification --></a></ys-navigationlink>
				<!-- end ngRepeat: nav in subNavList.sub -->
				<ys-navigationlink ng-repeat="nav in subNavList.sub" data="nav"
					click-link="fClickLink($event, nav)"
					class="ng-scope ng-isolate-scope"> <a
					class="fw-main-navigation-link1 ng-binding"
					ng-class="{selected: data.selected}" href="#/payment"
					ng-click="clickLink({nav: data, $event: $event})"><span
					class="ico ico-payment " type="payment"></span>收款方式<!-- ngIf: data.type === 'group' -->
					<!-- ngIf: data.notification --></a></ys-navigationlink>
				<!-- end ngRepeat: nav in subNavList.sub -->
				<ys-navigationlink ng-repeat="nav in subNavList.sub" data="nav"
					click-link="fClickLink($event, nav)"
					class="ng-scope ng-isolate-scope"> <a
					class="fw-main-navigation-link1 ng-binding"
					ng-class="{selected: data.selected}" href="#/shipment"
					ng-click="clickLink({nav: data, $event: $event})"><span
					class="ico ico-shipment " type="shipment"></span>运费模板<!-- ngIf: data.type === 'group' -->
					<!-- ngIf: data.notification --></a></ys-navigationlink>
				<!-- end ngRepeat: nav in subNavList.sub -->
				<ys-navigationlink ng-repeat="nav in subNavList.sub" data="nav"
					click-link="fClickLink($event, nav)"
					class="ng-scope ng-isolate-scope"> <a
					class="fw-main-navigation-link1 ng-binding"
					ng-class="{selected: data.selected}" href="#/authorize"
					ng-click="clickLink({nav: data, $event: $event})"><span
					class="ico ico-auth " type="auth"></span>社交授权<!-- ngIf: data.type === 'group' -->
					<!-- ngIf: data.notification --></a></ys-navigationlink>
				<!-- end ngRepeat: nav in subNavList.sub -->
				<ys-navigationlink ng-repeat="nav in subNavList.sub" data="nav"
					click-link="fClickLink($event, nav)"
					class="ng-scope ng-isolate-scope"> <a
					class="fw-main-navigation-link1 ng-binding"
					ng-class="{selected: data.selected}" href="#/smsmail"
					ng-click="clickLink({nav: data, $event: $event})"><span
					class="ico ico-smsmail " type="smsmail"></span>网站通知<!-- ngIf: data.type === 'group' -->
					<!-- ngIf: data.notification --></a></ys-navigationlink>
				<!-- end ngRepeat: nav in subNavList.sub -->
				<ys-navigationlink ng-repeat="nav in subNavList.sub" data="nav"
					click-link="fClickLink($event, nav)"
					class="ng-scope ng-isolate-scope"> <a
					class="fw-main-navigation-link1 ng-binding"
					ng-class="{selected: data.selected}" href="#/account"
					ng-click="clickLink({nav: data, $event: $event})"><span
					class="ico ico-account " type="account"></span>管理员<!-- ngIf: data.type === 'group' -->
					<!-- ngIf: data.notification --></a></ys-navigationlink>
				<!-- end ngRepeat: nav in subNavList.sub -->
			</div>
			<!-- end ngRepeat: subNavList in data.subNavLists -->
		</div>
	</div>
	</ys-navigation>


	<div class="fw-main-content ng-scope" id="main_cnt" ui-view="">
		<ys-mainmenu class="ng-scope">
		<div class="fw-main-menu" ng-transclude="">
			<h1 class="fw-main-menu-title ng-binding ng-scope">
				<span class="fw-main-menu-ico"><span class="ico ico-product "
					type="product"></span></span>新增商品
			</h1>
			<button class="btn btn-default " text="返回"
				ng-click="onClickBaseBack()">
				<!-- ngIf: hasPrevIcon -->
				返回
				<!-- ngIf: hasIcon -->
			</button>
			<div class="btn-group ng-scope">
				<button class="btn btn-default " text="查看"
					ng-click="onClickBaseView()"
					ng-disabled="!baseAvailable || isBaseLoading" disabled="disabled">
					<!-- ngIf: hasPrevIcon -->
					查看
					<!-- ngIf: hasIcon -->
				</button>
				<button class="btn btn-default btn-phone" type="phone"
					ng-click="onClickBaseViewQrcode($event)"
					ng-disabled="!baseAvailable || isBaseLoading" disabled="disabled">
					<!-- ngIf: hasPrevIcon -->
					<!-- ngIf: hasIcon -->
					<span class="ico ico-phone" ng-if="hasIcon"></span>
					<!-- end ngIf: hasIcon -->
				</button>
			</div>
			<button class="btn btn-primary " type="primary" text="确认新增"
				ng-click="onClickBaseSave()" ng-show="!isBaseSaving"
				ng-disabled="isBaseLoading">
				<!-- ngIf: hasPrevIcon -->
				确认新增
				<!-- ngIf: hasIcon -->
			</button>
			<button class="btn btn-default disabled  ng-hide" type="loading"
				ng-show="isBaseSaving">
				<!-- ngIf: hasPrevIcon -->
				<!-- ngIf: hasIcon -->
				<span class="ico ico-loading" ng-if="hasIcon"></span>
				<!-- end ngIf: hasIcon -->
			</button>
			<span class="fw-main-menu-desc ng-binding ng-scope" title=""></span>
			<div class="fw-main-menu-right ng-scope">
				<div class="fw-appentry ng-scope ng-hide" ng-show="showEntry"
					type="product_detail">
					<button class="btn btn-default btn-appentry" type="appentry"
						ng-click="showAppList();">
						<!-- ngIf: hasPrevIcon -->
						<!-- ngIf: hasIcon -->
						<span class="ico ico-appentry" ng-if="hasIcon"></span>
						<!-- end ngIf: hasIcon -->
					</button>
					<div class="btn-drop-ls  ng-hide fw-appentry-item-0"
						ng-show="showApp">
						<!-- ngRepeat: i in applist -->
						<span class="ico ico-arrow-6 " type="arrow-6"></span>
					</div>
				</div>
				<button class="btn btn-default " type="default" text="查看订单"
					ng-click="gotoProductOrders()"
					ng-disabled="!baseAvailable || isBaseLoading" disabled="disabled">
					<!-- ngIf: hasPrevIcon -->
					查看订单
					<!-- ngIf: hasIcon -->
				</button>
				<button class="btn btn-default " type="default" text="复制商品"
					ng-click="onClickBaseDuplicate()"
					ng-disabled="!baseAvailable || isBaseLoading" disabled="disabled">
					<!-- ngIf: hasPrevIcon -->
					复制商品
					<!-- ngIf: hasIcon -->
				</button>
				<button class="btn btn-danger " type="danger" text="删除"
					ng-click="onClickBaseDelete()"
					ng-disabled="!baseAvailable || isBaseLoading" disabled="disabled">
					<!-- ngIf: hasPrevIcon -->
					删除
					<!-- ngIf: hasIcon -->
				</button>
			</div>
			<div
				class="coedit-reminder ng-binding ng-scope ng-isolate-scope ng-hide"
				ng-show="clients.length > 0 &amp;&amp; !isHideRemainder"
				data="dataCoedit">
				当前共有1人正在编辑该
				<div class="coedit-reminder-close" ng-click="hideRemainder()">
					<span class="fw-popup-normal-close"></span>
				</div>
			</div>
		</div>
		</ys-mainmenu>

		<div ys-mainbody="" ys-fadein="" class="ng-scope fw-main-body"
			style="opacity: 1;">
			<div class="fw-transition-opacity fw-transition-opacity-fast"
				ng-style="showGrid" style="display: block; opacity: 100;">
				<form action="../UpLoadServlet" method="post"
					enctype="multipart/form-data">
					<div class="fw-main-item clearfix fw-main-item-nointro">
						<div class="fw-main-item-content">
							<h2>商品名</h2>
							<div class="validation">
								<input name="goodname" id="goodname"
									class="input input-long ng-pristine ng-untouched ng-valid ng-empty"
									ng-model="baseName" placeholder="请输入商品名"
									ys-validation="required|maxlength(100)"
									ys-validation-encodehtml="true" type="text">
								<div class="validation-tips-wrap hide" style="">
									<div class="validation-tips">
										<span class="ico ico-invalid-arrow"></span><span></span>
									</div>
								</div>
							</div>


							<h2>
								商品简介<span style="position: relative; left: 3px; top: 3px"
									ys-help="" class="ys-help-dir-top ys-help"><span
									class="b64-ys-help ys-help-ico"></span>
									<div class="ys-help-content"
										style="display: none; visibility: visible; left: -96px;">
										<span class="b64-ys-help ys-help-arrow"></span>简述商品卖点等吸引顾客的信息
									</div></span>
								<ys-text-length-hint data-text="" data-length="200"
									class="theme-seo-tip ng-isolate-scope"><!-- ngIf: vm.count >= 0 -->
								<span ng-if="vm.count >= 0"
									class="text-hint ng-binding ng-scope"
									style="display: inline-block;">还可输入200个字</span><!-- end ngIf: vm.count >= 0 --><!-- ngIf: vm.count < 0 --></ys-text-length-hint>
							</h2>
							<div class="validation">
								<textarea name="pro_shortdesc" id="pro_shortdesc" rows="1"
									class="input input-long fw-transition-quick ng-pristine ng-untouched ng-valid ng-empty"
									ng-model="shortDesc" placeholder="请输入商品简介" ys-validation=""
									ng-style="shortDescStyle" style="height: 32px;"></textarea>
								<div class="validation-tips-wrap hide" style="">
									<div class="validation-tips">
										<span class="ico ico-invalid-arrow"></span><span></span>
									</div>
								</div>
							</div>


						</div>
					</div>
					<div class="fw-main-item clearfix fw-main-item-nointro">
						<div class="fw-main-item-content" style="position: relative">
							<h2>
								橱窗图片<span style="position: relative; left: 3px; top: 3px"
									ys-help="" class="ys-help-dir-top ys-help"><span
									class="b64-ys-help ys-help-ico"></span>
									<div class="ys-help-content">
										<span class="b64-ys-help ys-help-arrow"></span>可拖动图片更改排序
									</div></span>
							</h2>
							<div class="pro-edit-images">
								<div class="pro-edit-uploadImg">
									<div class="pro-edit-noimages" id="goodpictuer"
										onchange="document.getElementById('goodpictuer').value=this.value"
										ng-click="onImgUpload()" style="height: 160px;">
										<img alt="未选择图片" id="imgshowid" src=""> 
										<span class="pro-edit-noimages-add fw-bg"></span> 
									</div>

								</div>
								<div style="position: relative" ng-show="getProDone" class="">
									<div class="text-nodata" style="margin-left: 170px"
										ng-show="!proimages || proimages.length == 0">
										<span class="ico ico-nodata-arrow " type="nodata-arrow"></span>
									</div>
									<input type='text' name='textfield' id='textfield' onchange="upload_showImg()">
									<input type="file" name="fileField" class="file" id="fileField"
										size="28"
										onchange="document.getElementById('textfield').value=this.value" />
								</div>
								<!-- ngRepeat: i in proimages -->
							</div>
						</div>
					</div>

					<div class="fw-main-item clearfix fw-main-item-nointro"
						style="padding-top: 4px">
						<div class="fw-main-item-content" style="position: relative">


							<div class="pro-edit-sold-quantity">
								<span style="margin-right: 3px">售价及库存设置</span> <span
									class="ico ico-arrow-1" style="margin: 0 5px"></span>
								<div class="validation">
									<input name="goodprice" id="goodprice"
										class="input ng-pristine ng-untouched ng-valid ng-empty"
										name="batchprice" placeholder="售价"
										ng-disabled="variantsIds.length < 1"
										ng-blur="editBatchDone(batchPrice,'price')"
										ng-model="batchPrice" ys-validation=""
										style="margin: 0 5px; width: 100px" type="text">
									<div class="validation-tips-wrap hide" style="">
										<div class="validation-tips">
											<span class="ico ico-invalid-arrow"></span><span></span>
										</div>
									</div>
								</div>
								<div class="validation">
									<input name="goodamount" id="goodamount"
										class="input ng-pristine ng-untouched ng-valid ng-empty"
										name="batchstock" placeholder="库存"
										ng-disabled="variantsIds.length < 1"
										ng-blur="editBatchDone(batchStock,'stock')"
										ng-model="batchStock" ys-validation=""
										style="margin: 0 5px; width: 100px" type="text">
									<div class="validation-tips-wrap hide" style="">
										<div class="validation-tips">
											<span class="ico ico-invalid-arrow"></span><span></span>
										</div>
									</div>
								</div>
								<div class="validation">
									<input
										class="input ng-pristine ng-untouched ng-valid ng-empty ng-hide"
										name="batchpoint" placeholder="积分"
										ng-disabled="variantsIds.length < 1"
										ng-show="YeeLevel.CUSTOMER_REWARD_POINT_ENABLE"
										ng-blur="editBatchDone(batchPoint,'point')"
										ng-model="batchPoint" ys-validation=""
										style="margin: 0 5px; width: 100px" disabled="disabled"
										type="text">
									<div class="validation-tips-wrap hide" style="">
										<div class="validation-tips">
											<span class="ico ico-invalid-arrow"></span><span></span>
										</div>
									</div>
								</div>
								<button class="btn btn-primary " type="primary" text="确认"
									ng-disabled="variantsIds.length < 1" ng-click="setBatchSKU()"
									style="margin: 0 5px 3px" disabled="disabled">
									<!-- ngIf: hasPrevIcon -->
									确认
									<!-- ngIf: hasIcon -->
								</button>
							</div>


							<div ng-show="data.variants.length" class="ng-hide">
								<div class="pro-edit-variant-add-btn">
									<button class="btn btn-primary " text="新增价格(SKU)"
										type="primary" style="margin-top: 14px"
										ng-click="fNewVariant()"
										ng-mouseenter="toggleVariantAddBtnTip(true)"
										ng-mouseleave="toggleVariantAddBtnTip(false)">
										<!-- ngIf: hasPrevIcon -->
										新增价格(SKU)
										<!-- ngIf: hasIcon -->
									</button>
									<div class="tips-help-content ng-hide"
										ng-show="showVariantAddBtnTip">
										<span class="b64-ys-help tips-help-arrow arrow"></span>需设置更多的商品属性，才可新<br>增更多的
										SKU
									</div>
								</div>
								<button class="btn btn-default " text="商品属性排序"
									ng-disabled="cantSortOptions()" ng-click="sortOptions()"
									style="margin-top: 14px" disabled="disabled">
									<!-- ngIf: hasPrevIcon -->
									商品属性排序
									<!-- ngIf: hasIcon -->
								</button>
							</div>
						</div>
					</div>



					<div class="fw-main-item clearfix fw-main-item-nointro" style="width:350px;">
						<div class="fw-main-item-content" style="float:left;">
							<h2 class="fw-main-item-content-h2span">商品大类</h2>
							<div class="pro-editor ">
								<select name="goodtype" id="goodtype" onchange = "selectType()">
									<option value="请选择">-请选择-</option>
									<option value="iphone">iphone</option>
									<option value="华为">华为</option>
									<option value="小米">小米</option>
									<option value="OPPO">OPPO</option>
									<option value="vivo">vivo</option>
									<option value="魅族">魅族</option>
									<option value="一加">一加</option>
									<option value="金立">金立</option>
								</select>
							</div>
						</div>
						
						<div class="fw-main-item-content" style="float:right;">
							<h2 class="fw-main-item-content-h2span">详细分类</h2>
							<div class="pro-editor ">
								<select name="detailid" id="detailid">
									<option value="请选择">-请选择-</option>
								</select>
							</div>
						</div>
						
						
					</div>
					
					

					<div class="clearfix fw-item-bottom">
						<button class="btn btn-primary " type="primary" text="确认新增"
							ng-click="onClickBaseSave()" ng-show="!isBaseSaving">
							<!-- ngIf: hasPrevIcon -->
							确认新增
							<!-- ngIf: hasIcon -->
						</button>
						<button class="btn btn-default disabled  ng-hide" type="loading"
							ng-show="isBaseSaving">
							<!-- ngIf: hasPrevIcon -->
							<!-- ngIf: hasIcon -->
							<span class="ico ico-loading" ng-if="hasIcon"></span>
							<!-- end ngIf: hasIcon -->
						</button>
					</div>
				</form>

			</div>
		</div>
	</div>

</body>
</html>