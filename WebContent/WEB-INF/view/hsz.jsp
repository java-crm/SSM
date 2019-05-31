<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/js/global.js"></script>
<script type="text/javascript">
	$(function(){
		selecthszAll();
	});
	function selecthszAll(){
		$("#dg").datagrid({
			url:'${pageContext.request.contextPath}/selectStudentIsdelAll',
			method:'post',
			rownumbers:true,
			fitColumns:true,
			pagination:true,
			striped:true,
			toolbar:'#usertb',
			pageSize:10,
			loadMsg:"正在努力加载数据,表格渲染中...",
			queryParams:{
				u_name:$("#userName").textbox("getValue")
			}
		});
	}
		
	function formattercaozuo(value, row, index){
		return "<a style='cursor: pointer;' onclick='huifu(" + index + ")'>恢复</a> | <a style='cursor: pointer;' onclick='qingchu(" + index + ")'>清除</a>";
	}
	/* 恢复修改状态为是 */
	function huifu(index){
		var data=$("#dg").datagrid("getData");
		$.messager.confirm('确认','您确认想要恢复该条学生信息吗？',function(r){    
		    if (r){    
		    	$.ajax({
					url:'${pageContext.request.contextPath}/updateStudenthsz',
					method:'post',
					data:{s_id:data.rows[index].s_id},
					dataType:'json',
					success:function(res){
						if(res>0){
							$("#dg").datagrid("reload");
							$.messager.alert("提示信息","恢复成功！");
						}
					}
				});   
		    }    
		}); 
	}
	/* 单个删除 */
	function qingchu(index){
		var data=$("#dg").datagrid("getData");
		$.messager.confirm('确认','您确认要从回收站移除吗？',function(r){    
		    if (r){
		    	$.ajax({
					url:'${pageContext.request.contextPath}/deleteByIdStuhsz',
					method:'post',
					data:{s_id:data.rows[index].s_id},
					dataType:'json',
					success:function(res){
						if(res>0){
							$("#dg").datagrid("reload");
							$.messager.alert("提示信息","移除成功");
						}
					}
				});
		    }    
		});  
	}
	/* 清空回收站 */
	function qingkong(){
		$.messager.confirm('确认','您确认清空回收站吗？',function(r){    
		    if (r){    
		    	$.ajax({
					url:'${pageContext.request.contextPath}/deleteStudenthsz',
					method:'post',
					dataType:'json',
					success:function(res){
						if(res>0){
							$("#dg").datagrid("reload");
							$.messager.alert("提示信息","成功清空");
						}
					}
				});   
		    }    
		});  
	}
	/* 批量操作删除或者恢复 */
	function piliangcaozuo(){
		$("#dd").dialog("open");
	}
	function plcz(a){
		var s_id=[];
		var rows = $("#dg").datagrid("getSelections"); // 获取所有选中的行
		/* 学生id */
		var us_checkState=[];
		$(rows).each(function(){
			s_id.push(this.s_id);   
	     });
		$.ajax({
			url:'${pageContext.request.contextPath}/plczhsz?a='+a+'&s_id='+s_id,
			method:'post',
			dataType:'json',
			success:function(res){
				if(res>0){
					$("#dg").datagrid("reload");
					$("#dd").dialog("close");
					$.messager.alert("提示信息","操作成功");
				}
			}
		});
	}
</script>
</head>
<body>
	<!-- 表格 -->
	<table class="easyui-datagrid" id="dg" title="网络咨询师" style="height: 480px" >
		<thead>
			<tr>
				<th data-options="field:'s_id',width:80,hidden:true"></th>
				<th data-options="field:'s_name',width:100">咨询师名称</th>
				<th data-options="field:'caozuo',width:100,formatter:formattercaozuo">操作</th>
			</tr>
		</thead>
	</table>
	
	<!-- 工具条 -->
	<div id="usertb" style="padding:5px; height:auto">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true" onclick="qingkong()">清空回收站</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true" onclick="piliangcaozuo()">批量操作</a>
		名称: <input class="easyui-textbox" id="userName"> 
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'" onclick="selecthszAll()">检索</a>
	</div>
	
	<!-- 弹出框 -->
	<div id="dd" class="easyui-dialog" title="操作提示" style="width:200px;height:100px;margin:0,auto; text-align:center;"   
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true">
        <table style="width:100pxs; height:50px; margin:0 auto;">
        	<tr>
        		<td><a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true" onclick="plcz(1)">全部清除</a></td>
        		<td><a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true" onclick="plcz(2)">全部恢复</a></td>
        	</tr>
        </table>   
</div> 
	
</body>
</html>