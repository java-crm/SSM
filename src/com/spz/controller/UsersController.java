package com.spz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spz.entity.Roles;
import com.spz.entity.Student;
import com.spz.entity.UserRoles;
import com.spz.entity.Userchecks;
import com.spz.entity.Users;
import com.spz.service.StudentService;
import com.spz.service.UserRolesService;
import com.spz.service.UserchecksService;
import com.spz.service.UsersService;
import com.spz.util.InitDateTime;
import com.spz.util.Result;

@Controller
public class UsersController {
	
	@Autowired UsersService usersService;
	
	@Autowired UserRolesService userRolesService;
	
	@Autowired StudentService studentService;
	
	@Autowired UserchecksService userchecksService;
	
	@RequestMapping(value="/moduls",method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> getModuls(Integer u_id) {
		return usersService.selectUserModuls(u_id);
	}
	
	@RequestMapping(value="/selectUser",method=RequestMethod.POST)
	@ResponseBody
	public String selectUser(Users users) {
		return usersService.selectUsersByUsers(users);
	}
	
	@RequestMapping(value="/insertUser",method=RequestMethod.POST)
	@ResponseBody
	public String insertUser(Users users) {
		Integer num=null;
		if(users.getU_id()==null) {
			num=usersService.insertUsers(users);
			return Result.toClient(num > 0 ? true :false, num > 0 ? "��ӳɹ�" : "���ʧ��");
		}else {
			num=usersService.updateUsers(users);
			return Result.toClient(num > 0 ? true :false, num > 0 ? "�޸ĳɹ�" : "�޸�ʧ��");
		}
	}
	
	@RequestMapping(value="/deleteUser",method=RequestMethod.POST)
	@ResponseBody
	public String deleteUser(Integer u_id) {
		//ɾ��Ա��ǰ�ж�ѧ�����Ƿ�����֮������ѧ������δ�ɷѡ���
		List<Student> byU_id = studentService.selectStudentByU_id(u_id);
		if(byU_id.size()>0) {
			return Result.toClient(true, "��Ա������ѧ��û�нɷѣ�������ɾ����");
		}else {
			Integer users = usersService.deleteUsers(u_id);
			return Result.toClient(true,users>0 ? "ɾ���ɹ�" : "ɾ��ʧ��" );
		}
	}
	
	@RequestMapping(value="/selectRoles",method=RequestMethod.POST)
	@ResponseBody
	public List<Roles> selectRoles(Integer u_id) {
		if(u_id==null) {
			return  usersService.selectRolesAll();
		}else{
			return  usersService.selectRolesAllbyU_id(u_id);
		}
	}
	
	@RequestMapping(value="/insertRoles",method=RequestMethod.POST)
	@ResponseBody
	public Integer insertRoles(UserRoles userRoles) {
		return userRolesService.insertUserRoles(userRoles);
	}
	
	@RequestMapping(value="/deleteRoles",method=RequestMethod.POST)
	@ResponseBody
	public Integer deleteRoles(UserRoles userRoles) {
		return userRolesService.deleteUserRoles(userRoles);
	}
	
	@RequestMapping(value="/lockUser",method=RequestMethod.POST)
	@ResponseBody
	public Integer lockUser(Users users) {
		return usersService.updateUsers(users);
	}
	
	@RequestMapping(value="/selectName",method=RequestMethod.POST)
	@ResponseBody
	public String selectName(Users users) {
		//����û�ʱ��ѯ�Ƿ��Ѿ�����
		Users userByName = usersService.selectUserBylogin(users);
		if(userByName==null) {
			return Result.toClient(true, "");
		}else{
			return Result.toClient(false, "�û��Ѿ�����");
		}
	}
	
	@RequestMapping(value="/selectUserIsFouDaKa",method=RequestMethod.POST)
	@ResponseBody
	public String selectUserIsFouDaKa(Integer u_id) {
		if(u_id==null) {
			return Result.toClient(true, "");
		}
		Userchecks userchecks = userchecksService.selectUserchecks(u_id);
		//�ж��û��Ƿ��Ѿ�����
		if("��".equals(userchecks.getUs_checkState())) {
			return Result.toClient(true, "1");
		}else {
			return Result.toClient(true, "0");
		}
	}
	
	@RequestMapping(value="/updataUserchecksIsDaka",method=RequestMethod.POST)
	@ResponseBody
	public Integer updataUserchecksIsDaka(Userchecks userchecks) {
		userchecks.setUs_checkinTime(InitDateTime.initTime());
		return userchecksService.updateUserchecks(userchecks);
	}
	
	@RequestMapping(value="/selectUserByPwd",method=RequestMethod.POST)
	@ResponseBody
	public Integer selectUserByPwd(Users users) {
		Users userBylogin = usersService.selectUserBylogin(users);
		if(userBylogin!=null) {
			return 1;
		}else {
			return 0;
		}
	}
	
	@RequestMapping(value="/updateUsersByPwd",method=RequestMethod.POST)
	@ResponseBody
	public String updateUsersByPwd(Users users) {
		Integer updateUsers = usersService.updateUsers(users);
		return Result.toClient(true, updateUsers>0 ? "�޸ĳɹ�" : "�޸�ʧ��");
	}
	
	@RequestMapping(value="/selectUsersByKaiQi",method=RequestMethod.POST)
	@ResponseBody
	public String selectUsersByKaiQi(Integer u_id) {
		Users usersByKaiQi = usersService.selectUsersByKaiQi(u_id);
		return Result.toClient(usersByKaiQi.getU_state() == 1 ? true : false, "");
	}
	
	//���������������İ�ť��ȡ������ʹ�õ�
	@RequestMapping(value="/updateUsersByu_state",method=RequestMethod.POST)
	@ResponseBody
	public Integer updateUsersByu_state(Integer u_state) {
		return usersService.updateUsersByu_state(u_state);
	}
	
	@RequestMapping(value="/selectUsersByflcz",method=RequestMethod.POST)
	@ResponseBody
	public String selectUsersByflcz(Users users){
		return usersService.selectUsersByflczAll(users);
	}
	
	@RequestMapping(value="/updateUserByIdState",method=RequestMethod.POST)
	@ResponseBody
	public Integer updateUserByIdState(Users users) {
		return usersService.updateUsers(users);
	}
	
	/*@RequestMapping(value="/updateUserByIdState",method=RequestMethod.POST)
	@ResponseBody
	public String selectUsersByfenliang() {
		return usersService.selectUsersByflczs();
	}*/
	
	
	
	
	/*������*/
	@RequestMapping(value="/selectUserCheckAll",method=RequestMethod.POST)
	@ResponseBody
	public String selectUserCheckAll(Userchecks userchecks) {
		
		return userchecksService.selectUserCheckAll(userchecks);
	}
	
	@RequestMapping(value="/updateUserchecksPL",method=RequestMethod.POST)
	@ResponseBody
	public Integer updateUserchecksPL(Userchecks userchecks,String usid) {
		userchecks.setUs_checkinTime(InitDateTime.initTime());
		String[] ssid=usid.split(",");
		Integer ii =0;
		for (int i = 0; i < ssid.length; i++) {
			Integer sid = Integer.parseInt(ssid[i]);
			userchecks.setUs_id(sid);
			ii=userchecksService.updateUserchecksPL(userchecks);
		}
		return ii;
	}
	
	@RequestMapping(value="/selectUsersByYuanGong")
	@ResponseBody
	public String selectUsersByYuanGong() {
		return userchecksService.selectUsersByYuanGong();
	}
	
	@RequestMapping(value="/selectUsersJingLi")
	@ResponseBody
	public String selectUsersJingLi() {
		return usersService.selectUsersJingLi();
	}
	
	@RequestMapping(value="/updateUserchecks")
	@ResponseBody
	public Integer updateUserchecks(Userchecks userchecks) {
		return userchecksService.updateUserchecksPL(userchecks);
	}
	
}
