<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="0">
<title>选择部门</title>
<link href="${pageContext.request.contextPath}/css/cupertino/jquery-ui-1.8.15.custom.css" rel="stylesheet" type="text/css" media="screen" />
<link href="${pageContext.request.contextPath}/css/hodanet.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.8.15.custom.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jstree/jquery.jstree.js"></script>
<script type="text/javascript">
$.ajaxSetup({cache:false});

$(function(){
	$(".departmentTree").jstree({
		"ui":{"select_limit" : 1},
		"json_data":{
			"ajax":{
				"url":"${pageContext.request.contextPath}/department/getChooseData.do",
				"data":function(node){//该函数用来获取提交参数
					if(node!='-1'){
						return {'pid':node.attr('id')};
					}else{
						return {'pid':'${pid }${pidFlag }'};
					}
				}
			},
			'after_json_load':function(tree,node){
				if($("#flag").val()=='1'){
					tree.hide_checkboxes();
				}
				if(node != "-1"){
					var li = $("li:first",node);
					if(li.length > 0 && li.attr("t")=='department'){
						tree.open_node(li);
					}
				}
			}
		}
		,"sort":function(a,b){
			//返回1 交换位置；返回-1不交换
			var $a = $(a),$b=$(b);
			var ca = $a.attr("create"),cb = $b.attr("create");
			if(ca == null || cb == null) return -1;
			var a1 = parseInt(ca,10);
			var b1 = parseInt(cb,10);
			return a1 > b1 ? 1 : -1;
		},"search":{
			"ajax":{
				"url":"${pageContext.request.contextPath}/department/search.do",
				"data":function(str){
					return {"name":str};
				}
			}
			,show_only_matches:true
		},
		"themes":{"theme":"default",dots:false,icons:true},
		"checkbox":{'two_state':false},
		"plugins":["themes", "json_data", "ui", "checkbox", "sort", "search"]
	}).bind('select_node.jstree',function(event,data){
		var n = data.rslt.obj;
		if(data.inst.is_checked(n)){
			data.inst.uncheck_node(n);
		}else{
			data.inst.check_node(n);
		}
	});

	$('.ok').button().click(function(){
		var nodes = $(".departmentTree").jstree('get_checked',null,true);
		if($("#flag").val()=='1'){
			nodes = $(".departmentTree").jstree('get_selected');
		}
		var tmp = new Array();
		
		if(nodes.length <=0){
			alert('请选择部门！');
			return;
		}
		
		nodes.each(function(i,o){
			tmp.push({'id':$(this).attr('id'),'name':$(".departmentTree").jstree('get_text',this)});
		});
		//调用父页面的函数，传递参数回去
		window.parent.funDialogCallBack('${param.type}',tmp);
	});
	$('.cancle').button().click(function(){
		//调用父窗体的JS函数，关闭
		window.parent.funDialogCallBack('${param.type}');
	});

	//搜索按钮
	$("#btnSearch").button().click(function(){
		if($("#searchValue").val().length > 0){
			$(".departmentTree").jstree("close_all");
			$(".departmentTree").jstree("search",$("#searchValue").val());
		}else{
			$(".departmentTree").jstree("clear_search");
		}
	});
});
</script>
</head>
<body>
<div style="width: 245px;font-size: 12px;">
	<input type='hidden' id='flag' value="${param.flag }">
	<div>
		<label for="searchValue" style="">名称:</label><input id="searchValue" style="width: 100px;"><input type="button" id="btnSearch" value="查找">
	</div>
	<div class="departmentTree" style="width: 240px;height: 280px;overflow: auto;">
	</div>
	<div style="text-align: right;">
		<span class="ok">确定</span><span class="cancle">取消</span>
	</div>
</div>
</body>
</html>