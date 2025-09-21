<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../../include/header.jsp"/>
<%--<jsp:include page="../../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">编辑读者</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="/reader/list.html" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> 返回列表
            </a>
        </div>
    </div>

    <div class="card">
        <div class="card-body">
            <form action="/reader/edit/do.html" method="post">
                <input type="hidden" name="id" value="${readerInfo.readerId}">

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="name" class="form-label">姓名</label>
                        <input type="text" class="form-control" id="name" name="name" value="${readerInfo.name}" required>
                    </div>
                    <div class="col-md-6">
                        <label for="sex" class="form-label">性别</label>
                        <select class="form-select" id="sex" name="sex" required>
                            <option value="男" ${readerInfo.sex == '男' ? 'selected' : ''}>男</option>
                            <option value="女" ${readerInfo.sex == '女' ? 'selected' : ''}>女</option>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="birth" class="form-label">出生日期</label>
                        <input type="date" class="form-control" id="birth" name="birth"
                               value="<fmt:formatDate value='${readerInfo.birth}' pattern='yyyy-MM-dd'/>">
                    </div>
                    <div class="col-md-6">
                        <label for="phone" class="form-label">电话</label>
                        <input type="tel" class="form-control" id="phone" name="phone" value="${readerInfo.phone}">
                    </div>
                </div>

                <div class="mb-3">
                    <label for="address" class="form-label">地址</label>
                    <input type="text" class="form-control" id="address" name="address" value="${readerInfo.address}">
                </div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <label for="email" class="form-label">邮箱</label>
                        <input type="email" class="form-control" id="email" name="email" value="${readerInfo.email}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">读者ID</label>
                        <input type="text" class="form-control" value="${readerInfo.readerId}" readonly>
                    </div>
                </div>

                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <button type="submit" class="btn btn-primary me-md-2">
                        <i class="fas fa-save me-1"></i> 保存更改
                    </button>
                    <a href="/reader/list.html" class="btn btn-secondary">
                        <i class="fas fa-times me-1"></i> 取消
                    </a>
                </div>
            </form>
        </div>
    </div>

    <!-- 读者卡信息 -->
    <div class="card mt-4">
        <div class="card-header">
            <h5 class="mb-0">
                <i class="fas fa-id-card me-2"></i>读者卡信息
            </h5>
        </div>
        <div class="card-body">
            <dl class="row mb-0">
                <dt class="col-sm-3">读者卡状态</dt>
                <dd class="col-sm-9">
                    <span class="badge bg-success">正常</span>
                </dd>

                <dt class="col-sm-3">可借数量</dt>
                <dd class="col-sm-9">${readerInfo.borrowQuantity}</dd>

                <dt class="col-sm-3">已借数量</dt>
                <dd class="col-sm-9">${readerInfo.borrowed}</dd>

                <dt class="col-sm-3">注册日期</dt>
                <dd class="col-sm-9">2023-01-01</dd>
            </dl>
        </div>
    </div>
</div>

<jsp:include page="../../include/footer.jsp"/>
