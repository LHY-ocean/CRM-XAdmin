<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<base href="../../">
<link href="lib/layui/css/layui.css" rel="stylesheet">
<script type="text/javascript" src="lib/layui/layui.all.js"></script>
<script type="text/javascript" src="static/js/my.js"></script>
<script type="text/javascript" src="static/js/jquery.min.js"></script>
<script src="static/js/eleDel.js" type="text/javascript" charset="utf-8"></script>
<title></title>
<style type="text/css">
.input {
	font-size: 16px; width : 200px;
	height: 30px;
	margin-top: -10px;
	margin-right: 10px;
	width: 200px;
}

.layui-form-select{width:200px;
}
</style>
</head>
<body>
	<table id="demo" lay-filter="test"></table>
	<script type="text/html" id="barDemo">
<a class="layui-btn layui-btn-xs" lay-event="edit">查看历史</a>
<a class="layui-btn layui-btn-xs" lay-event="edit">预约</a>
</script>
	<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">
    <div class="layui-input-inline">
      <input type="text" name="txt" lay-verify="title"  autocomplete="off" placeholder="请输入名称" class="layui-input input">
    </div>
    <button class="layui-btn layui-btn-sm" lay-event="search">查询</button>
    <button class="layui-btn layui-btn-sm" lay-event="add">添加回访</button>
  </div>
</script>

	<script>
	var id = "${clientid}";
		layui.use('table', function() {
			var table = layui.table;

			//第一个实例
			table.render({
				elem : '#demo',
				height : 575,
				url : 'revisit/index.action' //数据接口
				,
				toolbar : '#toolbarDemo',
				where:{
					clientid:id
				},
				page : true //开启分页
				,
				cols : [ [ 
					{
						field : 'id',
						title : 'ID',
						width : 80,
						sort : true,
					},{
						field : 'clientname',
						title : '客户名',
						width : 100
					},{
						field : 'linkstatusname',
						title : '连通状态',
						width : 100
					},{
						field : 'clientstatusname',
						title : '客户状态',
						width : 100
					},{
						field : 'purposestatusname',
						title : '意向状态',
						width : 100
					},{
						field : 'assessstatusname',
						title : '评估状态',
						width : 100
					},{
						field : 'execstatusname',
						title : '处理状态',
						width : 100
					},{
						field : 'askinfo',
						title : '询问状况',
						width : 100
					},{
						field : 'followinfo',
						title : '跟进措施',
						width : 100
					},{
						field : 'probleminfo',
						title : '客户顾虑',
						width : 100
					},{
						field : 'statusname',
						title : '状态',
						width : 100
					},{
						field : 'comments',
						title : '备注',
						width : 100
					},{
						fixed : 'right',
						title : '操作',
						toolbar : '#barDemo',
						width : 150,
						align : 'center'
					}

					] ],
				parseData : function(res) {
					return {
						"code" : res.code,
						"msg" : res.msg,
						"count" : res.count,
						data : res.list
					}
				}
			});
			
			

			//obj 行      obj.data 行数据    data.id 列
			//test  是table的lay-filter="test" 属性
			table.on('tool(test)', function(obj) {
				var data = obj.data;
				if (obj.event === 'del') { ///lay-event 属性
					
					myconfirm("刪除？",function(){
						$.post("revisit/delete.action", {id : data.id}, 
								function(json) {
							reload('demo');
							layer.close(layer.index);
								}, "json");
					});
				}else{
					WeAdminShow('编辑','pages/revisit/edit.jsp?id='+data.id);
				}
			});

			table.on('toolbar(test)', function(obj) {
				if (obj.event === 'search') {
					var txt = $(event.target).prev().find("input").val();
					reload('demo',{txt : txt});
				} else if(obj.event === 'add') {
					WeAdminShow('添加','pages/revisit/edit.jsp');
				}
			});

		});
	</script>
</body>
</html>