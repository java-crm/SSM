package com.spz.entity;

public class Chatfunction {
	private Integer p_id;
	private String fszName;
	private String jszName;
	private String fsContext;
	private String fsTime;
	private String isyidu;
	
	public Integer getP_id() {
		return p_id;
	}
	public void setP_id(Integer p_id) {
		this.p_id = p_id;
	}
	public String getFszName() {
		return fszName;
	}
	public void setFszName(String fszName) {
		this.fszName = fszName;
	}
	public String getJszName() {
		return jszName;
	}
	public void setJszName(String jszName) {
		this.jszName = jszName;
	}
	public String getFsContext() {
		return fsContext;
	}
	public void setFsContext(String fsContext) {
		this.fsContext = fsContext;
	}
	public String getFsTime() {
		return fsTime;
	}
	public void setFsTime(String fsTime) {
		this.fsTime = fsTime;
	}
	public String getIsyidu() {
		return isyidu;
	}
	public void setIsyidu(String isyidu) {
		this.isyidu = isyidu;
	}
	@Override
	public String toString() {
		return "Chatfunction [p_id=" + p_id + ", fszName=" + fszName + ", jszName=" + jszName + ", fsContext="
				+ fsContext + ", fsTime=" + fsTime + ", isyidu=" + isyidu + "]";
	}
	
}
