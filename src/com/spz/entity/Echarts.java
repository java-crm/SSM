package com.spz.entity;

public class Echarts {
	
	private String click_date;//查询的日期时间
	
	private Integer count;//查询的数据值
	
	public String getClick_date() {
		return click_date;
	}
	public void setClick_date(String click_date) {
		this.click_date = click_date;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	@Override
	public String toString() {
		return "Echarts [click_date=" + click_date + ", count=" + count + "]";
	}
	
	
}
