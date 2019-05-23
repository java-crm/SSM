package com.spz.entity;

public class Netfollows {
	private Integer n_id;
	private Integer s_id;
	private String s_name;
	private String n_followTime;
	private String n_nextfollowTime;
	private String n_content;
	private String u_id;
	private String n_followType;
	private String n_createTime;
	private String n_followState;
	private Integer page;
	private Integer rows;
	
	private String mincreateTime;
	private String maxcreateTime;
	
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getRows() {
		return rows;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	public Integer getN_id() {
		return n_id;
	}
	public void setN_id(Integer n_id) {
		this.n_id = n_id;
	}
	public Integer getS_id() {
		return s_id;
	}
	public void setS_id(Integer s_id) {
		this.s_id = s_id;
	}
	
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	public String getN_followTime() {
		return n_followTime;
	}
	public void setN_followTime(String n_followTime) {
		this.n_followTime = n_followTime;
	}
	public String getN_nextfollowTime() {
		return n_nextfollowTime;
	}
	public void setN_nextfollowTime(String n_nextfollowTime) {
		this.n_nextfollowTime = n_nextfollowTime;
	}
	public String getN_content() {
		return n_content;
	}
	public void setN_content(String n_content) {
		this.n_content = n_content;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getN_followType() {
		return n_followType;
	}
	public void setN_followType(String n_followType) {
		this.n_followType = n_followType;
	}
	public String getN_createTime() {
		return n_createTime;
	}
	public void setN_createTime(String n_createTime) {
		this.n_createTime = n_createTime;
	}
	public String getN_followState() {
		return n_followState;
	}
	public void setN_followState(String n_followState) {
		this.n_followState = n_followState;
	}
	
	public Netfollows() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getMincreateTime() {
		return mincreateTime;
	}
	public void setMincreateTime(String mincreateTime) {
		this.mincreateTime = mincreateTime;
	}
	public String getMaxcreateTime() {
		return maxcreateTime;
	}
	public void setMaxcreateTime(String maxcreateTime) {
		this.maxcreateTime = maxcreateTime;
	}
	
	
	
}
