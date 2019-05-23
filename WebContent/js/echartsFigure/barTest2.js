// 基于准备好的dom，初始化echarts实例
var myChart = echarts.init(document.getElementById('chart'));

var categories = [];
var values = [];

// 同步执行
$.ajaxSettings.async = false;

// 加载数据

$.getJSON('EchartsServlet', function (json) {
	categories = json.categories2;
	values = json.values2;
});



// 指定图表的配置项和数据
var option = {
	title : {
		text : '业绩分析',
	},
	tooltip : {
		trigger : 'axis'
	},
	legend : {
		data : ['今日分配']
	},
	toolbox : {
		show : true,
		feature : {
			mark : {
				show : true
			},
			dataView : {
				show : true,
				readOnly : false
			},
			magicType : {
				show : true,
				type : ['line', 'bar']
			},
			restore : {
				show : true
			},
			saveAsImage : {
				show : true
			}
		}
	},
	calculable : true,
	xAxis : [ {
		type : 'category',
		data : categories
	} ],
	yAxis : [ {
		type : 'value',
		axisLabel : {
			formatter : '{value} 个'
		}
	} ],
	series : [ {
		name : '今日分配',
		type : 'bar',
		itemStyle : {
			normal : {
				color : '#2EC7C9',
				barBorderRadius : 10,
			}
		},
		data : values,
		markPoint : {
			data : [ {
				type : 'max',
				name : '最大值'
			}, {
				type : 'min',
				name : '最小值'
			} ],
			itemStyle : {
				normal : {
					label : {
						show : true,
						textStyle : {
							color : '#090909'
						}
					}
				}
			},
		}
	}
	]
};
                    
                                 
// 使用刚指定的配置项和数据显示图表。
myChart.setOption(option);