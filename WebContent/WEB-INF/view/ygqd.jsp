<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/global.js"></script>
<script type="text/javascript">
	$(function(){
		initt();
	})
	
	function initt(){
		$('#dg').datagrid({    
	    url:'${pageContext.request.contextPath}/selectUserCheckAll', 
	    fitColumns:true,
	    pagination:true,
	    toolbar:"#dd",
	    queryParams: {
	    	u_id:$("#u_id").val(),
	    	us_checkState:$("#us_checkState").val(),
	    	us_checkinTime:$("#us_checkinTime").datebox("getValue"),
	    	us_checkoutTime:$("#us_checkoutTime").datebox("getValue")
		}
	});  
		
}
	
	
	/* 批量签到 */
	function piliangQD(index){
		var usid=[];
		var rows = $("#dg").datagrid("getSelections"); // 获取所有选中的行
		
		/* 签到状态 */
		var us_checkState=[];
		$(rows).each(function(){
			us_checkState.push(this.us_checkState);   
	     });
		
		for(var i=0;i<us_checkState.length;i++){
			if(us_checkState[i]=="是"){
				$.messager.alert("提示信息","重复签到！！");
				return;
			}
		};
		
		/* 签到 */
		$(rows).each(function(){
			usid.push(this.us_id);   
	     });
		$.ajax({
    		url:'${pageContext.request.contextPath}/updateUserchecksPL',
    		data:{
    			usid:usid.toString(),
    			us_checkState:"是"
    		},
    		method:'post',
    		dataType:'json',
    		success:function(res){
    			if(res>0){
    				$('#dg').datagrid("reload");
    				$('#dk').linkbutton({text:'已打卡'});
    				$('#dk').linkbutton('disable');
    				$.messager.alert("提示信息","打卡成功");
    			}
    		}
    	})  
	}
	
	/* 批量签退 */
	function piliangQT(index){
		var usid=[];
		var rows = $("#dg").datagrid("getSelections"); // 获取所有选中的行
		
		var us_checkState=[];
		$(rows).each(function(){
			us_checkState.push(this.us_checkState);   
	     });
		
		for(var i=0;i<us_checkState.length;i++){
			if(us_checkState[i]=="否"){
				$.messager.alert("提示信息","尚未签到，不能签退！！");
				return;
			}
		};
		
		 $(rows).each(function(){
			usid.push(this.us_id);   
	     });
		$.ajax({
    		url:'${pageContext.request.contextPath}/updateUserchecksPL',
    		data:{
    			usid:usid.toString(),
    			us_checkState:"否"
    		},
    		method:'post',
    		dataType:'json',
    		success:function(res){
    			if(res>0){
    				$('#dg').datagrid("reload");
    				$('#dk').linkbutton({text:'已打卡'});
    				$('#dk').linkbutton('disable');
    				$.messager.alert("提示信息","签退成功");
    			}
    		}
    	})  
	}
	function formatterzd(value,row,index){
		return row.us_checkState=="是" ? "已签到" : "未签到";
	}
	function formatterc(value,row,index){
		return row.us_isCancel=="是" ? "不加班" : "加班";
	}
	function formattershezhi(value,row,index){
		return "<a style='cursor: pointer;' onclick='szqd(" + index + ")'>设置</a>";
	}
	function szqd(index){
		var data=$("#dg").datagrid("getData");
		var us_ch=data.rows[index].us_checkState;
		if(us_ch=='否'){
			$.messager.alert("提示信息","该员工未签到,不能加班！！");
			return ;
		}else{
			if(data.rows[index].us_isCancel=="是"){
				$("#szjb").switchbutton({checked:false});
			}else{
				$("#szjb").switchbutton({checked:true});
			}   
			$("#shezhidd").dialog("open");
		
		
		$('#szjb').switchbutton({
			onChange: function(checked){
				var us_isCancel='否';
				if (checked == true){
					us_isCancel='否';
				}
				if (checked == false){
					us_isCancel='是';
				}
				$.ajax({
					url:'${pageContext.request.contextPath}/updateUserchecks',
					method:'post',
					data:{us_isCancel:us_isCancel,us_id:data.rows[index].us_id},
					dataType:'json',
					success:function(res){
						if(res>0){
							initt();
						}
					}
					if (checked == false){
						alert(us_isCancel);
						us_isCancel='是';
					}
					$.ajax({
						url:'${pageContext.request.contextPath}/updateUserchecks',
						method:'post',
						data:{us_isCancel:us_isCancel,us_id:data.rows[index].us_id},
						dataType:'json',
						success:function(res){
							if(res>0){
								initt();
							}
						}
					})
				}
			});
		}
	}
</script>

</head>
<body>
	<table id="dg" class="easyui-datagrid">   
	    <thead>
	        <tr>   
	        	<th data-options="field:'',width:100,checkbox:true"></th>
	            <th data-options="field:'us_id',width:100">编码</th>   
	            <th data-options="field:'u_id',width:100,hidden:true">员工id</th>   
	            <th data-options="field:'us_userName',width:100">员工名字</th>
	            <th data-options="field:'us_checkinTime',width:100">上班时间</th>   
	            <th data-options="field:'us_checkState',width:100,formatter:formatterzd">状态</th>   
	            <th data-options="field:'us_isCancel',width:100,formatter:formatterc">是否加班</th>
	            <th data-options="field:'us_checkoutTime',width:100">下班时间</th>   
	            <th data-options="field:'shezhi',width:100,formatter:formattershezhi">设置</th>   
	        </tr>   
	    </thead>   
	</table>
	
	<div id="dd" class="easyui-dialog" style="width: 100%" data-options="resizable:true,modal:true,closed:true">   
	    <form id="ff" method="post">   
		    <a id="btn" href="javascript:void(0)" onclick="piliangQD()" class="easyui-linkbutton" data-options="plain:true">签到</a>
		   <a id="btn" href="javascript:void(0)" onclick="piliangQT()" class="easyui-linkbutton" data-options="plain:true">签退</a>
		        <label for="name">用户名:</label>   
		        <input class="easyui-textbox" type="text" id="u_id" />   
		     
		        <label for="name">签到状态:</label>   
		        <input class="easyui-textbox" type="text" id="us_checkState"  />   
		      
		        <label for="name">签到时间:</label>   
		        <input class="easyui-datebox" type="text" id="us_checkinTime" />  
		      	~
		        <input class="easyui-datebox" type="text" id="us_checkoutTime" />  
		    
		   <a id="btn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="initt()">搜索</a>
		</form>    
	</div>


<div id="shezhidd" class="easyui-dialog" title="设置" style="width:200px;height:100px;margin:0,auto; text-align:center;"   
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true">
        <table style="width:100pxs; height:50px; margin:0 auto;">
        	<tr>
        		<td>设置加班：</td>
        		<td><input class='easyui-switchbutton' id="szjb"  onText='开' offText='关' /></td>
        	</tr>
        </table>   
</div> 
</body>
</html>