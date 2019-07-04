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
	//������
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
		//δ��������ֱ�����
		if(fenliang==0) {
			tjstu=studentMapper.insertStudent(student);
			if(student.getU_id()!=null) {
				usersMapper.updateUsersByu_pwdWrongTime(student.getU_id());
			}
			return tjstu;
		}else {
			//��������
			Class stuCla = (Class) student.getClass();//�õ������
	        Field[] fs = stuCla.getDeclaredFields();//�õ����Լ���
	        int tota=0;
	        for(int i=0;i<fs.length;i++) {//ѭ���õ������в�Ϊ�յ�����
	        	 fs[i].setAccessible(true);
	        	 Object val=null;
	        	 try {
					 val = fs[i].get(student);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        	 if(val!=null && !"".equals(val)) {//ֻҪ��1�����Բ�Ϊ��,��ô�Ͳ������е�����ֵ��Ϊ��
	                 tota++;
	             }
	        }
	        //�����а���u_id���Լ�һ��ǰ̨��д�����ݵĸ���
	        System.out.println("��������д��ֵ�ĸ�����"+tota);
	        //1��ȥ���ݿ��ѯ��ǰ����û�з���ѧ������ѯʦ�����û�п�����ѯʦ�Ͳ�ѯ����ѧ���ٵĲ��ҳɽ��ʸߵ���ѯʦ��
	        //2���õ���ѯʦid���и�ֵ
	        Integer u_id = null;
	        if(tota>6) {
	        	u_id=bubbleSortMax();
	        }else {
	        	u_id=bubbleSoreMin();
	        }
			student.setU_id(u_id);
			tjstu =studentMapper.insertStudent(student);
			if(tjstu>0) {
				System.out.println("�����"+u_id);
				usersMapper.updateUsersByu_pwdWrongTime(u_id);
			}
			return tjstu;
		}
	}
	//��ͨѧ���������Զ�����������������ٵ���ѯʦ�������������һ�������ȷָ��ɽ��ʵ׵ģ�
	public Integer bubbleSoreMin() {
		System.out.println("-------------------�����Զ���������ͨѧ��");
	 	Users users = new Users();
		users.setBeginCreateTime(InitDateTime.initDate());
		users.setEndCreateTime(InitDateTime.initTime());
		// ��������賿ʱ��ͱ��浱ǰ��ʱ�����ʵ����
		System.out.println(users.getBeginCreateTime());
		System.out.println(users.getEndCreateTime());
		List<Users> fl = usersMapper.selectUsersByFenLiang(users);
		for (Users users2 : fl) {
			System.out.println("-----"+users2.toString());
		}
		if(fl.size()==0) {
			return null;
		}
		List<Users> listmxs = new ArrayList<Users>();//�����ѯʦ�е�û��ѧ�����ȷ���û��ѧ������ѯʦ
		
		List<Users> listyxs = new ArrayList<Users>();//������ѧ������ѯʦ�浽������
		for (int i = 0; i < fl.size(); i++) {
			if (fl.get(i).getDcount() == 0) {
				listmxs.add(fl.get(i));
			}else {
				listyxs.add(fl.get(i));
			}
		}
		//������û��ѧ������ѯʦ�Զ�����
		if(listmxs.size()!=0) {
			Double bfb = listmxs.get(0).getBfb();
			Integer uid = listmxs.get(0).getU_id();
			for (int i = 0; i < listmxs.size(); i++) {
				if (listmxs.get(i).getBfb() < bfb) { // ��û��ѧ������ѯʦ��ȡ�ɽ��ʸߵ���ѯʦ���ȷ����������ѧ��
					bfb = listmxs.get(i).getBfb();
					uid = listmxs.get(i).getU_id();
				}
			}
			return uid;
		}else{ /*��������ѧ������ѯʦ�Զ�����
				if(listyxs.size()!=0) */
			//ѭ���ó�������η���ǰ�ܹ��Ѿ����˶��ٸ�ѧ��
			Integer total=0;
			for(int i=0;i<listyxs.size();i++) {
				total += listyxs.get(i).getDcount();
			}
			Integer uid=0;
			if(total!=0) {
				double pingjun=(double) total/listyxs.size();
				for(int i=0;i<listyxs.size();i++) {
					if(listyxs.get(i).getDcount()<pingjun) {//�Լ����챻�����ѧ������ƽ������
						uid=listyxs.get(i).getU_id();
					}
				}
				if(uid==0) {//������˵����ǰ�����Ѵ򿨵���ѯʦ�������������ƽ��ֵһ������ʱ���ճɽ���ȥѡ��ָ�˭
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
			}else {//��else�н����ܹ�����0��ѧ�� ��ֱ�ӷ��سɽ�����ߵ���ѯʦid��������ж��������������ֻ��˵������տ�ʼ�ϰ������˶���0��ѧ�������ĵ�һ��ѧ�������䣩
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
	//����ɽ��ʸ�ѧ�����ɽ��ʸߵ���ѯʦ
	public Integer bubbleSortMax() {
		System.out.println("====================�����Զ����������ɽ�����ߵ�");
	 	Users users = new Users();
		users.setBeginCreateTime(InitDateTime.initDate());
		users.setEndCreateTime(InitDateTime.initTime());
		// ��������賿ʱ��ͱ��浱ǰ��ʱ�����ʵ����
		System.out.println(users.getBeginCreateTime());
		System.out.println(users.getEndCreateTime());
		List<Users> fl = usersMapper.selectUsersByFenLiang(users);
		for (Users users2 : fl) {
			System.out.println("-----"+users2.toString());
		}
		if(fl.size()==0) {
			return null;
		}
		List<Users> listmxs = new ArrayList<Users>();//�����ѯʦ�е�û��ѧ�����ȷ���û��ѧ������ѯʦ
		
		List<Users> listyxs = new ArrayList<Users>();//������ѧ������ѯʦ�浽������
		for (int i = 0; i < fl.size(); i++) {
			if (fl.get(i).getDcount() == 0) {
				listmxs.add(fl.get(i));
			}else {
				listyxs.add(fl.get(i));
			}
		}
		//������û��ѧ������ѯʦ�Զ�����
		if(listmxs.size()!=0) {
			Double bfb = listmxs.get(0).getBfb();
			Integer uid = listmxs.get(0).getU_id();
			for (int i = 0; i < listmxs.size(); i++) {
				if (listmxs.get(i).getBfb() > bfb) { // ��û��ѧ������ѯʦ��ȡ�ɽ��ʸߵ���ѯʦ���ȷ����������ѧ��
					bfb = listmxs.get(i).getBfb();
					uid = listmxs.get(i).getU_id();
					System.out.println("����û��ѧ�����ҳɽ���Ϊ��ߵ���ѯʦ��"+uid);
				}
			}
			System.out.println("����û��ѧ������ѯʦ���ҳɽ�����ߵ�or��Ҳ�п��������гɽ��ʶ�Ϊ0.0������ȡ��һ�������ˣ�"+uid);
			return uid;
		}else{ /*��������ѧ������ѯʦ�Զ�����
				if(listyxs.size()!=0) */
			//ѭ���ó�������η���ǰ�ܹ��Ѿ����˶��ٸ�ѧ��
			Integer total=0;
			for(int i=0;i<listyxs.size();i++) {
				total += listyxs.get(i).getDcount();
			}
			System.out.println("�����ܹ����ˣ�"+total+" ��ѧ��");
			Integer uid=0;
			if(total!=0) {
				double pingjun=(double) total/listyxs.size();
				for(int i=0;i<listyxs.size();i++) {
					if(listyxs.get(i).getDcount()<pingjun) {//�Լ����챻�����ѧ������ƽ������
						uid=listyxs.get(i).getU_id();
					}
				}
				if(uid==0) {//������˵����ǰ�����Ѵ򿨵���ѯʦ�������������ƽ��ֵһ������ʱ���ճɽ���ȥѡ��ָ�˭
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
			}else {//��else�н����ܹ�����0��ѧ�� ��ֱ�ӷ��سɽ�����ߵ���ѯʦid��������ж��������������ֻ��˵������տ�ʼ�ϰ������˶���0��ѧ�������ĵ�һ��ѧ�������䣩
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
	
	//����
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

	
	//������
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
		Class stuCla = (Class) student.getClass();//�õ������
        Field[] fs = stuCla.getDeclaredFields();//�õ����Լ���
        int tota=0;
        for(int j=0;j<fs.length;j++) {//ѭ���õ������в�Ϊ�յ�����
        	 fs[j].setAccessible(true);
        	 Object val=null;
        	 try {
				 val = fs[j].get(student);
			} catch (Exception e) {
				e.printStackTrace();
			}
        	 if(val!=null && !"".equals(val)) {//ֻҪ��1�����Բ�Ϊ��,��ô�Ͳ������е�����ֵ��Ϊ��
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
