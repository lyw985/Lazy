<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="0">
<title>${commonMapper.title}</title>
<link rel="stylesheet" type="text/css" href="${commonMapper.rootPath}/css/hodanet.css"  />
<link rel="stylesheet" type="text/css" href="${commonMapper.rootPath}/css/pagination/linkbutton.css">
<link rel="stylesheet" type="text/css" href="${commonMapper.rootPath}/css/pagination/icon.css">
<link rel="stylesheet" type="text/css" href="${commonMapper.rootPath}/css/pagination/pagination.css">
<link rel="stylesheet" type="text/css" href="${commonMapper.rootPath}/css/alert/jquery.alerts.css"/>
<link rel="stylesheet" type="text/css" href="${commonMapper.rootPath}/css/cupertino/jquery-ui-1.8.15.custom.css"/>
<link rel="stylesheet" type="text/css" href="${commonMapper.rootPath}/css/validationEngine.jquery.css"/>

<script type="text/javascript" src="${commonMapper.rootPath}/js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="${commonMapper.rootPath}/js/jquery-ui-1.8.15.custom.min.js"></script>
<script type="text/javascript" src="${commonMapper.rootPath}/js/jquery.linkbutton.js"></script>
<script type="text/javascript" src="${commonMapper.rootPath}/js/jquery.pagination.js"></script>
<script type="text/javascript" src="${commonMapper.rootPath}/js/jquery.alerts.js"></script>
<script type="text/javascript" src="${commonMapper.rootPath}/js/jquery.form.js"></script>
<script type="text/javascript" src="${commonMapper.rootPath}/js/hodanet.js"></script>
<script type="text/javascript" src="${commonMapper.rootPath}/js/jquery.validationEngine-en.js"></script>
<script type="text/javascript" src="${commonMapper.rootPath}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${commonMapper.rootPath}/js/jquery.ui.datepicker-zh-CN.js"></script>
<script type="text/javascript" src="${commonMapper.rootPath}/js/chart/Chart.min.js"></script>
<script type="text/javascript" src="${commonMapper.rootPath}/js/chart/utils.js"></script>
<script type="text/javascript" src="${commonMapper.rootPath}/js/util/yuma.js"></script>
<script type="text/javascript">
	$(function() {
		$(".dateTime").datepicker({dateFormat: 'yy-mm-dd',changeMonth: true, changeYear: true});
		
		$(".selAll").click(function() {
			$(".selOne").attr("checked", !!$(".selAll").attr("checked"));
		});

		$(".selOne").click(function() {
			if($(".selOne").length == $(".selOne:checked").length) {
				$(".selAll").attr("checked", true);
			} else {
				$(".selAll").attr("checked", false);
			}
		});
		
		initItemSel("item_id", "item_model_id", "${item_id}","${item_model_id}");
		initProvinceSel("province_id","city_id","area_id","${province_id}","${city_id}","${area_id}");
		$("#chartParamertType").val("${chartParamertType}");
		$("#chartGroupByType1").val("${chartGroupByType1}");
		$("#chartGroupByType2").val("${chartGroupByType2}");
		$("#startDate").val("${startDate}");
		$("#endDate").val("${endDate}");
		
		var chartConfig=eval("("+$("#chartConfig").val()+")");
		
		window.onload = function() {
			var ctx = document.getElementById('canvas').getContext('2d');
			window.myLine = new Chart(ctx, chartConfig);
		};
	});
	
	//添加结果
	function showAddResponse(data)  { 
		if(data.flag){
			jAlert(data.msg,'成功',function(){
				$("#queryForm").submit();
			});
		}else{
			jAlert(data.msg,'失败');
		}
	}
</script>
</head>
<body>
	<div class="handle">
		<span>鱼妈海鲜-->数据统计</span>
		<!-- 
		<a href="#" class="add" id="addButton">新增</a>
		<a href="#" class="remove" id="deleteButton">删除</a> -->
	</div>
	<!-- --------------------查询表单-------------------- -->
	<div class="ui-widget">
		<form:form id="queryForm" action="${commonMapper.rootPath}/yuma/chart/query.do" method="post">
			<input type="hidden" id="pageSize" name="pageSize" value="${pageData.pageSize }"/> 
			<input type="hidden" id="pageNumber" name="pageNumber" value="${pageData.pageNumber }"/>
			<input type="hidden" id="chartConfig" name="chartConfig" value="${chartConfig }"/>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>商品：</td>
					<td>
						<select id="item_id" name="item_id" onchange="initItemModelSel('item_model_id',this.value)"></select> 
					</td>
				</tr>
				<tr>
					<td>型号：</td>
					<td>
						<select id="item_model_id" name="item_model_id" ></select>
					</td>
				</tr>
				<tr>
					<td>省份：</td>
					<td>
						<select id="province_id" name="province_id" onchange="initCitySel('city_id','area_id',this.value)"></select>
					</td>
				</tr>
				<tr>
					<td>城市：</td>
					<td>
						<select id="city_id" name="city_id" onchange="initAreaSel('area_id',this.value)"></select>
					</td>
				</tr>
				<tr>
					<td>地区：</td>
					<td>
						<select id="area_id" name="area_id" ></select>
					</td>
				</tr>
				<tr>
					<td>日期：</td>
					<td>
						<input id="startDate" name="startDate"  class="dateTime" style="width:75px;"/>-<input id="endDate" name="endDate"  class="dateTime" style="width:75px;"/>
					</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>查询类型：</td>
					<td>
						<select id="chartParamertType"  name="chartParamertType">
							<option value="11" selected="selected">订单总量</option>
							<option value="12">订单售价</option>
							<option value="13">订单均价</option>
							<option value="14">订单商品数量</option>
							<!-- <option value="15">订单原价</option> -->
							<!-- <option value="16">订单优惠比例</option> -->
							<option value="21">商品总量</option>
							<option value="22">商品总价</option>
							<option value="23">商品均价</option>
						</select> 
					</td>
				</tr>
				<tr>
					<td>区分条件：</td>
					<td>
						<select id="chartGroupByType1" name="chartGroupByType1" >
							<option value="">---选择区分条件---</option>
							<option value="11">年</option>
							<option value="12">月</option>
							<option value="13">天</option>
							<option value="14">周</option>
							<option value="15">周一至周日</option>
							<option value="16">0-23时</option>
							<option value="21">省份</option>
							<option value="22">城市</option>
							<option value="23">地区</option>
							<option value="31">商品</option>
							<option value="32">商品型号</option>
						</select> 
					</td>
					<td>
						<select id="chartGroupByType2" name="chartGroupByType2" >
							<option value="">---选择区分条件---</option>
							<option value="11">年</option>
							<option value="12">月</option>
							<option value="13">天</option>
							<option value="14">周</option>
							<option value="15">周一至周日</option>
							<option value="16">0-23时</option>
							<option value="21">省份</option>
							<option value="22">城市</option>
							<option value="23">地区</option>
							<option value="31">商品</option>
							<option value="32">商品型号</option>
						</select> 
					</td>
					<td>
						<input type="submit" id="btnSearch" name="btnSearch" class="buttonStyle" value="查询" />
					</td>
				</tr>
			</table>
		</form:form>
	</div>
	<!-- --------------------信息记录列表-------------------- -->
	<div class="chartDiv" style="background-color: white;width: 90%;">
		<canvas id="canvas"></canvas>
		<br>
	</div>
	<!-- --------------------弹出页面-------------------- -->
	<div id="divDialog"></div>
</body>
</html>