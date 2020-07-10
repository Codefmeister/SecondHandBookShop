<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>交大二手书交易平台管理端</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reset.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/Newlogin.css">
</head>
<body>
<div class="box">
    <h2>交大二手书交易平台管理端</h2>
    <form>
        <div class="inputbox">
            <input type="text" id="adminid" placeholder="管理员用户名">
        </div>
        <div class="inputbox">
            <input type="password" id="password" placeholder="管理员密码">
        </div>
        <input type="submit" id="login-button" style="align-content: center" value="登录">
    </form>
</div>


<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.2.js"></script>
<script type="text/javascript">

    $(function() {
        $('#login-button').click(function (event) {
            $('#errorInfo').html("");
            var adminid_ = $('#adminid').val();
            var password_ = $('#password').val();
            if (adminid_.length == 0 || password_.length == 0) {
                alert("用户名或密码不能为空！");
                return false;
            }

            var admin_ = {"adminid": adminid_, "password": password_};
            var jsonData = JSON.stringify(admin_);
            $.ajax({
                type: "POST",
                url: "/admin/sessions",
                async: false,
                dataType: "json",
                contentType: "application/json;charset=UTF-8",
                data: jsonData,
                success: function (result) {
                    if (result.resultCode == 200) {
                        event.preventDefault();
                        location.href = "/admin";
                    } else {
                        alert(result.message);
                    }


                }
            });
        });
    })
</script>
</body>
</html>
