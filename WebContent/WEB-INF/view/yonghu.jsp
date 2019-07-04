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
	});
	function init(){
		$('#dg').datagrid({    
		    url:"${pageContext.request.contextPath}/selectStuAll",  
		    method:"post",
		    fitColumns:true,
		    pagination:true,
		    singleSelect:true,
			selectOnCheck:false,
			striped:true,
			checkOnSelect:false,
		    onDblClickRow:function(index, row){
		    	lookStu(index);
			},
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
		$("#stuForm").form("reset");
	}
	
	

	
	function formattercaozuo(value,row,index){
		return "<a href='javascript:void(0)' onclick='updateStu("+index+")'>编辑</a>   "+
				"<a href='javascript:void(0)' onclick='deleteStu("+index+")'>删除</a>   "+
				"<a href='javascript:void(0)' onclick='lookStu("+index+")'>查看</a>      ";
	}
	
	function formattergenzong(value,row,index){
		return "<a href='javascript:void(0)' onclick='follow("+index+")'>跟踪</a>   "+
				"<a href='javascript:void(0)' onclick='rizhi("+index+")'>日志</a>   ";
	}
	
	function formatterfunction(value,row,index){
		return row.users != undefined ?  row.users.u_name : "未分配";
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
	
	function follow(){
		$("#genzong").form("clear");
		$("#genzongStu").dialog("open");
	}
	
	function clearStudent(){
		$("#genzongStu").dialog("close");
	}

	function genzong(){
		if($("#genzong").form("validate")){
			var row= $("#dg").datagrid("getSelected");
			
			var begtime=$("#n_followTime").datebox("getValue");
			var endtime=$("#n_nextfollowTime").datebox("getValue");
			if(begtime > endtime){
				return $.messager.alert("提示信息","下次跟踪时间必须大于回访时间！");
			}
			$.ajax({
				url:'${pageContext.request.contextPath}/insertStugz',
				method:'post',
				data:{
					s_id:row.s_id,
					s_name:row.s_name,
					n_userid:row.u_id,
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
		}else{
			$.messager.alert("提示信息","请填写完整！");
		}
		
	}
	
	function insertStudent(){
		$("#inserstuform").form("reset");
		var status= $("#zdfl").switchbutton("options").checked;
		$('#u_idshoudong').combobox({
			url:'${pageContext.request.contextPath}/selectUsersByZXS',
			valueField:'u_id',
			textField:'u_name'
		});
		$('#u_idshoudong').combobox('enable');
		$('#zdfl').switchbutton('enable');
		/* 修改标题并打开 */
		$("#insertstu_dialog").dialog({title:'添加学生'}).dialog("open");
	}
	 $(function(){
		    $('#zdfl').switchbutton({ 
		      checked: false, 
		      onChange: function(checked){ 
		        if(checked){
		        	$('#u_idshoudong').combobox('disable');
		        }else{
		        	$('#u_idshoudong').combobox('enable');
		        }
		      } 
		    });
		  })  
		$(function(){
		    $('#u_idshoudong').combobox({ 
		      checked: false, 
		      onChange: function(checked){ 
		        if(checked){
		        	$('#zdfl').switchbutton('disable');
		        }else{
		        	$('#zdfl').switchbutton('enable');
		        }
		      } 
		    });
		});
		  
	function addStu(){
		 /* 是否开启自动分量 */
		var status= $("#zdfl").switchbutton("options").checked;
		var fenliang= status ==true ? "1" : "0";
		$.ajax({
			url:'${pageContext.request.contextPath}/insertStu?s_createUser='+globalData.getCurUName()+'&fenliang='+fenliang,
			method:'post',
			data:$("#inserstuform").serializeArray(),
			success:function(res){
				if(res>0){
					$('#dg').datagrid("reload");
					$("#insertstu_dialog").dialog("close");
					$.messager.alert('提示信息','添加成功');    
				}
			}
		},"json")
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
	
	
	var xgname;
	var xgid;
	function updateStu(index){
		var data = $("#dg").datagrid("getData");
		/* 每次打开都清空form数据 */
		$("#stuForm").form("reset");
		/* 显示提交按钮 */
		$("#tj").show();
		
		/* 获取选择的表单数据 */
		//var data = $("#dg").datagrid("getData");
		
		$("#stuForm").form("load",data.rows[index]);
		
		/* 对表示input进行赋值，标识框主要用来在后面提交时判断url的 */
		$("#mark").val("2");
		if($("#mark").val()=="2"){
			$('#u_ids').combobox({
				url:'${pageContext.request.contextPath}/selectUsersByZXS',
				valueField:'u_id',
				textField:'u_name'
			})
		};
		var name;
		if(data.rows[index].users!=undefined){
			name=data.rows[index].users.u_name;
			xgname=data.rows[index].users.u_name;
			xgid=data.rows[index].users.u_id;
		}else{
			name="未分配";
		}
		$("#u_ids").textbox('setValue',name);
		if(data.rows[index].s_isValid=="否"){
			$('input[name="s_isValid"]').attr("disabled", false);//是否有效
			$("#s_lostValidzy").textbox("disable");//无效原因disable  enable
			 jinyong();
		 }
		 if(data.rows[index].s_isValid=="是"){
			 $('input[name="s_isValid"]').attr("disabled", false);//是否有效
			 $("#s_addresszy").textbox('enable');//所在区域
			 $("#s_netpusherldzy").combobox('enable');//学员关注
			 $("#s_sourcezy").combobox('enable');//课程方向
			 $("#s_learnforwardzy").combobox('enable');//打分
			 $("#u_ids").combobox('enable');//咨询师
			 $("#s_askerContentzy").textbox("enable")//咨询师备注
			 $("#s_inClassContentzy").textbox("enable")//进班备注
			 $("#s_inClassTimezy").textbox("enable")//进班时间
			 $("#s_recordzy").textbox("enable")//备注
			 $("#s_isbaobeizy").combobox("enable")//报备
			 $("#s_fromPartzy").combobox("enable")//来源网址
			 $("#s_wxzy").textbox("enable")//微信
			 $("#s_statezy").combobox("enable")//状态
			 $("#s_qqzy").textbox("enable")//qq
			 $("#s_stuConcernzy").combobox("enable")//学历
			 $("#s_keywordszy").textbox("enable")//来源关键词
			 $("#s_sexzy").combobox("enable")//性别
			 $("#s_courceurlzy").combobox("enable")//来源渠道
			 $("#s_agezy").textbox("enable")//年龄
			 $("#s_iphonezy").textbox("enable")//手机号
			 $("#s_namezy").textbox("enable")//名称
			 $('input[name="s_isreturnVist"]').attr("disabled", false);//是否回访
			 $('input[name="s_ishome"]').attr("disabled", false);//是否上门
			 $('input[name="s_ispay"]').attr("disabled",false);//是否缴费
			 $('input[name="s_isReturnMoney"]').attr("disabled", false);//是否退费
			 $('input[name="s_isInClass"]').attr("disabled", false);//是否进班
			 $("#s_lostValidzy").textbox("disable")//无效原因
		 }
		 if(data.rows[index].s_isreturnVist=="未回访"){
			 $("#s_fistVisitTimezy").datebox("disable")//是否回访
		 }
		 if(data.rows[index].s_ishome=="未上门"){
			 $("#s_homeTimezy").datebox("disable")//上们时间
		 }	 
		 if(data.rows[index].s_ispay=="未缴费"){
			 $("#s_paytimezy").datebox("disable")//缴费时间
			 $("#s_moneyzy").datebox("disable")//缴费金额
			 $('input[name="s_isReturnMoney"]').attr("disabled", "disabled");//是否退费
		 }
		 if(data.rows[index].s_isReturnMoney=="未退费"){
			 $("#s_returnMoneyReasonzy").textbox("disable")//退费原因
		 }
		 if(data.rows[index].s_isInClass=="未进班"){
			 $("#s_inClassContentzy").textbox("disable")//进班备注
			 $("#s_inClassTimezy").textbox("disable")//进班时间
		 }
		 dataformInit=$("#stuForm").serializeArray();
		/* 修改标题并打开 */
		$("#stu_dialog").dialog({title:'编辑学生'}).dialog("open");
		setTimeoutForm();
	}
	var dataformInit,ctime;
	function setTimeoutForm(){
		var jsonTextInit = JSON.stringify({ dataform: dataformInit});
		
		var dataform = $("#stuForm").serializeArray();
		var jsonText = JSON.stringify({ dataform: dataform }); 
		 if(jsonTextInit==jsonText)  { 
			 $('#updateStudentform').linkbutton('disable');
     	 }else{
     		 $('#updateStudentform').linkbutton('enable');
     	 }
		 ctime=setTimeout("setTimeoutForm()",200);
	}
	$(function(){
		$("input[name='s_isInClass']").click(function(){
			var val = $(this).val();
			if(val=="未进班"){
				 $("#s_inClassContentzy").textbox("disable")//进班备注
				 $("#s_inClassTimezy").textbox("disable")//进班时间
			}
			if(val=="已进班"){
				 $("#s_inClassContentzy").textbox("enable")//进班备注
				 $("#s_inClassTimezy").textbox("enable")//进班时间
			}
		});
		$("input[name='s_isReturnMoney']").click(function(){
			var val = $(this).val();
			if(val=="未退费"){
				 $("#s_returnMoneyReasonzy").textbox("disable")//退费原因
			}
			if(val=="已退费"){
				 $("#s_returnMoneyReasonzy").textbox("enable")//退费原因
			}
		});
		$("input[name='s_isreturnVist']").click(function(){
			var val = $(this).val();
			if(val=="未回访"){
				 $("#s_fistVisitTimezy").datebox("disable")
			}
			if(val=="已回访"){
				 $("#s_fistVisitTimezy").datebox("enable")
			}
		});
		$("input[name='s_ishome']").click(function(){
			var val = $(this).val();
			if(val=="未上门"){
				 $("#s_homeTimezy").datebox("disable")//上们时间
			}
			if(val=="已上门"){
				 $("#s_homeTimezy").datebox("enable")//上们时间
			}
		});
		$("input[name='s_ispay']").click(function(){
			var val = $(this).val();
			if(val=="未缴费"){
				var val1 = $('input[name="s_isReturnMoney"]:checked').val(); 
				if(val1=="已退费"){
					$("#yijioafei")[0].checked=true;
					return $.messager.alert("提示信息","和是否退费产生冲突！");
				}else{
					$("#s_paytimezy").datebox("disable")//缴费时间
					 $("#s_moneyzy").datebox("disable")//缴费金额
					 $('input[name="s_isReturnMoney"]').attr("disabled", "disabled");//是否退费
				}
			}
			if(val=="已缴费"){
				 $("#s_paytimezy").datebox("enable")//缴费时间
				 $("#s_moneyzy").datebox("enable")//缴费金额
				 $('input[name="s_isReturnMoney"]').attr("disabled",false);//是否退费
			}
		});
		$("input[name='s_isValid']").click(function(){
			var val = $(this).val();
			   if(val=="否"){
				     $("#s_addresszy").textbox('disable');//所在区域
					 $("#s_netpusherldzy").combobox('disable');//学员关注
				     $("#u_ids").combobox('disable');//咨询师
				     $("#s_sourcezy").combobox('disable');//课程方向
					 $("#s_learnforwardzy").combobox('disable');//打分
					 $("#s_fistVisitTimezy").datebox("disable")//首访时间
					 $("#s_homeTimezy").datebox("disable")//上们时间
					 $("#s_preMoneyTimezy").datebox("disable")//定金时间
					 $("#s_paytimezy").datebox("disable")//缴费时间
					 $("#s_moneyzy").datebox("disable")//缴费金额
					 $("#s_preMoneyzy").numberbox("disable")//定金金额
					 $("#s_askerContentzy").textbox("disable")//咨询师备注
					 $("#s_inClassContentzy").textbox("disable")//进班备注
					 $("#s_returnMoneyReasonzy").textbox("disable")//退费原因
					 $("#s_inClassTimezy").textbox("disable")//进班时间
					 $("#s_recordzy").textbox("disable")//备注
					 $("#s_isbaobeizy").combobox("disable")//报备
					 $("#s_fromPartzy").combobox("disable")//来源网址
					 $("#s_wxzy").textbox("disable")//微信
					 $("#s_statezy").combobox("disable")//状态
					 $("#s_qqzy").textbox("disable")//qq
					 $("#s_stuConcernzy").combobox("disable")//学历
					 $("#s_keywordszy").textbox("disable")//来源关键词
					 $("#s_sexzy").combobox("disable")//性别
					 $("#s_courceurlzy").combobox("disable")//来源渠道
					 $("#s_agezy").textbox("disable")//年龄
					 $("#s_iphonezy").textbox("disable")//手机号
					 $("#s_namezy").textbox("disable")//名称
					 $('input[name="s_isreturnVist"]').attr("disabled", "disabled");//是否回访
					 $('input[name="s_ishome"]').attr("disabled", "disabled");//是否上门
					 $('input[name="s_ispay"]').attr("disabled", "disabled");//是否缴费
					 $('input[name="s_isReturnMoney"]').attr("disabled", "disabled");//是否退费
					 $('input[name="s_isInClass"]').attr("disabled", "disabled");//是否进班
					 $("#s_lostValidzy").textbox("enable")//无效原因
				}
				if(val=="是"){
					 var yhf=$('input[name="s_isreturnVist"]:checked').val();
					 if(yhf=="已回访"){
						 $("#s_fistVisitTimezy").datebox("enable")//首访时间
					 }
					 var ysm=$('input[name="s_ishome"]:checked').val();
					 if(ysm=="已上门"){
						 $("#s_homeTimezy").datebox("enable")//上们时间
					 }
					 var sfjf=$('input[name="s_ispay"]:checked').val();
					 if(sfjf=="已缴费"){
						 $("#s_paytimezy").datebox("enable")//缴费时间
						 $("#s_moneyzy").datebox("enable")//缴费金额
					 }
					 var sftf=$('input[name="s_isReturnMoney"]:checked').val();
					 if(sftf=="已退费"){
						 $("#s_returnMoneyReasonzy").textbox("enable")//退费原因
					 }
					 var sfjb=$('input[name="s_isInClass"]:checked').val();
					 if(sfjb=="已进班"){
						 $("#s_inClassTimezy").textbox("enable")//进班时间
						 $("#s_inClassContentzy").textbox("enable")//进班备注
					 }
					 $("#s_addresszy").textbox('enable');//所在区域
					 $("#s_netpusherldzy").combobox('enable');//学员关注
					 $("#u_ids").combobox('enable');//咨询师
					 $("#s_sourcezy").combobox('enable');//课程方向
					 $("#s_learnforwardzy").combobox('enable');//打分
					 $("#s_preMoneyTimezy").datebox("enable")//定金时间
					 $("#s_preMoneyzy").numberbox("enable")//定金金额 
					 $("#s_askerContentzy").textbox("enable")//咨询师备注
					 $("#s_recordzy").textbox("enable")//备注
					 $("#s_isbaobeizy").combobox("enable")//报备
					 $("#s_fromPartzy").combobox("enable")//来源网址
					 $("#s_wxzy").textbox("enable")//微信
					 $("#s_statezy").combobox("enable")//状态
					 $("#s_qqzy").textbox("enable")//qq
					 $("#s_stuConcernzy").combobox("enable")//学历
					 $("#s_keywordszy").textbox("enable")//来源关键词
					 $("#s_sexzy").combobox("enable")//性别
					 $("#s_courceurlzy").combobox("enable")//来源渠道
					 $("#s_agezy").textbox("enable")//年龄
					 $("#s_iphonezy").textbox("enable")//手机号
					 $("#s_namezy").textbox("enable")//名称
					 $('input[name="s_isreturnVist"]').attr("disabled", false);//是否回访
					 $('input[name="s_ishome"]').attr("disabled", false);//是否上门
					 $('input[name="s_ispay"]').attr("disabled",false);//是否缴费
					 $('input[name="s_isReturnMoney"]').attr("disabled", false);//是否退费
					 $('input[name="s_isInClass"]').attr("disabled", false);//是否进班
					 $("#s_lostValidzy").textbox("disable")//无效原因
				}
		   })
			
	});
	function editStu(){
		var u_id=$("#u_ids").combobox("getValue");
		if(u_id==xgname){
			u_id=xgid;
		}
		if(u_id=="未分配"){
			u_id="";
		}
		var smsj = $('#s_homeTimezy').datebox('getValue');//上们时间
		var sfsj = $('#s_fistVisitTimezy').datebox('getValue');//首访时间
		if(smsj!=""){
			if(sfsj=="" || smsj<sfsj){
				return $.messager.alert("提示信息","首访时间必须大于上门时间！");
			}
		}
		var  jfsj = $('#s_paytimezy').datebox('getValue');//缴费时间
		var djsj = $('#s_preMoneyTimezy').datebox('getValue');//定金时间
		if(jfsj!=""){
			if(djsj=="" || jfsj<djsj){
				return $.messager.alert("提示信息","缴费时间必须大于定金时间！");
			}
		}
		xiugaixues(u_id);
	}
	function xiugaixues(u_id){
		$.ajax({
			url:'${pageContext.request.contextPath}/updateStus?u_id='+u_id,
			method:'post',
			data:$("#stuForm").serializeArray(),
			dataType:'json',
			success:function(res){
				if(res>0){
					clearTimeout(ctime);
					$("#dg").datagrid("reload");
					ClearStu();
					$.messager.alert("提示信息","修改成功");
				}
			}
		});
	}
	function jinyong(){
		 $("#s_addresszy").textbox('disable');//所在区域
		 $("#s_netpusherldzy").combobox('disable');//学员关注
		 $("#u_ids").combobox('disable');//咨询师学员关注
		 $("#s_sourcezy").combobox('disable');//课程方向
		 $("#s_learnforwardzy").combobox('disable');//打分
		 $("#s_preMoneyTimezy").datebox("disable")//定金时间
		 $("#s_preMoneyzy").numberbox("disable")//定金金额
		 $("#s_askerContentzy").textbox("disable")//咨询师备注
		 $("#s_inClassContentzy").textbox("disable")//进班备注
		 $("#s_inClassTimezy").textbox("disable")//进班时间
		 $("#s_lostValidzy").textbox("enable")//无效原因
		 $("#s_recordzy").textbox("disable")//备注
		 $("#s_isbaobeizy").combobox("disable")//报备
		 $("#s_fromPartzy").combobox("disable")//来源网址
		 $("#s_wxzy").textbox("disable")//微信
		 $("#s_statezy").combobox("disable")//状态
		 $("#s_qqzy").textbox("disable")//qq
		 $("#s_stuConcernzy").combobox("disable")//学历
		 $("#s_keywordszy").textbox("disable")//来源关键词
		 $("#s_sexzy").combobox("disable")//性别
		 $("#s_courceurlzy").combobox("disable")//来源渠道
		 $("#s_agezy").textbox("disable")//年龄
		 $("#s_iphonezy").textbox("disable")//手机号
		 $("#s_namezy").textbox("disable")//名称
		 $('input[name="s_isreturnVist"]').attr("disabled", "disabled");//是否回访
		 $('input[name="s_ishome"]').attr("disabled", "disabled");//是否上门
		 $('input[name="s_ispay"]').attr("disabled", "disabled");//是否缴费
		 $('input[name="s_isReturnMoney"]').attr("disabled", "disabled");//是否退费
		 $('input[name="s_isInClass"]').attr("disabled", "disabled");//是否进班
	}
	function lookStu(index){
		var data = $("#dg").datagrid("getData");
		var name;
		if(data.rows[index].users!=undefined){
			name=data.rows[index].users.u_name;
		}else{
			name="未分配";
		}
		$.ajax({
        	url:"${pageContext.request.contextPath}/selectStuByid",
        	method:'post',
        	data:{s_id:data.rows[index].s_id},
        	dataType:'json',
        	success:function(res){
        		if(res!=null){
        			/* 清空form数据 */
        			$("#stuForm").form("reset");
        			$("#tj").hide();
        			
        			$("#stuForm").form("load",res);/* 对form赋值 */
        			$("#u_ids").textbox('setValue',name);
        			jinyong();
        			$('input[name="s_isValid"]').attr("disabled", "disabled");//是否有效
        			$("#s_lostValidzy").textbox("disable");//无效原因disable  enable
        			$("#stu_dialog").dialog({title:'查看学生信息'}).dialog("open");
        		}
        	}
        })
	} 
	
	
	/* 提交添加Student */
	function SaveStu(){
		/* 判断使用那个方法提交 */
		$("#mark").val() == "2" ? editStu() : null;
	}
	
	function ClearStu(){
		clearTimeout(ctime);
		$("#stu_dialog").dialog("close");
	}
	
	
	/* 隐藏列 */
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
	//手机号验证
	$.extend($.fn.validatebox.defaults.rules, {    
	    telNum:{ //既验证手机号，又验证座机号
	        validator: function(value, param){ 
	            return /(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^(()|(\d{3}\-))?(1[358]\d{9})$)/.test(value);
	        },    
	        message: '请输入正确的电话号码。' 
	    }  
	});
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
	            <th data-options="field:'s_address'">客户地址</th>  
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
	            
	            <th data-options="field:'users.u_name',formatter:formatterfunction">咨询师</th>
	            
	            <th data-options="field:'caozuo',formatter:formattercaozuo">操作</th>
	           	<th data-options="field:'genzong',formatter:formattergenzong">操作</th>
	        </tr>
	    </thead>
	</table>
	
	<div id="stuTab" class="easyui-dialog" data-options="resizable:true,modal:true,closed:true">   
			<a id="btna" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="insertStudent()">添加</a>
			<a href="javascript:void(0);" id="btnExport" class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true"  >导出Excel</a>
			
		        <label for="name">姓名:</label>   
		        <input class="easyui-textbox" type="text" id="s_name" />   
		      
		        <label for="name">电话:</label>   
		        <input class="easyui-textbox" type="text" id="s_iphone" />   
		  		
		  		
	        	<label for="name">咨询师:</label> 
		  		<input class="easyui-combobox" type="text" id="u_id" panelHeight="auto"  data-options="editable:false,prompt:'——请选择 ——',valueField:'u_id',textField:'u_name',url:'selectUsersZiXunShi'" /> 
		  		
	        <a id="btn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="init()">搜索</a>
		   		
		<div id="aa" class="easyui-accordion" style="width:atuo;height:auto;" data-options="selected:false">
	  		<div title="更多" style="overflow:auto;padding:10px;" >

		    <label for="name">是否缴费:</label>   
	        <select class="easyui-combobox" data-options="editable:false" panelHeight='auto' style="width: 100px" id="s_ispay"> 
			    <option value="">-- 请选择 --</option>
			    <option value="已缴费">已缴费</option>   
			    <option value="未缴费">未缴费</option>   
			</select>
	        <label for="name">QQ:</label>   
	        <input class="easyui-textbox" type="text" id="s_qq" />    
	     	<label for="name">是否有效:</label>   
	        <select class="easyui-combobox" data-options="editable:false" panelHeight='auto' style="width: 100px" id="s_isValid"> 
			    <option value="">-- 请选择 --</option>
			    <option value="是">是</option>   
			    <option value="否">否</option>   
			</select>   
	      	<label for="name">是否回访:</label>   
	        <select class="easyui-combobox" data-options="editable:false" panelHeight='auto' style="width: 100px" id="s_isreturnVist"> 
			   	<option value="">-- 请选择 --</option>
			    <option value="已回访">已回访</option>   
			    <option value="未回访">未回访</option>   
			</select>
	       	<label for="name">创建时间:</label>   
	        <input class="easyui-datebox" type="text" id="min_s_createTime" />~
	        <input class="easyui-datebox" type="text" id="max_s_createTime" /> 
	        <br>
	        <label for="name">上门时间:</label>   
	        <input class="easyui-datebox" type="text" id="min_s_homeTime" />~
	        <input class="easyui-datebox" type="text" id="max_s_homeTime" />   
	        <label for="name">受访时间:</label>   
	        <input class="easyui-datebox" type="text" id="min_s_fistVisitTime" />~   
	        <input class="easyui-datebox" type="text" id="max_s_fistVisitTime" />   
	        <br>
	        <label for="name">缴费时间:</label>   
	        <input class="easyui-datebox" type="text" id="min_s_paytime" />~
	        <input class="easyui-datebox" type="text" id="max_s_paytime" />      
	        <label for="name">进班时间:</label>   
	        <input class="easyui-datebox" type="text" id="min_s_inClassTime" />~
	        <input class="easyui-datebox" type="text" id="max_s_inClassTime" />   
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
						</table>
					</form>
				</div>
   			 </div>   
	</div> 
	
	<div id="stu_dialog" class="easyui-window" data-options="modal:true,closed:true" style="padding:10px; top: auto;height:auto;width:1100px;">
		<form id="stuForm" method="post">
			<table>
				<tr>
					<td>
						<table cellpadding="5">
							<tr>
								<td><h3>在线录入：</h3></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							
							<tr>
								<td>客户姓名:</td>
								<td><input class="easyui-textbox" type="text" id="s_namezy" name="s_name" style="width: 80px" />
								<input type="hidden" name="s_id" /><input type="hidden" id="mark"/>
								</td>
								<td>客户电话:</td>
								<td><input class="easyui-textbox" id="s_iphonezy" name="s_iphone" /></td>
							</tr>
							<tr>
								<td>客户年龄:</td>
								<td><input class="easyui-numberbox"  type="text" id="s_agezy" name="s_age" style="width: 80px" /></td>
								<td>来源渠道:</td>
								<td>
									<select class="easyui-combobox" id="s_courceurlzy" panelHeight="auto"  data-options="editable:false" style="width: 160px" name="s_courceurl"> 
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
									<select class="easyui-combobox"  name="s_sex" id="s_sexzy" style="width: 80px"  panelHeight='auto' data-options="editable:false,required:true" > 
									    <option value="男">男</option>  
									    <option value="女">女</option>  
								    </select>
									<!-- <input type="radio" value="男"  name="s_sex" />男
		        					<input type="radio" value="女"  name="s_sex" />女 -->
								</td>
								<td>来源关键词:</td>
								<td><input class="easyui-textbox" id="s_keywordszy" type="text" name="s_keywords" /></td>
							</tr>
							<tr>
								<td>客户学历:</td>
								<td>	
								<select class="easyui-combobox" panelHeight="auto"  id="s_stuConcernzy" data-options="editable:false" style="width: 80px" name="s_stuConcern" > 
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
								<td><input class="easyui-numberbox" id="s_qqzy" type="text" name="s_qq" /></td>
							</tr>
							<tr>
								<td>客户状态:</td>
								<td>
									<select class="easyui-combobox" id="s_statezy" panelHeight="auto"  data-options="editable:false" style="width: 80px" name="s_state"> 
									    <option value="">--请选择--</option>
									    <option value="未知">未知</option>   
									    <option value="待业">待业</option> 
									    <option value="在职">在职</option>
									    <option value="在读">在读</option>  
									</select>
								</td>
								<td>客户微信:</td>
								<td><input class="easyui-textbox" type="text" id="s_wxzy" name="s_wx" /></td>
							</tr>
							<tr>
								<td>来源网站:</td>
								<td>
									<select class="easyui-combobox" id="s_fromPartzy" style="width: 80px" panelHeight="auto"  data-options="editable:false" name="s_fromPart"> 
									    <option value="">--请选择--</option>
									    <option value="其他">其他</option>   
									    <option value="职英B站">职英B站</option> 
									    <option value="职英A站">职英A站</option>
									    <option value="高考站">高考站</option>  
									</select>
								</td>
								<td>是否报备:</td>
								<td>
									<select class="easyui-combobox" panelHeight='auto' data-options="editable:false" id="s_isbaobeizy" name="s_isbaobei" style="width: 80px"> 
									    <option value="">--请选择--</option>   
									    <option value="是">是</option>   
									    <option value="否">否</option> 
									</select>
									<!-- <input type="radio" value="是" name="s_isbaobei" />是
		        					<input type="radio" value="否" name="s_isbaobei" />否 -->
								</td>
							</tr>
							<tr>
								<td>学员关注:</td>
								<td>
									<select class="easyui-combobox" style="width: 80px" panelHeight="auto" id="s_netpusherldzy" data-options="editable:false" name="s_netpusherld"> 
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
								<td>客户地址:</td>
								<td><input class="easyui-textbox" data-options="prompt:'所在区域'" type="text" id="s_addresszy" name="s_address" /></td>
							</tr>
							<tr>
								<td>录入人:</td>
								<td><input class="easyui-textbox" style="width: 80px" data-options="readonly:true" type="text" name="s_createUser" /></td>
							</tr>
						</table>
						<table>
							<tr>
								<td>&ensp;备&ensp;注:</td>
								<td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;<input class="easyui-textbox"
									data-options="prompt:'备注',multiline:true,height:50,width:329"
									 type="text" id="s_recordzy" name="s_record" /></td>
							</tr>
						</table>
					</td>
					<td>
						<table cellpadding="5">
							<tr>
								<td><h3>咨询师录入：</h3></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td>咨询师:</td>
								<td>
									<select class="easyui-combobox" data-options="editable:false" style="width: 150px" panelHeight="auto" name="u_ids" id="u_ids">
	    							</select>
								</td>
								<td>课程方向:</td>
								<td>
									<select class="easyui-combobox" data-options="editable:false,prompt:'——请选择课程 ——'" panelHeight="auto" style="width: 150px" id="s_sourcezy" name="s_source"> 
									    <option value="软件开发">软件开发</option> 
									    <option value="软件设计">软件设计</option>
									    <option value="网络营销">网络营销</option> 
									</select>
								</td>
							</tr>
							<tr>
								<td>客户打分:</td>
								<td>
									<select class="easyui-combobox" style="width: 150px" id="s_learnforwardzy" data-options="editable:false,prompt:'——请选择 ——'" panelHeight="auto" name="s_learnforward"> 
									    <option value="A.近期可报名">A.近期可报名</option> 
									    <option value="B.一个月内可报名">B.一个月内可报名</option>
									    <option value="C.长期 跟踪">C.长期跟踪</option>
									    <option value="D.无效">D.无效</option> 
									</select>
								</td>
								<td>是否有效:</td>
								<td>
									 <input type="radio" id="shi" value="是" name="s_isValid" />
									 <label for="shi">是</label>
							         <input type="radio" id="fou" value="否" name="s_isValid" />
							         <label for="fou">否</label>
						        </td>
							</tr>
							<tr>
								<td>无效原因:</td>
								<td><input class="easyui-textbox" type="text" data-options="prompt:'无效原因... '" style="width: 150px" id="s_lostValidzy" name="s_lostValid" /></td>
								<td>是否回访:</td>
								<td>
									<input type="radio" id="yihuifang"  value="已回访" name="s_isreturnVist" />
							        <label for="yihuifang">已回访</label>
							        <input type="radio" id="weihuifang" value="未回访" name="s_isreturnVist" />
							        <label for="weihuifang">未回访</label>
		        				</td>
							</tr>
							<tr>
								<td>首访时间:</td>
								<td><input class="easyui-datebox"  type="text" data-options="editable:false,prompt:'首访时间'" style="width: 150px" id="s_fistVisitTimezy" name="s_fistVisitTime" /></td>
								<td>是否上门:</td>
								<td>
									<input type="radio" id="yishangmen" value="已上门" name="s_ishome" />
									<label for="yishangmen">已上门</label>
							        <input type="radio" id="weishangmen" value="未上门" name="s_ishome" />
							        <label for="weishangmen">未上门</label>
								</td>
							</tr>
							<tr>
								<td>上门时间:</td>
								<td><input class="easyui-datebox" data-options="editable:false,prompt:'上门时间'" style="width: 150px" id="s_homeTimezy" name="s_homeTime" /></td>
								<td>定金金额:</td>
								<td><input class="easyui-numberbox" data-options="prompt:'定金金额',min:0,precision:2" style="width: 150px" id="s_preMoneyzy" name="s_preMoney" /></td>
							</tr>
							<tr>
								<td>定金时间:</td>
								<td><input class="easyui-datebox" id="s_preMoneyTimezy" data-options="editable:false,prompt:'定金时间'" style="width: 150px" name="s_preMoneyTime" /></td>
								<td>是否缴费:</td>
								<td>
									<input type="radio" id="yijioafei" value="已缴费" name="s_ispay" />
									<label for="yijioafei">已缴费</label>
							        <input type="radio" id="weijiaofei" value="未缴费" name="s_ispay" />
									<label for="weijiaofei">未缴费</label>
								</td>
							</tr>
							<tr>
								<td>缴费时间:</td>
								<td><input class="easyui-datebox" data-options="editable:false,prompt:'缴费时间'" style="width: 150px" id="s_paytimezy" name="s_paytime" /></td>
								<td>缴费金额:</td>
								<td><input class="easyui-numberbox" style="width: 150px" id="s_moneyzy" name="s_money" data-options="prompt:'缴费金额',min:0,precision:2" /></td>
							</tr>
							<tr>
								<td>是否退费:</td>
								<td>
									<input type="radio" id="yituifei" value="已退费" name="s_isReturnMoney" />
									<label for="yituifei">已退费</label>
							        <input type="radio" id="weituifei" value="未退费" name="s_isReturnMoney" />
							        <label for="weituifei">未退费</label>
								</td>
								<td>退费原因:</td>
								<td>
									<input class="easyui-textbox" data-options="prompt:'退费原因...'" style="width: 150px" id="s_returnMoneyReasonzy" name="s_returnMoneyReason" />
								</td>
							</tr>
							<tr>
								<td>是否进班:</td>
								<td>
									<input type="radio" id="yijinban" value="已进班" name="s_isInClass" />
									<label for="yijinban">已进班</label>
							        <input type="radio" id="weijinban" value="未进班" name="s_isInClass" />
							        <label for="weijinban">未进班</label>
								</td>
								<td>进班时间:</td>
								<td>
									<input class="easyui-datebox" data-options="editable:false,prompt:'进班时间'" style="width: 150px" id="s_inClassTimezy" name="s_inClassTime" />
								</td>
							</tr>
							<tr>
								<td>进班备注:</td>
								<td>
									<input class="easyui-textbox" id="s_inClassContentzy" data-options="prompt:'进班备注...',multiline:true,height:50,width:150" name="s_inClassContent" />
								</td>
								<td>咨询师备注:</td>
								<td>
									<input class="easyui-textbox" id="s_askerContentzy" data-options="prompt:'咨询师备注...',multiline:true,height:50,width:150" type="text" name="s_askerContent" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
				<div id="tj" style="padding:3px;float: left;">
					<a id="updateStudentform" href="javascript:void(0)" onclick="SaveStu()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>  
					<a id="btn" href="javascript:void(0)" onclick="ClearStu()" class="easyui-linkbutton" data-options="iconCls:'icon-clear'">取消</a>  
				</div>
		</form>
			
	</div>
	
	<div id="insertstu_dialog" class="easyui-dialog" title="新增员工信息" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:auto;padding:10px; top: auto;">
	<form id="inserstuform">
		<table cellpadding="5">
			<tr>
				<td>客户名称:</td>
				<td><input class="easyui-textbox" type="text" name="s_name" style="width: 150px" data-options="required:true,prompt:'姓名必须填写'"/></td>
				<td>客户手机号:</td>
				<td><input class="easyui-textbox" name="s_iphone" data-options="prompt:'请输入正确的电话号码',validType:'telNum'" /></td>
			</tr>
			<tr>
				<td>年龄:</td>
				<td><input class="easyui-numberbox" type="text" name="s_age" style="width: 150px"  data-options="min:16,max:30,prompt:'16-30岁之间'"/></td>
				<td>来源渠道:</td>
				<td>
					<select class="easyui-combobox"  name="s_courceurl" style="width: 159px" panelHeight="auto"  data-options="editable:false,required:true,prompt:'必须选择来源渠道'" > 
					    <option value="">--请选择--</option>   
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
				<td> 
					<!--  <input type="radio" name="s_sex" value="男" checked="checked" />男  
					 <input type="radio" name="s_sex" value="女"/> 女   -->
					 <input type="radio" id="nans" value="男" name="s_sex" checked="checked" />
					 <label for="nans">男</label>
			         <input type="radio" id="nvs" value="女" name="s_sex" />
			         <label for="nvs">女</label>
			    </td>
				<td>来源关键词:</td>
				<td><input class="easyui-textbox" type="text" data-options="prompt:'请输入来源关键词'" name="s_keywords" /></td>
			</tr>
			<tr>
				<td>客户学历:</td>
				<td>
					<select class="easyui-combobox" panelHeight="auto" data-options="editable:false" style="width: 150px" name="s_stuConcern" > 
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
					<select class="easyui-combobox" panelHeight="auto" data-options="editable:false" style="width: 150px" name="s_state"> 
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
					<select class="easyui-combobox" panelHeight="auto" data-options="editable:false" style="width: 150px" name="s_fromPart"> 
					    <option value="">--请选择--</option>   
					    <option value="其他">其他</option>   
					    <option value="职英B站">职英B站</option> 
					    <option value="职英A站">职英A站</option>
					    <option value="高考站">高考站</option>  
					</select>
				</td>
				<td>是否报备:</td>
				<td>
					 <!-- <input type="radio" value="是" name="s_isbaobei" checked="checked" />是
		       		 <input type="radio" value="否" name="s_isbaobei" />否 -->
		       		 <input type="radio" id="shis" value="是" name="s_isbaobei" checked="checked" />
					 <label for="shis">是</label>
			         <input type="radio" id="fous" value="否" name="s_isbaobei" />
			         <label for="fous">否</label>
				</td>
			</tr>
			<tr>
				<td>自动分量:</td>
				<td><input class="easyui-switchbutton" id="zdfl" data-options="onText:'开',offText:'关'" ></td>
				<td>手动分量:</td>
				<td><input class="easyui-combobox" name="u_id" panelHeight="auto" data-options="editable:false" style="width: 150px" id="u_idshoudong"  ></td>
			</tr>
			<tr>
				<td>备注:</td>
				<td>
					<input class="easyui-textbox" data-options="multiline:true,height:50,prompt:'备注...'" type="text" name="s_record"/>
				</td>
			</tr>
		</table>
	</form>
	<div style="text-align:center;padding:5px">
		<a href="javascript:void(0)" class="easyui-linkbutton" type="button" onclick="addStu()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="inClearStu()">取消</a>
	</div>
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

		<!-- 添加跟踪窗口 -->

<div id="genzongStu" class="easyui-dialog" style="width: 270px;height: 300px;" title="添加"    
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true">   
     <form id="genzong">
     </br>
     	<div>   
	        <label for="name">&ensp;回&ensp;访&ensp;时&ensp;间:</label>
	        <input class="easyui-datebox"  data-options="required:true,prompt:'必须选择回访时间',editable:false" required="required" type="text" name="n_followTime" id="n_followTime" />   
	    </div> 
	    <br/>
	    <div>   
	        <label for="name">&ensp;回&ensp;访&ensp;情&ensp;况:</label>
	        <input class="easyui-textbox" required="required" data-options="multiline:true,height:50,required:true,prompt:'必须选择回访情况'" type="text" name="n_contentgz" id="n_contentgz" />   
	    </div>
	    <br/>   
	    <div>   
	        <label for="email">&ensp;跟&ensp;踪&ensp;方&ensp;式:</label>
	        <input class="easyui-textbox" required="required" data-options="required:true,prompt:'必须填写跟踪方式'" type="text" name="n_followTypegz" id="n_followTypegz" />   
	    </div>
	    <br/>
	    <div>   
	        <label for="email">下次跟踪时间:</label>   
	        <input class="easyui-datebox" required="required" data-options="required:true,prompt:'必须选择下次跟踪时间',editable:false"  type="text" name="n_nextfollowTime" id="n_nextfollowTime" />   
	    </div>
	    <br/>
	    <div>   
	        <label for="email">&ensp;&ensp;备&ensp;&ensp;注&ensp;&ensp;&ensp;&ensp;:</label>
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
<script type="text/javascript">
/* 到处excel */
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
		var row=$("#dg").datagrid("getChecked");
		if(row.length == 0){
			$.messager.alert("系统信息","请选择数据");
			return;
		}
		var data = JSON.stringify(row);
		
			

		JSONToCSVConvertor(data, "数据信息", true);
	});

</script>
</html>