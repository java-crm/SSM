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
		//未开启分量直接添加
		if(fenliang==0) {
			return studentMapper.insertStudent(student);
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
			return studentMapper.insertStudent(student);
		}
	}
	//普通学生则让它自动分配给手里数量较少的咨询师（如果手里数量一样则优先分给成交率底的）
	public Integer bubbleSoreMin() {
		Users users = new Users();
		users.setBeginCreateTime(InitDateTime.initDate());
		users.setEndCreateTime(InitDateTime.initTime());
		List<Users> fl = usersMapper.selectUsersByFenLiang(users);
		
		if(fl.size()==0) {
			return null;
		}
		
		Integer uid =null;
		 
		int total = 0;
		Double bfb = fl.get(0).getBfb();
		uid = fl.get(0).getU_id();
		List<Users> list = new ArrayList<Users>();//将查询的数据存到集合中
		for (int i = 0; i < fl.size(); i++) {
			total += fl.get(i).getDcount();// 得到今天的总来源学生数量
			if (fl.get(i).getDcount() == 0) {// 如果咨询师有的没有学生优先分配没有学生的咨询师
				list.add(fl.get(i));
			}
		}
		System.out.println("今日总共来了："+total);
		System.out.println("有几个等于0的咨询师："+list.size());
		// 今天有咨询师没有被分配学生
		List<Users> myfl = new ArrayList<Users>();
		if (list.size() != 0) {
			bfb=list.get(0).getBfb();//修改为list.get(0).getBfb()
			for (int i = 0; i < list.size(); i++) {
				try {
					if (list.get(i).getBfb() <= bfb) { // 从没有学生的咨询师中取成交率底的咨询师优先分配一般的学生
						bfb = list.get(i).getBfb();
						uid = list.get(i).getU_id();
					}
				} catch (Exception e) {
					System.out.println("底，可能所有未被分配的咨询师成功率都为0");
				}
				System.out.println(fl.get(i).getU_id());
			}
			System.out.println("目前没有学生的，成交率最底的咨询师" + uid);
		}
		
		
		List<Users> zdfl = new ArrayList<Users>();
		if (list.size() == 0) {
			for (int i = 0; i < fl.size(); i++) {// 如果都拥有学生就按照今日所分配的学生数量低于总数量的平个数中找到成功率最高的咨询师
				try {
					if (fl.get(i).getDcount() < (total / fl.size() )) {
						zdfl.add(fl.get(i));//今日录入的数量低于平均数量的添加到集合中
					}
				} catch (Exception e) {
					System.out.println("异常可能找不到今日所分配的学生数量低于总数量的平个数中找到成功率最底的咨询师");
				}
			}
			System.out.println("都有学生平均：" + total / fl.size() + "个，成交率最底的咨询师id:" + uid);
			System.out.println("咨询师低于平均个数的有几个："+zdfl.size());
		  }
		
		if(zdfl.size()!=0) {
			bfb=zdfl.get(0).getBfb();
			for(int i=0;i<zdfl.size();i++) {
				if(zdfl.get(i).getBfb()<=bfb) {
					bfb = zdfl.get(i).getBfb();
					uid = zdfl.get(i).getU_id();
				}
			}
		}else {//如果所有咨询师下的学生数量都一样则取成交率最高的优先录入优质客户
			bfb = fl.get(0).getBfb();
			uid = fl.get(0).getU_id();
			for(int i=0;i<fl.size();i++) {
				if(fl.get(i).getBfb()<=bfb) {
					bfb = fl.get(i).getBfb();
					uid = fl.get(i).getU_id();
				}
			}
		}
		System.out.println("最终录入咨询师id:"+uid);
		
		return uid;
	}
	//分配成交率高学生给成交率高的咨询师
	public Integer bubbleSortMax() {
	 	Users users = new Users();
		users.setBeginCreateTime(InitDateTime.initDate());
		users.setEndCreateTime(InitDateTime.initTime());
		// 将当天的凌晨时间和保存当前的时间加入实体类
		System.out.println(users.getBeginCreateTime());
		System.out.println(users.getEndCreateTime());
		List<Users> fl = usersMapper.selectUsersByFenLiang(users);
			if(fl.size()==0) {
				return null;
			}
			Integer uid =null;
		 
			int total = 0;
			
			Double bfb = fl.get(0).getBfb();
			
			uid = fl.get(0).getU_id();
			
			List<Users> list = new ArrayList<Users>();//将查询的数据存到集合中
			
			for (int i = 0; i < fl.size(); i++) {
				total += fl.get(i).getDcount();// 得到今天的总来源学生数量
				if (fl.get(i).getDcount() == 0) {// 如果咨询师有的没有学生优先分配没有学生的咨询师
					list.add(fl.get(i));
				}
			}
			System.out.println("今日总共来了："+total);
			System.out.println("有几个等于0的咨询师："+list.size());
			// 今天有咨询师没有被分配学生
			List<Users> myfl = new ArrayList<Users>();
			if (list.size() != 0) {
				bfb=list.get(0).getBfb();//修改为list.get(0).getBfb()
				for (int i = 0; i < list.size(); i++) {
					try {
						if (list.get(i).getBfb() >= bfb) { // 从没有学生的咨询师中取成交率高的咨询师优先分配高质量的学生
							bfb = list.get(i).getBfb();
							uid = list.get(i).getU_id();
						}
					} catch (Exception e) {
						System.out.println("可能所有未被分配的咨询师成功率都为0");
					}
					System.out.println(fl.get(i).getU_id());
				}
				System.out.println("目前没有学生的，成交率最高的咨询师" + uid);
			}
			
			List<Users> zdfl = new ArrayList<Users>();
			if (list.size() == 0) {
				for (int i = 0; i < fl.size(); i++) {// 如果都拥有学生就按照今日所分配的学生数量低于总数量的平个数中找到成功率最高的咨询师
					try {
						if (fl.get(i).getDcount() < (total / fl.size() )) {
							zdfl.add(fl.get(i));//今日录入的数量低于平均数量的添加到集合中
						}
					} catch (Exception e) {
						System.out.println("异常可能找不到今日所分配的学生数量低于总数量的平个数中找到成功率最高的咨询师");
					}
				}
				System.out.println("都有学生平均：" + total / fl.size() + "个，成交率最高的咨询师id:" + uid);
				System.out.println("咨询师低于平均个数的有几个："+zdfl.size());
			  }
			
			if(zdfl.size()!=0) {
				bfb=zdfl.get(0).getBfb();
				for(int i=0;i<zdfl.size();i++) {
					if(zdfl.get(i).getBfb()>=bfb) {
						bfb = zdfl.get(i).getBfb();
						uid = zdfl.get(i).getU_id();
					}
				}
			}else {//如果所有咨询师下的学生数量都一样则取成交率最高的优先录入优质客户
				bfb = fl.get(0).getBfb();
				uid = fl.get(0).getU_id();
				for(int i=0;i<fl.size();i++) {
					if(fl.get(i).getBfb()>=bfb) {
						bfb = fl.get(i).getBfb();
						uid = fl.get(i).getU_id();
					}
				}
			}
			System.out.println("最终录入咨询师id:"+uid);
		return uid;
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
		// TODO Auto-generated method stub
		return new Gson().toJson(studentMapper.selectUsersByZXS());
	}
	@Override
	public List<Users> selectStudentUserName(Integer s_createUser) {
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
	
}
