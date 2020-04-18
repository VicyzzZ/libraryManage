<%--
  Created by IntelliJ IDEA.
  User: cleve
  Date: 2019/7/30
  Time: 13:06
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
            <a class="mdl-layout-title mdl-navigation__link mdl-color-text--pink-400" href="/admin/manageLog">Library</a>
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
            <!-- 主体 -->
            <div class="mdl-grid">
                <div class="mdl-cell mdl-cell--12-col center">


                    <div class="col-md-10" style="float: left;">
                        <div class="list-group">
                            <table class="table table-striped table-hover table-bordered">
                                <thead>
                                <tr>
                                    <th>借阅ID</th>
                                    <th>用户名</th>
                                    <th>书名</th>
                                    <th>借阅时间</th>
                                    <th>借阅时长</th>
                                    <c:if test="${Return==1}">
                                        <th>还书时间</th>
                                    </c:if>
                                    <th>状态</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach items="${logList}" var="log" varStatus="status">
                                    <tr>
                                        <td>${log.logID}</td>
                                        <c:forEach items="${userList}" var="user" varStatus="status">
                                            <c:if test="${user.userID==log.userID}">
                                                <td>${user.userName}</td>
                                            </c:if>
                                        </c:forEach>

                                        <c:forEach items="${bookList}" var="book" varStatus="status">
                                            <c:if test="${book.bookID==log.bookID}">
                                                <td><a class="mdl-navigation__link mdl-color-text--pink-400" href="/book/bookInfo?bookID=${book.bookID}">《${book.bookName}》</a></td>
                                            </c:if>
                                        </c:forEach>

                                        <td>${log.borrowTime}</td>
                                        <td>${log.borrowLong}天</td>
                                        <c:if test="${log.returnTime!=null}">
                                            <td>${log.returnTime}</td>
                                        </c:if>
                                        <td>
                                            <c:if test="${log.state==0}">
                                                未还书 未罚款
                                            </c:if>
                                            <c:if test="${log.state==1}">
                                                未还书 已罚款
                                            </c:if>
                                            <c:if test="${log.state==2}">
                                                已还书 未罚款
                                            </c:if>
                                            <c:if test="${log.state==3}">
                                                已还书 已罚款
                                            </c:if>
                                        </td>
                                        <c:if test="${over==1}">
                                            <c:forEach items="${bookList}" var="book" varStatus="status">
                                                <c:if test="${book.bookID==log.bookID}">
                                                    <td> <a class="btn btn-primary btn-lg" data-toggle="modal" data-target="#chargeModal" onclick='Values("${book.bookPrice}")'>罚款</a></td>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </tr>
                                    <!-- 模态框（Modal） -->
                                    <div class="modal fade" id="chargeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                    <h4 class="modal-title"  style="text-align: center">罚款</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <form class="form-group" action="/admin/charge">
                                                        <div class="form-group">
                                                            <input type="text" class="form-control"  name="logID" value="${log.logID}"
                                                                   aria-describedby="logIDHelp" hidden="hidden">
                                                        </div>
                                                        <div class="form-group">
                                                            <input type='text' onkeyup="value=value.replace(/^(0+)|[^\d]+/g,'')"class="form-control"  name="credit" id="credit"
                                                                   aria-describedby="creditHelp" value="" readonly>
                                                        </div>
                                                        <p>
                                                            *由于未按约定时间还书，按书籍原价罚款。
                                                        </p>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                                            <button type="submit" class="btn btn-primary">确定</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div><!-- /.modal-content -->
                                        </div><!-- /.modal -->
                                    </div>
                                </c:forEach>
                                </tbody>
                            </table>
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
<!-- js -->
<script>
    $('#chargeModal').modal("hide");
    function Values(bookPrice){
        $('#credit').val(bookPrice);
    }

</script>
</body>
</html>
