<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/js/global.js"></script>
<script type="text/javascript">
//39.105.35.157
var webscoket=new WebSocket("ws:39.105.35.157:8080/SSM/webscoket/${u_id}");

webscoket.onopen=function(){
	//alert("连接建立");
}
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
			});
	}
	
	function shoudongPL(){
		var u_ids=[];
		$('#u_id').combobox({
			url:'${pageContext.request.contextPath}/selectUsersByZXS',
			valueField:'u_id',
			textField:'u_name'
		})
		var rows = $("#dg").datagrid("getChecked"); // 获取所有选中的行
		if(rows.length<=0){
			$.messager.alert("提示信息","未选择客户");
			return;
		}
		 $(rows).each(function(){
			 u_ids.push(this.s_id);
			if(u_ids!=null && u_ids!=''){
				$("#fenliang").dialog("open");
			}
		});
	}
	function shoudongSave(){
		if($("#u_id").combobox("getValue")==''){
			$.messager.alert("提示信息","未选择咨询师！");
			return;
		}
		var u_ids=[];
		var rows = $("#dg").datagrid("getSelections"); // 获取所有选中的行
		 $(rows).each(function(){
				 u_ids.push(this.s_id);  
		 });
		$.ajax({
    		url:'${pageContext.request.contextPath}/shoudongFenLiang',
    		data:{
    			u_ids:u_ids.toString(),
    			u_id:$("#u_id").combobox("getValue")
    		},
    		method:'post',
    		dataType:'json',
    		success:function(res){
    			if(res>0){
    				$('#dg').datagrid("reload");
    				$("#fenliang").dialog("close");
    				$.messager.alert("提示信息","分配成功");
    				webscoket.send(globalData.getCurUName()+","+$("#u_id").combobox("getValue")+","+rows.length);
    			}else{
    				$.messager.alert("提示信息","分配失败");
    			}
    		}
    	})  

	}
	function shoudongClose(){
		$("#fenliang").dialog("close");
	}
</script>
<table class="easyui-datagrid" id="dg" title="未分配的学生"  >
	<thead>
		<tr>
			<th data-options="field:'',width:100,checkbox:true"></th>
			<th data-options="field:'s_id',width:80,hidden:true"></th>
			<th data-options="field:'s_name',width:100">学生姓名</th>
			<th data-options="field:'s_sex',width:100">性别</th>
			<th data-options="field:'s_age',width:100">年龄</th>
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
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true" onclick="shoudongPL()">手动分配</a>
</div>
<div id="fenliang" title="手动分量" style="padding:8px;width:300px; height:150px;" data-options="resizable:true,modal:true,closed:true" class="easyui-dialog">
	 咨询师：<input class="easyui-combobox"  id="u_id" name="u_id"> 
	
	<div style="text-align: center;">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-ok'" onclick="shoudongSave()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-clear'" onclick="shoudongClose()">取消</a>
	</div>
</div>


