<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/7/7
  Time: 18:17
<%--
  Created by IntelliJ IDEA.
  User: 傻逼
  Date: 2020/7/7
  Time: 13:00
  To change this template use File | Settings | File Templates.

  <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>

--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>校园二手书交易平台后台管理系统——书籍管理</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/book.css">
</head>
<body>
<!-- 导航 -->
<header>
    <nav class="navbar">
        <div class="nav-info">
            <a href="#" class="username">${admin.getName()}</a>
            <%--            <a href="/myBookshelf.do" class="bookshelf">||&nbsp;&nbsp;&nbsp;我的书架</a>--%>
            <a href="#" class="logout">[ 退 出 ]</a>
        </div> <!-- nav-info -->
        <form action="searchBook.do" method="post">
            <div class="nav-search">
                <a href="/admin/goadminhome"><img class="logo" src="<%=request.getContextPath()%>/img/adminlogo.png"></a>
                <div class="search-form">
                    <input id="search-input" name="name" type="search" class="searchIn" placeholder="搜图书...">
                    <a href="#" class="search-logo">| &nbsp;<img src="<%=request.getContextPath()%>/img/search.png"></a>
                    <button type="submit" id="search-button" class="searchBtn">搜索</button>
                </div>
            </div><!--  nav-search -->
        </form>
        <ul class="menu">
            <li><a href="/admin/goadminhome">首页</a></li>
            <li><a href="/admin/goadminuser">用户管理</a></li>
            <li><a class="active" href="/admin/goadminbook">书籍管理</a></li>
            <li><a href="/admin/goadminresource">服务区管理</a></li>
        </ul>
    </nav>
    <div class="bookstore-pic"></div>
</header>
<!-- 图书分类 -->
<div id="container">
    <div id="book-menu">
        <ul class="book-class">
            <c:forEach items="${categories}" var="category">
                <li><a href="goBookStore.do?id=${category.key}">${category.value}</a></li>
            </c:forEach>
        </ul>
    </div>

    <%--    <div id="book-menu-toggle">--%>
    <%--        查 看 菜 单--%>
    <%--        <div id="toggle-btn"></div>--%>
    <%--    </div>--%>

    <div id="book-container">
        <h3 class="book-title"><a href="#">| ${categoryName}</a></h3>
        <ul class="book-lists">
            <c:forEach items="${books}" var="book" varStatus="bookStatus">
                <li class="book-list">
                    <a href="/books/${book.getId()}" class="book-pic" target="_blank">
                        <img src="<%=request.getContextPath()%>/img/book-list/article/${book.getBookImage().getId()}.jpg">
                    </a>
                    <a href="#" class="book-info">
                        <h5 class="book-name">${book.getName()}</h5>
                        <span class="book-detail">${book.getDescription()}</span>
                    </a>
                    <span class="book-price" bookId="${book.id}">￥${book.getPrice()}
						<a href="#" class="book-buy">删除书籍</a>
                </span>
                </li>
            </c:forEach>

        </ul><!--  book-list end -->
    </div> <!-- book-container end-->


    <span class="page-btn">
			<a href="?start=0" class="page-top">首页</a>
			<a href="?start=${page.getStart()-page.getCount()}" class="page-pre">上一页</a>
			<a href="?start=${page.getStart()+page.getCount()}" class="page-next">下一页</a>
			<a href="?start=${page.getEnd()}" class="page-end">尾页</a>
    </span>
</div><!-- container end-->

<footer>
    <a href="#">©2020-2021 交大二手书交易平台</a>
    <a href="#">意见反馈&nbsp;&nbsp;&nbsp;联系我们&nbsp;&nbsp;&nbsp;隐私权声明&nbsp;&nbsp;&nbsp;使用条款</a>
</footer>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/session.js"></script>
<script type="text/javascript">
    $(function(){
        //菜单特效
        var index = 0;
        $("#book-menu-toggle").on("click",function(){
            if (index ===0 ) {
                $("#book-menu").css("left","1px");
                $(this).css("left","178px");
                index =1;
            }else{
                $("#book-menu").css("left","-180px");
                $(this).css("left","1px");
                index=0;
            }
        });

        //点击菜单，对应类别颜色加深
        $(".book-class li").on("click",function(){
            //加粗当前点击的li
            $(this).css("font-weight","600").siblings("li").css("font-weight","500");
        });
    })

    //为了使用Book.css的风格，所以这个button设置名为book-price。实际上为删除的按钮
    $("span.book-price").on("click",function(){
        var $this = $(this);
        var Mydata="id="+$this.attr("bookId");
        $.ajax({
            type:"POST",
            url:"/admin/goadminbook",
            data:Mydata,
            success:function(result){
                alert("删除成功");
                window.location.href="/admin/goadminbook";
            },
            error:function(result){
                alert(result.message);
            },
        });
    });

</script>
</body>
</html>

