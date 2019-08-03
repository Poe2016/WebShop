function check(str) {
	var x = document.getElementById(str);
	var y = document.getElementById(str + "Check");
	var mailnumber = x.value;
	if (str == "mail") {
		if (mailnumber == "" || !mailnumber.endsWith("@qq.com")) {
			y.hidden = false;
		} else
			y.hidden = true;
	}
	return y.hidden;
}
// 购物车中的函数
function addNum(i) {
	var input = document.getElementById("quantity" + i);
	input.value = Number(input.value) + Number(1);
	var unitPrice = document.getElementById("unitPrice" + i).innerText;
	document.getElementById("totalPrice" + i).innerText = Number(unitPrice
			.substring(1))
			* Number(input.value);
	location.href = "../DeleteFromCartServlet?state=add&index=" + i;
}
function deleteNum(i, i2) {
	var goodno = ("00000000" + i2).substr(-8);// 获取商品编号
	var input = document.getElementById("quantity" + i);
	var prenum = input.value;
	if (prenum == 1) {
		var con = confirm("确定要将该商品移出购物车？");
		if (con == true) {// 从购物车中删除该商品
			location.href = "../DeleteFromCartServlet?goodno=" + goodno
					+ "&index=" + i;
		} else {// 撤销操作
			return;
		}
	} else {
		input.value = prenum - 1;
		var unitPrice = document.getElementById("unitPrice" + i).innerText;
		document.getElementById("totalPrice" + i).innerText = Number(unitPrice
				.substring(1))
				* Number(input.value);
		location.href = "../DeleteFromCartServlet?state=decrease&index=" + i;
	}
}
function caculatePrice(i) {
	var input = document.getElementById("quantity" + i);
	var unitPrice = document.getElementById("unitPrice" + i).innerText;
	document.getElementById("totalPrice" + i).innerText = Number(unitPrice
			.substring(1))
			* Number(input.value);
}

var checkedAll = false;
function selectAll(checkboxName) {
	var toggles = document.getElementsByName("toggle-checkboxes");
	var elements = document.getElementsByName(checkboxName);// 各项商品的复选框数组
	var ele_selected_num = document.getElementById("selected_num");// 已选择的件数
	var ele_total_money = document.getElementById("total_money");
	var total_money = ele_total_money.innerText.substring(1);
	for (var i = 0; i < elements.length; i++) {
		var e = elements[i];
		if (checkedAll) {

			e.checked = false;
		} else {
			if (!e.checked) {
				var ele_smal_total = document.getElementById("totalPrice" + i);// 各项商品小计标签
				var smal_total = ele_smal_total.innerText;
				total_money = Number(total_money) + Number(smal_total);
				e.checked = true;
			}
		}
	}
	for (var j = 0; j < toggles.length; j++) {
		var e = toggles[j];
		if (checkedAll) {
			e.checked = false;
		} else {
			e.checked = true;
		}
	}

	if (checkedAll) {
		checkedAll = false;
		ele_selected_num.innerHTML = 0;
		ele_total_money.innerHTML = "¥" + 0.00;
	} else {
		checkedAll = true;
		ele_selected_num.innerHTML = elements.length;
		ele_total_money.innerHTML = "¥" + total_money;
	}
}
// 用于判断是否已经全选或者全不选了
function checkAll() {
	var toggles = document.getElementsByName("toggle-checkboxes");// 两个全选数组
	var elements = document.getElementsByName("checkItem");// 各项商品的复选框数组
	var state1 = allYes(elements);
	var state2 = allNo(elements);
	if (state1 && !state2) {// 全选中
		return true;
	} else if (!state1 && state2) {// 全不选中
		return false;
	}

}
function allYes(elements) {
	for (var i = 0; i < elements.length; i++) {
		e = elements[i];
		if (!e.checked) {// 存在未选中的复选框
			return false;
		}
	}
	return true;// 已全部选中
}
function allNo(elements) {
	for (var i = 0; i < elements.length; i++) {
		e = elements[i];
		if (e.checked) {// 存在选中的复选框
			return false;
		}
	}
	return true;// 已全部未选中
}
//
function selectOne(i) {
	var e = document.getElementById("checkItem" + i);
	var ele_smal_total = document.getElementById("totalPrice" + i);// 各项商品小计标签
	var smal_total = Number(ele_smal_total.innerText);// 小计的整数表示
	var ele_total_money = document.getElementById("total_money");
	var total_money = Number(ele_total_money.innerText.substring(1));// 总计的整数表示
	var ele_selected_num = document.getElementById("selected_num");// 已选择的件数
	var selected_num = Number(ele_selected_num.innerText)// 已选商品数的整数表示
	if (checkAll()) {// 所有商品都已选中
		checkedAll = true;
		var toggles = document.getElementsByName("toggle-checkboxes");
		for (var j = 0; j < toggles.length; j++) {
			toggles[j].checked = true;
		}
	} else {// 全未选中
		checkedAll = false;
		var toggles = document.getElementsByName("toggle-checkboxes");
		for (var j = 0; j < toggles.length; j++) {
			toggles[j].checked = false;
		}
	}
	if (e.checked) {
		selected_num = selected_num + 1;
		total_money = total_money + smal_total;
	} else {
		selected_num = selected_num - 1;
		total_money = total_money - smal_total;
	}
	ele_selected_num.innerHTML = selected_num;
	ele_total_money.innerHTML = "¥" + total_money;
}
function load_fun() {
	var ele_total_money = document.getElementById("total_money");
	var elements = document.getElementsByName("checkItem");// 各项商品的复选框数组
	var total_money = ele_total_money.innerText.substring(1);// 总金额
	for (var i = 0; i < elements.length; i++) {
		var e = elements[i];
		if (e.checked) {// 选中
			var smal_total = document.getElementById("totalPrice" + i).innerText;// 小计
			total_money = Number(total_money) + Number(smal_total);
		}
	}
	ele_total_money.innerText = "¥" + total_money;
}
// 结算弹框
function balance() {
	var ele_ch_boxs = document.getElementsByName("checkItem");// 各项商品的复选框数组
	var total_money = document.getElementById("total_money").innerText
			.substring(1);// 总价
	if (total_money > 0) {// 有选择的商品
		var state = confirm("确定要产生订单？");
		if (state) {
			var nolist = [];
			for (var i = 0; i < ele_ch_boxs.length; i++) {
				var e = ele_ch_boxs[i];
				if (e.checked) {// 选中
					var goodno = e.value;
					nolist.push(goodno);
				}
			}
			var good_no_string = nolist.join(',');
			location.href = "order.jsp?order_goods=" + good_no_string;
		}
	} else {
		alert("请选择商品");
	}
}
// 修改个人信息，使用ajax请求servlet，页面不刷新
function per_modify() {
	var mailno = document.getElementById("mailid").value;
	var nickname = document.getElementById("nicknameid").value;
	var address = document.getElementById("addressid").value;
	var url = "/WebShop/ModifyInfoServlet?mailno=" + mailno + "&nickname="
			+ nickname + "&address=" + address;
	if (window.XMLHttpRequest) {
		req2 = new XMLHttpRequest();// IE7, Firefox, Opera支持
	} else if (window.ActiveXObject) {
		req2 = new ActiveXObject("Microsoft.XMLHTTP");// IE5,IE6支持
	}
	req2.open("get", url, true);
	alert("修改成功");
	req2.onreadystatechange = callback;
	req2.send(null);
}
var req2;
function modify_info() {
	var mailno = document.getElementById("mailid").value;
	var nickname = document.getElementById("nicknameid").value;
	var address = document.getElementById("addressid").value;
	var url = "/WebShop/ModifyInfoServlet?mailno=" + mailno + "&nickname="
			+ nickname + "&address=" + address;
	if (window.XMLHttpRequest) {
		req2 = new XMLHttpRequest();// IE7, Firefox, Opera支持
	} else if (window.ActiveXObject) {
		req2 = new ActiveXObject("Microsoft.XMLHTTP");// IE5,IE6支持
	}
	req2.open("get", url, true);
	alert("修改成功");
	req2.onreadystatechange = callback;
	req2.send(null);
}
function callback() {
	if (req2.readyState == 4 && req2.status == 200) {
		return "OK";
	} else {
		return "error";
	}
}

// 立即付款
function pay_right() {
	var ele_goods = document.getElementsByName("ord_goodnos");// 所有选中商品编号
	var address = document.getElementById("addressid").value;// 收货地址
	var nickname = document.getElementById("nicknameid").value;// 收货人
	var goodnos = [];
	for (var i = 0; i < ele_goods.length; i++) {
		goodnos.push(ele_goods[i].value);
	}
	var goodnos_string = goodnos.join(',');
	var state = confirm("确定付款？");
	if (state) {
		alert("付款成功");
		location.href = "../AfterPay?paystate=right&goodnos=" + goodnos_string
				+ "&address=" + address + "&nickname=" + nickname;
	}
}
// 稍后付款
function pay_after() {
	var ele_goods = document.getElementsByName("ord_goodnos");// 所有选中商品编号
	var address = document.getElementById("addressid").value;// 收货地址
	var nickname = document.getElementById("nicknameid").value;// 收货人
	var goodnos = [];
	for (var i = 0; i < ele_goods.length; i++) {
		goodnos.push(ele_goods[i].value);
	}
	var goodnos_string = goodnos.join(',');
	location.href = "../AfterPay?paystate=after&goodnos=" + goodnos_string
			+ "&address=" + address + "&nickname=" + nickname;
}
// 待付款页面中的立即付款
function wait_pay_right(ord_id) {
	var state = confirm("确定付款？");
	if (state) {
		alert("付款成功，等待收货");
		location.href = "../PayAndDelete?condition=pay&ord_id=" + ord_id;
	}
}
// 待付款页面中的删除订单
function wait_delete(ord_id) {
	var state = confirm("确定删除订单？");
	if (state) {
		alert("订单删除成功");
		location.href = "../PayAndDelete?condition=delete&ord_id=" + ord_id;
	}
}
// 确认收货
function confirm_receive(ord_id) {
	var state = confirm("确认已经收货？");
	if (state) {// 已经收货
		location.href = "../PayAndDelete?condition=confirm_receive&ord_id="
				+ ord_id;
	}
}
// 确认发货
function confirm_send(ord_id) {
	var state = confirm("确认要发货？");
	if (state) {// 发货
		location.href = "../PayAndDelete?condition=confirm_send&ord_id="
				+ ord_id;
	}
}
// 满意度评价中刷出笑脸
function star_hover() {
	var ele = document.getElementById("wid");
	ele.onclick = mouseClick;
	ele.onmouseover = mouseOver;
	ele.onmouseout = mouseOut;
	var name_string;
	var ele_parent;
	var childs = [];
	var el;

	function mouseClick(evt) {// 获取当前点击标签的类名

		if (evt) {// 不是ie(错误，现已与ie兼容)
			el = evt.target;
			name_string = el.className;// 返回字符串，以空格隔开
		} else if (window.event) {// ie
			el = window.event.srcElement;
			name_string = el.className;
		}

		if (name_string.indexOf("star ") == 0) {// 包含star类的标签，是星星
			childs = el.parentNode.childNodes;
			for (var i = 0; i < childs.length; i++) {
				var str = childs[i].className;
				if (str != null) {
					childs[i].className = str.replace("active", "");
					// if(str == 'star-info'){
					// childs[i].innerText = name_string[9]+"分";
					// }
				}
			}
			name_string += " active";
		}
		if (evt) {// 重新设置属性
			evt.target.className = name_string;
		} else if (window.event) {
			window.event.srcElement.className = name_string;
		}
		scoreing(el);
	}
	function mouseOver(evt) {// 鼠标移上
		if (evt) {// 不是ie(错误，现已与ie兼容).....
			el = evt.target;
			name_string = el.className;// 返回字符串，以空格隔开
		} else if (window.event) {// ie
			el = window.event.srcElement;
			name_string = el.className;
		}
		if (name_string.indexOf("star ") == 0) {// 包含star类的标签，是星星
			name_string += " hover";
		}
		if (evt) {// 重新设置属性
			evt.target.className = name_string;
		} else if (window.event) {
			window.event.srcElement.className = name_string;
		}
		scoreing(el);
	}
	function mouseOut(evt) {// 鼠标移开
		if (evt) {// 不是ie
			el = evt.target;
			name_string = el.className;// 返回字符串，以空格隔开
		} else if (window.event) {// ie
			el = window.event.srcElement;
			name_string = el.className;
		}
		if (name_string.indexOf("star ") == 0) {// 包含star类的标签，是星星
			name_string = name_string.replace("hover", "");
		}
		if (evt) {// 重新设置属性
			evt.target.className = name_string;
		} else if (window.event) {
			window.event.srcElement.className = name_string;
		}
		scoreing(el);
	}
	function scoreing(e) {
		var childs = e.parentNode.childNodes;
		var score = 0;
		for (var j = 0; j < childs.length; j++) {
			var cla_name = childs[j].className;// 获取该节点的类名
			if (cla_name != null) {
				if (cla_name.indexOf("hover") != -1
						|| cla_name.indexOf("active") != -1) {
					score = cla_name[9];
				}
				if (cla_name == 'star-info') {
					childs[j].innerText = score + "分";
				}
			}

		}
	}
}
// 买家印象栏选择特点//点击自定义标签后要变成tag-define z-define-input
function select_advantage() {
	var ele = document.getElementById("selectid");
	ele.onclick = mouseClick;
	var name_string;// 指标签的类名
	function mouseClick(evt) {
		evt = evt || window.evt;// 兼容所有浏览器
		name_string = evt.target.className;// 返回字符串，以空格隔开
		if (name_string.indexOf("tag-item") != -1) {
			if (name_string.indexOf("tag-checked") != -1) {// 没选中，点击就选中
				evt.target.className = evt.target.className.replace(
						"tag-checked", "");
			} else {// 选中时再点击就取消选中
				evt.target.className += " tag-checked";
			}
		} else if (name_string.indexOf("define") != -1) {
			var e = document.getElementById("defineid");
			e.className = "tag-define z-define-input";
		}

	}
}
/*
 * 纯ajax,暂未调通 // 评价晒单 function _myeval(ord_id) {// 使用ajax传值 var stars =
 * document.getElementsByClassName("star");// 打分标签 var tag_items =
 * document.getElementsByClassName("tag-item");// 选框标签 var e_define =
 * document.getElementById("def-inp-id");// 自定义输入框 var e_words =
 * document.getElementById("shareword");// 文字输入框 var xhr;
 * 
 * var url = '../PayAndDelete'; if (window.XMLHttpRequest) { xhr = new
 * XMLHttpRequest(); } else { xhr = new ActiveXObject("Microsoft.XMLHTTP"); }
 * xhr.open('POST', url, true);//
 * get和post请求，true为异步请求、false我为同步请求,请求的URL中可带参数进行请求
 * xhr.setRequestHeader("Content-type", "application/json");//
 * 添加http头信息，该函数的顺序必须是open之后，send之前 var data = "data="+JSON.stringify({ ord_id :
 * ord_id, condition : 'evaluate' }); alert(data); xhr.send(data);//
 * post的send(String)必须要，send用于发送请求参数，如果不需要请求体发送请求参数，则为null。 //
 * send传输的数据是以json数据格式传给后台的。 // 返回响应 xhr.onreadystatechange = function() { if
 * (xhr.readyState == 4) { if (xhr.status >= 200 && xhr.status < 300 ||
 * xhr.status == 304) { // 请求成功的处理函数，服务器返回的数据存入responseText属性中 requestData =
 * xhr.responseText;// 获取到后台响应的数据 var date = JSON.parse(requestData);//
 * 将响应数据转化成json格式，以便使用 // 使用数据 // ~~~ } else { // 请求数据错误的处理函数 } } else { //
 * ajax发送失败，没有得到响应数据 } } // location.href =
 * "../PayAndDelete?condition=evaluate&ord_id=" + ord_id; }
 */

// 上传图片选择类别时选中下拉类别，后一个详细类别改变
function selectType() {
	var select = document.getElementById("goodtype");// 总类
	var detail = document.getElementById("detailid");// 子类
	var type = select.value;// 选中的大类
	var d_options = detail.options;
	if (type == "iphone") {// 增加iphoneX,iphone8,iphone7,其他 四个选项
		if (d_options.length > 1) {// 先清除
			for (var i = d_options.length - 1; i > 0; i--) {
				d_options.remove(i);
			}
		}
		var new_opt0 = new Option("iphoneX", "iphoneX");
		var new_opt1 = new Option("iphone8", "iphone8");
		var new_opt2 = new Option("iphone7", "iphone7");
		var new_opt3 = new Option("其他", "其他");
		d_options.add(new_opt0);
		d_options.add(new_opt1);
		d_options.add(new_opt2);
		d_options.add(new_opt3);
	} else if (type == "华为") {// Mate / P系 /荣耀
		if (d_options.length > 1) {// 先清除
			for (var i = d_options.length - 1; i > 0; i--) {
				d_options.remove(i);
			}
		}
		var new_opt0 = new Option("Mate", "Mate");
		var new_opt1 = new Option("P系", "P系");
		var new_opt2 = new Option("荣耀", "荣耀");
		d_options.add(new_opt0);
		d_options.add(new_opt1);
		d_options.add(new_opt2);
	} else if (type == "小米") {// MIX /红米/Note
		if (d_options.length > 1) {// 先清除
			for (var i = d_options.length - 1; i > 0; i--) {
				d_options.remove(i);
			}
		}
		var new_opt0 = new Option("MIX", "MIX");
		var new_opt1 = new Option("红米", "红米");
		var new_opt2 = new Option("Note", "Note");
		d_options.add(new_opt0);
		d_options.add(new_opt1);
		d_options.add(new_opt2);
	} else if (type == "OPPO") {// A /R /Find
		if (d_options.length > 1) {// 先清除
			for (var i = d_options.length - 1; i > 0; i--) {
				d_options.remove(i);
			}
		}
		var new_opt0 = new Option("A", "A");
		var new_opt1 = new Option("R", "R");
		var new_opt2 = new Option("Find", "Find");
		d_options.add(new_opt0);
		d_options.add(new_opt1);
		d_options.add(new_opt2);
	} else if (type == "vivo") {// Xplay /X / Y
		if (d_options.length > 1) {// 先清除
			for (var i = d_options.length - 1; i > 0; i--) {
				d_options.remove(i);
			}
		}
		var new_opt0 = new Option("Xplay", "Xplay");
		var new_opt1 = new Option("X", "X");
		var new_opt2 = new Option("Y", "Y");
		d_options.add(new_opt0);
		d_options.add(new_opt1);
		d_options.add(new_opt2);
	} else if (type == "魅族") {// Pro /魅蓝
		if (d_options.length > 1) {// 先清除
			for (var i = d_options.length - 1; i > 0; i--) {
				d_options.remove(i);
			}
		}
		var new_opt0 = new Option("Pro", "Pro");
		var new_opt1 = new Option("魅蓝", "魅蓝");
		d_options.add(new_opt0);
		d_options.add(new_opt1);
	} else if (type == "一加") {// X /T
		if (d_options.length > 1) {// 先清除
			for (var i = d_options.length - 1; i > 0; i--) {
				d_options.remove(i);
			}
		}
		var new_opt0 = new Option("X", "X");
		var new_opt1 = new Option("T", "T");
		d_options.add(new_opt0);
		d_options.add(new_opt1);
	} else if (type == "金立") {// M/S
		if (d_options.length > 1) {// 先清除
			for (var i = d_options.length - 1; i > 0; i--) {
				d_options.remove(i);
			}
		}
		var new_opt0 = new Option("M", "M");
		var new_opt1 = new Option("S", "S");
		d_options.add(new_opt0);
		d_options.add(new_opt1);
	}
}
// gooditem.jsp中的转换页面
function turnpages(page) {
	var divs = document.getElementsByName("pages");
	for (var i = 0; i < divs.length; i++) {
		if (i == page) {
			divs[i].setAttribute("style",
					"width: 4840px; left: 0px; position: absolute;")
		} else {
			divs[i].setAttribute("style",
					"width: 4840px; left: 1190px; position: absolute;")
		}
	}
	var lis = document.getElementsByName("pageli");
	for (var i = 0; i < lis.length; i++) {
		if (i == page) {
			if (lis[i].className.indexOf(" curr") == -1) {
				lis[i].className += " curr";
			}
		} else {
			lis[i].className=lis[i].className.replace("curr","");
		}
	}
}
