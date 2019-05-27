<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/js/global.js"></script>
<script type="text/javascript">
	$(function(){
		selectStudeninfo();
		$('#kqzdfl').switchbutton({
			onChange: function(checked){
				var data=$("#dg").datagrid("getData");
				var id= data.rows;
				var u_id=[];
				$(id).each(function(){
					u_id.push(this.s_id);
				});
				if(checked){
					$.ajax({
						url:'${pageContext.request.contextPath}/insertjingliFenPei',
						method:'post',
						data:{	
							s_id:u_id.toString()
						},
						dataType:'json',
						success:function(res){
							if(res>0){
								$("#dg").datagrid("reload");
								$.messager.alert("提示信息","自动分配已完成！");
							}
						},
					})
				}
			}
		});
	});
	function selectStudeninfo(){
		$("#dg").datagrid({
			url:'${pageContext.request.contextPath}/selectweifnInfo',
			method:'post',
			rownumbers:true,
			singleSelect:true,
			fitColumns:true,
			pagination:true,
			striped:true,
			toolbar:'#usertb',
			pageSize:10,
			loadMsg:"正在努力加载数据,表格渲染中...",
				queryParams:{
					s_name:$("#s_name").textbox("getValue"),
					s_sex:$("#s_sex").combobox("getValue"),
					s_age:$("#s_age").numberbox("getValue")
				},
				onLoadSuccess:function(data){
					var data=$("#dg").datagrid("getData");
					var id= data.rows;
					if(id.length==0){
						$('#kqzdfl').switchbutton('disable');
					}
				}
			})
	}
	function formattercaozuo(value, row, index){
		return "<a style='cursor: pointer;' onclick='showRoles(" + index + ")'>设置</a>";
	}
</script>
<table class="easyui-datagrid" id="dg" title="未分配的学生" style="height: 545px" >
	<thead>
		<tr>
			<th data-options="field:'s_id',width:80,hidden:true"></th>
			<th data-options="field:'s_name',width:100">学生姓名</th>
			<th data-options="field:'s_sex',width:100">性别</th>
			<th data-options="field:'s_age',width:100">年龄</th>
			<th data-options="field:'caozuo',width:100,formatter:formattercaozuo">操作</th>
		</tr>
	</thead>
</table>

<div id="usertb" style="padding:5px; height:auto">
	开启分配：<input class='easyui-switchbutton' id="kqzdfl"  onText='开' offText='关' />&nbsp;&nbsp;
	用户名: <input class="easyui-textbox" id="s_name" style="width:80px"> 
	性别: <select class="easyui-combobox" style="width: 80px" id="s_sex"> 
					    <option value="">--请选择--</option>   
					    <option value="男">男</option>   
					    <option value="女">女</option> 
		</select>  
	年龄: <input class="easyui-numberbox" data-options="min:16,max:50" id="s_age" style="width:80px"> 
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'" onclick="selectStudeninfo()">检索</a>
</div>

