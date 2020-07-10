package com.daniel.service;

import com.daniel.pojo.User;

import java.util.List;

public interface UserService {

    boolean checkUser(User user);

    User get(int id);

    User getByStudentid(String studnetid);

    int creatUser(User user);

    boolean checkExistSid(int id);

    List<User> list();

    int count();

    void delete(int id);
}
