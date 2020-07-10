<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>上传资源</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/upload.css">
</head>
<body>
<!-- 导航条 -->
<nav class="navbar">
    <div class="nav-menu">
        <ul class="menu">
            <li><a class="active" href="/home.do">首页</a></li>
            <li><a href="/goBookStore.do">书籍良品</a></li>
            <li><a href="/goAskBookStore.do">求书区</a></li>
            <li><a href="/goResource.do">资源区</a></li>
        </ul>
    </div><!-- nav-menu -->

    <div class="nav-search">
        <form action="searchBook.do" method="post">
            <input type="search" class="searchIn" name="name" placeholder="搜图书...">
            <button class="search-logo"><img src="<%=request.getContextPath()%>/img/search2.png"></button>
        </form>
    </div>

    <div class="nav-info">
        <a href="#" class="username">${user.getName()}</a>
        <a href="/myBookshelf.do" class="bookshelf">||&nbsp;&nbsp;&nbsp;我的书架</a>
        <a href="#" class="logout">[ 退 出 ]</a>
    </div> <!-- nav-info-end -->
</nav>
<div class="titleName">
    <h3>上传资源</h3>
    <p>设置资源信息</p>
</div>

<div class="container">
    <form enctype="multipart/form-data" id="resourceForm" class="upload-form">
        <p>
            <span class="pic-icon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            上传资源预览图： <input type="file" accept="/imgae/*" name="file"/>
        </p>
        <p>
            <span class="pic-icon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            上传资源文件： <input type="file"  name="file"/>
        </p>
        <p>
            <span class="name-icon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            资&nbsp;源&nbsp;名：<input type="text" name="name" placeholder="请输入资源的名称">
        </p>
        <p>
            <span class="author-icon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            后&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;缀：<input type="text" name="suffix" placeholder="请输入文件后缀,如.pdf">
        </p>
        <p>
            <span class="desc-icon">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            资&nbsp;源&nbsp;&nbsp;描&nbsp;述：<input type="text" name="description">
        </p>

        <input type="button" class="submit-btn" id="resource-submit" value="提交"/>
    </form>
</div>

<dialog id="modal-dialog">
    <div id="modal-text"></div>
    <img class="modal-close-icon" src="<%=request.getContextPath()%>/img/close.png">
    <div  class="modal-close">
        <img src="<%=request.getContextPath()%>/img/success.png">
    </div>
</dialog>

<footer>
    <a href="#">©2020-2021 交大二手书交易平台</a>
    <a href="#">意见反馈&nbsp;&nbsp;&nbsp;联系我们&nbsp;&nbsp;&nbsp;隐私权声明&nbsp;&nbsp;&nbsp;使用条款</a>
</footer>
</body>
<script src="<%=request.getContextPath()%>/js/jquery-3.2.js"></script>
<script src="<%=request.getContextPath()%>/js/upload.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/session.js"></script>
<script>

    $("#resource-submit").click(function (event){
        var form = new FormData(document.getElementById("resourceForm"));
        for (var i = 0;i<resourceForm.length;i++){
            if (resourceForm[i].value.length == 0){
                alert("请将信息填写完整！");
                return false;
            }
        }

        $.ajax({
            type:"POST",
            url:"/resource/upload",
            async:false,
            data:form,
            cache: false,
            processData: false,
            contentType: false,
            success:function(result){
                alert("上传成功");
                window.location.href="/myBookshelf.do";
            },
            error:function(result){
                alert(result.message);
            },
        });

        /*// 显示模态窗口
        var modal = document.getElementById("modal-dialog");
        if (status == "1"){
            $("#modal-text").html("上传成功");
        }else {
            $("#modal-text").html("上传失败");
        }
        modal.showModal();*/
    });

</script>
</html>
