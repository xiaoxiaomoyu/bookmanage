<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>修改密码</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 40px;
        }
        .container {
            max-width: 500px;
        }
        .alert {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h3 class="card-title mb-0">修改密码</h3>
        </div>
        <div class="card-body">
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                        ${error}
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success" role="alert">
                        ${success}
                </div>
            </c:if>

            <form action="repasswd_do.jsp" method="post">
                <div class="mb-3">
                    <label for="oldPasswd" class="form-label">原密码</label>
                    <input type="password" class="form-control" id="oldPasswd" name="oldPasswd" required>
                </div>
                <div class="mb-3">
                    <label for="newPasswd" class="form-label">新密码</label>
                    <input type="password" class="form-control" id="newPasswd" name="newPasswd" required>
                </div>
                <div class="mb-3">
                    <label for="reNewPasswd" class="form-label">确认新密码</label>
                    <input type="password" class="form-control" id="reNewPasswd" name="reNewPasswd" required>
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">提交修改</button>
                    <a href="${pageContext.request.contextPath}/admin/main" class="btn btn-outline-secondary">返回首页</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
