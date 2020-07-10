package com.daniel.service;

import com.daniel.pojo.MyResource;

import java.util.List;

public interface ResourceService {
    MyResource get(int id);
    List<MyResource> list();
    int count();
    void delete(int id);
    int addResource(MyResource resource);
}
