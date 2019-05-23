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
		//δ��������ֱ�����
		if(fenliang==0) {
			return studentMapper.insertStudent(student);
		}else {
			//��������
			Class stuCla = (Class) student.getClass();// �õ������
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
			return studentMapper.insertStudent(student);
		}
	}
	//��ͨѧ���������Զ�����������������ٵ���ѯʦ�������������һ�������ȷָ��ɽ��ʵ׵ģ�
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
		List<Users> list = new ArrayList<Users>();//����ѯ�����ݴ浽������
		for (int i = 0; i < fl.size(); i++) {
			total += fl.get(i).getDcount();// �õ����������Դѧ������
			if (fl.get(i).getDcount() == 0) {// �����ѯʦ�е�û��ѧ�����ȷ���û��ѧ������ѯʦ
				list.add(fl.get(i));
			}
		}
		System.out.println("�����ܹ����ˣ�"+total);
		System.out.println("�м�������0����ѯʦ��"+list.size());
		// ��������ѯʦû�б�����ѧ��
		List<Users> myfl = new ArrayList<Users>();
		if (list.size() != 0) {
			bfb=list.get(0).getBfb();//�޸�Ϊlist.get(0).getBfb()
			for (int i = 0; i < list.size(); i++) {
				try {
					if (list.get(i).getBfb() <= bfb) { // ��û��ѧ������ѯʦ��ȡ�ɽ��ʵ׵���ѯʦ���ȷ���һ���ѧ��
						bfb = list.get(i).getBfb();
						uid = list.get(i).getU_id();
					}
				} catch (Exception e) {
					System.out.println("�ף���������δ���������ѯʦ�ɹ��ʶ�Ϊ0");
				}
				System.out.println(fl.get(i).getU_id());
			}
			System.out.println("Ŀǰû��ѧ���ģ��ɽ�����׵���ѯʦ" + uid);
		}
		
		
		List<Users> zdfl = new ArrayList<Users>();
		if (list.size() == 0) {
			for (int i = 0; i < fl.size(); i++) {// �����ӵ��ѧ���Ͱ��ս����������ѧ������������������ƽ�������ҵ��ɹ�����ߵ���ѯʦ
				try {
					if (fl.get(i).getDcount() < (total / fl.size() )) {
						zdfl.add(fl.get(i));//����¼�����������ƽ����������ӵ�������
					}
				} catch (Exception e) {
					System.out.println("�쳣�����Ҳ��������������ѧ������������������ƽ�������ҵ��ɹ�����׵���ѯʦ");
				}
			}
			System.out.println("����ѧ��ƽ����" + total / fl.size() + "�����ɽ�����׵���ѯʦid:" + uid);
			System.out.println("��ѯʦ����ƽ���������м�����"+zdfl.size());
		  }
		
		if(zdfl.size()!=0) {
			bfb=zdfl.get(0).getBfb();
			for(int i=0;i<zdfl.size();i++) {
				if(zdfl.get(i).getBfb()<=bfb) {
					bfb = zdfl.get(i).getBfb();
					uid = zdfl.get(i).getU_id();
				}
			}
		}else {//���������ѯʦ�µ�ѧ��������һ����ȡ�ɽ�����ߵ�����¼�����ʿͻ�
			bfb = fl.get(0).getBfb();
			uid = fl.get(0).getU_id();
			for(int i=0;i<fl.size();i++) {
				if(fl.get(i).getBfb()<=bfb) {
					bfb = fl.get(i).getBfb();
					uid = fl.get(i).getU_id();
				}
			}
		}
		System.out.println("����¼����ѯʦid:"+uid);
		
		return uid;
	}
	//����ɽ��ʸ�ѧ�����ɽ��ʸߵ���ѯʦ
	public Integer bubbleSortMax() {
	 	Users users = new Users();
		users.setBeginCreateTime(InitDateTime.initDate());
		users.setEndCreateTime(InitDateTime.initTime());
		// ��������賿ʱ��ͱ��浱ǰ��ʱ�����ʵ����
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
			
			List<Users> list = new ArrayList<Users>();//����ѯ�����ݴ浽������
			
			for (int i = 0; i < fl.size(); i++) {
				total += fl.get(i).getDcount();// �õ����������Դѧ������
				if (fl.get(i).getDcount() == 0) {// �����ѯʦ�е�û��ѧ�����ȷ���û��ѧ������ѯʦ
					list.add(fl.get(i));
				}
			}
			System.out.println("�����ܹ����ˣ�"+total);
			System.out.println("�м�������0����ѯʦ��"+list.size());
			// ��������ѯʦû�б�����ѧ��
			List<Users> myfl = new ArrayList<Users>();
			if (list.size() != 0) {
				bfb=list.get(0).getBfb();//�޸�Ϊlist.get(0).getBfb()
				for (int i = 0; i < list.size(); i++) {
					try {
						if (list.get(i).getBfb() >= bfb) { // ��û��ѧ������ѯʦ��ȡ�ɽ��ʸߵ���ѯʦ���ȷ����������ѧ��
							bfb = list.get(i).getBfb();
							uid = list.get(i).getU_id();
						}
					} catch (Exception e) {
						System.out.println("��������δ���������ѯʦ�ɹ��ʶ�Ϊ0");
					}
					System.out.println(fl.get(i).getU_id());
				}
				System.out.println("Ŀǰû��ѧ���ģ��ɽ�����ߵ���ѯʦ" + uid);
			}
			
			List<Users> zdfl = new ArrayList<Users>();
			if (list.size() == 0) {
				for (int i = 0; i < fl.size(); i++) {// �����ӵ��ѧ���Ͱ��ս����������ѧ������������������ƽ�������ҵ��ɹ�����ߵ���ѯʦ
					try {
						if (fl.get(i).getDcount() < (total / fl.size() )) {
							zdfl.add(fl.get(i));//����¼�����������ƽ����������ӵ�������
						}
					} catch (Exception e) {
						System.out.println("�쳣�����Ҳ��������������ѧ������������������ƽ�������ҵ��ɹ�����ߵ���ѯʦ");
					}
				}
				System.out.println("����ѧ��ƽ����" + total / fl.size() + "�����ɽ�����ߵ���ѯʦid:" + uid);
				System.out.println("��ѯʦ����ƽ���������м�����"+zdfl.size());
			  }
			
			if(zdfl.size()!=0) {
				bfb=zdfl.get(0).getBfb();
				for(int i=0;i<zdfl.size();i++) {
					if(zdfl.get(i).getBfb()>=bfb) {
						bfb = zdfl.get(i).getBfb();
						uid = zdfl.get(i).getU_id();
					}
				}
			}else {//���������ѯʦ�µ�ѧ��������һ����ȡ�ɽ�����ߵ�����¼�����ʿͻ�
				bfb = fl.get(0).getBfb();
				uid = fl.get(0).getU_id();
				for(int i=0;i<fl.size();i++) {
					if(fl.get(i).getBfb()>=bfb) {
						bfb = fl.get(i).getBfb();
						uid = fl.get(i).getU_id();
					}
				}
			}
			System.out.println("����¼����ѯʦid:"+uid);
		return uid;
	}
	
	//����
	@Override
	public  String selectStu(Student stu) {
		// TODO Auto-generated method stub
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
		// TODO Auto-generated method stub
		return studentMapper.insertStugz(net);
	}

	
	//������
	@Override
	public String selectStuAll(Student student) {
		// TODO Auto-generated method stub
		Fenye<Student> fenye=new Fenye<Student>();
		 
		student.setPage((student.getPage()-1)*student.getRows());
	 
		fenye.setRows(studentMapper.selectStuAll(student));
		fenye.setTotal(studentMapper.selectStuCount(student));
		return new Gson().toJson(fenye);
	}

	@Override
	public Integer deleteStu(Student student) {
		// TODO Auto-generated method stub
		return studentMapper.deleteStu(student);
	}

	@Override
	public Integer updateStus(Student student) {
		// TODO Auto-generated method stub
		return studentMapper.updateStu(student);
	}

	@Override
	public Integer insertStus(Student student) {
		// TODO Auto-generated method stub
		return studentMapper.insertStus(student);
	}

	@Override
	public Student selectStuByid(Integer s_id) {
		// TODO Auto-generated method stub
		return studentMapper.selectStuByid(s_id);
	}
	@Override
	public String selectUsersByZixunShi() {
		return new Gson().toJson(studentMapper.selectUsersByZixunShi());
	}
	@Override
	public String selectUsersByZXS(Integer s_id) {
		// TODO Auto-generated method stub
		return new Gson().toJson(studentMapper.selectUsersByZXS(s_id));
	}
	@Override
	public List<Users> selectStudentUserName(Integer s_createUser) {
		return studentMapper.selectStudentUserName(s_createUser);
	}
}
