<%--
  Created by IntelliJ IDEA.
  User: cleve
  Date: 2019/7/20
  Time: 13:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="../../static/bootstrap/css/bootstrap.min.css">

    <title>Library - 注册</title>
</head>
<body>
<%-- 注册页面导航栏 --%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand text-white ml-lg-5" href="/index">
        Library
    </a>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <%-- 导航栏操作项目 --%>
    <div class="collapse navbar-collapse mr-lg-5 justify-content-end" id="navbarNav">
        <ul class="navbar-nav">
            <c:choose>
                <c:when test="${user.userName == null}">
                    <li class="nav-item">
                        <a class="nav-link" href="/userLogin">登录</a>
                    </li>
                </c:when>
            </c:choose>
        </ul>
    </div>
</nav>

<%-- 注册部分 --%>
<div class="container mt-lg-5">
    <div class="row">
        <div class="col-3"></div>
        <div class="col-6">
            <form action="/user/register" method="post">
                <div class="form-group">
                    <label for="userName">用户名</label>
                    <input type="text" class="form-control" id="userName" name="userName" required="required"
                           aria-describedby="userNameHelp" placeholder="输入用户名">
                </div>
                <div class="form-group">
                    <label for="password">密码</label>
                    <input type="password" class="form-control" id="password" required="required" name="password"
                           placeholder="输入密码">
                </div>
                <div class="form-group">
                    <label for="sex-1">性别</label>
                    <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="sex-1">
                        <input type="radio" id="sex-1" class="mdl-radio__button" name="userSex"
                               value="1"
                               checked>
                        <span class="mdl-radio__label">男</span>
                    </label>
                    <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="sex-2">
                        <input type="radio" id="sex-2" class="mdl-radio__button" name="userSex"
                               value="0">
                        <span class="mdl-radio__label">女</span>
                    </label>
                </div>
                <div class="form-group">
                    <label for="email">邮箱</label>
                    <input type="email" class="form-control" id="email" name="userEmail" placeholder="输入邮箱">
                </div>
                <div class="form-group">
                    <label for="phone">联系方式</label>
                    <input type="text" class="form-control" id="phone" name="userPhone" placeholder="输入联系方式">
                </div>
                <button type="submit" class="btn btn-primary">注册</button>
                <a href="/userLogin" class="btn btn-secondary ml-3">登录</a>
            </form>
        </div>
        <div class="col-3"></div>
    </div>

    <script src="../../static/bootstrap/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
    <script src="../../static/bootstrap/popper.min.js" crossorigin="anonymous"></script>
    <script src="../../static/bootstrap/js/bootstrap.min.js" crossorigin="anonymous"></script>
</div>
</body>
</html>
