package com.daniel.service.impl;

import com.daniel.dao.ResourceDAO;
import com.daniel.pojo.MyResource;
import com.daniel.service.ResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ResourceServiceImpl implements ResourceService {
    @Autowired
    private ResourceDAO resourceDAO;
    @Override
    public MyResource get(int id) {
        MyResource resource = resourceDAO.get(id);
        resource.setImage(Integer.toString(id)+".jpg");
        return resource;
    }

    @Override
    public List<MyResource> list() {
        List<MyResource> resourceList = resourceDAO.list();
        for(MyResource resource:resourceList){
            resource.setImage(Integer.toString(resource.getId())+".jpg");
        }
        return resourceList;
    }

    @Override
    public int count() {
        int count = resourceDAO.count();
        return count;
    }

    @Override
    public void delete(int id) {
        resourceDAO.delete(id);
    }

    @Override
    public int addResource(MyResource resource) {
        return resourceDAO.addResource(resource);
    }
}
