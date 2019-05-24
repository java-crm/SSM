<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/global.js"></script>
<script type="text/javascript">

	$(function(){
		seachselect();
	})
	
	
function seachselect(){
	$('#dg').datagrid({
	    url:'${pageContext.request.contextPath}/selectStu',
	    method:'POST',
	    fitColumns:true,
	  
	    pagination:true,
	    toolbar:"#toolbar",
	    queryParams: {
	    	u_id:<%=request.getSession().getAttribute("u_id")%>,
	    	s_name:$('#s_name').textbox('getValue'),
	    	s_sex:$('#s_sex').combobox('getValue'),
	    	s_age:$('#s_age').numberbox('getValue'),
	    	s_iphone:$('#s_iphone').numberbox('getValue'),
	    	/* s_zixunName:$('#s_zixunName').textbox('getValue'), */
	    	s_ispay:$('#s_ispay').combobox('getValue'),
	    	s_isValid:$('#s_isValid').combobox('getValue'),
	    	s_isreturnVist:$('#s_isreturnVist').combobox('getValue'),
	    	s_qq:$('#s_qq').textbox('getValue'),
	    	
	    	
	    	
	    	
	    	min_s_createTime:$('#min_s_createTime').datebox('getValue'),
	    	max_s_createTime:$('#max_s_createTime').datebox('getValue'),
	    	
	    	
	    	min_s_homeTime:$('#min_s_homeTime').datebox('getValue'),
	    	max_s_homeTime:$('#max_s_homeTime').datebox('getValue'),
	    	
	    	
	    	min_s_fistVisitTime:$('#min_s_fistVisitTime').datebox('getValue'),
	    	max_s_fistVisitTime:$('#max_s_fistVisitTime').datebox('getValue'),
	    	
	    	
	    	min_s_paytime:$('#min_s_paytime').datebox('getValue'),
	    	max_s_paytime:$('#max_s_paytime').datebox('getValue'),
	    	
	    	
	    	
	    	min_s_inClassTime:$('#min_s_inClassTime').datebox('getValue'),
	    	max_s_inClassTime:$('#max_s_inClassTime').datebox('getValue')
		}
	});
}
	
	function formattercaosuo(value,row,index){
		return  " <a href='javascript:void(0)' onclick='updateStu("+index+")'>修改</a>"+
				" <a href='javascript:void(0)' onclick='follow("+index+")'>跟踪</a>"+
				" <a href='javascript:void(0)' onclick='chaStu("+index+")'>查看</a>"+
				" <a href='javascript:void(0)' onclick='rizhi("+index+")'>日志</a>";
	}
	
	var inde;
	function rizhi(index){
		inde=index;
		initrizi();
		$("#rizhiform").form("clear");
		$('#rizhi').dialog("open");
	}
	function initrizi(){
		var data =$("#dg").datagrid("getData");
		$('#rizhitable').datagrid({
			url:'${pageContext.request.contextPath}/selectNet',
		    method:'POST',
		    fitColumns:true,
		    singleSelect:true,
		    pagination:true,
		    toolbar:"#toolbar2",
		    queryParams: {
		    	s_id:data.rows[inde].s_id,
		    	mincreateTime:$('#mincreateTime').datebox('getValue'),
		    	maxcreateTime:$('#maxcreateTime').datebox('getValue')
		    }
		});
	}
	function chaStu(index){
		var data=$("#dg").datagrid("getData");
		$("#chaform").form("load",data.rows[index])
		$("#chaStu").dialog("open");
	}
	
	function updateStu(index){
		$("#updateform").form("clear");
		 var data=$("#dg").datagrid("getData");
		$("#updateform").form("load",data.rows[index])
		$("#updateStu").dialog("open");
	}
	function updateStudent(){
		$.ajax({
			url:'${pageContext.request.contextPath}/updateStu',
			method:'post',
			data:$("#updateform").serializeArray(),
			success:function(res){
				if(res>0){
					$('#dg').datagrid("reload");
					$("#updateStu").dialog("close");
					$.messager.alert('提示信息','修改成功');    
				}
			}
		},"json")
	}
		function clearUpdateStudent(){
			$("#updateStu").dialog("close");
		}
		
		/*  导出excel 
		function daochu(){
			var data=$("#dg").datagrid("getData");
			var title=$("#dg").datagrid("getColumnFields");
			var d=title+"";
			window.location.href="../zxsdochu?stulist="+JSON.stringify(data.rows)+"&title="+d;
		} */	
		
		/* 	//打开设置隐藏列对话框
		 function selectColumn() {
			$("#hiddenColumn_dialog").dialog("open");
		} */
		function saveColumn() {
			var cbx = $("#hiddenColumn_form input[type='checkbox']"); //获取Form里面是checkbox的Object
		    var checkedValue = "";
		    var unCheckValue = "";
		    for (var i = 0; i < cbx.length; i++) {
		        if (cbx[i].checked) {//获取已经checked的Object
		            if (checkedValue.length > 0) {
		                checkedValue += "," + cbx[i].value; //获取已经checked的value
		            }
		            else {
		                checkedValue = cbx[i].value;
		            }
		        }
		        if (!cbx[i].checked) {//获取没有checked的Object
		            if (unCheckValue.length > 0) {
		                unCheckValue += "," + cbx[i].value; //获取没有checked的value
		            }
		            else {
		                unCheckValue = cbx[i].value;
		            }
		        }
		    }
		    var checkeds = new Array();
		    if (checkedValue != null && checkedValue != "") {
		        checkeds = checkedValue.split(',');
		        for (var i = 0; i < checkeds.length; i++) {
		        	
		            $('#dg').datagrid('showColumn', checkeds[i]); //显示相应的列
		        }
		    }
		    var unChecks = new Array();
		    if (unCheckValue != null && unCheckValue != "") {
		        unChecks = unCheckValue.split(',');
		        for (var i = 0; i < unChecks.length; i++) { 
		            $('#dg').datagrid('hideColumn', unChecks[i]); //隐藏相应的列
		        }
		    } 
		    /* $('#hiddenColumn_dialog').dialog('close'); */
		    init();
		}
		/* //关闭设置隐藏列弹框
		function closed_hiddenColumn() {
			$('#hiddenColumn_dialog').dialog('close');
		} */
		//全选按钮
		function ChooseAll() {
		   
		    var a=$("#isQuanXuan").text();//获取按钮的值
		    if("全选"==a.trim()){
		    	 $("#hiddenColumn_form input[type='checkbox']").prop("checked", true);//全选
		    	$('#isQuanXuan').linkbutton({ text:'全不选' });
		    }else{    	
		    	 $("#hiddenColumn_form input[type='checkbox']").removeAttr("checked", "checked");//取消全选
		    	 $('#isQuanXuan').linkbutton({ text:'全选' });
		    }
		    
		}
		function follow(){
			$("#genzong").form("clear");
			$("#genzongStu").dialog("open");
		}
		
		function clearStudent(){
			$("#genzongStu").dialog("close");
		}

		function genzong(){
			var row= $("#dg").datagrid("getSelected");
			$.ajax({
				url:'${pageContext.request.contextPath}/insertStugz',
				method:'post',
				data:{
					s_id:row.s_id,
					s_name:row.s_name,
					n_followTime:$("#n_followTime").datebox("getValue"),
					n_nextfollowTime:$("#n_nextfollowTime").datebox("getValue"),
					n_content:$("#n_contentgz").val(),
					n_followType:$("#n_followTypegz").val(),
					n_followState:$("#n_followState").val()
					
				},
				success:function(res){
					if(res>0){
						$('#dg').datagrid("reload");
						$("#genzongStu").dialog("close");
						$.messager.alert('提示信息','添加成功');    
					}
				}
			},"json")
		}

		
</script>
</head>
<body>


		<!-- 咨询师主表 -->

<table id="dg" data-options="fitColumns:true,checkbox: true" >  
		<thead>
			<tr>
			<th data-options="field:'check',checkbox:true">编号</th>   
            <th data-options="field:'s_id'">编号</th>   
            <th data-options="field:'s_name'">客户名称</th>   
            <th data-options="field:'s_age'">年龄</th>   
            <th data-options="field:'s_sex'">性别</th>   
            <th data-options="field:'s_iphone'">客户手机号</th>
            <th data-options="field:'s_state'">状态</th> 
            <th field="s_source" hidden="true">课程方向</th>
            <th data-options="field:'s_courceurl'">来源渠道</th> 
            <th data-options="field:'s_keywords'">来源关键词</th>
            <th data-options="field:'s_address'">咨客户地址</th>  
            <th data-options="field:'s_qq'">qq</th>
            <th data-options="field:'s_wx'">微信</th>
            <th field="s_content" hidden="true">内容</th>
            <th data-options="field:'s_createTime'">创建时间</th>
            <th field="s_isValid" hidden="true">有效（虚效）</th>
            <th field="s_record" hidden="true">记录</th>
            <th field="s_isreturnVist" hidden="true">是否回访</th>
            <th field="s_fistVisitTime" hidden="true">首访时间</th>
            <th field="s_ishome" hidden="true">是否上门</th>
            <th field="s_homeTime" hidden="true">上门时间</th>
            <th field="s_lostValid" hidden="true">无效原因</th>
            <th field="s_ispay" hidden="true">是否缴费</th>
            <th field="s_paytime" hidden="true">缴费时间</th>
            <th field="s_money" hidden="true">收入</th>
            <th field="s_isReturnMoney" hidden="true">是否退费</th>
            <th field="s_returnMoneyTime" hidden="true">退费时间</th>
            <th field="s_isInClass" hidden="true">是否进班</th>
            <th field="s_inClassTime" hidden="true">进班时间</th>
            <th field="s_inClassContent" hidden="true">进班备注</th>
            <th field="s_askerContent" hidden="true">咨询师备注</th>
            <th field="s_isdel" hidden="true">删除状态</th>
            <th field="s_fromPart" hidden="true">来源网址</th>
            <th field="s_stuConcern" hidden="true" >客户学历</th>
            <th field="s_isbaobei" hidden="true">是否报备</th>
            <th field="s_returnMoneyReason" hidden="true">退费原因</th>
            <th field="s_preMoney" hidden="true">定金金额</th>
            <th field="s_preMoneyTime" hidden="true">定金时间</th>            
            <th data-options="field:'njknjk',formatter:formattercaosuo">操作</th>  
        </tr>
    </thead>
</table>


		<!-- 多条件查询 -->
<div id="toolbar" style="background-color:silver;" >
	姓名：<input class="easyui-textbox" id="s_name">
	电话 ：<input class="easyui-numberbox" id="s_iphone">
	年龄：<input class="easyui-numberbox" id="s_age"> 
	QQ：<input class="easyui-textbox" id="s_qq">
	
	

	</br>
	</br>
	 <label for="s_sex">性别：</label>   
		        <select class="easyui-combobox" panelHeight='auto'  style="width: 159px" id="s_sex">
		        	 <option value="">-请选择-</option>
				    <option value="男">男</option>
				    <option value="女">女</option> 
				</select>
<!-- 	是否缴费：<input class="easyui-textbox" id="s_ispay"> -->
	<label for="s_sex">是否缴费：</label>
		        <select class="easyui-combobox" panelHeight='auto' style="width: 159px" id="s_ispay">
		        	 <option value="">-请选择-</option>
				    <option value="已缴费">已缴费</option>   
				    <option value="未缴费">未缴费</option>   
				</select>
	<!-- 是否有效：<input class="easyui-textbox" id="s_isValid"> -->
	<label for="s_isValid">是否有效：</label>   
		        <select class="easyui-combobox" panelHeight='auto' style="width: 159px" id="s_isValid">
		        	 <option value="">-请选择-</option>
				    <option value="是">是</option>   
				    <option value="否">否</option>   
				</select>
	<!-- 是否回访：<input class="easyui-textbox" id="s_isreturnVist"> -->
	
	<label for="s_isValid">是否回访：</label>   
		        <select class="easyui-combobox" panelHeight='auto' style="width: 159px" id="s_isreturnVist">
		        	 <option value="">-请选择-</option>
				    <option value="已回访">已回访</option>   
				    <option value="未回访">未回访</option>   
				</select>
				
				&nbsp;&nbsp;&nbsp;<a id="btn" href="javascript:void(0)" onclick="seachselect()" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">检索</a>
<a href="javascript:void(0);" id="btnExport" class="easyui-linkbutton" iconCls='icon-print'>导出Excel</a>
	</br>
	<!-- <div class="easyui-accordion" style="width:300px;height:200px;">
	<div title="About Accordion" iconCls="icon-ok">
		
	</div>
	</div> -->
	<div class="easyui-accordion" style="width:auto;height:auto;"data-options="selected:false">
	<div title="更多条件" iconCls="icon-ok" style="background-color:silver;" data-options="selected:false">
	创建时间：<input class="easyui-datebox" id="min_s_createTime">~<input class="easyui-datebox" id="max_s_createTime">
	上门时间：<input class="easyui-datebox" id="min_s_homeTime">~<input class="easyui-datebox" id="max_s_homeTime">
	<br/>
	<br/>
	首访时间：<input class="easyui-datebox" id="min_s_fistVisitTime">~<input class="easyui-datebox" id="max_s_fistVisitTime">
	缴费时间：<input class="easyui-datebox" id="min_s_paytime">~<input class="easyui-datebox" id="max_s_paytime">
	<br/>
	<br/>
	进班时间：<input class="easyui-datebox" id="min_s_inClassTime">~<input class="easyui-datebox" id="max_s_inClassTime">
	</div>
	</div>
	
	
<!-- 设置隐藏列 -->
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
								<td><input type="checkbox" value="s_stuConcern"/>客户学历</td>
							
								
							</tr>
							<!-- <tr style="display: none">
								<td><input type="checkbox" value="s_ext1"/>备注</td>
								<td><input type="checkbox" value="s_ext2"/>备注</td>
							
								<td><input type="checkbox" value="s_ext3"/>备注</td>
							</tr>
							<tr style="display: none">
								<td><input type="checkbox" value="s_ext4"/>备注</td>
							
								<td><input type="checkbox" value="s_ext5"/>备注</td>
							</tr>
							<tr style="display: none">
								<td><input type="checkbox" value="s_ext6"/>备注</td>
							</tr> -->
						</table>
					</form>
					
				</div>
    </div>   
	
	</div>


		<!-- 查看窗口 -->

<div id="chaStu" class="easyui-window" title="查看" 
		data-options="modal:true,closed:true,iconCls:'icon-save'"
		style="padding:10px; top: auto;">
		<form id="chaform">
			<table>
				<tr>
					<td>
						<table cellpadding="5">
							<tr>
								<td><h3>网络咨询师：</h3></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td>名称:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text" name="s_name"
									style="width: 80px" /></td>
								<td>手机号:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" name="s_iphone" /></td>
							</tr>
							<tr>
								<td>年龄:</td>
								<td><input class="easyui-numberbox" data-options="readonly:true" type="text"
									name="s_age" style="width: 80px" /></td>
								<td>来源渠道:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" name="s_courceurl" /></td>
							</tr>
							<tr>
								<td>性别:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text" name="s_sex"
									style="width: 80px" /></td>
								<td>来源关键词:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text"
									name="s_keywords" /></td>
							</tr>
							<tr>
								<td>学历:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" style="width: 80px"
									type="text" name="s_stuConcern" /></td>
								<td>qq:</td>
								<td><input class="easyui-numberbox" data-options="readonly:true" type="text" name="s_qq" /></td>
							</tr>
							<tr>
								<td>状态:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" style="width: 80px"
									type="text" name="s_state" /></td>
								<td>微信号:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text" name="s_wx" /></td>
							</tr>
							<tr>
								<td>来源网址:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" style="width: 80px"
									type="text" name="s_fromPart" /></td>
								<td>是否报备:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text"
									name="s_isbaobei" /></td>
							</tr>
						</table>
						<table>
							<tr>
								<td>&ensp;备&ensp;注:</td>
								<td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;<input class="easyui-textbox"
									data-options="multiline:true,height:50,width:329,
									readonly:true"
									 type="text"
									name="s_inClassContent" /></td>
							</tr>
							
						</table>
						<table cellpadding="5">
							
							
							
						</table>
					</td>
					<td>
						<table cellpadding="5">
						<tr>
								<td>&ensp;<h3>咨询师:</h3></td>
								<td></td>
							</tr>
						<tr>
						<td>课程方向:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" name="s_source" /></td>
						</tr>
							<tr>
								
							
								<td>打分:</td>
								<td><input class="easyui-textbox" type="text"
								data-options="readonly:true"
									name="s_learnforward"   /></td>
								<td>是否有效:</td>
								<td><input class="easyui-textbox" data-options="readonly:true"
								 name="s_isValid" /></td>
							</tr>
							<tr>
								<td>无效原因:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text"
									name="s_lostValid"   /></td>
								<td>是否回访:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text"
									name="s_isreturnVist" /></td>
							</tr>
							<tr>
								<td>首访时间:</td>
								<td><input class="easyui-textbox"  
									type="text" data-options="readonly:true" name="s_fistVisitTime" /></td>
								<td>是否上门:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text"
									name="s_ishome" /></td>
							</tr>
							<tr>
								<td>上门时间:</td>
								<td><input class="easyui-textbox"  
									type="text" data-options="readonly:true" name="s_homeTime" /></td>
								<td>定金金额:</td>
								<td><input class="easyui-textbox" type="text"
									data-options="readonly:true" name="s_preMoney" /></td>
							</tr>
							<tr>
								<td>定金时间:</td>
								<td><input class="easyui-textbox" data-options="readonly:true"  
									type="text" name="s_preMoneyTime" /></td>
								<td>是否缴费:</td>
								<td><input class="easyui-textbox" type="text" data-options="readonly:true"
									name="s_ispay" /></td>
							</tr>
							<tr>
								<td>缴费时间:</td>
								<td><input class="easyui-textbox" type="text" data-options="readonly:true"
									name="s_paytime" /></td>
								<td>缴费金额:</td>
								<td><input class="easyui-numberbox" type="text" data-options="readonly:true"
									name="s_money" /></td>
							</tr>
							<tr>
								<td>是否退费:</td>
								<td><input class="easyui-textbox" type="text" data-options="readonly:true"
									name="s_isReturnMoney" /></td>
								<td>退费原因:</td>
								<td><input class="easyui-textbox" type="text" data-options="readonly:true"
									name="s_returnMoneyReason" /></td>
							</tr>
							<tr>
								<td>是否进班:</td>
								<td>
								<input class="easyui-textbox" type="text" data-options="readonly:true"
									name="s_isInClass" />
								</td>
								<td>进班时间:</td>
								<td><input class="easyui-textbox" type="text" data-options="readonly:true"
									name="s_inClassTime" /></td>
							</tr>
							<tr>
								<td>进班备注:</td>
								<td>
									<input class="easyui-textbox" data-options="multiline:true,readonly:true,height:50,prompt:'备注...'" type="text" name="s_inClassContent"/>
								<td>咨询师备注:</td>
								<td>
									<input class="easyui-textbox" data-options="multiline:true,readonly:true,height:50,prompt:'备注...'" type="text" name="s_askerContent"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>


		<!-- 修改窗口 -->



<div id="updateStu" class="easyui-window" title="修改" 
		data-options="modal:true,closed:true,iconCls:'icon-save'"
		style="padding:10px; top: auto;">
		<form id="updateform">
		
			<table>
				<tr>
					<td>
						<table cellpadding="5">
							<tr>
								<td><h3>网络咨询师：</h3></td>
								<td></td>
								<td><input hidden data-options="readonly:true" type="text" name="s_id" /><td>
								<td></td>
							</tr>
							<tr>
								<td>名称:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text" name="s_name" id="s_name"
									style="width: 80px" /></td>
								<td>手机号:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" name="s_iphone" id="s_iphone"/></td>
							</tr>
							<tr>
								<td>年龄:</td>
								<td><input class="easyui-numberbox" data-options="readonly:true" type="text"
									name="s_age"  id="s_age" style="width: 80px" /></td>
								<td>来源渠道:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" name="s_courceurl" id="s_courceurl" /></td>
							</tr>
							<tr>
								<td>性别:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text" name="s_sex" id="s_sex"
									style="width: 80px" /></td>
								<td>来源关键词:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text"
									name="s_keywords" /></td>
							</tr>
							<tr>
								<td>学历:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" style="width: 80px"
									type="text" name="s_stuConcern" /></td>
								<td>qq:</td>
								<td><input class="easyui-numberbox" data-options="readonly:true" type="text" name="s_qq" /></td>
							</tr>
							<tr>
								<td>状态:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" style="width: 80px"
									type="text" name="s_state" /></td>
								<td>微信号:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text" name="s_wx" /></td>
							</tr>
							<tr>
								<td>来源网址:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" style="width: 80px"
									type="text" name="s_fromPart" /></td>
								<td>是否报备:</td>
								<td><input class="easyui-textbox" data-options="readonly:true" type="text"
									name="s_isbaobei" /></td>
							</tr>
						</table>
						<table>
							<tr>
								<td>&ensp;备&ensp;注:</td>
								<td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;<input class="easyui-textbox"
									data-options="multiline:true,height:50,width:329,
									readonly:true"
									 type="text"
									name="s_inClassContent" /></td>
							</tr>
							
						</table>
						<table cellpadding="5">
							
						</table>
					</td>
					<td>
						<table cellpadding="5">
						<tr>
								<td>&ensp;<h3>咨询师:</h3></td>
								<td></td>
							</tr>
						<tr>
								
								<td>课程方向:</td>
					<td><select class="easyui-combobox" panelHeight='auto' data-options="prompt:'——请选择 ——'" style="width: 150px" name="s_source"> 
								     
								    <option value="软件开发">软件开发</option> 
								    <option value="软件设计">软件设计</option>
								    <option value="网络营销">网络营销</option> 
									</select>   </td>
							</tr>
							<tr>
								<td>打分:</td>
								<td><select class="easyui-combobox" panelHeight='auto' data-options="prompt:'——请选择 ——'" style="width: 150px" name="s_learnforward"> 
								     
								    <option value="A、近期可报名">A、近期可报名</option> 
								    <option value="B、一个月内可报名">B、一个月内可报名</option>
								    <option value="C、长期跟踪">C、长期跟踪</option> 
								    <option value="D、无效">D、无效</option> 
									</select></td>
								<td>是否有效:</td>
								<td>
								 <input type="radio" value="是" name="s_isValid" />是
						        <input type="radio" value="否" name="s_isValid" />否
								</td>
							</tr>
							<tr>
								<td>无效原因:</td>
								<td><input class="easyui-textbox" data-options="prompt:'如果无效请输入原因'" type="text"
									name="s_lostValid"   /></td>
								<td>是否回访:</td>
								<td>
						        <input type="radio"  value="已回访" name="s_isreturnVist" />已回访
						        <input type="radio" value="未回访" name="s_isreturnVist" />未回访
									</td>
							</tr>
							<tr>
								<td>首访时间:</td>
								<td><input class="easyui-datebox"  
									type="text" data-options="prompt:'请输入正确时间'" name="s_fistVisitTime" /></td>
								<td>是否上门:</td>
								<td>
								<input type="radio" value="已缴费" name="s_ishome" />已上门
						        <input type="radio" value="未缴费" name="s_ishome" />未上门
								</td>
							</tr>
							<tr>
								<td>上门时间:</td>
								<td><input class="easyui-datebox"  
									type="text" data-options="prompt:'请输入正确时间'" name="s_homeTime" /></td>
								<td>定金金额:</td>
								<td><input class="easyui-textbox" type="text"
									data-options="prompt:'请输入金额'" name="s_preMoney" /></td>
							</tr>
							<tr>
								<td>定金时间:</td>
								<td><input class="easyui-datebox" data-options="prompt:'请输入正确时间'"  
									type="text" name="s_preMoneyTime" /></td>
								<td>是否缴费:</td>
								<td>
								<input type="radio" value="已缴费" name="s_ispay" />已缴费
						        <input type="radio" value="未缴费" name="s_ispay" />未缴费
							
							</td>
							</tr>
							<tr>
								<td>缴费时间:</td>
								<td><input class="easyui-datebox" type="text" data-options="prompt:'请输入正确时间'"
									name="s_paytime" /></td>
								<td>缴费金额:</td>
								<td><input class="easyui-numberbox" type="text" data-options="prompt:'请输入金额'"
									name="s_money" /></td>
							</tr>
							<tr>
								<td>是否退费:</td>
								<td>
								<input type="radio" value="已退费" name="s_isReturnMoney" />已退费
						        <input type="radio" value="未退费" name="s_isReturnMoney" />未退费
								</td>
								<td>退费原因:</td>
								<td><input class="easyui-textbox" type="text" data-options="prompt:'如果退费请输入原因'"
									name="s_returnMoneyReason" /></td>
							</tr>
							<tr>
								<td>是否进班:</td>
								<td>
								<input type="radio" value="已进班" name="s_isInClass" />已进班
						        <input type="radio" value="未进班" name="s_isInClass" />未进班
								</td>
								<td>进班时间:</td>
								<td><input class="easyui-datebox" type="text" data-options="prompt:'请输入正确时间'"
									name="s_inClassTime" /></td>
							</tr>
							<tr>
								<td>进班备注:</td>
								<td>
									<input class="easyui-textbox" data-options="multiline:true,height:50,prompt:'备注...'" type="text" name="s_inClassContent"/>
								<td>咨询师备注:</td>
								<td>
									<input class="easyui-textbox" data-options="multiline:true,height:50,prompt:'备注...'" type="text" name="s_askerContent"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<div id="tj" style="padding:3px;float: left;">
			<a id="btn" href="javascript:void(0)" onclick="updateStudent()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>  
			<a id="btn" href="javascript:void(0)" onclick="clearUpdateStudent()" class="easyui-linkbutton" data-options="iconCls:'icon-clear'">取消</a>  
		</div>
		</form>
	</div>
		
		<!-- 日志窗口 -->
			
<div id="rizhi" class="easyui-dialog" data-options="resizable:true,collapsible:true,closed:true" title="日志" style="width: 554px;" >
			<table id="rizhitable">   
			    <thead>
			        <tr>
			            <th data-options="field:'n_id'">编号</th>
			            <th data-options="field:'s_name'">学员名字</th>
			            <th data-options="field:'n_content'">内容</th>
						<th data-options="field:'n_followType'">跟踪方式</th>
			            <th data-options="field:'n_followTime'">跟踪时间</th>
						<th data-options="field:'n_nextfollowTime'">下次跟踪时间</th>
			        </tr>
			    </thead>
</table>			
<div id="toolbar2" style="background-color:silver;" >
<form id="rizhiform">
	记录时间：<input class="easyui-datebox" id="mincreateTime">~<input class="easyui-datebox" id="maxcreateTime">
	<a id="btn" href="javascript:void(0)" onclick="initrizi()" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">检索</a>
</form>

</div>
</div>

		<!-- 添加窗口 -->

<div id="genzongStu" class="easyui-dialog" style="width: 270px;height: 300px;" title="添加"    
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true">   
     <form id="genzong">
     </br>
     	<div>   
	        <label for="name">回访时间:</label>   
	        <input class="easyui-datebox"  data-options="required:true,prompt:'必须选择回访时间'" required="required" type="text" name="n_followTime" id="n_followTime" />   
	    </div> 
	    <br/>
	    <div>   
	        <label for="name">回访情况:</label>   
	        <input class="easyui-textbox" required="required" data-options="multiline:true,height:50,required:true,prompt:'必须选择回访情况'" type="text" name="n_contentgz" id="n_contentgz" />   
	    </div>
	    <br/>   
	    <div>   
	        <label for="email">跟踪方式:</label>   
	        <input class="easyui-textbox" required="required" data-options="required:true,prompt:'必须填写跟踪方式'" type="text" name="n_followTypegz" id="n_followTypegz" />   
	    </div>
	    <br/>
	    <div>   
	        <label for="email">下次跟踪时间:</label>   
	        <input class="easyui-datebox" required="required" data-options="required:true,prompt:'必须选择下次跟踪时间'"  type="text" name="n_nextfollowTime" id="n_nextfollowTime" />   
	    </div>
	    <br/>
	    <div>   
	        <label for="email">备注:</label>   
	        <input class="easyui-textbox"   type="text" name="n_followState" id="n_followState" />   
	    </div>      
	</form> 
	<br/>
	<div style="margin-left: 60px;">
	<a id="btn" href="javascript:void(0)" onclick="genzong()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" >提交</a>  
	<a id="btn" href="javascript:void(0)" onclick="clearStudent()" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" >取消</a>  
	</div>
</div>



</body>
	<!-- Excel导出 -->
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