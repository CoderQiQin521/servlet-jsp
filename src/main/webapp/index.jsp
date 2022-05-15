<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <button class="btn btn-primary">添加人员信息</button>
            <button class="btn btn-primary">添加出入信息</button>
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
            <tr>
                <td>1</td>
                <td>412721112172971921</td>
                <td>张三</td>
                <td>2022-03-12 15:26:12</td>
                <td>出</td>
                <td>外来人员</td>
                <td>成功</td>
                <td>123123</td>
                <td>
                    <button class="btn btn-default">修改</button>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>412721112172971921</td>
                <td>张三</td>
                <td>2022-03-12 15:26:12</td>
                <td>出</td>
                <td>居民</td>
                <td>成功</td>
                <td>123123</td>
                <td>
                    <button class="btn btn-default">修改</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script>
</body>
</html>
