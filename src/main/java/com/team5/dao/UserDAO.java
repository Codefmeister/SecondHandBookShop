package com.daniel.dao;

import com.daniel.pojo.User;

import java.util.List;

public interface UserDAO {

    User get(int id);

    void update(User user);

    int checkPassword(User user);

    User getByStudentid(String studentid);

    int creatUser(User user);

    int checkExistSid(int id);

    List<User> list();

    int count();

    void delete(int id);
}
