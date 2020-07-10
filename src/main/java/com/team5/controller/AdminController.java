package com.daniel.controller;


import com.daniel.pojo.*;
import com.daniel.service.*;
import com.github.pagehelper.PageHelper;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.daniel.common.Result;
import com.daniel.common.ResultGenerator;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private BookService bookService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private UserService userService;

    @Autowired
    private AdminService adminService;//自动注入连接

    @Autowired
    private ResourceService resourceService;

    @RequestMapping("")
    public ModelAndView adminHome(){return new ModelAndView("adminHome");}
    // 日志文件
    private static final Logger log = Logger.getLogger(AdminController.class);
    @RequestMapping("/login")
    public ModelAndView login() {
        return new ModelAndView("adminLogin");
    }

    /**
     * 管理员用户登录
     * @param admin 在前端提交的登录信息
     * @param request 登录成功时将admin信息放入session中
     * @return 登录成功时跳转到管理员界面
     * */
    @RequestMapping(value = "/sessions", method = RequestMethod.POST)
    @ResponseBody
    public Result checkAdminLogin(@RequestBody Admin admin, HttpServletRequest request){
        log.info("Inside AdminLogin");
        log.info("request: admin/login , admin: " + admin.getAdminid()+"password:"+admin.getPassword());
        // userService验证是否登录成功
        boolean flag = adminService.checkAdmin(admin);
        log.info("request: admin/login , admin: " + admin.toString());
        if (flag) {
            Map data = new HashMap();
            data.put("currentAdmin",admin);
            // 登录成功，将登录信息放入session
            request.getSession().setAttribute("admin",adminService.getByAdminid(admin.getAdminid()));
            return ResultGenerator.genSuccessResult(data);
        }else {
            return ResultGenerator.genFailResult("用户名或密码输入错误！");
        }

    }

    @RequestMapping("/goadminhome")
    public ModelAndView goAdminHome() {
        ModelAndView mav =new ModelAndView("adminHome");
//        Map<Integer, String> categories = categoryService.listByMap();
//        Map<Category, List<Book>> booksMap = bookService.listByCategory();
//        mav.addObject("categories",categories);
//        mav.addObject("booksMap",booksMap);
        return mav;
    }

    @RequestMapping("/goadminuser")
    public ModelAndView goAdminUser(Page page){
        ModelAndView mav = new ModelAndView("adminUser");
//        Map<Integer, String> users = userService.listByMap();

        int total = userService.count();
        page.calculateEnd(total);
        if (page.getStart() < 0) {
            page.setStart(0);
        }else if (page.getStart() > total){
            page.setEnd(page.getEnd());
        }
        PageHelper.offsetPage(page.getStart(),10);  //每页显示的用户数量
        List<User> users = userService.list();
        mav.addObject("users",users);
        return mav;
    }

    @RequestMapping(value = "/goadminuser",method = RequestMethod.POST)
    public Result deleteUser(HttpServletRequest request,@RequestParam(value = "id",required = false) String Sid){
        int id = Integer.parseInt(Sid);
        userService.delete(id);
        return ResultGenerator.genSuccessResult();
    }






    @RequestMapping("/goadminbook")
    public ModelAndView goAdminBook(Page page){
        ModelAndView mav = new ModelAndView("adminBook");
        String categoryName = "管理所有二手书";
        int total = bookService.count();
        page.calculateEnd(total);
        if (page.getStart() < 0) {
            page.setStart(0);
        }else if (page.getStart() > total){
            page.setEnd(page.getEnd());
        }
        PageHelper.offsetPage(page.getStart(),16);
        mav.addObject("categoryName",categoryName);
        List<Book> books = bookService.list();
        mav.addObject("books",books);
        return mav;
    }

    @RequestMapping(value = "/goadminbook",method = RequestMethod.POST)
    public Result deleteAdminBook(HttpServletRequest request,@RequestParam(value="id") String BookId){
        int bookId = Integer.parseInt(BookId);
        bookService.delete(bookId);
        return ResultGenerator.genSuccessResult();
    }

    @RequestMapping(value = "/goadminresource")
    public ModelAndView goAdminResource(Page page){
        ModelAndView mav = new ModelAndView("adminResource");
        int total = resourceService.count();
        page.calculateEnd(total);
        if (page.getStart() < 0) {
            page.setStart(0);
        }else if (page.getStart() > total){
            page.setEnd(page.getEnd());
        }
        PageHelper.offsetPage(page.getStart(),16);
        List<MyResource> resourceList = resourceService.list();
        mav.addObject("resourceList",resourceList);
        return mav;
    }

    @RequestMapping(value = "/goadminresource",method = RequestMethod.POST)
    public Result deleteResource(HttpServletRequest request,@RequestParam(value="id") String ResourceId){
        int resourceId= Integer.parseInt(ResourceId);
        resourceService.delete(resourceId);
        return ResultGenerator.genSuccessResult();
    }





}
