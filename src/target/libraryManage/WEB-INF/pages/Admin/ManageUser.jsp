<%--
  Created by IntelliJ IDEA.
  User: cleve
  Date: 2019/7/29
  Time: 13:19
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
        .modal-backdrop{z-index:0;}
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
                <div class="col-md-10" style="float: left;">
                    <div class="list-group">
                        <table class="table table-striped table-hover table-bordered">
                            <thead>
                            <tr>
                                <th>用户号</th>
                                <th>用户名</th>
                                <th>性别</th>
                                <th>邮箱</th>
                                <th>联系方式</th>
                                <th>用户类型</th>
                                <th>用户积分</th>
                                <th>可借阅数量</th>
                                <th>创建时间</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach items="${userList}" var="user" varStatus="status">
                                <tr>
                                    <td>${user.userID}</td>
                                    <td>${user.userName}</td>
                                    <td>
                                        <c:if test="${user.userSex==0}">女</c:if>
                                        <c:if test="${user.userSex==1}">男</c:if>
                                    </td>
                                    <td>${user.userEmail}</td>
                                    <td>${user.userPhone}</td>
                                    <td>
                                        <c:if test="${user.userRole==1}">普通用户</c:if>
                                        <c:if test="${user.userRole==2}">管理员</c:if>
                                    </td>
                                    <td>${user.userCredit}</td>
                                    <td>${user.userBorrowNum}</td>
                                    <td>${user.createTime}</td>
                                </tr>
                            </c:forEach>
                            </tbody>

                        </table>
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