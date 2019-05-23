<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="../js/global.js"></script>
<script type="text/javascript">

$(function(){
	seachselect();
})

function seachselect(){
		$('#dg').datagrid({
		    url:'../selectAll',
		    fitColumns:true, 
		    singleSelect:true,
		    pagination:true,
		    toolbar:"#toolbar",
		    queryParams: {
		    	s_name: $('#s_name').textbox('getValue'),
		    	s_sex: $('#s_sex').textbox('getValue'),
		    	s_age:$('#s_age').numberbox('getValue')
			}
		});
	}

	function formattercaosuo(value,row,index){
		return  " <a href='javascript:void(0)' onclick='chaStu("+index+")'>查看</a>";
	}
	
	function clearStudent(){
		$("#insertStu").dialog("close");
	}
	
	function seachinsert(){
		$("#insertStu").dialog("open");
	}
	
	function insertStudent(){
		$.ajax({
			url:'../insertStu',
			method:'post',
			data:$("#insertform").serializeArray(),
			success:function(res){
				if(res>0){
					$('#dg').datagrid("reload");
					$("#insertStu").dialog("close");
					$.messager.alert('提示信息','添加成功');    
				}
			}
		},"json")
	}
	function chaStu(index){
		var data=$("#dg").datagrid("getData");
		$("#chaform").form("load",data.rows[index])
		$("#chaStu").dialog("open");
	}
</script>
</head>
<body>
	<table id="dg" class="easyui-datagrid"  title="客户信息">   
    <thead>
        <tr>
            <th data-options="field:'s_id'">编号</th>   
            <th data-options="field:'s_name'">客户名称</th>   
            <th data-options="field:'s_age'">年龄</th>   
            <th data-options="field:'s_sex'">性别</th>   
            <th data-options="field:'s_iphone'">客户手机号</th>
            <th data-options="field:'s_stuConcern'">客户学历</th>   
            <th data-options="field:'s_state'">状态</th>   
            <th data-options="field:'s_courceurl'">来源渠道</th>   
            <th data-options="field:'s_fromPart'">来源网址</th>   
            <th data-options="field:'s_keywords'">来源关键词</th>   
            <th data-options="field:'s_qq'">qq</th>
            <th data-options="field:'s_wx'">微信号</th>
            <th data-options="field:'s_isbaobei'">是否报备</th>
            <th data-options="field:'s_inClassContent'">备注</th>
            <th data-options="field:'suibian',formatter:formattercaosuo">操作</th>   
        </tr>   
    </thead>   
</table>

<div id="toolbar">
<a id="btn" href="javascript:void(0)" onclick="seachinsert()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>  
	名称：<input class="easyui-textbox" id="s_name"> 
	年龄：<input class="easyui-numberbox" id="s_age"> 
	性别：<input class="easyui-textbox" id="s_sex"> 
	<a id="btn" href="javascript:void(0)" onclick="seachselect()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">检索</a>  
</div>

<!--新增角色-->
<div id="insertStu" class="easyui-window" title="新增员工信息" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;height:300px;padding:10px; top: 200px;">
	<form id="insertform">
		<table cellpadding="5">
		
			<tr>
				<td>客户名称:</td>
				<td><input class="easyui-textbox" type="text" name="s_name" id="s_name" data-options="required:true"></input>
				</td>
				<td>年龄:</td>
				<td><input class="easyui-textbox" type="text" name="s_age" id="s_age" data-options="required:true"></input>
				</td>
				<td>性别:</td>
				<td><input class="easyui-textbox" type="text" name="s_sex" id="s_sex" data-options="required:true"></input>
				</td>
				<td>客户手机号:</td>
				<td><input class="easyui-textbox" type="text" name="s_iphone" id="s_iphone" data-options="required:true"></input>
				</td>
				<td>客户学历:</td>
				<td><input class="easyui-textbox" type="text" name="s_stuConcern" id="s_stuConcern" data-options="required:true"></input>
				</td>
				<td>状态:</td>
				<td><input class="easyui-textbox" type="text" name="s_state" id="s_state" data-options="required:true"></input>
				</td>
				<td>来源渠道:</td>
				<td><input class="easyui-textbox" type="text" name="s_courceurl" id="s_courceurl" data-options="required:true"></input>
				</td>
				<td>来源网址:</td>
				<td><input class="easyui-textbox" type="text" name="s_fromPart" id="s_fromPart" data-options="required:true"></input>
				</td>
				<td>来源关键词:</td>
				<td><input class="easyui-textbox" type="text" name="s_keywords" id="s_keywords" data-options="required:true"></input>
				</td>
				<td>qq:</td>
				<td><input class="easyui-textbox" type="text" name="s_qq" id="s_qq" data-options="required:true"></input>
				</td>
				<td>微信号:</td>
				<td><input class="easyui-textbox" type="text" name="s_wx" id="s_wx" data-options="required:true"></input>
				</td>
				<td>是否报备:</td>
				<td><input class="easyui-textbox" type="text" name="s_isbaobei" id="s_isbaobei" data-options="required:true"></input>
				</td>
				<td>备注:</td>
				<td><input class="easyui-textbox" type="text" name="s_inClassContent" id="s_inClassContent" data-options="required:true"></input>
				</td>
			</tr>
		</table>
		
	</form>
	<div style="text-align:center;padding:5px">
		<a href="javascript:void(0)" class="easyui-linkbutton" type="button" onclick="insertStudent()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearStudent()">取消</a>
	</div>
</div>

<div id="chaStu" class="easyui-dialog" title="查看"    
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true">   
     <form id="chaform">
     	<div>
	        <label for="s_name">名字:</label>
	        <input class="easyui-validatebox" type="text" name="s_name"  />   
	    </div>
	    <div>
	        <label for="s_age">年龄:</label>   
	        <input class="easyui-validatebox" type="text" name="s_age" />   
	    </div>
	    <div>
	        <label for="s_sex">性别:</label>
	        <input class="easyui-validatebox" type="text" name="s_sex"  />   
	    </div>
	    <div>
	        <label for="s_iphone">客户手机号:</label>
	        <input class="easyui-validatebox" type="text" name="s_iphone"  />   
	    </div>
	    <div>
	        <label for="s_stuConcern">客户学历:</label>
	        <input class="easyui-validatebox" type="text" name="s_stuConcern"  />   
	    </div>
	    <div>
	        <label for="s_state">状态:</label>
	        <input class="easyui-validatebox" type="text" name="s_state"  />   
	    </div>
	    <div>
	        <label for="s_courceurl">来源渠道:</label>
	        <input class="easyui-validatebox" type="text" name="s_courceurl"  />   
	    </div>
	    <div>
	        <label for="s_fromPart">来源网址:</label>
	        <input class="easyui-validatebox" type="text" name="s_fromPart"  />   
	    </div>
	    <div>
	        <label for="s_keywords">来源关键词:</label>
	        <input class="easyui-validatebox" type="text" name="s_keywords"  />   
	    </div>
	    <div>
	        <label for="s_qq">qq:</label>
	        <input class="easyui-validatebox" type="text" name="s_qq"  />   
	    </div>
	    <div>
	        <label for="s_wx">微信号:</label>
	        <input class="easyui-validatebox" type="text" name="s_wx"  />   
	    </div>
	    <div>
	        <label for="s_isbaobei">是否报备:</label>
	        <input class="easyui-validatebox" type="text" name="s_isbaobei"  />   
	    </div>
	    <div>
	        <label for="s_inClassContent">备注:</label>
	        <input class="easyui-validatebox" type="text" name="s_inClassContent"  />   
	    </div>
	</form>
</div>

</body>
</html>