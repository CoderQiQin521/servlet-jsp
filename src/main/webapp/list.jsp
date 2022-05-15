<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>出入信息列表</title>
    <link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h2 class="text-center">出入信息列表</h2>
    <form class="form-inline">
        <div class="form-group">
            <label for="idcard">身份证号</label>
            <input type="text" class="form-control" id="idcard" placeholder="">
        </div>

        <div class="form-group">
            <label for="type">人员类型</label>
            <select id="type" class="form-control">
                <option>全部</option>
                <option>外来人员</option>
                <option>居民</option>
            </select>
        </div>
        <div class="form-group">
            <label for="cr">出入</label>

            <select id="cr" class="form-control">
                <option>全部</option>
                <option>出</option>
                <option>入</option>
            </select>
        </div>
        <button type="submit" class="btn btn-default">查询</button>
        <div class="pull-right">
            <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#addUser">添加人员信息</button>
            <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#addRecord">添加出入信息</button>
        </div>
    </form>

    <div class="table-responsive">
        <table class="table table-striped table-bordered">
            <thead>
            <tr class="success">
                <th>编号</th>
                <th>身份证号</th>
                <th>姓名</th>
                <th>时间</th>
                <th>出/入</th>
                <th>人员类型</th>
                <th>是否通过</th>
                <th>电话</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${sessionScope.recordList}" var="record">
                <tr>
                    <td>${record.id}</td>
                    <td>${record.idcard}</td>
                    <td>${record.name}</td>
                    <td>${record.created_at}</td>
                    <td>
                        <c:if test="${record.method == 0}">
                            出
                        </c:if>
                        <c:if test="${record.method == 1}">
                            入
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${record.type == 0}">
                            外来人员
                        </c:if>
                        <c:if test="${record.type == 1}">
                            居民
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${record.result == 0}">
                            失败
                        </c:if>
                        <c:if test="${record.result == 1}">
                            成功
                        </c:if>
                    </td>
                    <td>${record.phone}</td>
                    <td>
                        <button class="btn btn-default">修改</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="modal fade" id="addUser" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">添加人员信息</h4>
            </div>
            <form method="post" action="user">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="_name">姓名</label>
                        <input type="text" class="form-control" id="_name" name="name" maxlength="20"
                               placeholder="请输入姓名">
                    </div>
                    <div class="form-group">
                        <label for="_idcard">身份证号</label>
                        <input type="text" class="form-control" id="_idcard" name="idcard" maxlength="20"
                               placeholder="请输入身份证号">
                    </div>
                    <div class="form-group">
                        <label for="_phone">手机号</label>
                        <input type="text" class="form-control" id="_phone" name="phone" maxlength="11"
                               placeholder="请输入手机号">
                    </div>
                    <div class="form-group">
                        <label for="_type">人员类型</label>
                        <select id="_type" name="type" class="form-control">
                            <option value="0">居民</option>
                            <option value="1">外来人员</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="addRecord" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">添加出入信息</h4>
            </div>
            <form method="post" action="record">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="_uid">人员</label>
                        <select id="_uid" name="uid" class="form-control">
                            <c:forEach items="${sessionScope.userList}" var="user">
                                <option value="${user.id}">${user.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="_method">出/入</label>
                        <div class="radio">
                            <label>
                                <input type="radio" name="method" id="_method" value="0"> 出
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="method" id="_method2" value="1"> 入
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="_method">是否通过</label>
                        <div class="radio">
                            <label>
                                <input type="radio" name="result" id="inlineRadio1" value="1"> 是
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="result" id="inlineRadio2" value="0"> 否
                            </label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">保存</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script>
</body>
</html>
