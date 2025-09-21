<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../include/header.jsp"/>
<%--<jsp:include page="../../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">图书列表</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <a href="/book/add.html" class="btn btn-primary">
                <i class="fas fa-plus"></i> 添加图书
            </a>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-body">
            <form action="/book/query.html" method="get" class="row g-3">
                <div class="col-md-8">
                    <input type="text" name="searchWord" class="form-control" placeholder="输入书名或ID进行搜索">
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-secondary">搜索</button>
                </div>
            </form>
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
            <thead>
            <tr>
                <th>ID</th>
                <th>书名</th>
                <th>作者</th>
                <th>出版社</th>
                <th>价格</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${books}" var="book">
                <tr>
                    <td>${book.bookId}</td>
                    <td>${book.name}</td>
                    <td>${book.author}</td>
                    <td>${book.publish}</td>
                    <td>${book.price}</td>
                    <td>
                        <c:choose>
                            <c:when test="${book.state == 0}">
                                <span class="badge bg-success">可借</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">已借</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <div class="btn-group" role="group">
                            <a href="/book/detail.html?bookId=${book.bookId}" class="btn btn-sm btn-info">
                                <i class="fas fa-info-circle"></i>
                            </a>
                            <a href="/book/edit.html?bookId=${book.bookId}" class="btn btn-sm btn-warning">
                                <i class="fas fa-edit"></i>
                            </a>
                            <a href="/lend/book.html?bookId=${book.bookId}" class="btn btn-sm btn-primary">
                                <i class="fas fa-book-reader"></i>
                            </a>
                            <a href="/book/delete.html?bookId=${book.bookId}"
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('确定删除这本书吗？')">
                                <i class="fas fa-trash-alt"></i>
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="../../include/footer.jsp"/>
