package com.daniel.service.impl;

import com.daniel.dao.AdminDAO;
import com.daniel.pojo.Admin;
import com.daniel.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminDAO adminDAO;


    @Override
    public boolean checkAdmin(Admin admin){
        int flag = adminDAO.checkPassword(admin);
        return flag==1;
    }

    @Override
    public Admin get(int id){
        return adminDAO.get(id);
    }

    @Override
    public Admin getByAdminid(String adminid){
        return adminDAO.getByAdminid(adminid);
    }

    @Override
    public boolean checkExistAid(int id){
        int flag = adminDAO.checkExistAid(id);
        return flag==1;
    }

    @Override
    public int creatAdmin(Admin admin){
        int flag = 0;
        flag = adminDAO.creatAdmin(admin);
        return flag;
    }

    @Override
    public int getAdminLevel(int id){
        int level = 0;
        level = adminDAO.getAdminLevel(id);
        return level;
    }


}
