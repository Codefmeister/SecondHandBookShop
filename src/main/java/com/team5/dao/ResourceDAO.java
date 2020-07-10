package com.daniel.dao;

import com.daniel.pojo.MyResource;

import java.util.List;

public interface ResourceDAO {
    /**
     * 根据资源id获取资源对象
     * @param id 资源的id
     * @return 对应的MyResource对象
     */
    MyResource get(int id);
    /**
     * 获取所有资源列表
     */
    List<MyResource> list();
    int count();
    void delete(int id);
    int addResource(MyResource resource);
}
