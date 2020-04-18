<%--
  Created by IntelliJ IDEA.
  User: cleve
  Date: 2019/7/29
  Time: 13:18
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
                <c:forEach items="${bookList}" var="book" varStatus="status">
                <div class="mdl-cell mdl-cell--4-col">
                    <div class="mdl-card mdl-shadow--2dp center mdl-color--green-400">
                        <div class="mdl-card__title mdl-card--expand">
                            <a href="/book/bookInfo?bookID=${book.bookID}"><h4 class="mdl-color-text--white center">《${book.bookName}》</h4></a>
                            <c:forEach items="${categoryList}" var="category" varStatus="status">
                                <c:if test="${book.bookCategoryID==category.categoryID}">
                                    <p class="mdl-color-text--white center">分类：${category.categoryName}</p>
                                </c:if>
                            </c:forEach>
                        </div>
                        <div class="mdl-card__actions mdl-card--border" align="center">
                            <button class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect mdl-color-text--white"
                                    data-toggle="modal" data-target="#UpdateModal"
                                    onclick='Values("${book.bookID}","${book.bookName}","${book.bookInfo}","${book.bookAuthor}",
                                            "${book.bookPublish}","${book.bookPrice}","${book.bookNum}",)'>修改</button>
                            <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect mdl-color-text--white"
                               href="/admin/deleteBook?bookID=${book.bookID}">下架</a>
                            <div class="mdl-layout-spacer"></div>
                        </div>
                    </div>
                </div>
                </c:forEach>

                <div class="mdl-cell mdl-cell--4-col">
                    <div class="mdl-card mdl-shadow--2dp mdl-color--green-400 center">
                        <div class="mdl-card__title mdl-card--expand">
                            <img alt="添加" src="../../static/img/add.png" style="width: 298px;height: 115px"
                                 data-toggle="modal" data-target="#AddModal">
                        </div>
                        <div class="mdl-card__actions mdl-card--border" align="center">
                            <button class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect mdl-color-text--white"
                                    data-toggle="modal" data-target="#AddModal">新书上架</button>
                            <div class="mdl-layout-spacer"></div>
                        </div>
                    </div>
                </div>
                <!-- 模态框（AddModal） -->
                <div class="modal fade" id="AddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                <h4 class="modal-title"  style="text-align: center">添加书籍</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form-group" action="/admin/addBook" method="post">
                                    <div class="form-group">
                                        <label for="bookID">书号</label>
                                        <input type="text" class="form-control" name="bookID" required="required"
                                               aria-describedby="bookIDHelp" placeholder="输入书号">
                                    </div>
                                    <div class="form-group">
                                        <label for="bookName">书名</label>
                                        <input type="text" class="form-control"  name="bookName" required="required"
                                               aria-describedby="bookNameHelp" placeholder="输入书名">
                                    </div>
                                    <div class="form-group">
                                        <label for="bookAuthor">作者</label>
                                        <input type="text" class="form-control"  name="bookAuthor" required="required"
                                               aria-describedby="bookAuthorHelp" placeholder="输入作者">
                                    </div>
                                    <div class="form-group">
                                        <label for="bookPublish">出版社</label>
                                        <input type="text" class="form-control"  name="bookPublish" required="required"
                                               placeholder="输入出版社">
                                    </div>
                                    <div class="form-group">
                                        <label for="bookPrice">价格</label>
                                        <input type="text" class="form-control"  name="bookPrice" required="required"
                                               placeholder="输入价格">
                                    </div>
                                    <div class="form-group">
                                        <label for="bookNum">数量</label>
                                        <input type="text" class="form-control" name="bookNum" required="required"
                                               placeholder="输入数量">
                                    </div>
                                    <div class="form-group">
                                        <label for="bookCategoryID">选择分类</label>
                                        <select class="form-control"  name="bookCategoryID">
                                            <c:forEach items="${categoryList}" var="category" varStatus="status">
                                                <option value="${category.categoryID}">${category.categoryName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="bookInfo">简介</label>
                                        <textarea class="form-control" rows="3" name="bookInfo" placeholder="..."></textarea>
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                        <button type="submit" class="btn btn-primary">确定</button>
                                    </div>
                                </form>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal -->
                </div>

                <!-- 模态框（UpdateModal） -->
                <div class="modal fade" id="UpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                <h4 class="modal-title"  style="text-align: center">修改书籍</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form-group" action="/admin/updateBook" method="post">
                                    <div class="form-group">
                                        <label for="bookID">书号</label>
                                        <input type="text" class="form-control" id="bookID" name="bookID" required="required"
                                               aria-describedby="bookIDHelp" value="" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label for="bookName">书名</label>
                                        <input type="text" class="form-control" id="bookName" name="bookName" required="required"
                                               aria-describedby="bookNameHelp" value="">
                                    </div>
                                    <div class="form-group">
                                        <label for="bookAuthor">作者</label>
                                        <input type="text" class="form-control" id="bookAuthor" name="bookAuthor" required="required"
                                               aria-describedby="bookAuthorHelp" value="">
                                    </div>
                                    <div class="form-group">
                                        <label for="bookPublish">出版社</label>
                                        <input type="text" class="form-control" id="bookPublish" name="bookPublish" required="required"
                                               value="">
                                    </div>
                                    <div class="form-group">
                                        <label for="bookPrice">价格</label>
                                        <input type="text" class="form-control" id="bookPrice" name="bookPrice" required="required"
                                               value="">
                                    </div>
                                    <div class="form-group">
                                        <label for="bookNum">数量</label>
                                        <input type="text" class="form-control" id="bookNum" name="bookNum" required="required"
                                               value="">
                                    </div>
                                    <div class="form-group">
                                        <label for="bookCategoryID">选择分类</label>
                                        <select class="form-control" id="bookCategoryID" name="bookCategoryID">
                                            <c:forEach items="${categoryList}" var="category" varStatus="status">
                                                <option value="${category.categoryID}">${category.categoryName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="bookInfo">简介</label>
                                        <textarea class="form-control" rows="3" id="bookInfo" name="bookInfo" value=""></textarea>
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                        <button type="submit" class="btn btn-primary">确定</button>
                                    </div>
                                </form>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal -->
                </div>

            </div>
        </div>
    </main>
</div>

<script src="../../static/bootstrap/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
<script src="../../static/bootstrap/popper.min.js" crossorigin="anonymous"></script>
<script src="../../static/bootstrap/js/bootstrap.min.js" crossorigin="anonymous"></script>

<script>
    $('#UpdateModal').modal("hide");
    function Values(bookID,bookName,bookInfo,bookAuthor,bookPublish,bookPrice,bookNum){
        $('#bookID').val(bookID);
        $('#bookName').val(bookName);
        $('#bookInfo').val(bookInfo);
        $('#bookAuthor').val(bookAuthor);
        $('#bookPublish').val(bookPublish);
        $('#bookPrice').val(bookPrice);
        $('#bookNum').val(bookNum);
    }

</script>
</body>
</html>
