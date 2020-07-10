package com.daniel.controller;

import com.daniel.common.Result;
import com.daniel.common.ResultGenerator;
import com.daniel.dao.ResourceDAO;
import com.daniel.pojo.Book;
import com.daniel.pojo.BookImage;
import com.daniel.pojo.MyResource;
import com.daniel.pojo.User;
import com.daniel.service.ResourceService;
import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;

@RestController
@RequestMapping("/resource")
public class ResourceController {
    @Autowired
    private ResourceService resourceService;

    private static final Logger log = Logger.getLogger(ResourceController.class);

    @RequestMapping( value="",method = RequestMethod.POST)
    public Result deleteResource(HttpServletRequest request, @RequestParam(value = "resourceId", required = false) String resourceId){
            // 遍历每个ID
            int id = Integer.parseInt(resourceId);
            log.info("ResourceId="+id);
            // 获取当前图书的图片名称与存放路径
            String imageName = resourceService.get(id).getImage();
            String imagePath = request.getServletContext().getRealPath("/img/resource/img/");
            File filePath = new File(imagePath, imageName);
            log.info(filePath);
            String fileName = id + resourceService.get(id).getSuffix();
            String filePathE = request.getServletContext().getRealPath("/img/resource/doc/");
            File docPath = new File(filePathE,fileName);
            log.info(docPath);
            // 删除图片
            if (filePath.exists()){
                filePath.delete();
            }
            if(docPath.exists()){
                docPath.delete();
            }
            // 删除数据库中的资源
            resourceService.delete(id);
            log.info("request: delete Resource, id="+Integer.toString(id));
            return ResultGenerator.genSuccessResult();
    }
    @RequestMapping(value="/upload",method = RequestMethod.GET)
    public ModelAndView gotoUploadResource(){
        ModelAndView mav = new ModelAndView("uploadResource");
        return mav;
    }

    @RequestMapping(value = "/upload",method = RequestMethod.POST)
    public Result processUploadResource(HttpServletRequest request, MyResource resource, @RequestParam(value = "file") MultipartFile[] file){
        User user = (User) request.getSession().getAttribute("user");
        String userId=user.getStudentid();
        resource.setUserId(userId);
        try {
            if(file[0] != null && resource != null &&file[1] != null){
                // 写入资源信息
                resourceService.addResource(resource);
                int resourceId = resource.getId();
                String imageName = resourceId+".jpg";
                String imagePath = request.getServletContext().getRealPath("/img/resource/img/");
                File filePath = new File(imagePath,imageName);
                if (!filePath.getParentFile().exists()){
                    filePath.getParentFile().mkdir();
                }
                String docName = resourceId + resource.getSuffix();
                String docPath = request.getServletContext().getRealPath("/img/resource/doc/");
                File file1Path = new File(docPath+docName);
                if (!file1Path.getParentFile().exists()){
                    file1Path.getParentFile().mkdir();
                }
                log.info(filePath);
                log.info(file1Path);
                file[0].transferTo(new File(imagePath + File.separator + imageName));
                file[1].transferTo(new File(docPath+File.separator+docName));
                log.info(file[1].getContentType());
                log.info("request: resource/upload , resource: " + resource.toString());
                return ResultGenerator.genSuccessResult();
            }else {
                return ResultGenerator.genFailResult("信息填写不完整或未上传图片！");
            }
        } catch (IOException e) {
            e.printStackTrace();
            return ResultGenerator.genFailResult("上传失败");
        }
    }


}
