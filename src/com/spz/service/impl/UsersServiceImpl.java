package com.spz.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.spz.dao.RolesMapper;
import com.spz.dao.UserchecksMapper;
import com.spz.dao.UsersMapper;
import com.spz.entity.Fenye;
import com.spz.entity.Modules;
import com.spz.entity.Push;
import com.spz.entity.Roles;
import com.spz.entity.Userchecks;
import com.spz.entity.Users;
import com.spz.service.UsersService;
import com.spz.util.MyMd5Util;
import com.spz.util.RedisDao;
import com.spz.util.Result;
@Service
public class UsersServiceImpl implements UsersService {
	
	@Autowired private UsersMapper usersMapper;
	
	@Autowired private RolesMapper rolesMapper;
	
	@Autowired private RedisDao redisDao;
	
	@Autowired private UserchecksMapper userchecksMapper;
	
	@Override
	public String selectUsersByUsers(Users users) {
		Fenye<Users> fy=new Fenye<Users>();
		users.setPage((users.getPage()-1)*users.getRows());
		fy.setTotal(usersMapper.selectUsersByUsersCount(users));
		fy.setRows(usersMapper.selectUsersByUsers(users));
		return new Gson().toJson(fy);
	}
	
	@Override
	public Integer insertUsers(Users users) {
		users.setU_pwd(MyMd5Util.strMd5("ysd123"));//Ĭ������
		Integer insertUsers = usersMapper.insertUsers(users);
		if(insertUsers>0) {
			users = usersMapper.selecuMaxUserId();
			System.out.println(users.toString());
			Userchecks userchecks=new Userchecks();
			userchecks.setU_id(users.getU_id()+"");
			userchecks.setUs_userName(users.getU_name());
			userchecksMapper.insertUserchecks(userchecks);
		}
		return insertUsers;
	}

	@Override
	public Integer updateUsers(Users users) {//��������or�޸�����
		if(users.getU_pwd()!=null) {
			users.setU_pwd(MyMd5Util.strMd5(users.getU_pwd()));
		}
		return usersMapper.updateUsers(users);
	}

	@Override
	public Integer deleteUsers(Integer u_id) {
		userchecksMapper.deleteUsersByUserId(u_id);
		return usersMapper.deleteUsers(u_id);
	}
	
	
	
	@Override
	public Users selectUserBylogin(Users users) {
		//�޸�����ǰ�ȶ��Ƿ���ȷor��¼ʱҲ�ȶ��Ƿ���ȷ
		if(users.getU_pwd()!=null) {
			users.setU_pwd(MyMd5Util.strMd5(users.getU_pwd()));
		}
		Users userBylogin = usersMapper.selectUserBylogin(users);
		return userBylogin;
	}

	@Override
	public List<Map<String, Object>> selectUserModuls(Integer u_id) {
		List<Modules> listmoduls = usersMapper.selectUserModuls(u_id);
		List<Map<String, Object>> m=new ArrayList<Map<String, Object>>();
		if(listmoduls!=null) {
			for(int i=0;i<listmoduls.size();i++) {
				Map<String, Object> map=new HashMap<String, Object>();
				if(listmoduls.get(i).getM_parentId()==0){
					map.put("id", listmoduls.get(i).getM_id());
					map.put("text", listmoduls.get(i).getM_name());
					map.put("url", listmoduls.get(i).getM_path());
					map.put("children",childre(listmoduls.get(i),u_id));
					m.add(map);
				}
			}
		}
		return m;
	}
	public List<Map<String, Object>> childre(Modules modules,Integer u_id){
		List<Modules> modulsByid = usersMapper.selectModulsByid(modules.getM_id(), u_id);
		List<Map<String, Object>> list=new ArrayList<Map<String, Object>>();
			for(int i=0;i<modulsByid.size();i++) {
				Map<String, Object> map=new HashMap<String, Object>();
				if(modulsByid.get(i).getM_parentId()==modules.getM_id()){
					map.put("id", modulsByid.get(i).getM_id());
					map.put("text", modulsByid.get(i).getM_name());
					map.put("url", modulsByid.get(i).getM_path());
					map.put("children",childre(modulsByid.get(i),u_id));
				    list.add(map);
				}
			}
		return list;
	}

	//���ﴫԱ��u_id���ǲ�Ա�������еĽ�ɫ��ǰ̨����Ϊu_id��Ϊnull��ѯȫ����ɫ
	@Override
	public List<Roles> selectRolesAll() {
		return rolesMapper.selectRolesAll();
	}

	@Override
	public List<Roles> selectRolesAllbyU_id(Integer u_id) {
		return rolesMapper.selectRolesAllbyU_id(u_id);
	}
	
	//������ѯ����ѯʦ
	@Override
	public List<Users> selectUsersByFenLiang(Users users) {
		return usersMapper.selectUsersByFenLiang(users);
	}

	@Override
	public Users selectUsersByKaiQi(Integer u_id) {
		return usersMapper.selectUsersByKaiQi(u_id);//Result.toClient(byKaiQi.getU_state() == 1 ? true : false, "");
	}

	@Override
	public String selectUsersByflczAll(Users users) {
		users.setPage((users.getPage()-1)*users.getRows());
		Fenye<Users> fy=new Fenye<Users>();
		fy.setRows(usersMapper.selectUsersByflcz(users));
		fy.setTotal(usersMapper.selectUsersByflczCount(users));
		return new Gson().toJson(fy);
	}

	
	@Override
	public Integer updateUsersByu_state(Integer u_state) {
		return usersMapper.updateUsersByu_state(u_state);
	}

	@Override
	public String selectUsersJingLi() {
		Users usersJingLi = usersMapper.selectUsersJingLi();
		if(usersJingLi!=null) {
			return Result.toClient(true, "���������ö����");
		}else {
			return Result.toClient(false, "");
		}
	}

	@Override
	public Integer selectUserAndPushIsreaderCount(String u_name) {
		System.out.println(u_name);
		Push push= redisDao.getPush(u_name);
		System.out.println("ֱ�Ӵӻ����õ����ݣ�"+push);
		if(push==null||push.getId()==0) {
			push = selectPushByName(u_name);
			 System.out.println("���ݿ���ȡ�������ݣ�"+push.toString());
			 if(push.getId()>0) {
				 //System.out.println("д��"+redisDao.putPush(push));
				 System.out.println("��ʼ��redisд�룡");
				 String result = redisDao.putPush(push);
				 System.out.println("д��redis:"+result.toLowerCase());
				 System.out.println("�����в������:"+redisDao.getPush(u_name));
			 }else {
				 System.out.println("������ݿ�û��δ������Ϣ�Ի����0");
				 push.setId(0);
				 String result = redisDao.putPush(push);
				 System.out.println("��redisд��0:"+result);
			 }
		}
		System.out.println(push.getId());
		return push.getId();
	}
	
	public Push selectPushByName(String u_name) {
		return usersMapper.selectUserAndPushIsreaderCount(u_name);
	}

	@Override
	public List<Users> selectAllUsers() {
		return usersMapper.selectAllUsers();
	}

	@Override
	public List<Push> selectPushIsWeidu(String u_name) {
		List<Push> weidu = usersMapper.selectPushIsWeidu(u_name);
		return weidu;
	}

	@Override
	public void updatePushIsreader(String u_name) {
		Push push=new Push();
		push.setZxname(u_name);
		push.setId(0);
		redisDao.putPush(push);
		usersMapper.updatePushIsreader(u_name);
	}

	@Override
	public Integer updateUsersByu_pwdWrongTime(Integer u_id) {
		return usersMapper.updateUsersByu_pwdWrongTime(u_id);
	}

	@Override
	public Integer selectUsersByu_pwdWrongTime(Integer u_id) {
		return usersMapper.selectUsersByu_pwdWrongTime(u_id);
	}

	@Override
	public void updateUsersByu_pwdWrongTimeIsNUll(Integer u_id) {
		usersMapper.updateUsersByu_pwdWrongTimeIsNUll(u_id);
	}
	
}
