package com.spz.controller;


import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spz.entity.Users;
import com.spz.service.UsersService;
import com.spz.util.InitDateTime;
import com.spz.util.MyMd5Util;
import com.spz.util.Result;
import com.sun.glass.ui.Application;

@Controller
public class LoginController {
	
	@Autowired UsersService usersService;
	
	@RequestMapping(value="login",method=RequestMethod.POST)
	@ResponseBody
	public String login(Users users,HttpSession session,Integer yzm,HttpServletResponse resp,HttpServletRequest request) throws UnsupportedEncodingException {
		//获取登陆密码加密后判断
		Users users2 = usersService.selectUserBylogin(users);
		String k = (String) session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		/*System.out.println(k+"后验证码");
		System.out.println(yzm+"前验证码"); */
		if(yzm==null) {
			//前三次无验证码正常查
			if(users2 != null) {
				// 声明application
				ServletContext application = request.getServletContext();
				if (application.getAttribute(""+users2.getU_id()+"") != null && application.getAttribute(""+users2.getU_id()+"").equals(""+users2.getU_id()+"")) {
					return Result.toClient(false, "该用户已登陆。");
				} else {
					session.setAttribute("u_id", users2.getU_id());
					session.setAttribute("u_name", users2.getU_name());
					if(users2.getU_isLockout()==2) {
						return Result.toClient(false, "用户已被锁定。");
					}
					if(users.getU_pwd()!=null) {
						if(users.getU_pwd().equals(users2.getU_pwd())) {
							//session.setAttribute("u_id", users2.getU_id());
							users.setU_lastLoginTime(InitDateTime.initTime());
							usersService.updateUsers(users);
							//把用户名添加到cookie(因为cookie不能存中文，得处理一下);
							String name=URLEncoder.encode(users2.getU_name(),"UTF-8");
							insertCookie(resp,name);
							// 将用户名放入application
							application.setAttribute(""+users2.getU_id()+"",""+users2.getU_id()+"");
						}
					}
				}
			}
		}
		if(yzm!=null){
			//判断验证码是否正确不正确返回验证码错误正确则查询
			/*Object a=Integer.parseInt(k)!=yzm ? Result.toClient(false, "验证码错误！") : (users2 == null ? null : request.getSession().setAttribute("u_id", users2.getU_id()));*/
			if(Integer.parseInt(k)==yzm) {
				//验证码正确查询
				if(users2 != null) {
					
					if(users2.getU_isLockout()==2) {
						return Result.toClient(false, "用户已被锁定");
					}
					if(users2.getU_isLockout()==1) {
						session.setAttribute("u_id", users2.getU_id());
						//把用户名添加到cookie
						String name=URLEncoder.encode(users2.getU_name(),"UTF-8");
						insertCookie(resp,name);
						users.setU_lastLoginTime(InitDateTime.initTime());
						usersService.updateUsers(users);
					}
				}
			}
			if(Integer.parseInt(k)!=yzm){
				//验证码错去返回
				return Result.toClient(false, "验证码错误！","1");
			}
			
			
		}
		//如果得到的登录用户是否被锁定状态==1则给出提示
		//String count=users2.getU_isLockout()==1 ? "用户被锁定 ！请联系管理员解锁后登陆 " : "密码错误！";
		/*if(users2 !=null) {
			if(users2.getU_isLockout()==1) {
				return Result.toClient(false, "用户已被锁定");
			}
		}*/
        if(users2 ==null){
			if(users.getU_pwd()==null) {
				return Result.toClient(false, "用户不存在");
			}
		}
		return Result.toClient(users2 !=null ? true : false, users2 !=null ? users2 : "密码错误！");
		
		

	}
	@RequestMapping(value="locking",method=RequestMethod.POST)
	@ResponseBody
	public Integer locking(Users users) {
		//登录失败多次锁定用户
		return usersService.updateUsers(users);
	}
	
	//将所登录的用户名和密码存到cookie中
	public void insertCookie(HttpServletResponse resp,String val1) {
		Cookie name=new Cookie("u_name", val1);
		//设置过期时间（以秒为单位）
		name.setMaxAge(60*60);
		//设置添加到根路径下
		name.setPath("/");
		//添加Cookie
		resp.addCookie(name);
	}
		
	
	
	
	
	@RequestMapping(value="errorClose",method=RequestMethod.POST)
    public void errorClose(HttpServletRequest request,Users users) {
        // 声明application
        ServletContext application = request.getServletContext();
        // 判断当前用户名是否还存在
        System.out.println(users.toString());
        
        if (application.getAttribute(""+users.getU_id()+"") != null && application.getAttribute(""+users.getU_id()+"").equals(""+users.getU_id()+"")) {
            // 从application中移除当前用户
            application.removeAttribute(""+users.getU_id()+"");
        }
    }
	
    


	
	@RequestMapping(value="/log",method=RequestMethod.GET)
	public String login2() {
		return "view/index";
	}
	
	@RequestMapping(value="/main",method=RequestMethod.GET)
	public String main() {
		return "view/main";
	}
	@RequestMapping(value="/yh",method=RequestMethod.GET)
	public String yh() {
		return "view/yh";
	}
	@RequestMapping(value="/flcz",method=RequestMethod.GET)
	public String flcz() {
		return "view/flcz";
	}
	@RequestMapping(value="/jdgl",method=RequestMethod.GET)
	public String jdgl() {
		return "view/jdgl";
	}
	@RequestMapping(value="/Modules",method=RequestMethod.GET)
	public String Modules() {
		return "view/Modules";
	}
	@RequestMapping(value="/wlzxs",method=RequestMethod.GET)
	public String wlzxs() {
		return "view/wlzxs";
	}
	@RequestMapping(value="/ygqd",method=RequestMethod.GET)
	public String ygqd() {
		return "view/ygqd";
	}
	@RequestMapping(value="/yonghu",method=RequestMethod.GET)
	public String yonghu() {
		return "view/yonghu";
	}
	@RequestMapping(value="/zxs",method=RequestMethod.GET)
	public String zxs() {
		return "view/zxs";
	}
	@RequestMapping(value="/tbtj",method=RequestMethod.GET)
	public String tbtj() {
		return "view/tbtj";
	}
	@RequestMapping(value="/wflxs",method=RequestMethod.GET)
	public String wflxs() {
		return "view/wflxs";
	}

	@RequestMapping(value="/tuisong",method=RequestMethod.GET)
	public String tuisong() {
		return "view/tuisong";
	}
	
	@RequestMapping(value="/yggl",method=RequestMethod.GET)
	public String yggl() {
		return "view/yggl";
	}
	
	@RequestMapping(value="/hsz",method=RequestMethod.GET)
	public String hsz() {
		return "view/hsz";
	}
}
