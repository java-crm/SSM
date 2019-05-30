package com.spz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spz.entity.Push;
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
			return Result.toClient(num > 0 ? true :false, num > 0 ? "添加成功" : "添加失败");
		}else {
			num=usersService.updateUsers(users);
			return Result.toClient(num > 0 ? true :false, num > 0 ? "修改成功" : "修改失败");
		}
	}
	
	@RequestMapping(value="/deleteUser",method=RequestMethod.POST)
	@ResponseBody
	public String deleteUser(Integer u_id) {
		//删除员工前判断学生表是否有与之关联的学生还‘未缴费’的
		List<Student> byU_id = studentService.selectStudentByU_id(u_id);
		if(byU_id.size()>0) {
			return Result.toClient(true, "该员工还有学生没有缴费！您不能删除！");
		}else {
			Integer users = usersService.deleteUsers(u_id);
			return Result.toClient(true,users>0 ? "删除成功" : "删除失败" );
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
		//添加用户时查询是否已经存在
		Users userByName = usersService.selectUserBylogin(users);
		if(userByName==null) {
			return Result.toClient(true, "");
		}else{
			return Result.toClient(false, "用户已经存在");
		}
	}
	
	@RequestMapping(value="/selectUserIsFouDaKa",method=RequestMethod.POST)
	@ResponseBody
	public String selectUserIsFouDaKa(Integer u_id) {
		if(u_id==null) {
			return Result.toClient(true, "");
		}
		Userchecks userchecks = userchecksService.selectUserchecks(u_id);
		//判断用户是否已经打卡了
		if("是".equals(userchecks.getUs_checkState())) {
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
		return Result.toClient(true, updateUsers>0 ? "修改成功" : "修改失败");
	}
	
	@RequestMapping(value="/selectUsersByKaiQi",method=RequestMethod.POST)
	@ResponseBody
	public String selectUsersByKaiQi(Integer u_id) {
		Users usersByKaiQi = usersService.selectUsersByKaiQi(u_id);
		return Result.toClient(usersByKaiQi.getU_state() == 1 ? true : false, "");
	}
	
	//经理点击开启分量的按钮和取消分量使用的
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
	
	
	
	
	/*孙所蕾*/
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
	
	@RequestMapping(value="/selectUserAndPushIsreaderCount")
	@ResponseBody
	public Integer selectUserAndPushIsreaderCount(String u_name) {
		return usersService.selectUserAndPushIsreaderCount(u_name);
	}
	
	@RequestMapping(value="/selectPushIsWeidu")
	@ResponseBody
	public List<Push> selectPushIsWeidu(String u_name) {
		return usersService.selectPushIsWeidu(u_name);
	}
	
	@RequestMapping(value="/updatePushIsreader",method=RequestMethod.POST)
	@ResponseBody
	public void updatePushIsreader(String u_name) {
		usersService.updatePushIsreader(u_name);
	}
	
	
	@RequestMapping(value="/selectAllUsers")
	public String  selectAllUsers(Model model) {
		model.addAttribute("listUsers", usersService.selectAllUsers());
		return "view/ltym";
	}
	
}
