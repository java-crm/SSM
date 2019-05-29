<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/js/global.js"></script>
<script type="text/javascript">
$(function(){
	document.onkeydown=function(event){ 
	e = event ? event :(window.event ? window.event : null); 
		if(e.keyCode==13){ 
			send();
		}
	}
});
var webscoket=new WebSocket("ws:localhost:8080/SSM/webscoketRescore/"+globalData.getCurUName()+"");

webscoket.onopen=function(){
	//alert(globalData.getCurUName()+"连接建立");
}
webscoket.onclose=function(){
	//alert("连接关闭了");
}
var idname;
webscoket.onmessage=function(event){
	var split =event.data.split(",");
	if(nam==split[1]){
		$("#testlt").append("<div><font color='red'>"+split[1]+"</font> 对你说 :<br/>"+split[0]+"</div>");
	}
	if($("#"+split[1]+"").text()!='' && nam!=split[1]){
		idname=split[1];
		if(iCount){
			clearInterval(iCount);
			iCount = null;
		}
		iCount=setInterval("changeColor()",200);//定时器
	}
};
var iCount=setInterval("changeColor()",200);
function changeColor(){ 
	var color="#f00|#0f0|#00f|#880|#808|#088|yellow|green|blue|gray"; 
	color=color.split("|"); 
	document.getElementById(""+idname+"").style.color=color[parseInt(Math.random() * color.length)]; 
	}
function send(){
	var pp = $('#tt').tabs('getSelected');  
	if(pp==null){
		$.messager.alert("提示信息","请选择一个员工！")
		return;
	}
	webscoket.send(globalData.getCurUName()+","+nam+","+$("#ltcontext").textbox("getValue"));
	
	$("#testlt").append("<div style='margin-left:1000px;'>你对 <font color='red'>"+nam+"</font> 说 :<br/>"+$("#ltcontext").textbox("getValue")+"</div>");
	$("#ltcontext").textbox("clear");
}
var nam;
function showcontent(name){
	if(name==globalData.getCurUName()){
		$.messager.alert("提示信息","您不能与自己进行聊天！");
		return;
	}
	if($('#tt').tabs('exists', name)){
		$('#tt').tabs('select', name);
	}else{
		var count= $('#tt').tabs('tabs').length;
		if(count>0){
			$('#tt').tabs('close',nam);
			nam=null;
		}else{
			if(iCount){
				clearInterval(iCount);
				iCount = null;
			}
			nam=name;
			$('#tt').tabs('add', {//在选项卡中，创建1个选项页
		        title: name,   //选项卡中，选项页的标题（在同一个选项卡中，选项页需要保持一致）。
		        closable: false,
		        content: "<div id='testlt'></div>"
		   });
			 
			$.ajax({
				url:'${pageContext.request.contextPath}/selectChatfunction',
				method:'post',
				data:{
					fszName:globalData.getCurUName(),
					jszName:nam
				},
				dataType:'json',
				success:function(res){
					if(res.length>0){
						for(var i=0;i<res.length;i++){
							if(res[i].fszName==globalData.getCurUName()){
								$("#testlt").append("<div style='margin-left:1000px;'>你对 <font color='red'>"+nam+"</font> 说 :<br/>"+res[i].fsContext+"</div>");
							}else{
								$("#testlt").append("<div><font color='red'>"+res[i].fszName+"</font> 对你说 :<br/>"+res[i].fsContext+"</div>");
							}
						}
					}else{
						$("#testlt").append("<br/><div style='margin-left:550px;'>暂无聊天记录</div>")
					}
				}
			});
		}
	}
}

</script>
<style type = "text/css"> 
	a{text-decoration:none};
</style>
</head>
<body>
	<table>
		<tr>
				<!-- 点击tree上的不同用过户名可以对不同的用户进行聊天操作-->
				<div class="easyui-layout" style="width:1280px;height:480px;">
				<div region="west" split="true" title="好友列表" style="width:150px;">
					<p style="padding:5px;margin:0;">@全部人员:</p>
					<ul>
					 <c:set var="count" value="0"></c:set>
						<c:forEach items="${listUsers}" var="us">
							<li><a href="javascript:void(0)" id="${us.u_name}" style="line-height:20px" onclick="showcontent('${us.u_name}')">${us.u_name}</a></li>
						</c:forEach>
					</ul>
				</div>
				<div id="content" region="center" title="聊天平台" style="padding:5px;">
					<div id="tt" class="easyui-tabs" style="width:1121px;height:300px;">   
					</div> 
					<input  class="easyui-textbox" id="ltcontext" data-options="multiline:true,height:50,prompt:'发送消息...'"  style="width:1000px;height:100px;"/>
					<a href="javascript:void(0)" onclick="send()" class="easyui-linkbutton" data-options="height:100,plain:true,iconCls:'icon-ok'" onclick="fasongxiaoxi()">发生消息</a>
				</div>
			</div>
			</td>
		</tr>
	</table>
</body>
</html>