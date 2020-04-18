<%--
  Created by IntelliJ IDEA.
  User: cleve
  Date: 2019/7/22
  Time: 17:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="../../static/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../static/css/material-icons.css">
    <link rel="stylesheet" href="../../static/css/material.min.css">
    <script type="text/javascript" src="../../static/js/material.min.js"></script>
    <script type="text/javascript" src="../../static/js/jquery-3.1.1.min.js"></script>

    <title>Library</title>
    <style>
        .center {
            margin-left: auto;
            margin-right: auto;
        }
        .modal-backdrop{z-index:0;}
    </style>
</head>
<body>
<div class="mdl-layout mdl-js-layout">
    <header class="mdl-layout__header mdl-layout__header--scroll mdl-color--grey-200">
        <div class="mdl-layout__header-row">
            <!-- Title -->
            <a class="mdl-layout-title mdl-navigation__link mdl-color-text--pink-400" href="/main">Library</a>
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
            <!-- 主体 -->
            <div class="mdl-grid">
                <div class="mdl-cell mdl-cell--12-col center">
                    <div class="col-md-4" style="float: left;">
                        <img src="../../static/img/book.png" class="img-thumbnail" style="width: 600px;height: 600px" >
                    </div>

                    <div class="col-md-8" style="float: left;">
                        <p class="text-info">书名：《${book.bookName}》</p>
                        <p class="text-info">作者：${book.bookAuthor}</p>
                        <p class="text-info">出版社：${book.bookPublish}</p>
                        <p class="text-info">价格：${book.bookPrice}</p>
                        <p class="text-info">数量：${book.bookNum}</p>
                        <p class="text-info">借阅次数：${book.bookBorrowTimes}</p>
                        <p class="text-info">简介：${book.bookInfo}</p>
                        <br><br><br><br>

                        <c:choose>
                            <c:when test="${user.userName != null}">
                            <!-- 按钮触发模态框 -->
                                <button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">借阅此书</button>
                            </c:when>
                        </c:choose>

                        <!-- 模态框（Modal） -->
                        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title" id="myModalLabel">借阅信息表</h4>
                                    </div>
                                    <div class="modal-body">
                                        <form class="form-group" action="/log/borrowBook" method="post">
                                            <div class="form-group">
                                                <label>用户</label>
                                                <input name="userID" class="form-control" type="text"
                                                       placeholder="${user.userName}" value="${user.userID}" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label>借阅书籍</label>
                                                <input name="bookID" class="form-control" type="text"
                                                       placeholder="《${book.bookName}》" value="${book.bookID}" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label>借阅时长</label>
                                                <input type="radio" class="mdl-radio__button" name="borrowLong"
                                                       value="1"
                                                       checked>
                                                <span class="mdl-radio__label">1天</span>
                                                <input type="radio" class="mdl-radio__button" name="borrowLong"
                                                       value="7">
                                                <span class="mdl-radio__label">7天</span>
                                                <input type="radio" class="mdl-radio__button" name="borrowLong"
                                                       value="10">
                                                <span class="mdl-radio__label">10天</span>
                                                <input type="radio" class="mdl-radio__button" name="borrowLong"
                                                       value="20">
                                                <span class="mdl-radio__label">20天</span>
                                                <input type="radio" class="mdl-radio__button" name="borrowLong"
                                                       value="30">
                                                <span class="mdl-radio__label">30天</span>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                                <button type="submit" class="btn btn-primary">提交借阅</button>
                                            </div>
                                        </form>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal -->
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