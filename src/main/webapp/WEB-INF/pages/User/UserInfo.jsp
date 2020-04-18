<%--
  Created by IntelliJ IDEA.
  User: cleve
  Date: 2019/7/20
  Time: 14:06
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
    <header class="mdl-layout__header mdl-layout__header--scroll mdl-color--grey-100">
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
                    <div class="col-md-2" style="float: left;">
                        <img src="../../static/img/${user.userSex}.png" class="img-thumbnail" style="width: 200px;height: 200px" >
                    </div>

                    <div class="col-md-10" style="float: left;">
                        <p class="text-info">用户名：${user.userName}</p>
                        <p class="text-info">性别：
                            <c:if test="${user.userSex==1}">男</c:if>
                            <c:if test="${user.userSex==0}">女</c:if>
                        </p>
                        <p class="text-info">邮箱：${user.userEmail}</p>
                        <p class="text-info">联系电话：${user.userPhone}</p>
                        <p class="text-info">用户类型：
                            <c:if test="${user.userRole==1}">普通用户</c:if>
                            <c:if test="${user.userRole==2}">管理员</c:if>
                        </p>
                        <p class="text-info">用户积分：${user.userCredit}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#rechargeModal">充值</button></p>
                        <p class="text-info">剩余借书：${user.userBorrowNum}</p>
                        <p class="text-info">注册时间：${user.createTime}</p>
                        <br><br><br><br>

                        <!-- 模态框（Modal） -->
                        <div class="modal fade" id="rechargeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                        <h4 class="modal-title"  style="text-align: center">充值</h4>
                                    </div>
                                    <div class="modal-body">
                                        <form class="form-group" action="/user/recharge" method="post">
                                            <div class="form-group">
                                                <input type="text" class="form-control"  name="userID" value="${user.userID}"
                                                       aria-describedby="userIDHelp" hidden="hidden">
                                            </div>
                                            <div class="form-group">
                                                <input type='text' onkeyup="value=value.replace(/^(0+)|[^\d]+/g,'')"class="form-control"  name="userCredit" placeholder="请输入充值金额"
                                                       aria-describedby="userIDHelp">
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                                <button type="submit" class="btn btn-primary">确定充值</button>
                                            </div>
                                        </form>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal -->
                        </div>

                        <c:choose>
                            <c:when test="${user.userName != null}">
                                <!-- 按钮触发模态框 -->
                                <button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">编辑我的资料</button>
                            </c:when>
                        </c:choose>

                        <!-- 模态框（Modal） -->
                        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title" id="myModalLabel" style="text-align: center">个人资料</h4>
                                    </div>
                                    <div class="modal-body">
                                        <form class="form-group" action="/user/updateUserInfo" method="post">
                                            <div class="form-group">
                                                <input type="text" class="form-control" id="userID" name="userID" value="${user.userID}"
                                                       aria-describedby="userIDHelp" hidden="hidden">
                                            </div>
                                            <div class="form-group">
                                                <label for="userName">用户名</label>
                                                <input type="text" class="form-control" id="userName" name="userName" value="${user.userName}"
                                                       aria-describedby="userNameHelp" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="sex-1">性别</label><br>
                                                <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="sex-1">
                                                    <input type="radio" id="sex-1" class="mdl-radio__button" name="userSex" value="1"
                                                           <c:if test="${user.userSex==1}">checked</c:if>
                                                           >
                                                    <span class="mdl-radio__label">男</span>
                                                </label>
                                                <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="sex-2">
                                                    <input type="radio" id="sex-2" class="mdl-radio__button" name="userSex" value="0"
                                                           <c:if test="${user.userSex==0}">checked</c:if>>
                                                    <span class="mdl-radio__label">女</span>
                                                </label>
                                            </div>
                                            <div class="form-group">
                                                <label for="email">邮箱</label>
                                                <input type="email" class="form-control" id="email" name="userEmail" value="${user.userEmail}">
                                            </div>
                                            <div class="form-group">
                                                <label for="phone">联系方式</label>
                                                <input type="text" class="form-control" id="phone" name="userPhone" value="${user.userPhone}">
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                                <button type="submit" class="btn btn-primary">提交修改</button>
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
