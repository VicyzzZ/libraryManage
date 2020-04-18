<%--
  Created by IntelliJ IDEA.
  User: cleve
  Date: 2019/7/27
  Time: 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="../../static/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../static/css/material-icons.css">
    <link rel="stylesheet" href="../../static/css/material.min.css">
    <script type="text/javascript" src="../../static/js/material.min.js"></script>
    <script type="text/javascript" src="../../static/js/jquery-3.1.1.min.js"></script>

    <title>图书管管理</title>
    <style>
        .center {
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>
<body>
<!-- 导航栏 -->
<!-- Always shows a header, even in smaller screens. -->
<div class="mdl-layout mdl-js-layout">
    <header class="mdl-layout__header mdl-layout__header--scroll mdl-color--grey-200">
        <div class="mdl-layout__header-row">
            <!-- Title -->
            <a class="mdl-layout-title mdl-navigation__link mdl-color-text--pink-400" href="/admin/manageCenter">Library</a>
            <!-- Add spacer, to align navigation to the right -->
            <div class="mdl-layout-spacer"></div>
            <!-- Navigation. We hide it in small screens. -->
            <nav class="mdl-navigation">
                <c:choose>
                    <c:when test="${user.userName != null}">
                        <a class="mdl-layout-title mdl-navigation__link mdl-color-text--red-900 dropdown-toggle" data-toggle="dropdown">
                                ${user.userName}<b class="caret"></b></a>
                        <ul class="dropdown-menu text-sm-center">
                            <li><a href="/user/userInfo?userID=${user.userID}">个人资料</a></li>
                            <li><a href="/log/borrowLog?userID=${user.userID}">借阅记录</a></li>
                            <li><a href="/log/unReturnLog?userID=${user.userID}">未还记录</a></li>
                            <li><a href="/log/ReturnLog?userID=${user.userID}">已还记录</a></li>
                            <li><a href="/log/overLog?userID=${user.userID}">逾期记录</a></li>

                            <li class="dropdown-divider"></li>
                            <li><a href="/user/loginOut">注销</a></li>
                        </ul>
                        <c:if test="${user.userRole == 2}">
                            <a class="mdl-navigation__link mdl-color-text--black" href="/main">退出管理后台</a>
                        </c:if>
                    </c:when>
                    <c:when test="${user.userName == null}">
                        <a class="mdl-navigation__link mdl-color-text--pink-400" href="/userLogin">登录</a>
                        <a class="mdl-navigation__link mdl-color-text--pink-400" href="/userRegister">注册</a>
                    </c:when>
                </c:choose>
            </nav>
        </div>
    </header>
    <!-- 页面主体 -->
    <main class="mdl-layout__content">
        <div class="page-content">
            <!-- Your content goes here -->
            <!-- 页面主体内容 -->
            <div class="mdl-grid">
                <div class="mdl-cell mdl-cell--3-col">
                    <div class="mdl-card mdl-shadow--2dp mdl-color--amber-400 center">
                        <div class="mdl-card__title mdl-card--expand">
                            <h4 class="mdl-color-text--white center">分类管理</h4>
                        </div>
                        <div class="mdl-card__actions mdl-card--border" align="center">
                            <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect mdl-color-text--white"
                               href="/admin/manageCategory">查看</a>
                            <div class="mdl-layout-spacer"></div>
                        </div>
                    </div>
                </div>
                <div class="mdl-cell mdl-cell--3-col">
                    <!-- 书籍管理卡片 -->
                    <div class="mdl-card mdl-shadow--2dp center mdl-color--green-400">
                        <div class="mdl-card__title mdl-card--expand">
                            <h4 class="mdl-color-text--white center">书籍管理</h4>
                        </div>
                        <div class="mdl-card__actions mdl-card--border" align="center">
                            <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect mdl-color-text--white"
                               href="/admin/manageBook">查看</a>
                            <div class="mdl-layout-spacer"></div>
                        </div>
                    </div>
                </div>
                <div class="mdl-cell mdl-cell--3-col">
                    <!-- 用户管理卡片 -->
                    <div class="mdl-card mdl-shadow--2dp center mdl-color--blue-400">
                        <div class="mdl-card__title mdl-card--expand">
                            <h4 class="mdl-color-text--white center">用户管理</h4>
                        </div>
                        <div class="mdl-card__actions mdl-card--border" align="center">
                            <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect mdl-color-text--white"
                               href="/admin/manageUser">查看</a>
                            <div class="mdl-layout-spacer"></div>
                        </div>
                    </div>
                </div>
                <div class="mdl-cell mdl-cell--3-col">
                    <!-- 借书记录卡片 -->
                    <div class="mdl-card mdl-shadow--2dp center mdl-color--cyan-400">
                        <div class="mdl-card__title mdl-card--expand">
                            <h4 class="mdl-color-text--white center">借书记录</h4>
                        </div>
                        <div class="mdl-card__actions mdl-card--border" align="center">
                            <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect mdl-color-text--white"
                               href="/admin/manageLog">查看</a>
                            <div class="mdl-layout-spacer"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<script src="../../static/bootstrap/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
<script src="../../static/bootstrap/popper.min.js" crossorigin="anonymous"></script>
<script src="../../static/bootstrap/js/bootstrap.min.js" crossorigin="anonymous"></script>
</body>
</html>