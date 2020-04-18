<%--
  Created by IntelliJ IDEA.
  User: cleve
  Date: 2019/7/5
  Time: 17:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Library</title>

    <link rel="stylesheet" href="../static/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../static/css/material-icons.css">
    <link rel="stylesheet" href="../static/css/material.min.css">
    <script type="text/javascript" src="../static/js/material.min.js"></script>
    <script type="text/javascript" src="../static/js/jquery-3.1.1.min.js"></script>

    <style>
        .center {
            margin-left: auto;
            margin-right: auto;
        }
        .button {
            margin-top: 75px;
            margin-bottom: 75px;
        }
    </style>
</head>
<body>
<div class="mdl-layout mdl-js-layout">
    <header class="mdl-layout__header mdl-layout__header--scroll mdl-color--grey-200">
        <div class="mdl-layout__header-row">
            <!-- Title -->
            <a class="mdl-layout-title mdl-navigation__link mdl-color-text--pink-400" href="/index">Library</a>
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
                            <a class="mdl-navigation__link mdl-color-text--black" href="/admin/manageCenter">登入管理后台</a>
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
            <!-- 主体1 -->
            <div class="mdl-grid">
                <div class="mdl-cell mdl-cell--12-col center">
                    <div align="center">
                        <img  src="../static/img/home-first.png" align="center">
                    </div>
                </div>
            </div>
            <!-- 主体2 -->
            <div class="mdl-grid">
                <div class="mdl-cell--12-col center">
                    <div align="center">
                        <a href="/main" class="mdl-button mdl-js-button mdl-button--raised mdl-color-text--white mdl-color--pink-400 button">
                            Go in !
                        </a>
                    </div>
                </div>
            </div>
            <!-- 主页底部信息 -->
            <footer class="mdl-mini-footer">
                <div class="mdl-mini-footer__left-section center" align="center">
                    <div class="mdl-logo">Welcome   To   Everybody   Library</div>
                </div>
            </footer>
        </div>
    </main>
</div>

<script src="../static/bootstrap/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
<script src="../static/bootstrap/popper.min.js" crossorigin="anonymous"></script>
<script src="../static/bootstrap/js/bootstrap.min.js" crossorigin="anonymous"></script>

</body>
</html>
