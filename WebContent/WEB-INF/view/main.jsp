<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>人力资源管理系统</title>
		<script src="js/global.js"></script> 
		<script src="jquery-easyui-1.4.3/jquery.cookie.js"></script> 
		<script>
		//树形结构显示
	    $(function(){
	    	var roleName=globalData.getCurUName();
	    	$("#spName").text(globalData.getCurUName());
	    	$("#menuTree").tree({
	    		url:'moduls?u_id='+<%=request.getSession().getAttribute("u_id")%>,
	    		method:'post',
	    		lines: true,
	    		onClick: function (node){
	    			 var flag = $("#tt").tabs('exists', node.text);
	    			 var isLeaf = $('#treeUlId').tree('isLeaf',node.target); //是否是叶子节点
	                 if (isLeaf) {//只有叶子节点才会在选项卡中创建选项页（每个选项页对应1个功能）
	                     if(!flag){
	                         $('#tt').tabs('add', { //在选项卡中，创建1个选项页
	                             title: node.text,   //选项卡中，选项页的标题（在同一个选项卡中，选项页需要保持一致）。
	                             closable: true,
	                             content: "<iframe  src='"+node.url+"' style='height:100%;width:100%'/>"    //此处做了调整，推荐使用iframe的方式实现
	                        });
	                     } else {
	                         $("#tt").tabs('select', node.text); //直接选中title对应的选项卡
	                     }
	                 }else{
	                	 if(node.url!=null){
	                		 //如果是父节点还有url的话则可以选中打开
	                		 /* if(!flag) {
		                         $('#tt').tabs('add', { //在选项卡中，创建1个选项页
		                             title: node.text,   //选项卡中，选项页的标题（在同一个选项卡中，选项页需要保持一致）。
		                             closable: true,
		                             content: "<iframe  src='"+node.url+"' style='height:100%;width:100%'/>"    //此处做了调整，推荐使用iframe的方式实现
		                        });
		                     } else {
		                         $("#tt").tabs('select', node.text); //直接选中title对应的选项卡
		                     }  */
	                	 }
	                 }
	    		}
	    		
	    	});
	    	//页面加载是判断是否该用户是否已打卡
	    	qiandaodaka();
	    });  
	    var i=0;
		function qiandaodaka(){
			$.ajax({
	    		url:'selectUserIsFouDaKa',
	    		method:'post',
	    		data:{
	    			u_id:<%=request.getSession().getAttribute("u_id")%>
	    		},
	    		dataType:'json',
	    		success:function(res){
	    			if(res.success){
	    				//返回0未打卡
	    				i=res.message;
	    				if(i==1){
	    					 $('#dk').linkbutton({text:'已打卡'});
	    					 $('#dk').linkbutton('disable');
	    				}
	    			}
	    		}
	    	})
		}
		var a=0;
		function qiandao(){
			var s=$("#showTime").text();
			if(s.length==7){
				s="0"+s;
			}
			var t="00:00:00";
			var d="23:00:00";
			 if(s<t || s>d ){
				 $('#dk').linkbutton('disable');
			}
			if( s>t && s<d && i==0){
				i=1;
				$.messager.confirm('确认','您还未签到点击确定进行签到！',function(r){    
		    	    if (r){ 
		    	    	//确认签到执行签到操作
		    	    	dianjidaka();
		    	    }
		    	});
			}
		}
		function dianjidaka(){
			$.ajax({
	    		url:'updataUserchecksIsDaka',
	    		data:{
	    			u_id:<%=request.getSession().getAttribute("u_id")%>,
	    			us_checkState:"是"
	    		},
	    		method:'post',
	    		dataType:'json',
	    		success:function(res){
	    			if(res>0){
	    				$('#dk').linkbutton({text:'已打卡'});
	    				$('#dk').linkbutton('disable');
	    				$.messager.alert("提示信息","打卡成功");
	    			}
	    		}
	    	})  
		}
		function time()
	    {   
	       dt = new Date();
	       var h=dt.getHours();//获取时
	       var m=dt.getMinutes();//获取分
	       var s=dt.getSeconds();//获取秒
	       document.getElementById("showTime").innerHTML = h+":"+m+":"+s;
	       setTimeout("time()",1000); //设定定时器，循环运行     
	       setTimeout("qiandao()",1000); //设定定时器，循环运行     
	      
	       
	    } 
    function tuichu(){
	   	$.messager.confirm("确认","你确认要推出当前页面吗？",function(r){
	   		if(r){
	   			$.removeCookie('u_pwd',{ path: '/'});
	   			$.removeCookie('u_name',{ path: '/'});
	    		sessionStorage.clear();
	    		window.location.href="/SSM/log";
	   		}
	   	});
    }
    $.extend($.fn.validatebox.defaults.rules, {    
        equals: {    
            validator: function(value,param){    
                return value == $(param[0]).val();    
            },    
            message: '两次密码输入的不一样!'   
        }    
    });
    function xiugaimima(){
    	$("#updataPwd_window").window("open");
    }
    function clearPwdForm(){
    	$("#updataPwd_window").window("close");
    }
    function submitPwdForms(){
    	if($("#updatePwdForm").form("validate")){
    		 $.ajax({
         		url:'selectUserByPwd',
         		data:{
         			u_id:<%=request.getSession().getAttribute("u_id")%>,
         			u_pwd:$("#loadpwd").val()
         		},
         		method:'post',
         		dataType:'json',
         		success:function(res){
         			if(res>0){
         				$.ajax({
         	        		url:'updateUsersByPwd',
         	        		data:{
         	        			u_id:<%=request.getSession().getAttribute("u_id")%>,
         	        			u_pwd:$("#rpwd").val()
         	        		},
         	        		method:'post',
         	        		dataType:'json',
         	        		success:function(res){
         	        			if(res.success){
         	        				$("#updataPwd_window").window("close");
         	        				$.messager.alert("提示信息",res.message);
         	        			}
         	        		}
         	        	}) 
         			}else{
         				$.messager.alert("提示信息","旧密码错误！");
         			}
         		}
         	})
    	}else{
    		$.messager.alert("提示信息","请完善数据")
    	}
    	
    }
		</script>
	</head>
	<body> 
		<div style="margin:20px 0;"></div>
	    <div class="easyui-layout" style="width:100%;height:700px;">
	        <div data-options="region:'north'" style="height:100px">
	        	<img alt="" src="img/main.jpg" style="height:98px;width:700px;float:left;"  >
	        	<div style="margin:60px 50px 20px;float:right;">
	        	<font color="green" >CRM系统&nbsp;&nbsp;欢迎您：</font>&nbsp;
	        	<font color="red"><span id="spName"></span>&nbsp;&nbsp;</font>
	        	<font color="green" >
	        		<span id="showTime"></span>
	        		<span id="currentdate">&nbsp;
	        			<a id="btn" href="javascript:void" onclick="tuichu()" style="cursor:pointer">安全退出</a>
	        			<a href="javascript:void(0)" data-options="plain:true" id="dk" class="easyui-linkbutton" onclick="dianjidaka()">打卡</a>
						<a href="javascript:void(0)" data-options="plain:true"  class="easyui-linkbutton" onclick="xiugaimima()">修改密码</a>
	        		</span>
	        	</font>
	        	</div>
	        </div>
	        <div data-options="region:'south',split:true" style="height:50px;"></div>
	        <div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:150px;padding:10px;">东部区域</div>
		        <div data-options="region:'west',split:true" title="导航应用" style="width:150px;">
		           <div id="menuTree" ><!--这个地方显示树状结构-->
		           		
		           </div>
		        </div>
	        
	        <div id="center_1" data-options="region:'center',iconCls:'icon-ok'">
	            <div id="tt" class="easyui-tabs" data-options="fit:true,border:false"> <!--这个地方采用tabs控件进行布局-->
	             	<div title="首页" style="padding:10px">
						<div align="center" style="padding-top:100px;"><font color="red" size="7">欢迎使用</font></div>
					</div>
	            </div>
	        </div>
	    </div>
	    
	    <!--修改密码-->
<div id="updataPwd_window" class="easyui-window" title="修改密码" data-options="modal:true,closed:true,iconCls:'icon-save'" style="padding:10px; top: 200px;">
	<form id="updatePwdForm">
		<table cellpadding="5">
			<tr>
				<td>旧密码:</td>
				<td><input class="easyui-validatebox" type="password" id="loadpwd"  name="loadpwd" data-options="required:true"></input>
				</td>
			</tr>
			<tr>
				<td>新密码:</td>
				<td> 
					<input id="pwd" name="pwd" type="password" class="easyui-validatebox" data-options="required:true" />   
				<!-- <input class="easyui-textbox" type="text" name="newpwd" id="newpwd" data-options="required:true"></input> -->
				</td>
			</tr>

			<tr>
				<td>确认密码:</td>
				<td><!-- <input type="text" class="easyui-textbox" id="qrpwd" name="qrpwd" data-options="required:true"> -->
					<input id="rpwd" name="rpwd" type="password" class="easyui-validatebox"     
   					 required="required" validType="equals['#pwd']" /> 
				</td>
			</tr>
		</table>
	</form>
	<div style="text-align:center;padding:5px">
		<a href="javascript:void(0)" class="easyui-linkbutton" type="button" onclick="submitPwdForms()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearPwdForm()">取消</a>
	</div>
</div>
	</body>
	<script type="text/javascript">
	time();
	</script>
</html>
