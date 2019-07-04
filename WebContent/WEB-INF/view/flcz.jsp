<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/js/global.js"></script>
<script type="text/javascript">
	$(function(){
		searchUserInfo();
		$('#kqzdfl').switchbutton({
			onChange: function(checked){
				var u_state=1;
				if (checked == true){
					u_state=1;
				}
				if (checked == false){
					u_state=2;
				}
				$.ajax({
					url:'${pageContext.request.contextPath}/updateUsersByu_state',
					method:'post',
					data:{u_state:u_state},
					dataType:'json',
					success:function(res){
						if(res>0){
							searchUserInfo();
						}
					}
				})
			}
		});
	});
	
	function searchUserInfo(){
		$("#kqzdfl").switchbutton({checked:true});
		$("#dg").datagrid({
			url:'${pageContext.request.contextPath}/selectUsersByflcz',
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
				u_name:$("#userName").textbox("getValue"),
				u_state:$("#u_state").combobox("getValue")
			},
			onLoadSuccess:function(data){
				var dat=data.rows;
				for(var i=0;i<dat.length;i++){
					if(dat[i].u_state=="2"){
						$("#kqzdfl").switchbutton({checked:false});
					}
				}
			}
		});
	}
	/* 格式化分量状态 */
	function formatterflcz(value, row, index){
		return value == "1" ?  "自动分量" : "未设置";
	}
	function formattercaozuo(value, row, index){
		return "<a style='cursor: pointer;' onclick='edit(" + index + ")'>设置</a>";
	}
	function edit(index){
		var data=$("#dg").datagrid("getData");
		$.ajax({
			url:'${pageContext.request.contextPath}/selectUsersByKaiQi',
			method:'post',
			data:{u_id:data.rows[index].u_id},
			dataType:'json',
			success:function(res){
				if(res.success){
					$("#zdfl").switchbutton({checked:true});
				}else{
					$("#zdfl").switchbutton({checked:false});
				}
			}
		});
		$("#dd").dialog("open");
		
		

		
		$('#zdfl').switchbutton({
			onChange: function(checked){
				var u_state=1;
				if (checked == true){
					u_state=1;
				}
				if (checked == false){
					u_state=2;
				}
				$.ajax({
					url:'${pageContext.request.contextPath}/updateUserByIdState',
					method:'post',
					data:{u_state:u_state,u_id:data.rows[index].u_id},
					dataType:'json',
					success:function(res){
						if(res>0){
							searchUserInfo();
						}
					}
				})
			}
		});
	}
	
	
</script>
<table class="easyui-datagrid" id="dg" title="网络咨询师" style="height: 545px" >
	<thead>
		<tr>
			<th data-options="field:'u_id',width:80,hidden:true"></th>
			<th data-options="field:'u_name',width:100">咨询师名称</th>
			<th data-options="field:'u_state',width:100,formatter:formatterflcz">分量状态</th>
			<th data-options="field:'caozuo',width:100,formatter:formattercaozuo">操作</th>
		</tr>
	</thead>
</table>
<div id="usertb" style="padding:5px; height:auto">
	全部开启自动分配：<input class='easyui-switchbutton' id="kqzdfl"  onText='开' offText='关' />&nbsp;&nbsp;
	用户名: <input class="easyui-textbox" id="userName" style="width:80px"> 
	分量状态:
	<select class="easyui-combobox" data-options="editable:false" panelHeight='auto' style="width: 80px" id="u_state"> 
		    <option value="">--请选择--</option>   
		    <option value="1">自动分量</option>   
		    <option value="2">未设置</option> 
	</select> 
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'" onclick="searchUserInfo()">检索</a>
</div>

<div id="dd" class="easyui-dialog" title="设置分量" style="width:200px;height:100px;margin:0,auto; text-align:center;"   
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true">
        <table style="width:100pxs; height:50px; margin:0 auto;">
        	<tr>
        		<td>开启自动分配：</td>
        		<td><input class='easyui-switchbutton' id="zdfl"  onText='开' offText='关' /></td>
        	</tr>
        </table>   
</div>  