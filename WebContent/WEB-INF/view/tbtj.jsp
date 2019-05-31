<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/js/global.js"></script>
<!-- 引入 echarts.js -->
<script src="${pageContext.request.contextPath}/js/echarts.common.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>
<!--设置div不换行-->
   <style type="text/css">
       div{
           float:left;
       }
   </style>
   <script type="text/javascript">
   		//$("#chart")
   </script>
</head>
<body>
	
	<div id="chart" style="width: 1200px; height: 420px; margin: 0 auto; border: 1px solid gray;"></div>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/echartsFigure/barTest2.js"> </script>
</body>
</html>