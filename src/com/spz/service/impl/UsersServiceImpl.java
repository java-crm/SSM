package com.spz.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.spz.entity.Roles;
import com.spz.entity.Userchecks;
import com.spz.entity.Users;
import com.spz.service.UsersService;
import com.spz.util.MyMd5Util;
import com.spz.util.Result;
@Service
public class UsersServiceImpl implements UsersService {
	
	@Autowired private UsersMapper usersMapper;
	
	@Autowired private RolesMapper rolesMapper;
	
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
		users.setU_pwd("ysd123");
		Integer insertUsers = usersMapper.insertUsers(users);
		Users u = usersMapper.selecuMaxUserId();
		Userchecks userchecks=new Userchecks();
		userchecks.setU_id(u.getU_id()+"");
		userchecks.setUs_userName(u.getU_name());
		userchecksMapper.insertUserchecks(userchecks);
		return insertUsers;
	}

	@Override
	public Integer updateUsers(Users users) {
	/*	if(users.getU_pwd()!=null) {
			users.setU_pwd(MyMd5Util.converMd5(users.getU_pwd()));
		}*/
		return usersMapper.updateUsers(users);
		//return Result.toClient(true, users2>0 ? "�޸ĳɹ�" : "�޸�ʧ��");
	}

	@Override
	public Integer deleteUsers(Integer u_id) {
		userchecksMapper.deleteUsersByUserId(u_id);
		return usersMapper.deleteUsers(u_id);
	}
	
	
	
	@Override
	public Users selectUserBylogin(Users users) {
		//ͨ���û���������ȥ��ѯ
		/*if(users.getU_pwd()!=null) {
			users.setU_pwd(MyMd5Util.converMd5(users.getU_pwd()));
		}*/
		return usersMapper.selectUserBylogin(users);
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

	
}
