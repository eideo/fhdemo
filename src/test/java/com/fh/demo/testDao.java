package com.fh.demo;

import java.lang.reflect.Field;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fh.entity.system.Menu;
import com.fh.service.system.menu.MenuService;



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring/root-context.xml")
public class testDao {
	
	@Autowired
	MenuService menuService;
	@Test
	public void test01(){
		String str="";
		System.out.println(str.length());
	}
	
	@Test
	public void test02(){
		System.out.println(System.getProperty("user.dir"));
	}
	@Test
	public void test03(){
		System.out.println(this.getClass().getClassLoader().getResource("/").getPath());
	}
	
	
	@Test
	public void test05() throws IllegalArgumentException, IllegalAccessException{
		Calendar clndr = Calendar.getInstance();  
		Class cls = clndr.getClass();  
		  
		System.out.println(cls.getName());  
		Field[] flds = cls.getFields();  
		  
		if ( flds != null )  
		{  
		    for ( int i = 0; i < flds.length; i++ )  
		    {  
		        System.out.println(flds[i].getName() + " - " + flds[i].get(clndr));  
		    }  
		}
	}
	@Test
	public void test06(){
		try {
			List<Menu> list = menuService.listAllParentMenu();
			for(Menu m:list){
				System.out.println(m.getMENU_ID());
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
