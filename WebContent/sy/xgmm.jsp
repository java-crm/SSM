<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/global.js"></script>
<script type="text/javascript">
/* $(function(){
	$("#dg").datagrid({
		url:"",
		method:"post"
		
	})
}) */
	
</script>
</head>
<body>
<!-- 
 <div id="tb"> 
	<form id="dg"  title="修改密码" class="easyui-form">   
     	   	<label for="name">名字:</label>   
	        <input class="easyui-validatebox" type="text" name="u_name" id="u_name"  />   
	        <br/>
	        <label for="name">密码:</label>   
	        <input class="easyui-validatebox" type="text" name="u_pwd" id="u_pwd"  />   
	    <br/>
	     
	         <label for="u_pwd">年龄:</label>   
	        <input class="easyui-validatebox" type="text" name="u_pwd" id="u_pwd"/>  
	         <br/> 
	        <label for="u_pwd">年龄:</label>   
	        <input class="easyui-validatebox" type="text" name="u_pwd" id="u_pwd"/>
	         <br/>
	         <label for="u_pwd">年龄:</label>   
	        <input class="easyui-validatebox" type="text" name="u_pwd" id="u_pwd"/>
	         <br/>
	         <label for="u_pwd">年龄:</label>   
	        <input class="easyui-validatebox" type="text" name="u_pwd" id="u_pwd"/>
	         <br/>
	         <label for="u_pwd">年龄:</label>   
	        <input class="easyui-validatebox" type="text" name="u_pwd" id="u_pwd"/>
	         <br/>
	        <label for="u_pwd">年龄:</label>   
	        <input class="easyui-validatebox" type="text" name="u_pwd" id="u_pwd"/>
	         
	</form>
</div>
	
	<div id="toobal">
		<a id="btn" href="javascript:void(0)" onclick="updateStudent()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>
	</div> -->


<div id="insertStu" class="easyui-dialog" title="添加"    
        data-options="iconCls:'icon-save',resizable:true,modal:true">   
     <form id="insertform">   
     	<div>   
	        <label for="name">用户名:</label>   
	        <input class="easyui-validatebox" type="text" name="sname"  />   
	    </div> 
	    <div>   
	        <label for="name">密码:</label>   
	        <input class="easyui-validatebox" type="text" name="age" />   
	    </div>   
	    <div>   
	        <label for="email">性别:</label>   
	        <input class="easyui-validatebox" type="text" name="sex"  />   
	    </div>   
	</form> 
	<a id="btn" href="javascript:void(0)" onclick="insertStudent()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>  
	<a id="btn" href="javascript:void(0)" onclick="clearStudent()" class="easyui-linkbutton" data-options="iconCls:'icon-clear'">取消</a>  
</div>  

</body>
</html>