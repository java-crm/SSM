<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/js/global.js"></script>
<script type="text/javascript">

$(function(){
	$("#u_id").combobox({
		url:'${pageContext.request.contextPath}/selectUserName?s_createUser='+<%=request.getSession().getAttribute("u_id")%>,
		editable:false, //不可编辑状态 
		valueField:'u_id',
		textField:'u_name'
	})
	shezhidongtai();
	seachselect();
	
});



function seachselect(){
		$('#dg').datagrid({
		    url:'${pageContext.request.contextPath}/selectAll',
			method:'post',
			rownumbers:true,
			
			fitColumns:true,
			pagination:true,
			striped:true, 
		    toolbar:"#toolbar",
		    queryParams: {
		    	s_createUser:<%=request.getSession().getAttribute("u_id")%>,
		    	s_name: $("#s_name").textbox("getValue"),
				s_sex:$('#dd').textbox('getValue'),
				/* s_zixunName: $('#s_zixunName').textbox('getValue'), */
		    	s_age:$('#s_age').numberbox('getValue'),
		    	s_qq:$('#s_qq').numberbox('getValue'),
		    	s_iphone:$('#s_iphone').numberbox('getValue'),
				s_isbaobei: $("#s_isbaobei").combobox("getValue"),
				s_isreturnVist: $("#s_isreturnVist").combobox("getValue"),
				s_ispay: $("#s_ispay").combobox("getValue"),
				min_s_createTime: $("#min_s_createTime").datebox("getValue"),
				max_s_createTime: $("#max_s_createTime").datebox("getValue"),
				u_id: $("#u_id").combobox("getValue")
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
		$("#insertform").form("reset");//重置
		$('#zdfl').switchbutton('disable');
		//打开窗口前查询当前咨询师是否被经理设置为自动分量的操作
		$.ajax({
			url:'${pageContext.request.contextPath}/selectUsersByKaiQi',
			method:'post',
			data:{u_id:<%=request.getSession().getAttribute("u_id")%>},
			dataType:'json',
			success:function(res){
				if(res.success){
					$("#zdfl").switchbutton({checked:true});
				}else{
					$("#zdfl").switchbutton({checked:false});
				}
			}
		});
		$("#insertStu").dialog("open");
	}
	
	function insertStudent(){
		
		/* 是否开启自动分量 */
		var status= $("#zdfl").switchbutton("options").checked;
		var fenliang= status ==true ? "1" : "0"
		$.ajax({
			url:'${pageContext.request.contextPath}/insertStu?s_createUser='+<%=request.getSession().getAttribute("u_id")%>+'&fenliang='+fenliang,
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
		$("#u_name").textbox('setValue',data.rows[index].users.u_name);
		$("#chaform").form("load",data.rows[index])
		$("#chaStu").dialog("open");
	}
	
	//手机号验证
	$.extend($.fn.validatebox.defaults.rules, {    
	    telNum:{ //既验证手机号，又验证座机号
	        validator: function(value, param){ 
	            return /(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^(()|(\d{3}\-))?(1[358]\d{9})$)/.test(value);
	        },    
	        message: '请输入正确的电话号码。' 
	    }  
	});
	function formatteruserName(value,row,index){
		return row.users != undefined ?  row.users.u_name : "未分配";
	}
</script>
</head>
<body>
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
            <th data-options="field:'s_stuConcern'">客户学历</th>
            <th field="s_isbaobei" hidden="true">是否报备</th>
            <!-- <th field="s_zixunName" hidden="true">咨询师名字</th> -->
            <th field="s_returnMoneyReason" hidden="true">退费原因</th>
            <th field="s_preMoney" hidden="true">定金金额</th>
            <th field="s_preMoneyTime" hidden="true">定金时间</th>
            <th data-options="field:'users',formatter:formatteruserName">咨询师</th>
            <th data-options="field:'suibian',formatter:formattercaosuo">操作</th>   
        </tr>   
    </thead>   
</table>
<div id="toolbar" style="padding:5px; height:auto">
		<!-- <a id="btn" href="javascript:void(0)" onclick="daochu()" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">自选导出</a> -->
		
				&nbsp;	用户名: <input class="easyui-textbox" id="s_name" style="width:80px"> &nbsp;&nbsp;
						年龄：<input class="easyui-numberbox" id="s_age" style="width:80px"> 
						电话：<input class="easyui-numberbox" id="s_iphone" style="width:80px"> 
						qq：<input class="easyui-numberbox" id="s_qq" style="width:80px"> 
						咨询师: <!-- <input class="easyui-textbox" id="s_zixunName" style="width:80px"> -->
							<input class="easyui-combobox" id="u_id"  style="width:80px"/>
						性别：
						<select id="dd" class="easyui-combobox" data-options="editable:false" name=s_sex style="width:auto;">
							<option value="">--请选择---</option>
							<option value="男">男</option>
							<option value="女">女</option>
					    </select>
					   
						创建时间: <input class="easyui-datebox" id="min_s_createTime" style="width:100px">
						-
						<input class="easyui-datebox" id="max_s_createTime" style="width:100px"> &nbsp;&nbsp;
						 <br/>是否缴费:
						<select id="s_ispay" class="easyui-combobox" data-options="editable:false" name="s_ispay" style="width:auto;">
							<option value="">--请选择---</option>
							<option value="已缴费">已缴费</option>
							<option value="未缴费">未缴费</option>
					    </select> 
						是否报备:
						<select id="s_isbaobei" class="easyui-combobox" data-options="editable:false" name="s_isbaobei" style="width:auto;">
							<option value="">--请选择---</option>
							<option value="是">是</option>
							<option value="否">否</option>
					    </select>
					           是否回访:
					    <select id="s_isreturnVist" class="easyui-combobox" data-options="editable:false" name="s_isreturnVist" style="width:auto;">
							<option value="">--请选择---</option>
							<option value="已回访">已回访</option>
							<option value="未回访">未回访</option>
					    </select>
		<a href="javascript:void(0);" id="btnExport" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-print'">导出Excel</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'" onclick="seachinsert()">新增</a>		
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'" onclick="seachselect()">检索</a>
		<!-- 设置隐藏列 -->
		 <div  class="easyui-accordion" style="width:atuo;height:auto;" data-options="selected:false">
	  						
	  			<div title="更多" style="overflow:auto;padding:10px;" >
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
								
								<td><input type="checkbox" value="s_zixunName"/>咨询师</td>
								
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
							
								<td><input type="checkbox" value="s_askerContent"/>咨询师备注</td>
								<td><input type="checkbox" value="s_isdel"/>删除状态</td>
							
								<td><input type="checkbox" value="s_isbaobei"/>是否报备</td>
								<td><input type="checkbox" value="s_returnMoneyReason"/>退费原因</td>
							
								<td><input type="checkbox" value="s_preMoney"/>定金金额</td>
								<td><input type="checkbox" value="s_preMoneyTime"/>定金时间</td>
								<td><input type="checkbox" value="u_id"/>员工id</td>
							
								
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

<!--新增-->
<div id="insertStu" class="easyui-window" title="新增员工信息" data-options="modal:true,closed:true,iconCls:'icon-save'" style="padding:10px; top: auto;">
	<form id="insertform">
		<table cellpadding="5">
			<tr>
				<td>客户名称:</td>
				<td><input class="easyui-textbox" type="text" name="s_name" style="width: 80px" data-options="required:true,prompt:'姓名必须填写'"/></td>
				<td>客户手机号:</td>
				<td><input class="easyui-textbox" name="s_iphone" data-options="prompt:'请输入正确的电话号码',validType:'telNum'" /></td>
			</tr>
			<tr>
				<td>年龄:</td>
				<td><input class="easyui-numberbox" type="text" name="s_age" style="width: 80px"  data-options="min:16,max:30,prompt:'16-30岁之间'"/></td>
				<td>来源渠道:</td>
				<td>
					<select class="easyui-combobox"  name="s_courceurl" style="width: 159px" data-options="required:true,prompt:'必须选择来源渠道'" > 
					    <option value=""></option>   
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
				<td>性别:</td>
				<td><input type="radio" name="s_sex" value="男" checked="checked" />男  
					<input type="radio" name="s_sex" value="女"/> 女  </td>
				<td>来源关键词:</td>
				<td><input class="easyui-textbox" type="text" data-options="prompt:'请输入来源关键词'" name="s_keywords" /></td>
			</tr>
			<tr>
				<td>客户学历:</td>
				<td>
					<select class="easyui-combobox" style="width: 80px" name="s_stuConcern" > 
					    <option value="">--请选择--</option>   
					    <option value="未知">未知</option>   
					    <option value="大专">大专</option>   
					    <option value="高中">高中</option>   
					    <option value="中专">中专</option>   
					    <option value="初中">初中</option>   
					    <option value="本科">本科</option> 
					    <option value="其他">其他</option>   
					</select>  
				</td>
				<td>qq:</td>
				<td><input class="easyui-numberbox" type="text" data-options="prompt:'请输入QQ号'" name="s_qq" /></td>
			</tr>
			<tr>
				<td>状态:</td>
				<td> 
					<select class="easyui-combobox" style="width: 80px" name="s_state"> 
					    <option value="">--请选择--</option>   
					    <option value="未知">未知</option>   
					    <option value="待业">待业</option> 
					    <option value="在职">在职</option>
					    <option value="在读">在读</option>  
					</select> 
				</td>
				<td>微信号:</td>
				<td><input class="easyui-textbox" type="text" data-options="prompt:'请输入微信号号'" name="s_wx"/></td>
			</tr>
			<tr>
				<td>来源网址:</td>
				<td>
					<select class="easyui-combobox" style="width: 80px" name="s_fromPart"> 
					    <option value="">--请选择--</option>   
					    <option value="其他">其他</option>   
					    <option value="职英B站">职英B站</option> 
					    <option value="职英A站">职英A站</option>
					    <option value="高考站">高考站</option>  
					</select>
				</td>
				<td>是否报备:</td>
				<td>
					 <input type="radio" value="是" name="s_isbaobei" checked="checked" />是
		       		 <input type="radio" value="否" name="s_isbaobei" />否
				</td>
			</tr>
			<tr>
				<td>是否自动分量:</td>
				<td><input class="easyui-switchbutton" id="zdfl" data-options="onText:'开',offText:'关'" ></td>
				<td>备注:</td>
				<td><input class="easyui-textbox" data-options="multiline:true,height:50,prompt:'备注...'" type="text" name="s_inClassContent"/></td>
			</tr>
		</table>
		
	</form>
	<div style="text-align:center;padding:5px">
		<a href="javascript:void(0)" class="easyui-linkbutton" type="button" onclick="insertStudent()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearStudent()">取消</a>
	</div>
</div>

<!-- 查看 -->
	<div id="chaStu" class="easyui-window" title="查看" 
		data-options="modal:true,closed:true,iconCls:'icon-save'"
		style="padding:10px; top: auto;">
		<form id="chaform">
			<table>
				<tr>
					<td>
						<table cellpadding="5">
							<tr>
								<td>网络咨询师：</td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td>名称:</td>
								<td><input class="easyui-textbox" type="text" name="s_name"
									style="width: 80px" /></td>
								<td>手机号:</td>
								<td><input class="easyui-textbox" name="s_iphone" /></td>
							</tr>
							<tr>
								<td>年龄:</td>
								<td><input class="easyui-numberbox" type="text"
									name="s_age" style="width: 80px" /></td>
								<td>来源渠道:</td>
								<td><input class="easyui-textbox" name="s_courceurl" /></td>
							</tr>
							<tr>
								<td>性别:</td>
								<td><input class="easyui-textbox" type="text" name="s_sex"
									style="width: 80px" /></td>
								<td>来源关键词:</td>
								<td><input class="easyui-textbox" type="text"
									name="s_keywords" /></td>
							</tr>
							<tr>
								<td>学历:</td>
								<td><input class="easyui-textbox" style="width: 80px"
									type="text" name="s_stuConcern" /></td>
								<td>qq:</td>
								<td><input class="easyui-numberbox" type="text" name="s_qq" /></td>
							</tr>
							<tr>
								<td>状态:</td>
								<td><input class="easyui-textbox" style="width: 80px"
									type="text" name="s_state" /></td>
								<td>微信号:</td>
								<td><input class="easyui-textbox" type="text" name="s_wx" /></td>
							</tr>
							<tr>
								<td>来源网址:</td>
								<td><input class="easyui-textbox" style="width: 80px"
									type="text" name="s_fromPart" /></td>
								<td>是否报备:</td>
								<td><input class="easyui-textbox" type="text"
									name="s_isbaobei" /></td>
							</tr>
						</table>
						<table>
							<tr>
								<td>&ensp;备&ensp;注:</td>
								<td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;<input class="easyui-textbox"
									data-options="multiline:true,height:50,width:329" type="text"
									name="s_inClassContent" /></td>
							</tr>
							<tr>
								<td>&ensp;咨询师:</td>
								<td></td>
							</tr>
						</table>
						<table cellpadding="5">
							<tr>
								<td>咨询师:</td>
								<td>&ensp;&ensp;&ensp;&ensp;&ensp;<input class="easyui-textbox"  type="text" id="u_name"
									style="width: 80px"  /></td>
								<td>&ensp;&ensp;课程方向:</td>
								<td><input class="easyui-textbox" name="s_source" /></td>
							</tr>
						</table>
					</td>
					<td>
						<table cellpadding="5">
							<tr>
								<td>打分:</td>
								<td><input class="easyui-numberbox" type="text"
									name="s_learnforward"   /></td>
								<td>是否有效:</td>
								<td><input class="easyui-textbox" name="s_isValid" /></td>
							</tr>
							<tr>
								<td>无效原因:</td>
								<td><input class="easyui-textbox" type="text"
									name="s_lostValid"   /></td>
								<td>是否回访:</td>
								<td><input class="easyui-textbox" type="text"
									name="s_isreturnVist" /></td>
							</tr>
							<tr>
								<td>首访时间:</td>
								<td><input class="easyui-textbox"  
									type="text" name="s_fistVisitTime" /></td>
								<td>是否上门:</td>
								<td><input class="easyui-textbox" type="text"
									name="s_ishome" /></td>
							</tr>
							<tr>
								<td>上门时间:</td>
								<td><input class="easyui-textbox"  
									type="text" name="s_homeTime" /></td>
								<td>定金金额:</td>
								<td><input class="easyui-textbox" type="text"
									name="s_preMoney" /></td>
							</tr>
							<tr>
								<td>定金时间:</td>
								<td><input class="easyui-textbox"  
									type="text" name="s_preMoneyTime" /></td>
								<td>是否缴费:</td>
								<td><input class="easyui-textbox" type="text"
									name="s_ispay" /></td>
							</tr>
							<tr>
								<td>缴费时间:</td>
								<td><input class="easyui-textbox" type="text"
									name="s_paytime" /></td>
								<td>缴费金额:</td>
								<td><input class="easyui-numberbox" type="text"
									name="s_money" /></td>
							</tr>
							<tr>
								<td>是否退费:</td>
								<td><input class="easyui-textbox" type="text"
									name="s_isReturnMoney" /></td>
								<td>退费原因:</td>
								<td><input class="easyui-textbox" type="text"
									name="s_returnMoneyReason" /></td>
							</tr>
							<tr>
								<td>是否进班:</td>
								<td><input class="easyui-textbox" type="text"
									name="s_isInClass" /></td>
								<td>进班时间:</td>
								<td><input class="easyui-textbox" type="text"
									name="s_inClassTime" /></td>
							</tr>
						</table>
						<table>
							<tr>
								<td>咨询师备注:</td>
								<td><input class="easyui-textbox"
									data-options="multiline:true,height:50,width:395" type="text"
									name="s_askerContent" /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
<script type="text/javascript">
	function shezhidongtai() {
		var createGridHeaderContextMenu = function(e, field) {
			e.preventDefault();
			var grid = $(this);
			var headerContextMenu = this.headerContextMenu;
			if (!headerContextMenu) {
				var tmenu = $('<div style="width:100px;"></div>').appendTo(
						'body');
				var fields = grid.datagrid('getColumnFields');
				for (var i = 0; i < fields.length; i++) {
					var fildOption = grid
							.datagrid('getColumnOption', fields[i]);
					if (!fildOption.hidden) {
						$('<div iconCls="icon-ok" field="'+fields[i]+'"/>')
								.html(fildOption.title).appendTo(tmenu)
					} else {
						$('<div iconCls="icon-empty" field="'+fields[i]+'"/>')
								.html(fildOption.title).appendTo(tmenu)
					}
				}
				headerContextMenu = this.headerContextMenu = tmenu.menu({
					onClick : function(item) {
						var field = $(item.target).attr('field');
						if (item.iconCls == 'icon-ok') {
							grid.datagrid('hideColumn', field);
							$(this).menu('setIcon', {
								target : item.target,
								iconCls : 'icon-empty'
							})
						} else {
							grid.datagrid('showColumn', field);
							$(this).menu('setIcon', {
								target : item.target,
								iconCls : 'icon-ok'
							})
						}
					}
				})
			}
			headerContextMenu.menu('show', {
				left : e.pageX,
				button : e.pageY
			})
		};
		$.fn.datagrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;
		$.fn.treegrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu
	}
	
	
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
		var data = JSON.stringify($('#dg').datagrid('getData').rows);
		if (data == '')
			return;

		JSONToCSVConvertor(data, "数据信息", true);
	});

</script>

</html>