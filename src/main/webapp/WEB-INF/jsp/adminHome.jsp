<%--
  Created by IntelliJ IDEA.
  User: 健浩
  Date: 2020/7/7
  Time: 8:55
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>校园二手书交易平台后台管理系统</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/home.css">
</head>
<body>
<!-- 导航 -->
<nav class="navbar">
    <div class="nav-info">
        <a href="/admin/goadminhome" class="adminname">${admin.getName()}</a>
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
        <li><a class="active" href="/admin/goadminhome">首页</a></li>
        <li><a href="/admin/goadminuser">用户管理</a></li>
        <li><a href="/admin/goadminbook">书籍管理</a></li>
        <li><a href="/admin/goadminresource">资源管理</a></li>
        <%--        <li><a href="#">服务区</a></li>--%>
    </ul>
</nav>

<!-- 轮播 -->
<div class="carousel">
    <div class="book-guide">
        <h4>图书导航</h4>
        <ul class="book-class">
            <c:forEach items="${categories}" var="category">
                <li><a href="#book-part-${category.key}" title="book-part-${category.key}">${category.value}</a></li>
            </c:forEach>
        </ul>
    </div><!-- book-guide -->
    <%--    <div class="slider">--%>
    <%--        <div class="slider-img">--%>
    <%--            <ul class="slider-img-ul">--%>
    <%--                <li><img src="<%=request.getContextPath()%>/img/carousel/5.jpg"></li>--%>
    <%--                <li><img src="<%=request.getContextPath()%>/img/carousel/1.jpg"></li>--%>
    <%--                <li><img src="<%=request.getContextPath()%>/img/carousel/2.jpg"></li>--%>
    <%--                <li><img src="<%=request.getContextPath()%>/img/carousel/3.jpg"></li>--%>
    <%--                <li><img src="<%=request.getContextPath()%>/img/carousel/4.jpg"></li>--%>
    <%--                <li><img src="<%=request.getContextPath()%>/img/carousel/5.jpg"></li>--%>
    <%--                <li><img src="<%=request.getContextPath()%>/img/carousel/1.jpg"></li>--%>
    <%--            </ul>--%>
    <%--        </div>--%>
    <%--    </div><!-- 	slider -->--%>
</div><!-- carousel -->

<!-- 图书分类 -->
<div id="container">

    <c:forEach items="${booksMap}" var="books" varStatus="booksStatus">
        <div class="book-part" id="book-part-${books.value.get(0).getCategory().getId()}">
            <h3 class="book-title"><a href="#">| ${books.key.getName()}</a></h3>
            <a class="more" href="goBookStore.do?id=${books.value.get(0).getCategory().getId()}"> > > 更多</a>
            <ul class="book-lists">
                <c:forEach items="${books.value}" var="book" varStatus="bookStatus">
                    <li class="book-list">
                            <%--<a href="bookDetail.do?id=${book.getId()}" class="book-pic" target="_blank">--%>
                        <a href="/books/${book.getId()}" class="book-pic" target="_blank">
                            <img src="<%=request.getContextPath()%>/img/book-list/article/${book.getBookImage().getId()}.jpg">
                        </a>
                        <a href="#" class="book-info">
                            <h5 class="book-name">${book.getName()}</h5>
                            <span class="book-detail">${book.getDescription()}</span>
                        </a>
                        <span class="book-price">￥${book.getPrice()}
                            <a href="#" class="book-buy">立即下单</a>
                        </span>
                    </li>
                </c:forEach>
            </ul><!--  book-list end -->
        </div><!--  book-part end -->
    </c:forEach>
</div> <!-- container end-->





<footer>
    <a href="#">©2020-2021 交大二手书交易平台</a>
    <a href="#">意见反馈&nbsp;&nbsp;&nbsp;联系我们&nbsp;&nbsp;&nbsp;隐私权声明&nbsp;&nbsp;&nbsp;使用条款</a>
</footer>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/xSlider.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/session.js"></script>
<script type="text/javascript">
    $(function(){

        /*$('#search-button').click(function (event) {
            var keyword = $('#search-input').val();
            var book_ = {"name":keyword};
            var jsonData = JSON.stringify(book_);
            var flag = "";
            $.ajax({
                type:"POST",
                url:"searchBook.do",
                async:false,
                dataType:"json",
                contentType:"application/json;charset=UTF-8",
                data:jsonData,
                success:function (msg) {
                    flag = msg;
                }
            });

        });*/

        $(".book-class li a").on("click",function(){
            var classId = $(this).prop("title");
            console.log(classId);
            var classTop =  $("#container").find(("#"+classId)).offset().top;
            $("html,body").animate({scrollTop:classTop+ "px"}, 500);
        });
    })
</script>

</body>
</html>


