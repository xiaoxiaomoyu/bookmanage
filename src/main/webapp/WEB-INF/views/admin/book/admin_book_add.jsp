<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../include/header.jsp"/>
<%--<jsp:include page="../../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">添加图书</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="/book/list.html" class="btn btn-secondary">
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
            <form action="/book/add/do.html" method="post">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="name" class="form-label">书名</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="col-md-6">
                        <label for="author" class="form-label">作者</label>
                        <input type="text" class="form-control" id="author" name="author" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="publish" class="form-label">出版社</label>
                        <input type="text" class="form-control" id="publish" name="publish" required>
                    </div>
                    <div class="col-md-6">
                        <label for="isbn" class="form-label">ISBN</label>
                        <input type="text" class="form-control" id="isbn" name="isbn" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="introduction" class="form-label">简介</label>
                    <textarea class="form-control" id="introduction" name="introduction" rows="3"></textarea>
                </div>

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="language" class="form-label">语言</label>
                        <input type="text" class="form-control" id="language" name="language" required>
                    </div>
                    <div class="col-md-4">
                        <label for="price" class="form-label">价格</label>
                        <input type="number" class="form-control" id="price" name="price" step="0.01" required>
                    </div>
                    <div class="col-md-4">
                        <label for="pubdate" class="form-label">出版日期</label>
                        <input type="date" class="form-control" id="pubdate" name="pubdate" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="classId" class="form-label">分类ID</label>
                        <input type="number" class="form-control" id="classId" name="classId" required>
                    </div>
                    <div class="col-md-4">
                        <label for="pressmark" class="form-label">书架号</label>
                        <input type="number" class="form-control" id="pressmark" name="pressmark" required>
                    </div>
                    <div class="col-md-4">
                        <label for="state" class="form-label">状态</label>
                        <select class="form-select" id="state" name="state" required>
                            <option value="0">可借</option>
                            <option value="1">已借</option>
                        </select>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary">添加图书</button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../../include/footer.jsp"/>
