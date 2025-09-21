<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../include/header.jsp"/>
<%--<jsp:include page="../../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">读者管理</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="${pageContext.request.contextPath}/reader/admin_reader_add.jsp" class="btn btn-primary">
                <i class="fas fa-plus"></i> 添加读者
            </a>
        </div>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>姓名</th>
                <th>性别</th>
                <th>电话</th>
                <th>邮箱</th>
                <th>可借数量</th>
                <th>已借数量</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${readers}" var="reader">
                <tr>
                    <td>${reader.readerId}</td>
                    <td>${reader.name}</td>
                    <td>
                        <c:choose>
                            <c:when test="${reader.sex == '男'}">
                                <span class="badge bg-primary">${reader.sex}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">${reader.sex}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${reader.phone}</td>
                    <td>${reader.email}</td>
                    <td>
                        <span class="badge bg-info">${reader.borrowQuantity}</span>
                    </td>
                    <td>
                        <span class="badge ${reader.borrowed == 0 ? 'bg-success' : 'bg-warning'}">${reader.borrowed}</span>
                    </td>
                    <td>
                        <div class="btn-group btn-group-sm" role="group">
                            <a href="/reader/info.html?readerId=${reader.readerId}"
                               class="btn btn-outline-info" title="详情">
                                <i class="fas fa-info-circle"></i>
                            </a>
                            <a href="/reader/edit.html?readerId=${reader.readerId}"
                               class="btn btn-outline-primary" title="编辑">
                                <i class="fas fa-edit"></i>
                            </a>
                            <a href="/reader/delete.html?readerId=${reader.readerId}"
                               class="btn btn-outline-danger" title="删除"
                               onclick="return confirm('确定删除读者 ${reader.name} 吗？')">
                                <i class="fas fa-trash-alt"></i>
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- 分页导航 -->
    <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
            <li class="page-item disabled">
                <a class="page-link" href="#" tabindex="-1">上一页</a>
            </li>
            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item">
                <a class="page-link" href="#">下一页</a>
            </li>
        </ul>
    </nav>
</div>

<jsp:include page="../../include/footer.jsp"/>
