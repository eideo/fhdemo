<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
	<head>
	<%@ include file="/include/top.jsp" %>
	<%@ include file="/include/table.jsp" %>
	<script src="http://cdn.static.runoob.com/libs/angular.js/1.4.6/angular.min.js"></script>
	
	</head>
	
	<body>
	<div ng-app="myApp" ng-controller="siteCtrl"> 
	
		<div class="container-fluid" id="main-container" >
		<div id="page-content" class="clearfix">
	  	<div class="row-fluid">
		<div class="row-fluid">
			<!-- 检索  -->
			<form action="user/listUsers.do" method="post" name="userForm" id="userForm">
			<table>
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="USERNAME" value="${pd.USERNAME }" placeholder="这里输入关键词" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
					<td><input class="span10 date-picker" name="lastLoginStart" id="lastLoginStart"  value="${pd.lastLoginStart}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="最近登录开始"/></td>
					<td><input type="date" placeholder="开始日期" title="最近登录开始"/></td>
					<td>
						 <select class="form-control" ng-model="selectedSite">
					      <option ng-repeat="role in roles" value="{{role.ROLE_ID}}">{{role.ROLE_NAME}}</option>
					    </select>
					</td>
					
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();" title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a></td>
					<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="fromExcel();" title="从EXCEL导入"><i id="nav-search-icon" class="icon-cloud-upload"></i></a></td>
					
				</tr>
			</table>
			<!-- 检索  -->
			
		<table class="table table-striped table-bordered table-hover"  id="userTable">
			<thead>
				<tr>
					<th data-sortable="true" data-formatter="getIndex">下标</th>
					<th data-field="userId">编号</th>
					<th data-field="username">用户名</th>
					<th>职位</th>
					<th><i class="icon-envelope"></i>邮箱</th>
					<th>最近登陆</th>
					<th>上次登陆</th>
					<th data-formatter="operate">操作</th>
				</tr>
			</thead>
		</table>
		<div class="page-header position-relative">
		<table style="width:100%;">
			<tr>
				<td style="vertical-align:top;">
					<a class="btn btn-small btn-success" onclick="add();"><i class="fa fa-address-book-o" aria-hidden="true"></i>新增</a>
				</td>
			</tr>
		</table>
		</div>
		</form>
		</div>
		</div>
		</div>
		</div>
	</div>	
	


	<!-- <div ng-app="">
	     <p>名字 : <input type="text" ng-model="name"></p>
	     <h1>Hello {{name}}</h1>
	</div> -->

	<script>
		var app = angular.module('myApp', []);
		app.controller('siteCtrl', function($scope, $http) {
		  $http.get("${ctx}/sysUser/listRoles.do")
		  .then(function (response) {$scope.roles = response.data;});
		});
		
	</script>	
		

	<script type="text/javascript">
		
		$(top.hangge());
		$('#userTable').bootstrapTable({
			url:'${ctx}/sysUser/userList.do',
			pagination: true, //是否显示分页（*）
			sidePagination: "client", //分页方式：client客户端分页，server服务端分页（*）
			pageNumber:1, //初始化加载第一页，默认第一页
			pageSize: 5, //每页的记录行数（*）
			pageList: [10, 25, 50, 100], //可供选择的每页的行数（*）
			toolbar:'#toolbar'
		});
	</script>
	<script type="text/javascript">
		 function getIndex(val,row,index){
	         return index + 1;
	     }
		 function operate(val,row,index){
			 var userId=row.userId;
			 return  "<button id='btn_delete' onclick=deleteUser("+"'"+userId+"'"+") type='button' class='btn btn-mini btn-danger'> <span class='glyphicon glyphicon-remove' aria-hidden='true'></span>删除 </button>";
		 }
		 function deleteUser(userId){
			 $.ajax({
				 data:{userId:userId},
				 url:'${ctx}/sysUser/userDelete.do',
				 success:function(result){
					if(result.success=='true'){
						alert("删除成功");
					}else{
						alert("删除失败");
					}
					$('#userTable').bootstrapTable('refresh');
			 	 },
				 error:function(){
					 alert("错误，稍后重试");
				 }
			 });
		 }
		 function search(){
			$('#userForm').submit();
		 }
		 function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL =  "${ctx}/sysUser/goAddU.do";
			 diag.Width = 600;
			 diag.Height = 400;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				diag.close();
			 };
			 diag.show();
		 }
	</script>
	</body>
</html>