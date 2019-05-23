package com.spz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.spz.dao.RoleModulesMapper;
import com.spz.entity.Modules;
import com.spz.entity.Roles;
import com.spz.service.ModulesService;
import com.spz.util.Result;

@Controller
public class ModulesController {
	
	@Autowired ModulesService modulesService;
	
	@Autowired RoleModulesMapper roleModulesMapper;
	
	@RequestMapping(value="/selectModules",method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> selectModules() {
		List<Map<String, Object>> modulesAll = modulesService.selectModulesAll();
		return modulesAll;
	}
	
	@RequestMapping(value="/addEditModules",method=RequestMethod.POST)
	@ResponseBody
	public String addEditModules(Modules modules) {
		Integer num =null;
		if(modules.getM_id()==null) {
			num= modulesService.insertModules(modules);
			return Result.toClient(num>0 ? true : false, num>0 ? "��ӳɹ�" : "���ʧ��");
		}else {
			num= modulesService.updateModules(modules);
			return Result.toClient(num>0 ? true : false, num>0 ? "�޸ĳɹ�" : "�޸�ʧ��");
		}
	}
	
	@RequestMapping(value="/deleteModules",method=RequestMethod.POST)
	@ResponseBody
	public String deleteModules(Integer m_id) {
		List<Roles> byModulesID = roleModulesMapper.selectRolesByModulesID(m_id);
		if(byModulesID.size()>0) {
			return Result.toClient(true, "��ģ�����ڱ�����������ɾ����");
		}
		Integer num = modulesService.deleteModules(m_id);
		if(num>0){
			//ɾ����ģ��ͬʱɾ����ģ��
			modulesService.deleteModulesByP_id(m_id);
		}
		return Result.toClient(num>0 ? true : false,num>0 ? "ɾ���ɹ�" : "ɾ��ʧ��");
	}
	
	@RequestMapping(value="/selectModulesByid",method=RequestMethod.POST)
	@ResponseBody
	public String selectModulesByid(Integer m_id) {
		Modules byId = modulesService.selectModulesById(m_id);
		return Result.toClient(byId != null ? true : false, byId != null ? new Gson().toJson(byId): null);
	}
	
	@RequestMapping(value="/selectRolesModules",method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> selectRolesModules(Integer r_id){
		return modulesService.selectModulesByRolesId(r_id);
	}
}
