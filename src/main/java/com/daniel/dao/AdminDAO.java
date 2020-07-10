package com.daniel.dao;

import com.daniel.pojo.Admin;
import com.daniel.pojo.User;

public interface AdminDAO {

    Admin get(int id);

    int getAdminLevel(int id);

    void update(Admin admin);

    int checkPassword(Admin admin);

    Admin getByAdminid(String adminid);

    int creatAdmin(Admin admin);

    int checkExistAid(int id);
}
