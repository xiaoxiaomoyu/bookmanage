<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../include/header.jsp"/>
<%--<jsp:include page="../../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">添加读者</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="/reader/list.html" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> 返回列表
            </a>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card">
        <div class="card-body">
            <form action="/reader/add/do.html" method="post">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="name" class="form-label">姓名</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="col-md-6">
                        <label for="sex" class="form-label">性别</label>
                        <select class="form-select" id="sex" name="sex" required>
                            <option value="">请选择</option>
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="birth" class="form-label">出生日期</label>
                        <input type="date" class="form-control" id="birth" name="birth">
                    </div>
                    <div class="col-md-6">
                        <label for="phone" class="form-label">电话</label>
                        <input type="tel" class="form-control" id="phone" name="phone">
                    </div>
                </div>

                <div class="mb-3">
                    <label for="address" class="form-label">地址</label>
                    <input type="text" class="form-control" id="address" name="address">
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="email" class="form-label">邮箱</label>
                        <input type="email" class="form-control" id="email" name="email">
                    </div>
                    <div class="col-md-6">
                        <label for="borrowQuantity" class="form-label">可借数量</label>
                        <input type="number" class="form-control" id="borrowQuantity" name="borrowQuantity" value="5" min="1" max="10">
                    </div>
                </div>

                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                    <button type="submit" class="btn btn-primary me-md-2">
                        <i class="fas fa-save me-1"></i> 保存
                    </button>
                    <button type="reset" class="btn btn-outline-secondary">
                        <i class="fas fa-undo me-1"></i> 重置
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../../include/footer.jsp"/>
