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
		init();
	})
	function init(){
		$('#dg').datagrid({    
		    url:"${pageContext.request.contextPath}/selectStuAll",  
		    method:"post",
		    fitColumns:true,
		    pagination:true,
		    toolbar:"#stuTab",
		    queryParams: {
		    	s_name:$("#s_name").val(),
		    	s_iphone:$("#s_iphone").val(),
		    	u_id:$("#u_id").combobox("getValue"),
		    	s_ispay:$("#s_ispay").combobox("getValue"),
		    	s_isValid:$("#s_isValid").combobox("getValue"),
		    	s_isreturnVist:$("#s_isreturnVist").combobox("getValue"),
		    	s_qq:$("#s_qq").val(),
		    	
		    	min_s_createTime:$("#min_s_createTime").datebox("getValue"),
		    	max_s_createTime:$("#max_s_createTime").datebox("getValue"),
		    	min_s_homeTime:$("#min_s_homeTime").datebox("getValue"),
		    	max_s_homeTime:$("#max_s_homeTime").datebox("getValue"),
		    	min_s_fistVisitTime:$("#min_s_fistVisitTime").datebox("getValue"),
		    	max_s_fistVisitTime:$("#max_s_fistVisitTime").datebox("getValue"),
		    	min_s_paytime:$("#min_s_paytime").datebox("getValue"),
		    	max_s_paytime:$("#max_s_paytime").datebox("getValue"),
		    	min_s_inClassTime:$("#min_s_inClassTime").datebox("getValue"),
		    	max_s_inClassTime:$("#max_s_inClassTime").datebox("getValue")
		    	
			}
		});  
		$('#u_id').combobox({
		    url:'${pageContext.request.contextPath}/selectUsersZiXunShi',  
		    valueField:'u_id',    
		    textField:'u_name'   
		}); 
	}
	
	

	
	function formattercaozuo(value,row,index){
		return "<a href='javascript:void(0)' onclick='updateStu("+index+")'>编辑</a>   "+
				"<a href='javascript:void(0)' onclick='deleteStu("+index+")'>删除</a>   "+
				"<a href='javascript:void(0)' onclick='lookStu("+index+")'>查看</a>";
	}
	
	
	function formatterfunction(value,row,index){
		if(row.users){
			return row.users.u_name;
		}
	}

	
	
	function insertStudent(){
		/* 修改标题并打开 */
		$("#insertstu_dialog").dialog({title:'添加学生'}).dialog("open");
	}
	function addStu(){
		$.ajax({
			url:"${pageContext.request.contextPath}/insertStus",
			method:'post',
			data:$("#inserform").serializeArray(),
			success:function(res){
				$("#dg").datagrid("reload");
				inClearStu();
				$.messager.alert("提示信息","添加成功");
				$("#inserform").form("clear");
			}
		},"json");
	}
	function inClearStu(){
		$("#insertstu_dialog").dialog("close");
	}
	
	
	/* 修改成无效 */
	function deleteStu(index){	
	var data=$("#dg").datagrid("getData");
	
	$.messager.confirm('确认','您确认想要删除记录吗？',function(r){    
	    if (r){    
	      $.ajax({
	    	  url:"${pageContext.request.contextPath}/deleteStu",
	    	  method:'post',
	    	  data:{
	    		  s_id:data.rows[index].s_id
	    	  },
	    	  dataType:'json',
	    	  success:function(res){
	    		  if(res.remark==0){
	    			  $("#dg").datagrid("reload");
	    		  }
	    		  if(res.success){
	    			  $.messager.alert("提示信息",res.message);
	    		  }
	    	  }
	      })
	    }    
	});  

	}
	
	
	
	function updateStu(index){
		/* 每次打开都清空form数据 */
		$("#stuForm").form("clear");
		/* 显示提交按钮 */
		$("#tj").show();
		
		/* 获取选择的表单数据 */
		var data = $("#dg").datagrid("getData");
		$("#stuForm").form("load",data.rows[index]);
		
		/* 对表示input进行赋值，标识框主要用来在后面提交时判断url的 */
		$("#mark").val("2");
		
		/* 修改标题并打开 */
		$("#stu_dialog").dialog({title:'编辑学生'}).dialog("open");
	}
	
	function editStu(){
		$.ajax({
			url:"${pageContext.request.contextPath}/updateStus",
			method:'post',
			data:$("#stuForm").serializeArray(),
			success:function(res){
				$("#dg").datagrid("reload");
				ClearStu();
				$.messager.alert("提示信息","修改成功");
			}
		},"json");
	}
	
	
	function lookStu(index){
		var data = $("#dg").datagrid("getData");
		var row=data.rows[index];
		
		//$('#uidname').combobox('getValue');
		$('#uidname').combobox({
			url:'${pageContext.request.contextPath}/selectUsersByZXS',
			valueField:'u_id',
			textField:'u_name',
			queryParams:{
				s_id:row.s_id
			}
		})
		$('#uidname').combobox('select',row.users.u_name)
			$.ajax({
	        	url:"${pageContext.request.contextPath}/selectStuByid",
	        	method:'post',
	        	data:{s_id:data.rows[index].s_id},
	        	dataType:'json',
	        	success:function(res){
	        		if(res!=null){
	        			/* 清空form数据 */
	        			$("#stuForm").form("clear");
	        			$("#tj").hide();
	        			
	        			$("#stuForm").form("load",res);/* 对form赋值 */
	        			$("#stu_dialog").dialog({title:'查看学生信息'}).dialog("open");
	        		}
	        	}
	        })
	        
		} 
	
	
	/* 提交添加Student */
	function SaveStu(){
		/* 判断使用那个方法提交 */
		$("#mark").val() == "1" ? addStu() : ($("#mark").val() == "2" ? editStu() : null);
	}
	
	function ClearStu(){
		$("#stu_dialog").dialog("close");
	}
</script>
</head>
<body>


	<table id="dg" class="easyui-datagrid">   
	    <thead>   
	        <tr>
	        	<th data-options="field:'check',checkbox:true">编号</th> 
	            <th data-options="field:'s_id'">编号</th>
	            <th data-options="field:'s_createTime'">创建时间</th>
	            <th data-options="field:'s_name'">学生名字</th>
	            <th data-options="field:'s_iphone'">学员电话</th>
				<th data-options="field:'s_age'">年龄</th>
				<th data-options="field:'s_sex'">性别</th>
	            <th data-options="field:'s_stuConcern'">学历</th>
	            <th data-options="field:'s_state'">个人状态</th>
	            <th data-options="field:'s_courceurl'">来源渠道</th>
	            <th data-options="field:'s_fromPart'">来源网址</th>
	            <th data-options="field:'s_keywords'">来源关键词</th>
	            
	            <th data-options="field:'s_address'">所在区域</th>
	            <th data-options="field:'s_wx'">微信</th>
	            <th data-options="field:'s_qq'">QQ</th>
	            <th data-options="field:'s_createUser'">来源部门</th>
	            <th data-options="field:'s_isbaobei'">是否报备</th>
	            <th data-options="field:'s_source'">课程方向</th>
	            <th data-options="field:'s_isValid'">是否有效</th>
	            <th data-options="field:'s_learnforward'">打分</th>
	            <th data-options="field:'s_isreturnVist'">是否回访</th>
	            <th data-options="field:'s_fistVisitTime'">首次回访时间</th>
	            <th data-options="field:'s_ishome'">是否上门</th>
	            <th data-options="field:'s_homeTime'">上门时间</th>
	            <th data-options="field:'s_lostValid'">无效原因</th>
	            <th data-options="field:'s_ispay'">是否缴费</th>
	            <th data-options="field:'s_paytime'">缴费时间</th>
	            <th data-options="field:'s_money'">缴费金额</th>
	            <th data-options="field:'s_isReturnMoney'">是否退费</th>
	            <th data-options="field:'s_isInClass'">是否进班</th>
	            <th data-options="field:'s_inClassTime'">进班时间</th>
	            <th data-options="field:'s_inClassContent'">进班备注</th>
	            <th data-options="field:'s_returnMoneyReason'">退费原因</th>
	            <th data-options="field:'s_preMoney'">定金金额</th>
	            <th data-options="field:'s_preMoneyTime'">定金时间</th>   
	            
	            
	            
	            <th data-options="field:'users.u_name',formatter:formatterfunction">咨询师</th>
	            
	            <th data-options="field:'caozuo',width:'80px',formatter:formattercaozuo">操作</th>
	           
	            
	        </tr>   
	    </thead>   
	</table>
	
	
	<div  class="easyui-accordion" style="width:atuo;height:auto;" data-options="selected:false">
	  						
	  			<div title="设置隐藏列" style="overflow:auto;padding:10px;" >
					<form id="hiddenColumn_form" class="easyui-form">
					<a href="javascript:void()"  class="easyui-linkbutton" id="isQuanXuan" onclick="ChooseAll()" data-options="iconCls:'icon-edit'">全选</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="saveColumn()()">保存</a> 
						<table>
							<tr>
								<td><input type="checkbox" value="s_id" checked="checked"/>编号</td>
								<td><input type="checkbox" value="s_name" checked="checked"/>姓名</td>
								<td><input type="checkbox" value="s_age" checked="checked"/>年龄</td>
								<td><input type="checkbox" value="s_sex" checked="checked"/>性别</td>
								<td><input type="checkbox" value="s_iphone" checked="checked"/>客户手机号</td>
								<td><input type="checkbox" value="s_stuConcern" checked="checked"/>客户学历</td>
								<td><input type="checkbox" value="s_state" checked="checked"/>状态</td>
								<td><input type="checkbox" value="s_courceurl" checked="checked"/>来源渠道</td>
								<td><input type="checkbox" value="s_fromPart"/>来源网站</td>
								<td><input type="checkbox" value="s_keywords" checked="checked"/>来源关键词</td>
								<td><input type="checkbox" value="s_address" checked="checked"/>咨客户地址</td>
								
								
								<td><input type="checkbox" value="s_qq" checked="checked"/>qq</td>
								<td><input type="checkbox" value="s_wx" checked="checked"/>微信</td>
								<td><input type="checkbox" value="s_inClassContent"/>进班备注</td>
								</tr>
							<tr>
								<td><input type="checkbox" value="s_createTime" checked="checked"/>创建时间</td>
								<td><input type="checkbox" value="s_source"/>课程方向</td>
							
								<td><input type="checkbox" value="s_isValid"/>有效（虚效）</td>
								<td><input type="checkbox" value="s_isreturnVist"/>是否回访</td>
								<td><input type="checkbox" value="s_fistVisitTime"/>首访时间</td>
								<td><input type="checkbox" value="s_ishome"/>是否上门</td>
								<td><input type="checkbox" value="s_homeTime"/>上门时间</td>
								<td><input type="checkbox" value="s_lostValid"/>无效原因</td>
								<td><input type="checkbox" value="s_ispay"/>是否缴费</td>
								<td><input type="checkbox" value="s_paytime"/>缴费时间</td>
								<td><input type="checkbox" value="s_money"/>收入</td>
								<td><input type="checkbox" value="s_isReturnMoney"/>是否退费</td>
								<td><input type="checkbox" value="s_isInClass"/>是否进班</td>
								<td><input type="checkbox" value="s_inClassTime"/>进班时间</td>
							</tr>
							<tr>
								<td><input type="checkbox" value="s_inClassContent"/>进班备注</td>
							
								<td><input type="checkbox" value="s_isdel"/>删除状态</td>
							
								<td><input type="checkbox" value="s_isbaobei"/>是否报备</td>
								<td><input type="checkbox" value="s_returnMoneyReason"/>退费原因</td>
							
								<td><input type="checkbox" value="s_preMoney"/>定金金额</td>
								<td><input type="checkbox" value="s_preMoneyTime"/>定金时间</td>
								<td><input type="checkbox" value="u_id"/>员工id</td>
							
								
							</tr>
						</table>
					</form>
					
				</div>
    </div>   
	
	<div id="stuTab" class="easyui-dialog" data-options="resizable:true,modal:true,closed:true">   
		<form id="ff" method="post">   
			<a id="btna" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="insertStudent()">添加</a>
			<a href="javascript:void(0);" id="btnExport" class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true"  >导出Excel</a>
			
		        <label for="name">姓名:</label>   
		        <input class="easyui-textbox" type="text" id="s_name" />   
		      
		        <label for="name">电话:</label>   
		        <input class="easyui-textbox" type="text" id="s_iphone" />   
		  		
		  		
	        	<label for="name">咨询师:</label> 
		  		<input class="easyui-combobox" type="text" id="u_id" data-options="valueField:'u_id',textField:'u_name',url:'selectUsersZiXunShi'" /> 
		  		
	        <a id="btn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="init()">搜索</a>
		   		
		<div id="aa" class="easyui-accordion" style="width:atuo;height:auto;" data-options="selected:false">
	  		<div title="更多" style="overflow:auto;padding:10px;" >

		    <label for="name">是否缴费:</label>   
	        <select class="easyui-combobox" style="width: 100px" id="s_ispay"> 
			    <option value="">-- 请选择 --</option>
			    <option value="已缴费">已缴费</option>   
			    <option value="未缴费">未缴费</option>   
			</select>
			
	     	
		    
	        <label for="name">QQ:</label>   
	        <input class="easyui-textbox" type="text" id="s_qq" />    
	   		<br>
		    
	     	
	     	<label for="name">是否有效:</label>   
	        <select class="easyui-combobox" style="width: 100px" id="s_isValid"> 
			    <option value="">-- 请选择 --</option>
			    <option value="是">是</option>   
			    <option value="否">否</option>   
			</select>   
	          
	      	<label for="name">是否回访:</label>   
	        <select class="easyui-combobox" style="width: 100px" id="s_isreturnVist"> 
			   	<option value="">-- 请选择 --</option>
			    <option value="已回访">已回访</option>   
			    <option value="未回访">未回访</option>   
			</select>
	        <br>
	       
	       
	       	<label for="name">创建时间:</label>   
	        <input class="easyui-datebox" type="text" id="min_s_createTime" />~
	        <input class="easyui-datebox" type="text" id="max_s_createTime" /> 
	        <br>
	      
	        <label for="name">上门时间:</label>   
	        <input class="easyui-datebox" type="text" id="min_s_homeTime" />~
	        <input class="easyui-datebox" type="text" id="max_s_homeTime" />   
	     	<br>
	     	
	        <label for="name">受访时间:</label>   
	        <input class="easyui-datebox" type="text" id="min_s_fistVisitTime" />~   
	        <input class="easyui-datebox" type="text" id="max_s_fistVisitTime" />   
	      	<br>
	      	
	        <label for="name">缴费时间:</label>   
	        <input class="easyui-datebox" type="text" id="min_s_paytime" />~
	        <input class="easyui-datebox" type="text" id="max_s_paytime" />      
	      	<br>
	      
	        <label for="name">进班时间:</label>   
	        <input class="easyui-datebox" type="text" id="min_s_inClassTime" />~
	        <input class="easyui-datebox" type="text" id="max_s_inClassTime" />   
	       	<br>
			</div>
		</div>
		</form>   
	</div> 
	<div id="stu_dialog" class="easyui-window" data-options="modal:true,closed:true" style="padding:10px; top: auto;">
		<form id="stuForm" method="post">
			<table>
				<tr>
					<td>
						<table cellpadding="5">
							<tr>
								<td><h3>在线录入：</h3></td>
							</tr>
							
							<tr>
								<td>客户姓名:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text" name="s_name" style="width: 80px" />
								<input type="hidden" name="s_id" /><input type="hidden" id="mark"/>
								</td>
								<td>客户电话:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" name="s_iphone" /></td>
							</tr>
							<tr>
								<td>客户年龄:</td>
								<td><input class="easyui-numberbox" data-options="readonly:true" type="text" name="s_age" style="width: 80px" /></td>
								<td>来源渠道:</td>
								<td>
									<select class="easyui-combobox" data-options="readonly:true" style="width: 160px" name="s_courceurl"> 
									    <option value="未知">未知</option>   
									    <option value="百度">百度</option> 
									    <option value="百度移动端">百度移动端</option>
									    <option value="360">360</option>  
									    <option value="360移动端">360移动端</option>  
									    <option value="搜狗">搜狗</option>  
									    <option value="搜狗移动端">搜狗移动端</option>  
									    <option value="UC移动端">UC移动端</option>  
									    <option value="直接输入">直接输入</option>  
									    <option value="自然流量">自然流量</option>  
									    <option value="直电">直电</option>  
									    <option value="微信">微信</option>  
									    <option value="QQ">QQ</option>  
									</select>
								</td>	
							</tr>
							<tr>
								<td>客户性别:</td>
								<td>
									<input type="radio" value="男" data-options="readonly:true" name="s_sex" />男
		        					<input type="radio" value="女" data-options="readonly:true" name="s_sex" />女
								</td>
								<td>来源关键词:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text" name="s_keywords" /></td>
							</tr>
							<tr>
								<td>客户学历:</td>
								<td>	
								<select class="easyui-combobox" data-options="readonly:true" style="width: 80px" name="s_stuConcern" > 
				   					<option value="未知">未知</option>   
				    					<option value="大专">大专</option>   
				    					<option value="高中">高中</option>   
				    					<option value="中专">中专</option>   
				    					<option value="初中">初中</option>   
				    					<option value="本科">本科</option> 
				    					<option value="其他">其他</option>   
								</select>
								</td>
								<td>学生Q Q:</td>
								<td><input class="easyui-numberbox" data-options="readonly:true" type="text" name="s_qq" /></td>
							</tr>
							<tr>
								<td>客户状态:</td>
								<td>
									<select class="easyui-combobox" data-options="readonly:true" style="width: 80px" name="s_state"> 
									    <option value="未知">未知</option>   
									    <option value="待业">待业</option> 
									    <option value="在职">在职</option>
									    <option value="在读">在读</option>  
									</select>
								</td>
								<td>客户微信:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text" name="s_wx" /></td>
							</tr>
							<tr>
								<td>来源网站:</td>
								<td>
									<select class="easyui-combobox" style="width: 80px" data-options="readonly:true" name="s_fromPart"> 
									    <option value="其他">其他</option>   
									    <option value="职英B站">职英B站</option> 
									    <option value="职英A站">职英A站</option>
									    <option value="高考站">高考站</option>  
									</select>
								</td>
								<td>是否报备:</td>
								<td>
									<input type="radio" value="是" data-options="readonly:true" name="s_isbaobei" />是
		        					<input type="radio" value="否" data-options="readonly:true" name="s_isbaobei" />否
								</td>
							</tr>
							<tr>
								<td>学员关注:</td>
								<td>
									<select class="easyui-combobox" style="width: 80px" data-options="readonly:true" name="s_netpusherld"> 
								    <option value="课程">课程</option> 
								    <option value="学费">学费</option>
								    <option value="学时">学时</option>  
								    <option value="学历">学历</option>   
								    <option value="师资">师资</option> 
								    <option value="就业">就业</option>
								    <option value="环境">环境</option>
								    <option value="其他">其他</option>  
									</select>
								</td>
								<td>所在区域:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text" name="s_address" /></td>
								
							</tr>
							<tr>
								<td>来源部门:</td>
								<td>
									<select class="easyui-combobox" style="width: 80px" data-options="readonly:true" name="s_createUser"> 
								    <option value="网络">网络</option> 
								    <option value="市场">市场</option>
								    <option value="教质">教质</option>  
								    <option value="学术">学术</option>   
								    <option value="就业">就业</option> 
									</select>
								</td>
								<td>咨询师:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text" name="u_id" /></td>
							</tr>
						</table>
					</td>
					
					<td>
						<table cellpadding="5">
							<tr>
								<td><h3>咨询师录入：</h3></td>
							</tr>
							<tr>
								<td>咨询师:</td>
								<td>
									<select class="easyui-combobox" style="width: 150px" name="u_id" id="uidname">
	    							</select>
								</td>
								<td>课程方向:</td>
								<td>
									<select class="easyui-combobox" style="width: 150px" name="s_source"> 
									    <option value="软件开发">软件开发</option> 
									    <option value="软件设计">软件设计</option>
									    <option value="网络营销">网络营销</option> 
									</select>
								</td>
							</tr>
							<tr>
								<td>客户打分:</td>
								<td>
									<select class="easyui-combobox" style="width: 150px" name="s_learnforward"> 
									    <option value="A.近期可报名">A.近期可报名</option> 
									    <option value="B.一个月内可报名">B.一个月内可报名</option>
									    <option value="C.长期 跟踪">C.长期跟踪</option>
									    <option value="D.无效">D.无效</option> 
									</select>
								</td>
								<td>是否有效:</td>
								<td>
									<input type="radio" value="是" name="s_isValid" />是
							        <input type="radio" value="否" name="s_isValid" />否
						        </td>
							</tr>
							<tr>
								<td>无效原因:</td>
								<td><input class="easyui-textbox" type="text" style="width: 150px" name="s_lostValid" /></td>
								<td>是否回访:</td>
								<td>
									 <input type="radio" value="已回访" name="s_isreturnVist" />已回访
		        					 <input type="radio" value="未回访" name="s_isreturnVist" />未回访
		        				</td>
							</tr>
							<tr>
								<td>首访时间:</td>
								<td><input class="easyui-datebox" type="text" style="width: 150px" name="s_fistVisitTime" /></td>
								<td>是否上门:</td>
								<td>
									<input type="radio" value="已上门" name="s_ishome" />已上门
		        					<input type="radio" value="未上门" name="s_ishome" />未上门
								</td>
							</tr>
							<tr>
								<td>上门时间:</td>
								<td><input class="easyui-datebox" style="width: 150px" name="s_homeTime" /></td>
								<td>定金金额:</td>
								<td><input class="easyui-numberbox" style="width: 150px" name="s_preMoney" /></td>
							</tr>
							<tr>
								<td>定金时间:</td>
								<td><input class="easyui-datebox" style="width: 150px" name="s_preMoneyTime" /></td>
								<td>是否缴费:</td>
								<td>
									<input type="radio" value="已缴费" name="s_ispay" />已缴费
		        					<input type="radio" value="未缴费" name="s_ispay" />未缴费
								</td>
							</tr>
							<tr>
								<td>缴费时间:</td>
								<td><input class="easyui-datebox" style="width: 150px" name="s_paytime" /></td>
								<td>缴费金额:</td>
								<td><input class="easyui-numberbox" style="width: 150px" name="s_money" /></td>
							</tr>
							<tr>
								<td>是否退费:</td>
								<td>
									<input type="radio" value="已退费" name="s_isReturnMoney" />已退费
		        					<input type="radio" value="未退费" name="s_isReturnMoney" />未退费
								</td>
								<td>退费原因:</td>
								<td>
									<input class="easyui-textbox" style="width: 150px" name="s_returnMoneyReason" />
								</td>
							</tr>
							<tr>
								<td>是否进班:</td>
								<td>
									<input type="radio" value="已进班" name="s_isInClass" />已进班
		        					<input type="radio" value="未进班" name="s_isInClass" />未进班
								</td>
								<td>进班时间:</td>
								<td>
									<input class="easyui-datebox" style="width: 150px" name="s_inClassTime" />
								</td>
							</tr>
							<tr>
								<td>进班备注:</td>
								<td>
									<input class="easyui-textbox" data-options="multiline:true,height:50,width:150" name="s_inClassContent" />
								</td>
								<td>咨询师备注:</td>
								<td>
									<input class="easyui-textbox" data-options="multiline:true,height:50,width:150" type="text" name="s_inClassContent" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
				<div id="tj" style="padding:3px;float: left;">
					<a id="btn" href="javascript:void(0)" onclick="SaveStu()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>  
					<a id="btn" href="javascript:void(0)" onclick="ClearStu()" class="easyui-linkbutton" data-options="iconCls:'icon-clear'">取消</a>  
				</div>
		</form>
			
	</div>
	
	<div id="insertstu_dialog" class="easyui-window" title="新增员工信息" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:400px;height:auto;padding:10px; top: auto;">
	<form id="inserform">
		<table cellpadding="5">
			<tr>
				<td>客户名称:</td>
				<td><input class="easyui-textbox" type="text" name="s_name" style="width: 160px" data-options="required:true,prompt:'姓名必须填写'"></input>
				</td>
			</tr>
			<tr>
				<td>年龄:</td>
				<td><input class="easyui-numberbox" type="text" name="s_age" style="width: 160px"  data-options="min:16,max:30,prompt:'16-30岁之间'"></input>
				</td>
			</tr>	
			<tr>
				<td>性别:</td>
				<td>
					<input type="radio" name="s_sex" value="男" checked="checked" />男  
					<input type="radio" name="s_sex" value="女"/> 女  
				</td>
			</tr>	
			<tr>	
				<td>客户手机号:</td>
				<td>
					<input class="easyui-textbox"  name="s_iphone" data-options="prompt:'请输入正确的电话号码。',validType:'telNum'" />
				</td>
			</tr>	
			<tr>	
				<td>客户学历:</td>
				<td>
					<input class="easyui-textbox" type="text" name="s_stuConcern" id="s_stuConcern" data-options="required:true"></input>
				</td>
			</tr>	
			<tr>	
				<td>状态:</td>
				<td><input class="easyui-textbox" type="text" name="s_state" id="s_state" data-options="required:true"></input>
				</td>
			</tr>	
			<tr>	
				<td>来源渠道:</td>
				<td><input class="easyui-textbox" type="text" name="s_courceurl" id="s_courceurl" data-options="required:true"></input>
				</td>
			</tr>	
			<tr>	
				<td>来源网址:</td>
				<td><input class="easyui-textbox" type="text" name="s_fromPart" id="s_fromPart" data-options="required:true"></input>
				</td>
			</tr>	
			<tr>	
				<td>来源关键词:</td>
				<td><input class="easyui-textbox" type="text" name="s_keywords" id="s_keywords" data-options="required:true"></input>
				</td>
			</tr>	
			<tr>	
				<td>所在区域:</td>
				<td><input class="easyui-textbox" type="text" name="s_address" id="s_address" data-options="required:true"></input>
				</td>
			</tr>
			<tr>	
				<td>qq:</td>
				<td><input class="easyui-textbox" type="text" name="s_qq" id="s_qq" data-options="required:true"></input>
				</td>
			</tr>
			<tr>	
				<td>微信号:</td>
				<td><input class="easyui-textbox" type="text" name="s_wx" id="s_wx" data-options="required:true"></input>
				</td>
				
			<tr>	
				<td>是否报备:</td>
				<td><input class="easyui-textbox" type="text" name="s_isbaobei" id="s_isbaobei" data-options="required:true"></input>
				</td>
			</tr>	
			
		</table>
		
	</form>
	<div style="text-align:center;padding:5px">
		<a href="javascript:void(0)" class="easyui-linkbutton" type="button" onclick="addStu()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="inClearStu()">取消</a>
	</div>
</div>
</body>
<script type="text/javascript">

function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		//如果jsondata不是对象，那么json.parse将分析对象中的json字符串。
		var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
		var CSV = '';

		//在第一行拼接标题
		CSV += ReportTitle + '\r\n\n';

		//产生数据标头
		if (ShowLabel) {
			var row = "";
			//此循环将从数组的第一个索引中提取标签
			for ( var index in arrData[0]) {

				//现在将每个值转换为字符串和逗号分隔
				row += index + ',';
			}

			row = row.slice(0, -1);

			//添加带换行符的标签行
			CSV += row + '\r\n';
		}

		//第一个循环是提取每一行
		for (var i = 0; i < arrData.length; i++) {
			var row = "";

			//2nd loop will extract each column and convert it in string comma-seprated
			for ( var index in arrData[i]) {
				row += '"' + arrData[i][index] + '",';
			}

			row.slice(0, row.length - 1);

			//add a line break after each row
			CSV += row + '\r\n';
		}

		if (CSV == '') {
			alert("Invalid data");
			return;
		}

		//Generate a file name
		var fileName = "我的学生_";
		//this will remove the blank-spaces from the title and replace it with an underscore
		fileName += ReportTitle.replace(/ /g, "_");

		//Initialize file format you want csv or xls
		//var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
		var uri = 'data:text/csv;charset=utf-8,\ufeff' + encodeURI(CSV);

		// Now the little tricky part.
		// you can use either>> window.open(uri);
		// but this will not work in some browsers
		// or you will not get the correct file extension    

		//this trick will generate a temp <a /> tag
		var link = document.createElement("a");
		link.href = uri;

		//set the visibility hidden so it will not effect on your web-layout
		link.style = "visibility:hidden";
		link.download = fileName + ".csv";

		//this part will append the anchor tag and remove it after automatic click
		document.body.appendChild(link);
		link.click();
		document.body.removeChild(link);
	}
	$("#btnExport").click(function() {
		var row=$("#dg").datagrid("getSelections");
		if(row.length == 0){
			$.messager.alert("系统信息","请选择数据");
			return;
		}
		var data = JSON.stringify(row);
		
			

		JSONToCSVConvertor(data, "数据信息", true);
	});

</script>
</html>