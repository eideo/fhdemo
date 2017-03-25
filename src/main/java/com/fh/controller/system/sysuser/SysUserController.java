package com.fh.controller.system.sysuser;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.dao.test.UserMapper;
import com.fh.entity.system.Role;
import com.fh.entity.test.User;
import com.fh.entity.test.UserExample;
import com.fh.service.system.role.RoleService;
import com.fh.util.Const;
import com.fh.util.PageData;

@Controller
@RequestMapping(value="/sysUser")
public class SysUserController extends BaseController{
	@Autowired 
	UserMapper userMapper;
	@Autowired
	RoleService roleService;
	
	/**
	 * 去表格页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/goList")
	String toList(Model model){
		return "system/sysuser/appuser_list";
//		return "system/sysuser/test";
	}
	
	/**
	 * 加载表格数据
	 * @return
	 */
	@RequestMapping(value="/userList")
	@ResponseBody
	List<User>userList(){
		
		UserExample example = new UserExample();
		List<User> userList= userMapper.selectByExample(example);
		return userList;
	}
	/**
	 * 删除用户
	 * @param userId
	 * @return
	 */
	@RequestMapping(value="/userDelete")
	@ResponseBody
	Map<String,String>userDelete(String userId){
		Map<String,String> map = new HashMap<String,String>();
		if(userMapper.deleteByPrimaryKey(userId)==1){
			map.put("success", "true");
		}else{
			map.put("success", "false");
		}
		return map;
	}
	@RequestMapping(value="/listRoles")
	@ResponseBody
	List<Role>listRoles(){
		List<Role> roleList = null;
		try {
			roleList = roleService.listAllERRoles();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return roleList;
	}
	@RequestMapping(value="/goAddU")
	@ResponseBody
	ModelAndView goAddU(Model model) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<Role> roleList;
		
		roleList = roleService.listAllERRoles();			//列出所有二级角色
		
		mv.setViewName("system/sysuser/edit");
		mv.addObject("msg", "saveU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);

		return mv;
	}
	/*===================权限========================*/
	public Map<String,String>getHC(){
		Subject subject = SecurityUtils.getSubject();
		Session session = subject.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}
	/*===================权限========================*/
}
