package com.spz.entity;

public class Push {
	private Integer id;
	private Integer studentid; //学生id
	private String studentname;//推送人的名字（谁，把谁推送给谁）
	private String context;//发生内容
	private String zxname;//接收者
	private Integer isreader;//状态（已读/未读）
	private String tstime;//发送的时间
	private Student student;
	
	public Student getStudent() {
		return student;
	}
	public void setStudent(Student student) {
		this.student = student;
	}
	private Integer page;
	private Integer rows;
	
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
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getStudentid() {
		return studentid;
	}
	public void setStudentid(Integer studentid) {
		this.studentid = studentid;
	}
	public String getStudentname() {
		return studentname;
	}
	public void setStudentname(String studentname) {
		this.studentname = studentname;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	
	public String getZxname() {
		return zxname;
	}
	public void setZxname(String zxname) {
		this.zxname = zxname;
	}
	
	public Integer getIsreader() {
		return isreader;
	}
	public void setIsreader(Integer isreader) {
		this.isreader = isreader;
	}
	public String getTstime() {
		return tstime;
	}
	public void setTstime(String tstime) {
		this.tstime = tstime;
	}
	@Override
	public String toString() {
		return "Push [id=" + id + ", studentid=" + studentid + ", studentname=" + studentname + ", context=" + context
				+ ", zxname=" + zxname + ", isreader=" + isreader + ", tstime=" + tstime + ", student=" + student
				+ ", page=" + page + ", rows=" + rows + "]";
	}
	
	
}
