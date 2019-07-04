package com.spz.service.impl;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.spz.dao.StudentMapper;
import com.spz.dao.UsersMapper;
import com.spz.entity.Fenye;
import com.spz.entity.Netfollows;
import com.spz.entity.Push;
import com.spz.entity.Student;
import com.spz.entity.Users;
import com.spz.service.StudentService;
import com.spz.util.InitDateTime;
@Service
public class StudentServiceImpl implements StudentService {

	@Autowired private StudentMapper studentMapper;

	@Autowired private UsersMapper usersMapper;
	
	@Override
	public List<Student> selectStudentByU_id(Integer u_id) {
		
		return studentMapper.selectStudentByU_id(u_id);
	}
	//岳治文
	@Override
	public String selectAll(Student student) {
		Fenye<Student> fy = new Fenye<Student>();
		student.setPage((student.getPage()-1)*student.getRows());
		
		fy.setRows(studentMapper.selectStudent(student));
		fy.setTotal(studentMapper.CountStudent(student));
		
		return new Gson().toJson(fy);
	}

	@Override
	public Integer insertStu(Student student,Integer fenliang){
		Integer tjstu=0;
		//未开启分量直接添加
		if(fenliang==0) {
			tjstu=studentMapper.insertStudent(student);
			if(student.getU_id()!=null) {
				usersMapper.updateUsersByu_pwdWrongTime(student.getU_id());
			}
			return tjstu;
		}else {
			//开启分量
			Class stuCla = (Class) student.getClass();//得到类对象
	        Field[] fs = stuCla.getDeclaredFields();//得到属性集合
	        int tota=0;
	        for(int i=0;i<fs.length;i++) {//循环得到对象中不为空的属性
	        	 fs[i].setAccessible(true);
	        	 Object val=null;
	        	 try {
					 val = fs[i].get(student);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        	 if(val!=null && !"".equals(val)) {//只要有1个属性不为空,那么就不是所有的属性值都为空
	                 tota++;
	             }
	        }
	        //对象中包含u_id所以减一是前台填写的数据的个数
	        System.out.println("对象所填写的值的个数："+tota);
	        //1、去数据库查询当前所有没有分配学生的咨询师（如果没有空闲咨询师就查询手里学生少的并且成交率高的咨询师）
	        //2、拿到咨询师id进行赋值
	        Integer u_id = null;
	        if(tota>6) {
	        	u_id=bubbleSortMax();
	        }else {
	        	u_id=bubbleSoreMin();
	        }
			student.setU_id(u_id);
			tjstu =studentMapper.insertStudent(student);
			if(tjstu>0) {
				System.out.println("添加了"+u_id);
				usersMapper.updateUsersByu_pwdWrongTime(u_id);
			}
			return tjstu;
		}
	}
	//普通学生则让它自动分配给手里数量较少的咨询师（如果手里数量一样则优先分给成交率底的）
	public Integer bubbleSoreMin() {
		System.out.println("-------------------调用自动分量分普通学生");
	 	Users users = new Users();
		users.setBeginCreateTime(InitDateTime.initDate());
		users.setEndCreateTime(InitDateTime.initTime());
		// 将当天的凌晨时间和保存当前的时间加入实体类
		System.out.println(users.getBeginCreateTime());
		System.out.println(users.getEndCreateTime());
		List<Users> fl = usersMapper.selectUsersByFenLiang(users);
		for (Users users2 : fl) {
			System.out.println("-----"+users2.toString());
		}
		if(fl.size()==0) {
			return null;
		}
		List<Users> listmxs = new ArrayList<Users>();//如果咨询师有的没有学生优先分配没有学生的咨询师
		
		List<Users> listyxs = new ArrayList<Users>();//手里有学生的咨询师存到集合中
		for (int i = 0; i < fl.size(); i++) {
			if (fl.get(i).getDcount() == 0) {
				listmxs.add(fl.get(i));
			}else {
				listyxs.add(fl.get(i));
			}
		}
		//对手里没有学生的咨询师自动分配
		if(listmxs.size()!=0) {
			Double bfb = listmxs.get(0).getBfb();
			Integer uid = listmxs.get(0).getU_id();
			for (int i = 0; i < listmxs.size(); i++) {
				if (listmxs.get(i).getBfb() < bfb) { // 从没有学生的咨询师中取成交率高的咨询师优先分配高质量的学生
					bfb = listmxs.get(i).getBfb();
					uid = listmxs.get(i).getU_id();
				}
			}
			return uid;
		}else{ /*对手里有学生的咨询师自动分配
				if(listyxs.size()!=0) */
			//循环得出今天这次分量前总共已经来了多少个学生
			Integer total=0;
			for(int i=0;i<listyxs.size();i++) {
				total += listyxs.get(i).getDcount();
			}
			Integer uid=0;
			if(total!=0) {
				double pingjun=(double) total/listyxs.size();
				for(int i=0;i<listyxs.size();i++) {
					if(listyxs.get(i).getDcount()<pingjun) {//自己今天被分配的学生低于平均数量
						uid=listyxs.get(i).getU_id();
					}
				}
				if(uid==0) {//进这里说明当前所有已打卡的咨询师被分配的数量和平均值一样大这时按照成交率去选则分给谁
					Double bfb = listyxs.get(0).getBfb();
					uid=listyxs.get(0).getU_id();
					for(int i=0;i<listyxs.size();i++) {
						if (listyxs.get(i).getBfb() < bfb) { 
							bfb = listyxs.get(i).getBfb();
							uid = listyxs.get(i).getU_id();
						}
					}
					return uid;
				}else {
					return uid;
				}
			}else {//到else中今天总共来了0个学生 则直接反回成交率最高的咨询师id不做别的判定（出现这种情况只能说明今天刚开始上班所有人都是0个学生对来的第一个学生做分配）
				Double bfb = listmxs.get(0).getBfb();
				uid=listmxs.get(0).getU_id();
				for(int i=0;i<fl.size();i++) {
					if (fl.get(i).getBfb() < bfb) { 
						bfb = fl.get(i).getBfb();
						uid = fl.get(i).getU_id();
					}
				}
				return uid;
			}
		}
	}
	//分配成交率高学生给成交率高的咨询师
	public Integer bubbleSortMax() {
		System.out.println("====================调用自动分量给给成交率最高的");
	 	Users users = new Users();
		users.setBeginCreateTime(InitDateTime.initDate());
		users.setEndCreateTime(InitDateTime.initTime());
		// 将当天的凌晨时间和保存当前的时间加入实体类
		System.out.println(users.getBeginCreateTime());
		System.out.println(users.getEndCreateTime());
		List<Users> fl = usersMapper.selectUsersByFenLiang(users);
		for (Users users2 : fl) {
			System.out.println("-----"+users2.toString());
		}
		if(fl.size()==0) {
			return null;
		}
		List<Users> listmxs = new ArrayList<Users>();//如果咨询师有的没有学生优先分配没有学生的咨询师
		
		List<Users> listyxs = new ArrayList<Users>();//手里有学生的咨询师存到集合中
		for (int i = 0; i < fl.size(); i++) {
			if (fl.get(i).getDcount() == 0) {
				listmxs.add(fl.get(i));
			}else {
				listyxs.add(fl.get(i));
			}
		}
		//对手里没有学生的咨询师自动分配
		if(listmxs.size()!=0) {
			Double bfb = listmxs.get(0).getBfb();
			Integer uid = listmxs.get(0).getU_id();
			for (int i = 0; i < listmxs.size(); i++) {
				if (listmxs.get(i).getBfb() > bfb) { // 从没有学生的咨询师中取成交率高的咨询师优先分配高质量的学生
					bfb = listmxs.get(i).getBfb();
					uid = listmxs.get(i).getU_id();
					System.out.println("手里没有学生并且成交率为最高的咨询师："+uid);
				}
			}
			System.out.println("手里没有学生的咨询师并且成交率最高的or是也有可能是所有成交率都为0.0这样则取第一个就行了："+uid);
			return uid;
		}else{ /*对手里有学生的咨询师自动分配
				if(listyxs.size()!=0) */
			//循环得出今天这次分量前总共已经来了多少个学生
			Integer total=0;
			for(int i=0;i<listyxs.size();i++) {
				total += listyxs.get(i).getDcount();
			}
			System.out.println("今天总共来了："+total+" 个学生");
			Integer uid=0;
			if(total!=0) {
				double pingjun=(double) total/listyxs.size();
				for(int i=0;i<listyxs.size();i++) {
					if(listyxs.get(i).getDcount()<pingjun) {//自己今天被分配的学生低于平均数量
						uid=listyxs.get(i).getU_id();
					}
				}
				if(uid==0) {//进这里说明当前所有已打卡的咨询师被分配的数量和平均值一样大这时按照成交率去选则分给谁
					Double bfb = listyxs.get(0).getBfb();
					uid=listyxs.get(0).getU_id();
					for(int i=0;i<listyxs.size();i++) {
						if (listyxs.get(i).getBfb() > bfb) { 
							bfb = listyxs.get(i).getBfb();
							uid = listyxs.get(i).getU_id();
						}
					}
					return uid;
				}else {
					return uid;
				}
			}else {//到else中今天总共来了0个学生 则直接反回成交率最高的咨询师id不做别的判定（出现这种情况只能说明今天刚开始上班所有人都是0个学生对来的第一个学生做分配）
				Double bfb = listmxs.get(0).getBfb();
				uid=listmxs.get(0).getU_id();
				for(int i=0;i<fl.size();i++) {
					if (fl.get(i).getBfb() > bfb) { 
						bfb = fl.get(i).getBfb();
						uid = fl.get(i).getU_id();
					}
				}
				return uid;
			}
		}
	}
	
	//周炎
	@Override
	public  String selectStu(Student stu) {
		Fenye<Student> fy = new Fenye<Student>();
		stu.setPage((stu.getPage()-1)*stu.getRows());
		fy.setRows(studentMapper.selectStu(stu));
		fy.setTotal(studentMapper.selectStucount(stu));
		
		return new Gson().toJson(fy);
	}

	@Override
	public Integer updateStu(Student stu) {
		return studentMapper.updateStu(stu);
	}
	
	@Override
	public Integer insertStugz(Netfollows net) {
		return studentMapper.insertStugz(net);
	}

	
	//孙所蕾
	@Override
	public String selectStuAll(Student student) {
		Fenye<Student> fenye=new Fenye<Student>();
		 
		student.setPage((student.getPage()-1)*student.getRows());
	 
		fenye.setRows(studentMapper.selectStuAll(student));
		fenye.setTotal(studentMapper.selectStuCount(student));
		return new Gson().toJson(fenye);
	}

	@Override
	public Integer deleteStu(Student student) {
		return studentMapper.deleteStu(student);
	}

	@Override
	public Integer updateStus(Student student) {
		return studentMapper.updateStu(student);
	}

	@Override
	public Integer insertStus(Student student) {
		return studentMapper.insertStus(student);
	}

	@Override
	public Student selectStuByid(Integer s_id) {
		return studentMapper.selectStuByid(s_id);
	}
	@Override
	public String selectUsersByZixunShi() {
		return new Gson().toJson(studentMapper.selectUsersByZixunShi());
	}
	@Override
	public String selectUsersByZXS() {
		return new Gson().toJson(studentMapper.selectUsersByZXS());
	}
	@Override
	public List<Users> selectStudentUserName(String s_createUser) {
		return studentMapper.selectStudentUserName(s_createUser);
	}
	@Override
	public Integer addPush(Push push) {
		Integer addPush = studentMapper.addPush(push);
		return addPush;
	}
	@Override
	public String selectStudentWeriFenliang(Student student) {
		Fenye<Student> fy=new Fenye<Student>();
		student.setPage((student.getPage()-1)*student.getRows());
		fy.setTotal(studentMapper.selectStudentWeriFenliangCount(student));
		fy.setRows(studentMapper.selectStudentWeriFenliang(student));
		return new Gson().toJson(fy);
	}
	
	@Override
	public Integer insertjingliFenPei(String u_id) {
		String[] split = u_id.split(",");
		Integer Retu=null;
		for(int i=0;i<split.length;i++) {
			Student stuByid = studentMapper.selectStuByid(Integer.parseInt(split[i]));
			int tota = selectStudentCount(stuByid);
	        Integer id = null;
	        if(tota>6) {
	        	id=bubbleSortMax();
	        }else {
	        	id=bubbleSoreMin();
	        }
	        stuByid.setU_id(id);
			usersMapper.updateUsersByu_pwdWrongTime(id);
	        Retu=studentMapper.updateStus(stuByid);
		}
		return Retu;
	}
	public int selectStudentCount(Student student) {
		Class stuCla = (Class) student.getClass();//得到类对象
        Field[] fs = stuCla.getDeclaredFields();//得到属性集合
        int tota=0;
        for(int j=0;j<fs.length;j++) {//循环得到对象中不为空的属性
        	 fs[j].setAccessible(true);
        	 Object val=null;
        	 try {
				 val = fs[j].get(student);
			} catch (Exception e) {
				e.printStackTrace();
			}
        	 if(val!=null && !"".equals(val)) {//只要有1个属性不为空,那么就不是所有的属性值都为空
                 tota++;
             }
        }
		return tota;
	}
	@Override
	public Integer updatePushIsreader(Integer id) {
		return studentMapper.updatePushIsreader(id);
	}
	@Override
	public Integer selectMaxId() {
		return studentMapper.selectMaxId();
	}
	@Override
	public String selectStudentIsdelAll(Student student) {
		Fenye<Student> fy=new Fenye<Student>();
		student.setPage((student.getPage()-1)*student.getRows());
		fy.setRows(studentMapper.selectStudentIsdel(student));
		fy.setTotal(studentMapper.selectStudentIsdelCount(student));
		return new Gson().toJson(fy);
	}
	@Override
	public Integer deleteStudenthsz() {
		return studentMapper.deleteStudenthsz();
	}
	@Override
	public Integer deleteByIdStuhsz(Integer s_id) {
		return studentMapper.deleteByIdStuhsz(s_id);
	}
	@Override
	public Integer updateStudenthsz(Integer s_id) {
		return studentMapper.updateStudenthsz(s_id);
	}
	@Override
	public Integer shoudongFenLiang(Student student) {
		Integer liang = studentMapper.shoudongFenLiang(student);
		if(liang>0) {
			usersMapper.updateUsersByu_pwdWrongTime(student.getU_id());
		}
		return liang;
	}
}
