package com.daniel.service;

import com.daniel.pojo.Admin;
import com.daniel.pojo.User;

public interface AdminService {

    boolean checkAdmin(Admin admin);

    Admin get(int id);

    int getAdminLevel(int id);

    Admin getByAdminid(String adminid);

    int creatAdmin(Admin admin);

    boolean checkExistAid(int id);
}
