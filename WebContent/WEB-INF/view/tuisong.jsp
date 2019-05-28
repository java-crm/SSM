<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/global.js"></script>
<script type="text/javascript">
	$(function(){
		seachselect();
	})
	function seachselect(){
		$("#dg").datagrid({
			url:'selectPushTwo',
			method:'post',
			fitColumns:true,
			pagination:true,
			toolbar:"#toolbar",
			queryParams:{
				zxname:globalData.getCurUName(),
				context:$("#s_name").textbox("getValue"),
				tstime:$("#tstime").datebox("getValue"),
				isreader:$("#isreader").combobox("getValue")	
			}
		});
	}
	/* 	
		$('#classid').combobox({
		    url:'selectClas',  
		    valueField:'class_id',    
		    textField:'class_name'   
		});  
	}
	
	function formatterfunction(value,row,index){
		if(row.classes){
			return row.classes.class_name;
		}
	} */


	


	function formatterStudent(value,row,index){
		return row.student !=undefined ? row.student.s_name : "NULL";
	}
</script>

</head>
<body>
	<table id="dg" >   
	    <thead>   
	        <tr>
	            <th data-options="field:'id'">推送编号</th>   
	           
	            <th data-options="field:'student',formatter:formatterStudent">学生名字</th>
	            <th data-options="field:'context'">内容</th>
	            <th data-options="field:'studentname'">推送人</th>
	            <th data-options="field:'tstime'">推送时间</th>
	            
	        </tr>   
	    </thead>   
	</table>

	<!-- 工具条 -->
	<div id="toolbar">
		<form id="sousuo">
			姓名：<input class="easyui-textbox" id="s_name"/>
			推送时间：<input class="easyui-datebox" id="tstime"/>
			 <label for="isreader">是否已读：</label>   
		        <select class="easyui-combobox" panelHeight='auto'  style="width: 159px" id="isreader">
		        	 <option value="">-请选择-</option>
				    <option value="1">1</option>
				    <option value="2">2</option> 
				</select>
			
			<a id="btn" href="javascript:void(0)" onclick="seachselect()" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">检索</a>
		</form>
	</div>





</body>
</html>