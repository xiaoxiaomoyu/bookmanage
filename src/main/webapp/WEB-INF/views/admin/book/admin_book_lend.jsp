<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../include/header.jsp"/>
<%--<jsp:include page="../../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">借出图书</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="/book/list.html" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> 返回列表
            </a>
        </div>
    </div>

    <div class="card">
        <div class="card-body">
            <div class="row mb-4">
                <div class="col-md-3 text-center">
                    <i class="fas fa-book-open fa-4x text-primary mb-3"></i>
                    <h5>${book.name}</h5>
                    <p>ID: ${book.bookId}</p>
                </div>
                <div class="col-md-9">
                    <form action="/lend/book/do.html" method="post">
                        <input type="hidden" name="id" value="${book.bookId}">

                        <div class="mb-3">
                            <label for="readerId" class="form-label">读者ID</label>
                            <input type="number" class="form-control" id="readerId" name="readerId" required>
                            <small class="text-muted">请输入借阅者的读者ID</small>
                        </div>

                        <div class="alert alert-info">
                            <i class="fas fa-info-circle"></i>
                            确认图书信息无误后，请输入借阅者的读者ID并提交
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <button type="submit" class="btn btn-primary me-md-2">
                                <i class="fas fa-check-circle"></i> 确认借出
                            </button>
                            <a href="/book/list.html" class="btn btn-secondary">取消</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- 读者查询帮助 -->
    <div class="card mt-4">
        <div class="card-header">
            <h5 class="mb-0">
                <i class="fas fa-search me-2"></i>读者查询
            </h5>
        </div>
        <div class="card-body">
            <form class="row g-3">
                <div class="col-md-8">
                    <input type="text" class="form-control" placeholder="输入读者姓名或ID">
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-secondary w-100">查询</button>
                </div>
            </form>

            <div class="mt-3">
                <!-- 这里可以添加读者查询结果 -->
                <p class="text-muted">使用查询功能可快速查找读者信息</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../include/footer.jsp"/>
