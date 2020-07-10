package com.daniel.service.impl;

import com.daniel.dao.UserDAO;
import com.daniel.pojo.User;
import com.daniel.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{

    @Autowired
    private UserDAO userDAO;

    @Override
    public boolean checkUser(User user) {
        int flag = userDAO.checkPassword(user);
        return flag==1;
    }

    @Override
    public User get(int id) {
        return userDAO.get(id);
    }

    @Override
    public User getByStudentid(String studnetid) {
        return userDAO.getByStudentid(studnetid);
    }

    @Override
    public boolean checkExistSid(int id){
        int flag = userDAO.checkExistSid(id);
        return  flag==1;
    }

    @Override
    public int creatUser(User user){
        int flag = 0;
        flag = userDAO.creatUser(user);
        return flag;
    }

    @Override
    public List<User> list() {
        return userDAO.list();
    }

    @Override
    public int count() {
        return userDAO.count();
    }

    @Override
    public void delete(int id) {
        userDAO.delete(id);
    }
}
