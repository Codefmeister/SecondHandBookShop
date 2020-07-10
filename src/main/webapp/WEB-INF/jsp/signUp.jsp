<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" import="java.util.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>新用户注册</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/signUp.css">
</head>
<body>
<div class="box">
    <h2>交大校园二手书交易平台</h2>
    <form>
        <div class="inputbox">
            <input type="text" id="studentid" placeholder="学号">
        </div>
        <div class="inputbox">
            <input type="password" id="password" placeholder="密码">
        </div>
        <div class="inputbox">
            <input type="text" id="name" placeholder="姓名">
        </div>

        <!--
            <div class="inputbox">
               性别: <input type="radio" name="sex" id="s_man" value="m">男
               <input type="radio" name="sex" id="s_woman" value="f">女
            </div>

           <p>性别</p> </br>
        <select id="category" name="sex" class="select">
            <option value="m">男</option>
            <option value="f">女</option>
        </select>

        -->
        <div class="inputbox">
            <input type="text" id="sex" placeholder="性别：男 请输入m或f。m代表男性，f代表女性">
        </div>

        <div class="inputbox">
            <input type="text" id="tel" placeholder="电话">
        </div>
        <div class="inputbox">
            <input type="text" id="address" placeholder="地址">
        </div>
        <div class="inputbox">
            <input type="text" id="major" placeholder="专业">
        </div>
        <input type="submit" id="sign-button" style="align-content: center" value="注册">
    </form>
</div>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.2.js"></script>
<script type="text/javascript">

    $(function() {
        $('#sign-button').click(function (event) {
            $('#errorInfo').html("");
            var studentid_ = $('#studentid').val();
            var password_ = $('#password').val();
            var name_ = $('#name').val();
            var sex_ = $('#sex').val();
            var tel_ = $('#tel').val();
            var address_ = $('#address').val();
            var major_ = $('#major').val();

            if (studentid_.length == 0 || password_.length == 0) {
                $('#errorInfo').html("学号或密码不能为空！");

                return false;
            }
            if (name_.length == 0) {
                $('#errorInfo').html("姓名不能为空！");
                return false;
            }
            if (sex_.length == 0) {
                $('#errorInfo').html("性别不能为空！");
                return false;
            }

            if (tel_.length == 0) {
                $('#errorInfo').html("联系电话不能为空！");
                return false;
            }
            if (address_.length == 0) {
                $('#errorInfo').html("住址不能为空！");
                return false;
            }
            if (major_.length == 0) {
                $('#errorInfo').html("年级专业不能为空！");
                return false;
            }

            var newUser_ = {"studentid": studentid_, "password": password_,
                "name": name_, "sex": sex_, "tel": tel_,
                "address": address_, "major": major_};

            var jsonData = JSON.stringify(newUser_);
            $.ajax({
                type: "POST",
                url: "/users/signUp",
                async: false,
                dataType: "json",
                contentType: "application/json;charset=UTF-8",
                data: jsonData,
                success: function (result) {
                    if (result.resultCode == 200) {
                        event.preventDefault();
                        location.href = "/home.do";
                    } else {
                        alert(result.message);
                        event.preventDefault();
                        $('#errorInfo').html(result.message);
                    }
                }
            });
        });
    })
</script>

</body>
</html>
