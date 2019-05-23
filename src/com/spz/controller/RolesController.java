package com.spz.controller;

import java.util.List;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spz.dao.RolesMapper;
import com.spz.entity.Roles;
import com.spz.entity.UserRoles;
import com.spz.service.RolesModulesService;
import com.spz.service.RolesService;
import com.spz.service.UserRolesService;
import com.spz.util.Result;

@Controller
public class RolesController {

	@Autowired private RolesService rolesService;
	
	@Autowired private RolesModulesService rolesModulesService;
	
	@Autowired private UserRolesService  userRolesService;
	
	@RequestMapping(value="/selectAllRoles",method=RequestMethod.POST)
	@ResponseBody
	public String selectAllRoles(Roles roles) {
		return rolesService.selectRolesByRole(roles);
	}
	
	@RequestMapping(value="/addEditRoles",method=RequestMethod.POST)
	@ResponseBody
	public String addEditRoles(Roles roles) {
		Integer num=null;
		if(roles.getR_id()==null) {
			num=rolesService.insertRoles(roles);
			return Result.toClient(num>0 ? true : false, num>0 ? "��ӳɹ�" : "���ʧ��");
		}else {
			num=rolesService.updateRoles(roles);
			return Result.toClient(num>0 ? true : false, num>0 ? "�޸ĳɹ�" : "�޸�ʧ��");
		}
	}
	
	@RequestMapping(value="/deleteRolesById",method=RequestMethod.POST)
	@ResponseBody
	public String deleteRolesById(Integer r_id) {
		//ɾ����ɫ֮ǰ�����ж��Ƿ�Ա�����ã���������õ�ʱ����ɾ��
		List<UserRoles> byR_id = userRolesService.selectByR_id(r_id);
		if(byR_id.size()>0) {
			return Result.toClient(true, "�ý�ɫ���ڱ�Ա�����ã��������ٽ���ɾ����");
		}else {
			Integer roles = rolesService.deleteRoles(r_id);
			return Result.toClient(roles>0 ? true :false, roles>0 ? "ɾ���ɹ�" : "ɾ��ʧ��");
		}
	}
	
	@RequestMapping(value="/setupQuanXian",method=RequestMethod.POST)
	@ResponseBody
	public String setupQuanXian(String arr,Integer r_id) {
		//�õ���ɫ��idȥ��ɫ��ģ����м��ɾ�����н�ɫ��ģ�飬Ȼ��ȥ����µ�ģ����Ϣ
		String[] split = arr.split(",");
		if(split.length==1) {
			 Integer modules = rolesModulesService.deleteRoleModules(r_id);
			 return Result.toClient(true, modules>0 ? "���óɹ�" : "����ʧ��");
		}
		TreeSet<String> tr = new TreeSet<String>();
		for (int i = 0; i < split.length; i++) {
			tr.add(split[i]);
		}
		String[] s2 = new String[tr.size()];
		for (int i = 0; i < s2.length; i++) {
			s2[i] = tr.pollFirst();// ��TreeSet��ȡ��Ԫ�����¸�������
		}
		Integer integer = rolesModulesService.deleteRoleModules(r_id);
		for(int i=0;i<s2.length;i++) {
			integer= rolesModulesService.insertRoleModules(r_id, Integer.parseInt(s2[i]));
		}
		return Result.toClient(true, integer>0 ? "���óɹ�" : "����ʧ��");
	}
	
	@RequestMapping(value="/selectByName",method=RequestMethod.POST)
	@ResponseBody
	public String selectByName(Roles roles) {
		Roles byName = rolesService.selectRolesByName(roles);
		if(byName==null) {
			return Result.toClient(true, "");
		}else{
			return Result.toClient(false, "�û��Ѿ�����");
		}
	}
	
}
