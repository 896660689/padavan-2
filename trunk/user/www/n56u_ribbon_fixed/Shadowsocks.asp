<!DOCTYPE html>
<html>

<head>
	<title>
		<#Web_Title#> - <#menu5_16#>
	</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="-1">
	<link rel="shortcut icon" href="images/favicon.ico">
	<link rel="icon" href="images/favicon.png">
	<link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap-table.min.css">
	<link rel="stylesheet" type="text/css" href="/bootstrap/css/main.css">
	<link rel="stylesheet" type="text/css" href="/bootstrap/css/engage.itoggle.css">
	<script type="text/javascript" src="/jquery.js?random=<% uptime(); %>"></script>
	<script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/bootstrap/js/bootstrap-table.min.js"></script>
	<script type="text/javascript" src="/bootstrap/js/bootstrap-table-zh-CN.min.js"></script>
	<script type="text/javascript" src="/bootstrap/js/engage.itoggle.min.js"></script>
	<script type="text/javascript" src="/state.js"></script>
	<script type="text/javascript" src="/general.js"></script>
	<script type="text/javascript" src="/itoggle.js"></script>
	<script type="text/javascript" src="/popup.js"></script>
	<script type="text/javascript" src="/help.js"></script>
	<script type="text/javascript" src="/validator.js"></script>
	<script>
		var node_global_max = 0;
		<% shadowsocks_status(); %>
		<% dns2tcp_status(); %>
		<% dnsproxy_status(); %>
		<% rules_count(); %>
		node_global_max = 0;
		editing_ss_id = 0;
		var $j = jQuery.noConflict();
		$j(document).ready(function () {
			init_itoggle('ss_enable');
			init_itoggle('switch_enable_x_0');
			init_itoggle('ss_chdns');
			init_itoggle('ss_router_proxy', change_ss_watchcat_display);
			init_itoggle('ss_cgroups');
			init_itoggle('ss_watchcat');
			init_itoggle('ss_update_chnroute');
			init_itoggle('ss_update_gfwlist');
			init_itoggle('ss_adblock');
			init_itoggle('ss_turn');
			init_itoggle('socks5_enable');
			init_itoggle('ss_schedule_enable', change_on);
			$j("#tab_ss_cfg, #tab_ss_add, #tab_ss_dlink, #tab_ss_ssl, #tab_ss_cli, #tab_ss_log, #tab_ss_help").click(
				function () {
					var newHash = $j(this).attr('href').toLowerCase();
					showTab(newHash);
					return false;
				});
			$j("#close_add").click(function () {
				$j("#vpnc_settings").fadeOut(200);
			});
			$j("#btn_add_link").click(function () {
				initSSParams();
				editing_ss_id = 0;
				document.getElementById("ss_setting_title").innerHTML = "添加节点";
				$j("#vpnc_settings").fadeIn(200);
			});
			$j("#btn_del_link").click(function () {
				del_dlink();
			});
			$j("#btn_ping_link").click(function () {
				ping_dlink();
			});
			$j("#btn_aping_link").click(function () {
				aping_dlink();
			});
			$j("#s5_aut").change(function() { 
			if($j("#s5_aut").is(':checked')){
			document.getElementById('s5_aut').value=1;
			}else{
			document.getElementById('s5_aut').value=0;
			}
			}); 
			$j("#v2_tls").change(function() { 
			if(document.getElementById('v2_tls').value != '0'){
			showhide_div('row_tj_tls_host', 1);
			}else{			
			showhide_div('row_tj_tls_host', 0);
			}
			});
			$j("#v2_mux").change(function() { 
			if($j("#v2_mux").is(':checked')){
			document.getElementById('v2_mux').value=1;
			}else{
			document.getElementById('v2_mux').value=0;
			}
			});
			$j("#ssp_insecure").change(function() { 
			if($j("#ssp_insecure").is(':checked')){
			document.getElementById('ssp_insecure').value=1;
			}else{
			document.getElementById('ssp_insecure').value=0;
			}
			});
		});
function ctime() {
var t=0;
c=null;
document.getElementById('btn_ctime').value='正在运行脚本:0s';
document.getElementById('btn_ctime').style.display="inline";
		c=setInterval(function(){
		t=t+1
        //document.getElementById("ctime").value=t + "秒";
		document.getElementById('btn_ctime').value='正在运行脚本:' + t +"s";
    },1000);
}
function dtime() {
clearInterval(c);
document.getElementById('btn_ctime').value='脚本运行完成!';
setTimeout('document.getElementById("btn_ctime").style.display="none";',1000);
}
		function initial() {
			show_banner(2);
			show_menu(13, 13, 0);
			show_footer();
			fill_ss_status(shadowsocks_status());
			fill_dns2tcp_status(dns2tcp_status());
			fill_dnsproxy_status(dnsproxy_status());
			var wan0_dns = '<% nvram_get_x("","wan0_dns"); %>';
			if (wan0_dns.length > 0){ // use local DNS
					$j("select[name='china_dns']").prepend($j('<option value="'+wan0_dns+'" selected>本地DNS ' + wan0_dns + '</option>'));
			}

			$("chnroute_count").innerHTML = '<#menu5_17_3#>' + chnroute_count();
			$("gfwlist_count").innerHTML = '<#menu5_17_3#>' + gfwlist_count();
			switch_ss_type();
			showTab(getHash());
			showMRULESList();
			switch_dns();
			var o2 = document.form.lan_con;
			var o3 = document.form.ss_threads;
			var o4 = document.form.china_dns;
			var o5 = document.form.pdnsd_enable;
			//var o6 = document.form.socks5_enable;
			var o7 = document.form.tunnel_forward;
			o2.value = '<% nvram_get_x("","lan_con"); %>';
			o3.value = '<% nvram_get_x("","ss_threads"); %>';
			o4.value = '<% nvram_get_x("","china_dns"); %>';
			o5.value = '<% nvram_get_x("","pdnsd_enable"); %>';
			//o6.value = '<% nvram_get_x("","socks5_enable"); %>';
			o7.value = '<% nvram_get_x("","tunnel_forward"); %>';
			switch_dns();
			if (ss_schedule_support) {
				document.form.ss_date_x_Sun.checked = getDateCheck(document.form.ss_schedule.value, 0);
				document.form.ss_date_x_Mon.checked = getDateCheck(document.form.ss_schedule.value, 1);
				document.form.ss_date_x_Tue.checked = getDateCheck(document.form.ss_schedule.value, 2);
				document.form.ss_date_x_Wed.checked = getDateCheck(document.form.ss_schedule.value, 3);
				document.form.ss_date_x_Thu.checked = getDateCheck(document.form.ss_schedule.value, 4);
				document.form.ss_date_x_Fri.checked = getDateCheck(document.form.ss_schedule.value, 5);
				document.form.ss_date_x_Sat.checked = getDateCheck(document.form.ss_schedule.value, 6);
				document.form.ss_time_x_hour.value = getrebootTimeRange(document.form.ss_schedule.value, 0);
				document.form.ss_time_x_min.value = getrebootTimeRange(document.form.ss_schedule.value, 1);
				document.getElementById('ss_schedule_enable_tr').style.display = "";
				change_on();
			} else {
				document.getElementById('ss_schedule_enable_tr').style.display = "none";
				document.getElementById('ss_schedule_date_tr').style.display = "none";
				document.getElementById('ss_schedule_time_tr').style.display = "none";
			}
		}
		function textarea_scripts_enabled(v) {
			//inputCtrl(document.form['scripts.ss.dom.sh'], v);
			//inputCtrl(document.form['scripts.ss.ip.sh'], v);
		}
		function change_on() {
			var v = document.form.ss_schedule_enable_x.value;
			showhide_div('ss_schedule_date_tr', v);
			showhide_div('ss_schedule_time_tr', v);
			if (v == 1)
				check_Timefield_checkbox();
		}
		function validForm() {
			if (ss_schedule_support) {
				if (!document.form.ss_date_x_Sun.checked && !document.form.ss_date_x_Mon.checked &&
					!document.form.ss_date_x_Tue.checked && !document.form.ss_date_x_Wed.checked &&
					!document.form.ss_date_x_Thu.checked && !document.form.ss_date_x_Fri.checked &&
					!document.form.ss_date_x_Sat.checked && document.form.ss_schedule_enable_x[0].checked) {
					alert(Untranslated.filter_lw_date_valid);
					document.form.ss_date_x_Sun.focus();
					return false;
				}
			}
			return true;
		}
		function switch_ss_type() {
			showhide_div('row_quic_header', 0);
			showhide_div('row_quic_key', 0);
			showhide_div('row_quic_security', 0);
			showhide_div('row_s5_password', 0);
			showhide_div('row_s5_username', 0);
			showhide_div('row_ss_method', 0);
			showhide_div('row_ss_obfs_para', 0);
			showhide_div('row_ss_obfs', 0);
			showhide_div('row_ss_password', 0);
			showhide_div('row_ss_plugin_opts', 0);
			showhide_div('row_ss_plugin', 0);
			showhide_div('row_ss_protocol_para', 0);
			showhide_div('row_ss_protocol', 0);
			showhide_div('row_ssp_insecure', 0);
			showhide_div('row_tj_tls_host', 0);
			showhide_div('row_v2_aid', 0);
			showhide_div('row_v2_http2_host', 0);
			showhide_div('row_v2_http2_path', 0);
			showhide_div('row_v2_mkcp_congestion', 0);
			showhide_div('row_v2_mkcp_downlink', 0);
			showhide_div('row_v2_mkcp_mtu', 0);
			showhide_div('row_v2_mkcp_readbu', 0);
			showhide_div('row_v2_mkcp_tti', 0);
			showhide_div('row_v2_mkcp_uplink', 0);
			showhide_div('row_v2_mkcp_writebu', 0);
			showhide_div('row_v2_mux', 0);
			showhide_div('row_v2_net', 0);
			showhide_div('row_v2_security', 0);
			showhide_div('row_v2_tls', 0);
			showhide_div('row_v2_flow', 0);
			showhide_div('row_v2_type_tcp', 0);
			showhide_div('row_v2_type', 0);
			showhide_div('row_v2_vid', 0);
			showhide_div('row_v2_webs_host', 0);
			showhide_div('row_v2_webs_path', 0);
			showhide_div('row_v2_grpc_path', 0);
			showhide_div('row_s5_enable', 0);
			showhide_div('row_s5_username', 0);
			showhide_div('row_s5_password', 0);
			showhide_div('row_v2_http_host', 0);
			showhide_div('row_v2_http_path', 0);
			var b = document.form.ssp_type.value;
			if (b == "ss") {
				showhide_div('row_ss_password', 1);
				showhide_div('row_ss_method', 1);
				showhide_div('row_ss_plugin', 1);
				showhide_div('row_ss_plugin_opts', 1);
			} else if (b == "ssr") {
				showhide_div('row_ss_protocol', 1);
				showhide_div('row_ss_protocol_para', 1);
				showhide_div('row_ss_obfs', 1);
				showhide_div('row_ss_obfs_para', 1);
				showhide_div('row_ss_password', 1);
				showhide_div('row_ss_method', 1);
			} else if (b == "trojan") {
				showhide_div('row_ss_password', 1);
				//showhide_div('row_v2_tls', 1);
				showhide_div('row_tj_tls_host', 1);
				showhide_div('row_ssp_insecure', 1);
			} else if (b == "v2ray" || b == "xray") {
				switch_v2_type();
				showhide_div('row_v2_aid', 1);
				showhide_div('row_v2_vid', 1);
				showhide_div('row_v2_security', 1);
				showhide_div('row_v2_net', 1);
				showhide_div('row_v2_type', 1);
				showhide_div('row_v2_tls', 1);
				showhide_div('row_v2_flow', 1);
				showhide_div('row_v2_mux', 1);
				showhide_div('row_tj_tls_host', 1);
				showhide_div('row_ssp_insecure', 1);
			} else if (b == "socks5") {
				showhide_div('row_s5_enable', 1);
				showhide_div('row_s5_username', 1);
				showhide_div('row_s5_password', 1);
			}
		}
		function switch_v2_type() {
			showhide_div('row_quic_header', 0);
			showhide_div('row_quic_key', 0);
			showhide_div('row_quic_security', 0);
			showhide_div('row_v2_http_host', 0);
			showhide_div('row_v2_http_path', 0);
			showhide_div('row_v2_http2_host', 0);
			showhide_div('row_v2_http2_path', 0);
			showhide_div('row_v2_mkcp_congestion', 0);
			showhide_div('row_v2_mkcp_downlink', 0);
			showhide_div('row_v2_mkcp_mtu', 0);
			showhide_div('row_v2_mkcp_readbu', 0);
			showhide_div('row_v2_mkcp_tti', 0);
			showhide_div('row_v2_mkcp_uplink', 0);
			showhide_div('row_v2_mkcp_writebu', 0);
			showhide_div('row_v2_type_tcp', 0);
			showhide_div('row_v2_type', 0);
			showhide_div('row_v2_webs_host', 0);
			showhide_div('row_v2_webs_path', 0);
			showhide_div('v2_kcp_guise', 0);
			showhide_div('v2_tcp_guise', 0);
			var b = document.form.v2_transport.value;
			if (b == "tcp") {
				showhide_div('row_v2_type', 1);
				showhide_div('v2_tcp_guise', 1);
				showhide_div('row_v2_http_host', 1);
				showhide_div('row_v2_http_path', 1);
			} else if (b == "kcp") {
				showhide_div('row_v2_type', 1);
				showhide_div('v2_kcp_guise', 1);
				showhide_div('row_v2_mkcp_mtu', 1);
				showhide_div('row_v2_mkcp_tti', 1);
				showhide_div('row_v2_mkcp_uplink', 1);
				showhide_div('row_v2_mkcp_downlink', 1);
				showhide_div('row_v2_mkcp_readbu', 1);
				showhide_div('row_v2_mkcp_writebu', 1);
				showhide_div('row_v2_mkcp_congestion', 1);
			} else if (b == "ws") {
				showhide_div('row_v2_webs_host', 1);
				showhide_div('row_v2_webs_path', 1);
			} else if (b == "grpc") {
				showhide_div('row_v2_grpc_path', 1);
			} else if (b == "h2") {
				showhide_div('row_v2_http2_host', 1);
				showhide_div('row_v2_http2_path', 1);
			} else if (b == "quic") {
				showhide_div('row_quic_security', 1);
				showhide_div('row_quic_key', 1);
				showhide_div('row_quic_header', 1);
			}
		}
		function switch_dns() {
			var b = document.form.pdnsd_enable.value;
			if (b == "0" || b == "1") { 
				showhide_div('row_china_dns', 1);
				showhide_div('row_tunnel_forward', 1);
				showhide_div('row_ssp_dns_ip', 0);
				showhide_div('row_ssp_dns_port', 0);
			} else if (b == "2") {
				showhide_div('row_china_dns', 0);
				showhide_div('row_tunnel_forward', 0);
				showhide_div('row_ssp_dns_ip', 0);
				showhide_div('row_ssp_dns_port', 0);
			}
		}
		function applyRule() {
			if (validForm()) {
				if (ss_schedule_support) {
					updateDateTime();
				}
			}
			showLoading();
			showsdlinkList();
			showsudlinkList();
			shows5dlinkList();
			document.form.action_mode.value = " Restart ";
			document.form.current_page.value = "Shadowsocks.asp";
			document.form.next_page.value = "";
			document.form.submit();
		}
		function submitInternet(v) {
			showLoading();
			$j.ajax({
				type: "POST",
				url: "/Shadowsocks_action.asp",
				data: {
					connect_action: v,
				},
				dataType: "json",
				success: function (response) {
					alert("脚本执行成功...")
				},
				complete: function(xhr, ts) {
					hideLoading();
				}
			});
		}
		function change_ss_watchcat_display() {
			var v = document.form.ss_router_proxy[0].checked;
			showhide_div('ss_wathcat_option', v);
		}
		function fill_ss_status(status_code) {
			var stext = "Unknown";
			if (status_code == 0)
				stext = "<#Stopped#>";
			else if (status_code == 1)
				stext = "<#Running#>";
			$("ss_status").innerHTML = '<span class="label label-' + (status_code != 0 ? 'success' : 'warning') + '">' + stext + '</span>';
			$("domestic_ip").innerHTML = '<iframe src="http://ip.3322.net" height="30" scrolling="no" frameborder="0" marginheight="0" marginwidth="0"></iframe>';
			$("foreign_ip").innerHTML = '<iframe src="https://ifconfig.me/ip" height="30" scrolling="no" frameborder="0" marginheight="0" marginwidth="0"></iframe>';
			$("gg_status").innerHTML = '<span><img alt="无法访问" src="https://www.google.com/favicon.ico?' + new Date().getTime() + '" /></span>';
		}
		function fill_dns2tcp_status(status_code) {
			var stext = "Unknown";
			if (status_code == 0)
				stext = "<#Stopped#>";
			else if (status_code == 1)
				stext = "<#Running#>";
			$("dns2tcp_status").innerHTML = '<span class="label label-' + (status_code != 0 ? 'success' : 'warning') + '">' +
				stext + '</span>';
		}
		function fill_dnsproxy_status(status_code) {
			var stext = "Unknown";
			if (status_code == 0)
				stext = "<#Stopped#>";
			else if (status_code == 1)
				stext = "<#Running#>";
			$("dnsproxy_status").innerHTML = '<span class="label label-' + (status_code != 0 ? 'success' : 'warning') + '">' +
				stext + '</span>';
		}
		var arrHashes = ["cfg", "add", "ssl", "cli", "log", "help"];
		function showTab(curHash) {
			var obj = $('tab_ss_' + curHash.slice(1));
			if (obj == null || obj.style.display == 'none')
				curHash = '#cfg';
			for (var i = 0; i < arrHashes.length; i++) {
				if (curHash == ('#' + arrHashes[i])) {
					$j('#tab_ss_' + arrHashes[i]).parents('li').addClass('active');
					$j('#wnd_ss_' + arrHashes[i]).show();
				} else {
					$j('#wnd_ss_' + arrHashes[i]).hide();
					$j('#tab_ss_' + arrHashes[i]).parents('li').removeClass('active');
				}
			}
			window.location.hash = curHash;
		}
		function getHash() {
			var curHash = window.location.hash.toLowerCase();
			for (var i = 0; i < arrHashes.length; i++) {
				if (curHash == ('#' + arrHashes[i]))
					return curHash;
			}
			return ('#' + arrHashes[0]);
		}
		function markGroupRULES(o, c, b) {
			document.form.group_id.value = "SspList";
			if (b == " Add ") {
				if (document.form.ssp_staticnum_x_0.value >= c) {
					alert("<#JS_itemlimit1#> " + c + " <#JS_itemlimit2#>");
					return false;
				}
			}
			pageChanged = 0;
			document.form.action_mode.value = b;
			document.form.current_page.value = "Shadowsocks.asp#add";
			return true;
		}
		//订阅节点
		function dlink() {
		ctime();
			var ns = {};
			ns[1] = "dlink";
			document.getElementById("btn_update_link").value="正在更新";
			$j.ajax({
				url: "/applydb.cgi?usedlink=1&p=ss",
				type: 'POST',
				contentType: "application/x-www-form-urlencoded",
				dataType: 'text',
				data: $j.param(ns),
				error: function (xhr) {
					alert("脚本执行失败！！！")
				},
				success: function (response) {
					setTimeout("dtime();$j('#table99').bootstrapTable('refresh');document.getElementById('btn_update_link').value='更新订阅';",1000);
				}
			});
		}
		//清空节点
		function ddlink() {
		ctime();
			var ns = {};
			ns[1] = "ddlink";
			document.getElementById("btn_rest_link").value="正在清空";
			$j.ajax({
				url: "/applydb.cgi?useddlink=1&p=ss",
				type: 'POST',
				contentType: "application/x-www-form-urlencoded",
				dataType: 'text',
				data: $j.param(ns),
				error: function (xhr) {
					alert("脚本执行失败！！！")
				},
				success: function (response) {
					node_global_max=0;
					setTimeout("dtime();$j('#table99').bootstrapTable('refresh');document.getElementById('btn_rest_link').value='清空节点';",1000);
				}
			});
		}
		function showMRULESList() {
					$j('#table99').bootstrapTable({
						//data: myss,
						striped: true,
						pageNumber: 1,
						pagination: true,
						sortable: true,
						sortName: 'ids',
						sortOrder: "desc",
						sidePagination: 'client',
						pageSize: 15,
						pageList: [15, 25, 35, 50], // 分页显示记录数
						uniqueId: "ids",
						ajax:function(request) {
						$j.ajax({
						  url:"/dbconf?p=ss&v=<% uptime(); %>",
						  type:"get",
						  success:function(data){
							request.success({
							  row : data
							});
							//显示节点下拉列表 by 花妆男
					// 渲染父节点  obj 需要渲染的数据 keyStr key需要去除的字符串
					var keyStr = "ssconf_basic_json_";
					var nodeList = document.getElementById("nodeList"); // 获取TCP节点
					var unodeList = document.getElementById("u_nodeList"); // 获取UDP节点
					var s5nodeList = document.getElementById("s5_nodeList"); // 获取SOCK5节点
					nodeList.options.length=1; // 清除TCP旧节点，准备获取新列表信息
					unodeList.options.length=1;// 清除UDP旧节点，准备获取新列表信息
					s5nodeList.options.length=1;// 清除SOCK5旧节点，准备获取新列表信息
					for (var key in db_ss) { // 遍历对象
						var optionObj = JSON.parse(db_ss[key]); // 字符串转为对象
						//if(optionObj.ping != "failed"){   //过滤ping不通的节点
						var text = '[ ' + (optionObj.type ? optionObj.type : "类型获取失败") + ' ] ' + (optionObj.alias ? optionObj.alias : "名字获取失败"); // 判断下怕获取失败 ，括号是运算的问题
						// 添加 
						nodeList.options.add(new Option(text, key.replace(keyStr, ''))); // 通过 replacce把不要的字符去掉
						unodeList.options.add(new Option(text, key.replace(keyStr, ''))); // 通过 replacce把不要的字符去掉
						s5nodeList.options.add(new Option(text, key.replace(keyStr, ''))); // 通过 replacce把不要的字符去掉
						$j('#nodeList>option').sort(function (a, b) {
							var aText = $j(a).val() * 1;
							var bText = $j(b).val() * 1;
							if (aText > bText) return -1;
							if (aText < bText) return 1;
							return 0;
						}).appendTo('#nodeList');
						$j('#nodeList>option').eq(0).attr("selected", "selected");
						//udp列表
						$j('#u_nodeList>option').sort(function (a, b) {
							var aText = $j(a).val() * 1;
							var bText = $j(b).val() * 1;
							if (aText > bText) return -1;
							if (aText < bText) return 1;
							return 0;
						}).appendTo('#u_nodeList');
						$j('#u_nodeList>option').eq(0).attr("selected", "selected");
						//s5列表
						$j('#s5_nodeList>option').sort(function (a, b) {
							var aText = $j(a).val() * 1;
							var bText = $j(b).val() * 1;
							if (aText > bText) return -1;
							if (aText < bText) return 1;
							return 0;
						}).appendTo('#s5_nodeList');
						$j('#s5_nodeList>option').eq(0).attr("selected", "selected");
						//$j('#nodeList').selectpicker('val', '<% nvram_get_x("","global_server"); %>'); //主服务器列表默认
						//$j('#u_nodeList').selectpicker('val', '<% nvram_get_x("","udp_relay_server"); %>'); //UDP服务器列表默认
						document.form.global_server.value = '<% nvram_get_x("","global_server"); %>';
						document.form.udp_relay_server.value = '<% nvram_get_x("","udp_relay_server"); %>';
						document.form.socks5_enable.value = '<% nvram_get_x("","socks5_enable"); %>';
						//}
					}
					//订阅节点表格
					var myss = new Array();
					var i = 0;
					for (var key in db_ss) { // 遍历对象
						var dbss = JSON.parse(db_ss[key])
						dbss.ids = key.replace("ssconf_basic_json_", '');
						myss[i] = dbss;
						i = i + 1;
						if (myss != null) {
							var node_i = parseInt(key.replace("ssconf_basic_json_", ''));
							if (node_i > node_global_max) {
								node_global_max = node_i;
							}
						}
					}
							$j('#table99').bootstrapTable('load', myss);
						  },
						  error:function(error){
							console.log(error);
						  }
						})
					  },
						columns: [{
							field: 'delete',
							title: '删除',
							checkbox: true,
							width: '30px'
						}, {
							field: 'ids',
							title: '序号',
							width: '30px',
							align: 'center',
							valign: 'middle',
							sortable: true
						}, {
							field: 'type',
							title: '类型',
							align: 'center',
							valign: 'middle',
							width: '10px'
						}, {
							field: 'alias',
							cellStyle: formatTableUnit,
							formatter: paramsMatter,
							title: '别名',
							align: 'center',
							valign: 'middle',
							width: '230px'
						}, {
							field: 'server',
							cellStyle: formatTableUnit,
							formatter: paramsMatter,
							title: '服务器地址',
							align: 'center',
							valign: 'middle',
							width: '150px'
						}, {
							field: 'ping',
							title: 'ping',
							align: 'center',
							valign: 'middle',
							width: '50px',
							cellStyle: cellStylesales,
							formatter: actionFormatter2,
							sortable: true
						}, {
							field: 'lost',
							title: '丢包',
							align: 'center',
							valign: 'middle',
							width: '50px'
						}, {
							field: 'operate',
							title: '操作',
							width: '200px',
							align: 'center',
							valign: 'middle',
							events: window.operateEvents,
							formatter: actionFormatter
						}]
					});
		}
		function cellStylesales(value, row, index) {
			var ping = row.ping
			if (typeof (ping) == "undefined") {
				return ""
			} else if (ping < 100) {
				return {
					css: {
						background: '#04B404',
						color: '#000'
					}
				};
			} else if (ping < 300) {
				return {
					css: {
						background: '#ffeb3b',
						color: '#000'
					}
				};
			} else {
				return {
					css: {
						background: '#f44336',
						color: '#000'
					}
				};
			}
		}
		function actionFormatter2(value, row, index) {
			var ping = row.ping
			var result = "";
			if (typeof (ping) == "undefined") {
				result += "-";
			} else if (ping != "failed") {
				result += ping + "ms";
			} else {
				result += ping
			}
			return result;
		}
		function actionFormatter(value, row, index) {
			return [
				'<a class="edit_ss" href="javascript:void(0)" title="编辑">编辑</a>',
				'<a class="copy_ss" href="javascript:void(0)" title="复制">复制</a>',
				'<a class="del_ss" href="javascript:void(0)" title="删除">删除</a>'
			].join(' | ');
		}
		window.operateEvents = {
			'click .edit_ss': function (e, value, row, index) {
				editing_ss_id = row.ids;
				document.getElementById("ss_setting_title").innerHTML = "编辑节点";
				showSSEditor(row);
			},
			'click .copy_ss': function (e, value, row, index) {
				editing_ss_id = 0;
				document.getElementById("ss_setting_title").innerHTML = "复制节点";
				showSSEditor(row);
			},
			'click .del_ss': function (e, value, row, index) {
				if (confirm('确认删除' + row.alias + '吗？')) {
					del(row.ids);
				}
			}
		}
		function initSSParams() {
			//ss
			document.getElementById('ssp_type').value = 'ss';
			document.getElementById('ssp_name').value = '';
			document.getElementById('ssp_server').value = '';
			document.getElementById('ssp_prot').value = '';
			document.getElementById("ss_password").value = '';
			//ssr
			document.getElementById("ss_method").value = 'rc4-md5';
			document.getElementById("ss_plugin").value = '';
			document.getElementById("ss_plugin_opts").value = '';
			document.getElementById("ss_protocol").value = 'origin';
			document.getElementById("ss_protocol_param").value = '';
			document.getElementById("ss_obfs").value = 'plain';
			document.getElementById("ss_obfs_param").value = '';
			//v2
			document.getElementById("ssp_insecure").value = 0;
			document.getElementById("ssp_insecure").checked = false;
			document.getElementById("v2_mux").value = 0;
			document.getElementById("v2_mux").checked = false;
			document.getElementById("v2_security").value = 'none';
			document.getElementById("v2_vmess_id").value = '';
			document.getElementById("v2_alter_id").value = '';
			document.getElementById("v2_transport").value = 'tcp';
			document.getElementById("v2_tcp_guise").value = 'none';
			document.getElementById("v2_tls").value = '0';
			document.getElementById("v2_flow").value = '0';
			document.getElementById("v2_http_host").value = '';
			document.getElementById("v2_http_path").value = '/';
			//document.getElementById("v2_tls").checked = false;
			document.getElementById("ssp_tls_host").value = '';
			//"v2 tcp"
			document.getElementById("v2_kcp_guise").value = 'none';
			document.getElementById("v2_mtu").value = '';
			document.getElementById("v2_tti").value = '';
			document.getElementById("v2_uplink_capacity").value = '';
			document.getElementById("v2_downlink_capacity").value = '';
			document.getElementById("v2_read_buffer_size").value = '';
			document.getElementById("v2_write_buffer_size").value = '';
			//v2 ws
			document.getElementById("v2_ws_host").value = '';
			document.getElementById("v2_ws_path").value = '';
			//v2 grpc
			document.getElementById("v2_grpc_path").value = '';
			//v2 h2
			document.getElementById("v2_h2_host").value = '';
			document.getElementById("v2_h2_path").value = '';
			//v2 quic
			document.getElementById("v2_quic_key").value = '';
			document.getElementById("v2_quic_guise").value = 'none';
			document.getElementById("v2_quic_security").value = 'none';
			//sock5
			document.getElementById("s5_password").value = '';
			document.getElementById("s5_username").value = '';
			switch_ss_type();
		}
		//编辑节点
		function showSSEditor(ss) {
			function getProperty(obj, prop, defVal) {
				return obj && obj.hasOwnProperty(prop) ? obj[prop] : defVal;
			}
			var type = getProperty(ss, 'type', 'ss');
			document.getElementById('ssp_type').value = type;
			document.getElementById('ssp_name').value = getProperty(ss, 'alias', '');
			document.getElementById('ssp_server').value = getProperty(ss, 'server', '');
			document.getElementById('ssp_prot').value = getProperty(ss, 'server_port', '');
			document.getElementById("ss_password").value = getProperty(ss, 'password', '');
			if (type == 'ss') {
				document.getElementById("ss_method").value = getProperty(ss, 'encrypt_method_ss', 'none'),
				document.getElementById("ss_plugin").value = getProperty(ss, 'plugin', ''),
				document.getElementById("ss_plugin_opts").value = getProperty(ss, 'plugin_opts', '');
			} else if (type == "ssr") {
				document.getElementById("ss_protocol").value = getProperty(ss, 'protocol', 'origin');
				document.getElementById("ss_protocol_param").value = getProperty(ss, 'protocol_param', '');
				document.getElementById("ss_method").value = getProperty(ss, 'encrypt_method', 'none');
				document.getElementById("ss_obfs").value = getProperty(ss, 'obfs', 'plain');
				document.getElementById("ss_obfs_param").value = getProperty(ss, 'obfs_param', '');
			} else if (type == "v2ray" || type == "xray") {
				var transport = getProperty(ss, 'transport', 'tcp');
				document.getElementById("ssp_insecure").value = getProperty(ss, 'insecure', 0);
				document.getElementById("ssp_insecure").checked = document.getElementById("ssp_insecure").value != 0;
				document.getElementById("v2_mux").value = getProperty(ss, 'mux', 0);
				document.getElementById("v2_mux").checked = document.getElementById("v2_mux").value != 0;
				document.getElementById("v2_security").value = getProperty(ss, 'security', 'auto');
				document.getElementById("v2_vmess_id").value = getProperty(ss, 'vmess_id', '');
				document.getElementById("v2_alter_id").value = getProperty(ss, 'alter_id', '');
				document.getElementById("v2_transport").value = transport;
				document.getElementById("v2_tcp_guise").value = getProperty(ss, 'tcp_guise', 'none');
				document.getElementById("v2_http_host").value = getProperty(ss, 'http_host', '');
				document.getElementById("v2_http_path").value = getProperty(ss, 'http_path', '');
				document.getElementById("v2_tls").value = getProperty(ss, 'tls', '0');
				document.getElementById("v2_flow").value = getProperty(ss, 'flow', '0');
				//document.getElementById("v2_tls").checked =  document.getElementById("v2_tls").value != 0;
				document.getElementById("ssp_tls_host").value = getProperty(ss, 'tls_host', '');
				if (transport == "kcp") {
					document.getElementById("v2_kcp_guise").value = getProperty(ss, 'kcp_guise', 'none');
					document.getElementById("v2_mtu").value = getProperty(ss, 'mtu', '');
					document.getElementById("v2_tti").value = getProperty(ss, 'tti', '');
					document.getElementById("v2_uplink_capacity").value = getProperty(ss, 'uplink_capacity', '');
					document.getElementById("v2_downlink_capacity").value = getProperty(ss, 'downlink_capacity', '');
					document.getElementById("v2_read_buffer_size").value = getProperty(ss, 'read_buffer_size', '');
					document.getElementById("v2_write_buffer_size").value = getProperty(ss, 'write_buffer_size', '');
				} else if (transport == "ws") {
					document.getElementById("v2_ws_host").value = getProperty(ss, 'ws_host', '');
					document.getElementById("v2_ws_path").value = getProperty(ss, 'ws_path', '');
				} else if (transport == "grpc") {
					document.getElementById("v2_grpc_path").value = getProperty(ss, 'grpc_path', '');
				} else if (transport == "h2") {
					document.getElementById("v2_h2_host").value = getProperty(ss, 'h2_host', '');
					document.getElementById("v2_h2_path").value = getProperty(ss, 'h2_path', '');
				} else if (transport == "quic") {
					document.getElementById("v2_quic_guise").value = getProperty(ss, 'quic_guise', 'none');
					document.getElementById("v2_quic_key").value = getProperty(ss, 'quic_key', '');
					document.getElementById("v2_quic_security").value = getProperty(ss, 'quic_security', 'none');
				}
			} else if (type == "trojan") {
				document.getElementById("ssp_insecure").value = getProperty(ss, 'insecure', 0);
				document.getElementById("ssp_insecure").checked = document.getElementById("ssp_insecure").value != 0;
				document.getElementById("v2_tls").value = 1;
				//document.getElementById("v2_tls").checked = document.getElementById("v2_tls") != 0;
				document.getElementById("ssp_tls_host").value = getProperty(ss, 'tls_host', '');
			} else if (type == "socks5") {
				//
			}
			switch_ss_type();
			$j("#vpnc_settings").fadeIn(200);
		}
		//单项删除
		function del(id) {
		ctime();
			var p = "ssconf_basic";
			var ns = {};
			ns[p + "_json_" + id] = "deleting";
			$j.ajax({
				url: "/applydb.cgi?userm1=del&p=ss",
				type: 'POST',
				contentType: "application/x-www-form-urlencoded",
				dataType: 'text',
				data: $j.param(ns),
				error: function (xhr) {
					alert("删除失败,请重试！")
				},
				success: function (response) {
				dtime();
					$j('#table99').bootstrapTable('refresh');
				}
			});
		}
		//批量删除
		function del_dlink() {
		ctime();
			var row = $j("#table99").bootstrapTable('getSelections');
			var p = "ssconf_basic";
			var ns = {};
			for (var key in row) {
				ns[p + "_json_" + row[key].ids] = "deleting";
			}
			//console.log(ns)
			document.getElementById("btn_del_link").value="正在删除节点";
			$j.ajax({
				url: "/applydb.cgi?userm1=del&p=ss",
				type: 'POST',
				contentType: "application/x-www-form-urlencoded",
				dataType: 'text',
				data: $j.param(ns),
				error: function (xhr) {
					alert("删除失败,请重试！")
				},
				success: function (response) {
					setTimeout("dtime();$j('#table99').bootstrapTable('refresh');document.getElementById('btn_del_link').value='批量删除节点';",1000);
				}
			});
		}
		//ping节点
		function ping_dlink() {
		ctime();
			var row = $j("#table99").bootstrapTable('getSelections');
			var p = "ssconf_basic";
			var ns = {};
			for (var key in row) {
				ns[row[key].ids] = "ping";
			}
			//showLoading();
			document.getElementById("btn_ping_link").value="正在ping节点";
			$j.ajax({
				url: "/applydb.cgi?useping=1&p=ss",
				type: 'POST',
				contentType: "application/x-www-form-urlencoded",
				dataType: 'text',
				data: $j.param(ns),
				error: function (xhr) {
					alert("脚本执行失败！！！")
				},
				success: function (response) {
					setTimeout("dtime();$j('#table99').bootstrapTable('refresh');document.getElementById('btn_ping_link').value='ping节点';",2000);
				}
			});
		}
		//ping全部节点
		function aping_dlink() {
		ctime();
			var ns = {};
			ns[1] = "allping";
			document.getElementById("btn_aping_link").value="正在ping全部节点";
			$j.ajax({
				url: "/applydb.cgi?useping=1&p=ss",
				type: 'POST',
				contentType: "application/x-www-form-urlencoded",
				dataType: 'text',
				data: $j.param(ns),
				error: function (xhr) {
					alert("脚本执行失败！！！")
				},
				success: function (response) {
					setTimeout("dtime();$j('#table99').bootstrapTable('refresh');document.getElementById('btn_aping_link').value='ping全部节点';",2000);
				}
			});
		}
		function paramsMatter(value, row, index) {
			var span = document.createElement("span");
			span.setAttribute("title", value);
			span.innerHTML = value;
			return span.outerHTML;
		}
		//td宽度以及内容超过宽度隐藏
		function formatTableUnit(value, row, index) {
			return {
				css: {
					"white-space": "nowrap",
					"text-overflow": "ellipsis",
					"overflow": "hidden",
					"max-width": "60px"
				}
			}
		}
		//-----------导入链接开始
		function padright(str, cnt, pad) {
			return str + Array(cnt + 1).join(pad);
		}
		function b64EncodeUnicode(str) {
			return btoa(encodeURIComponent(str).replace(/%([0-9A-F]{2})/g, function (match, p1) {
				return String.fromCharCode('0x' + p1);
			}));
		}
		function b64encutf8safe(str) {
			return b64EncodeUnicode(str).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/g, '');
		}
		function b64DecodeUnicode(str) {
			return decodeURIComponent(Array.prototype.map.call(atob(str), function (c) {
				return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
			}).join(''));
		}
		function b64decutf8safe(str) {
			var l;
			str = str.replace(/-/g, "+").replace(/_/g, "/");
			l = str.length;
			l = (4 - l % 4) % 4;
			if (l)
				str = padright(str, l, "=");
			return b64DecodeUnicode(str);
		}
		function b64encsafe(str) {
			return btoa(str).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/g, '')
		}
		function b64decsafe(str) {
			var l;
			str = str.replace(/-/g, "+").replace(/_/g, "/");
			l = str.length;
			l = (4 - l % 4) % 4;
			if (l)
				str = padright(str, l, "=");
			return atob(str);
		}
		function dictvalue(d, key) {
			var v = d[key];
			if (typeof (v) == 'undefined' || v == '')
				return '';
			return b64decsafe(v);
		}
		function import_ssr_url(btn, urlname, sid) {
			var s = document.getElementById(urlname + '-status');
			if (!s)
				return false;
			var ssrurl = prompt("在这里黏贴配置链接 ssr:// | ss:// | vmess:// | vless:// | trojan://", "");
			if (ssrurl == null || ssrurl == "") {
				s.innerHTML = "<font color='red'>用户取消</font>";
				return false;
			}
			initSSParams();
			s.innerHTML = "";
			//var ssu = ssrurl.match(/ssr:\/\/([A-Za-z0-9_-]+)/i);
			var ssu = ssrurl.split('://');
			//console.log(ssu.length);
			if ((ssu[0] != "ssr" && ssu[0] != "ss" && ssu[0] != "vmess" && ssu[0] != "vless" && ssu[0] != "trojan") || ssu[1] == "") {
				s.innerHTML = "<font color='red'>无效格式</font>";
				return false;
			}
			var event = document.createEvent("HTMLEvents");
			event.initEvent("change", true, true);
			initSSParams();
			if (ssu[0] == "ssr") {
				var sstr = b64decsafe(ssu[1]);
				var ploc = sstr.indexOf("/?");
				document.getElementById('ssp_type').value = "ssr";
				document.getElementById('ssp_type').dispatchEvent(event);
				var url0, param = "";
				if (ploc > 0) {
					url0 = sstr.substr(0, ploc);
					param = sstr.substr(ploc + 2);
				}
				var ssm = url0.match(/^(.+):([^:]+):([^:]*):([^:]+):([^:]*):([^:]+)/);
				if (!ssm || ssm.length < 7)
					return false;
				var pdict = {};
				if (param.length > 2) {
					var a = param.split('&');
					for (var i = 0; i < a.length; i++) {
						var b = a[i].split('=');
						pdict[decodeURIComponent(b[0])] = decodeURIComponent(b[1] || '');
					}
				}
				document.getElementById('ssp_server').value = ssm[1];
				document.getElementById('ssp_prot').value = ssm[2];
				document.getElementById('ss_protocol').value = ssm[3];
				document.getElementById('ss_method').value = ssm[4];
				document.getElementById('ss_obfs').value = ssm[5];
				document.getElementById('ss_password').value = b64decsafe(ssm[6]);
				document.getElementById('ss_obfs_param').value = dictvalue(pdict, 'obfsparam');
				document.getElementById('ss_protocol_param').value = dictvalue(pdict, 'protoparam');
				var rem = pdict['remarks'];
				if (typeof (rem) != 'undefined' && rem != '' && rem.length > 0)
					document.getElementById('ssp_name').value = b64decutf8safe(rem);
				s.innerHTML = "<font color='green'>导入ShadowsocksR配置信息成功</font>";
				return false;
			} else if (ssu[0] == "ss") {
				var url0, param = "";
				var sipIndex = ssu[1].indexOf("@");
				var ploc = ssu[1].indexOf("#");
				if (ploc > 0) {
					url0 = ssu[1].substr(0, ploc);
					param = ssu[1].substr(ploc + 1);
				} else {
					url0 = ssu[1]
				}
				if (sipIndex != -1) {
				var userInfo = b64decsafe(url0.substr(0, sipIndex));
				var temp = url0.substr(sipIndex + 1).split("/?");
				var serverInfo = temp[0].split(":");
				var server = serverInfo[0];
				var port = serverInfo[1].replace("/","");
				var method, password, plugin, pluginOpts;
				if (temp[1]) {
					var pluginInfo = decodeURIComponent(temp[1]);
					var pluginIndex = pluginInfo.indexOf(";");
					var pluginNameInfo = pluginInfo.substr(0, pluginIndex);
					plugin = pluginNameInfo.substr(pluginNameInfo.indexOf("=") + 1);
					pluginOpts = pluginInfo.substr(pluginIndex + 1);
				}
				var userInfoSplitIndex = userInfo.indexOf(":");
				if (userInfoSplitIndex != -1) {
					method = userInfo.substr(0, userInfoSplitIndex);
					password = userInfo.substr(userInfoSplitIndex + 1);
				}
				document.getElementById('ssp_type').value = "ss";
				document.getElementById('ssp_type').dispatchEvent(event);
				document.getElementById('ssp_server').value = server;
				document.getElementById('ssp_prot').value = port;
				document.getElementById('ss_password').value = password || "";
				document.getElementById('ss_method').value = method || "";
				document.getElementById('ss_plugin').value = plugin || "";
				if (plugin != undefined && plugin != "") {
				document.getElementById('ss_plugin_opts').value = pluginOpts || "";
				}
				if (param != undefined) {
				document.getElementById('ssp_name').value = decodeURI(param);
				}				
				s.innerHTML = "<font color='green'>导入Shadowsocks配置信息成功</font>";
				}
			 else {
				var sstr = b64decsafe(url0);
				document.getElementById('ssp_type').value = "ss";
				document.getElementById('ssp_type').dispatchEvent(event);
				var team = sstr.split('@');
				console.log(param);
				var part1 = team[0].split(':');
				var part2 = team[1].split(':');
				document.getElementById('ssp_server').value = part2[0];
				document.getElementById('ssp_prot').value = part2[1];
				document.getElementById('ss_password').value = part1[1];
				document.getElementById('ss_method').value = part1[0];
				s.innerHTML = "<font color='green'>导入Shadowsocks配置信息成功</font>";
				}
				if (param != undefined) {
					document.getElementById('ssp_name').value = decodeURI(param);
				}
				return false;
			} else if (ssu[0] == "trojan") {
				var url0, param = "";
				var ploc = ssu[1].indexOf("#");
				if (ploc > 0) {
					url0 = ssu[1].substr(0, ploc);
					param = ssu[1].substr(ploc + 1);
				} else {
					url0 = ssu[1]
				}
				var sstr = url0;
				document.getElementById('ssp_type').value = "trojan";
				document.getElementById('ssp_type').dispatchEvent(event);
				var team = sstr.split('@');
				var password = team[0]
				var serverPart = team[1].split(':');
				var others = serverPart[1].split('?');
				var port = parseInt(others[0]);
				var queryParam = {}
				if (others.length > 1) {
					var queryParams = others[1]
					var queryArray = queryParams.split('&');
					for (i = 0; i < queryArray.length; i++) {
						var params = queryArray[i].split('=');
						queryParam[decodeURIComponent(params[0])] = decodeURIComponent(params[1] || '');
					}
				}
				document.getElementById('ssp_server').value = serverPart[0];
				document.getElementById('ssp_prot').value = port || '443';;
				document.getElementById('ss_password').value = password;
				document.getElementById('v2_tls').value = '1';
				document.getElementById('ssp_tls_host').value = queryParam.sni || '';
				if (param != undefined) {
					document.getElementById('ssp_name').value = decodeURI(param);
				}
				s.innerHTML = "<font color='green'>导入Trojan配置信息成功</font>";
				return false;
			} else if (ssu[0] == "vmess") {
				var sstr = b64DecodeUnicode(ssu[1]);
				console.log(sstr);
				var ploc = sstr.indexOf("/?");
				document.getElementById('ssp_type').value = "v2ray";
				document.getElementById('ssp_type').dispatchEvent(event);
				var url0, param = "";
				if (ploc > 0) {
					url0 = sstr.substr(0, ploc);
					param = sstr.substr(ploc + 2);
				}
				var ssm = JSON.parse(sstr);
				document.getElementById('ssp_name').value = ssm.ps;
				document.getElementById('ssp_server').value = ssm.add;
				document.getElementById('ssp_prot').value = ssm.port;
				document.getElementById('v2_alter_id').value = ssm.aid;
				document.getElementById('v2_vmess_id').value = ssm.id;
				document.getElementById('v2_transport').value = ssm.net;
				document.getElementById('v2_transport').dispatchEvent(event);
				if (ssm.net == "tcp") {
					if (ssm.type && ssm.type != "http") {
						ssm.type = "none"
					}
					document.getElementById('v2_tcp_guise').value = ssm.type;
					document.getElementById('v2_http_host').value = ssm.host;
					if (ssm.path != undefined){
						document.getElementById('v2_http_path').value = ssm.path;
					}
					else {
						document.getElementById('v2_http_path').value = '/';
					}
				} 
				if (ssm.net == "ws") {
					document.getElementById('v2_ws_host').value = ssm.host;
					document.getElementById('v2_ws_path').value = ssm.path;
				}
				if (ssm.net == "grpc") {
					document.getElementById('v2_grpc_path').value = ssm.path;
				}
				if (ssm.net == "h2") {
					document.getElementById('v2_h2_host').value = ssm.host;
					document.getElementById('v2_h2_path').value = ssm.path;
				}
				if (ssm.tls == "tls") {
					document.getElementById('v2_tls').value = '1';
					//document.getElementById('v2_tls').checked = true;
					document.getElementById('ssp_insecure').value = 1;
					document.getElementById('ssp_insecure').checked = true;
					document.getElementById('ssp_tls_host').value = ssm.host;
				}
				s.innerHTML = "<font color='green'>导入V2ray配置信息成功</font>";
				return false;
			} else if (ssu[0] == "vless") {
				var url0, param = "";
				var ploc = ssu[1].indexOf("#");
				if (ploc > 0) {
					url0 = ssu[1].substr(0, ploc);
					param = ssu[1].substr(ploc + 1);
				} else {
					url0 = ssu[1]
				}
				if (param != undefined) {
					document.getElementById('ssp_name').value = decodeURI(param);
				}
				var sstr = url0;
				var team = sstr.split('@');
				var password = team[0]
				var serverPart = team[1].split(':');
				var others = serverPart[1].split('?');
				var port = others[0]
				var queryParam = {}
				if (others.length > 1) {
				var queryParams = others[1]
				var queryArray = queryParams.split('&');
				for (i = 0; i < queryArray.length; i++) {
					var params = queryArray[i].split('=');
					queryParam[decodeURIComponent(params[0])] = decodeURIComponent(params[1] || '');
									}
							}
				document.getElementById('ssp_server').value = serverPart[0];
				document.getElementById('ssp_prot').value = port;
				document.getElementById('v2_vmess_id').value = password;
				document.getElementById('v2_alter_id').value = "0";
				document.getElementById('ssp_type').value = "xray";
				document.getElementById('ssp_type').dispatchEvent(event);
				document.getElementById('v2_security').value = queryParam.encryption || "none";
				document.getElementById('v2_transport').value = queryParam.type || "tcp";
				document.getElementById('v2_transport').dispatchEvent(event);

				if (queryParam.security == "tls") {
					document.getElementById('v2_tls').value = '1';
					document.getElementById('v2_flow').value = '0';
					//document.getElementById('v2_tls').checked = true;
					document.getElementById('ssp_insecure').value = 0;
					document.getElementById('ssp_insecure').checked = false;
					document.getElementById('ssp_tls_host').value = queryParam.sni || serverPart[0];
				}

				if (queryParam.type == "ws") {
					document.getElementById('v2_ws_host').value = queryParam.host;
					document.getElementById('v2_ws_path').value = queryParam.path;
				}
				if (queryParam.type == "grpc") {
					document.getElementById('v2_grpc_path').value =  queryParam.serviceName;
				}
				if (queryParam.type == "h2") {
					document.getElementById('v2_h2_host').value = queryParam.host;
					document.getElementById('v2_h2_path').value = queryParam.path;
				}

				if (queryParam.security == "xtls") {
					document.getElementById('v2_tls').value = '2';
					if (queryParam.flow != undefined) {
					    if(queryParam.flow == 'xtls-rprx-direct'){
					    	document.getElementById('v2_flow').value = '1';
					    }
					    else if(queryParam.flow == 'xtls-rprx-splice'){
					    	document.getElementById('v2_flow').value = '2';
					    }
					    else
					    {
					    	document.getElementById('v2_flow').value = '0';
					    }
					    
					}
					else
					{
					    document.getElementById('v2_flow').value = '1';
					}
					//document.getElementById('v2_tls').checked = true;
					document.getElementById('ssp_insecure').value = 0;
					document.getElementById('ssp_insecure').checked = false;
					document.getElementById('ssp_tls_host').value = queryParam.sni || serverPart[0];
				}
				s.innerHTML = "<font color='green'>导入Xray配置信息成功</font>";
				return false;
			}
		}
		//-----------导入链接结束
		function check_Timefield_checkbox() {
			if (document.form.ss_date_x_Sun.checked == true ||
				document.form.ss_date_x_Mon.checked == true ||
				document.form.ss_date_x_Tue.checked == true ||
				document.form.ss_date_x_Wed.checked == true ||
				document.form.ss_date_x_Thu.checked == true ||
				document.form.ss_date_x_Fri.checked == true ||
				document.form.ss_date_x_Sat.checked == true) {
				inputCtrl(document.form.ss_time_x_hour, 1);
				inputCtrl(document.form.ss_time_x_min, 1);
				document.form.ss_schedule.disabled = false;
			} else {
				inputCtrl(document.form.ss_time_x_hour, 0);
				inputCtrl(document.form.ss_time_x_min, 0);
				document.form.ss_schedule.disabled = true;
				document.getElementById('ss_schedule_time_tr').style.display = "";
			}
		}
		function getrebootTimeRange(str, pos) {
			if (pos == 0)
				return str.substring(7, 9);
			else if (pos == 1)
				return str.substring(9, 11);
		}
		function setrebootTimeRange(rd, rh, rm) {
			return (rd.value + rh.value + rm.value);
		}
		function updateDateTime() {
			if (document.form.ss_schedule_enable_x[0].checked) {
				document.form.ss_schedule_enable.value = "1";
				document.form.ss_schedule.disabled = false;
				document.form.ss_schedule.value = setDateCheck(
					document.form.ss_date_x_Sun,
					document.form.ss_date_x_Mon,
					document.form.ss_date_x_Tue,
					document.form.ss_date_x_Wed,
					document.form.ss_date_x_Thu,
					document.form.ss_date_x_Fri,
					document.form.ss_date_x_Sat);
				document.form.ss_schedule.value = setrebootTimeRange(
					document.form.ss_schedule,
					document.form.ss_time_x_hour,
					document.form.ss_time_x_min);
			} else
				document.form.ss_schedule_enable.value = "0";
		}
		//点击保存节点按钮
		function showNodeData(idName, obj) {
			var nodeData = document.getElementById(idName);
			//console.log(nodeData);
			for (var key in obj) {
				var tr = document.createElement("tr");
				var td = document.createElement("td");
				var td2 = document.createElement("td");
				var input = document.createElement("input");
				td.innerText = obj[key];
				tr.appendChild(td);
				input.name = key;
				td2.appendChild(input);
				tr.appendChild(td2);
				nodeData.appendChild(tr);
			}
		}
		function add_ss() {
			showhide_div('vpnc_settings', 0);
			var type = document.getElementById("ssp_type").value;
			if (type == "ss") {
				var DataObj = {
					type: document.getElementById("ssp_type").value,
					alias: document.getElementById("ssp_name").value,
					server: document.getElementById("ssp_server").value,
					server_port: document.getElementById("ssp_prot").value,
					password: document.getElementById("ss_password").value,
					encrypt_method_ss: document.getElementById("ss_method").value,
					plugin: document.getElementById("ss_plugin").value,
					plugin_opts: document.getElementById("ss_plugin_opts").value,
					coustom: "1",
				}
			} else if (type == "ssr") {
				var DataObj = {
					type: document.getElementById("ssp_type").value,
					alias: document.getElementById("ssp_name").value,
					server: document.getElementById("ssp_server").value,
