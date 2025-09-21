<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../include/header.jsp"/>
<%--<jsp:include page="../../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
  <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">编辑图书</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
      <a href="/book/list.html" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i> 返回列表
      </a>
    </div>
  </div>

  <div class="card">
    <div class="card-body">
      <form action="/book/edit/do.html" method="post">
        <input type="hidden" name="bookId" value="${book.bookId}">

        <div class="row mb-3">
          <div class="col-md-6">
            <label for="name" class="form-label">书名</label>
            <input type="text" class="form-control" id="name" name="name" value="${book.name}" required>
          </div>
          <div class="col-md-6">
            <label for="author" class="form-label">作者</label>
            <input type="text" class="form-control" id="author" name="author" value="${book.author}" required>
          </div>
        </div>

        <!-- 其他字段与添加页面类似，只是多了value属性 -->
        <!-- 根据需要添加其他字段 -->

        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
          <button type="submit" class="btn btn-primary me-md-2">保存修改</button>
          <a href="/book/list.html" class="btn btn-secondary">取消</a>
        </div>
      </form>
    </div>
  </div>
</div>

<jsp:include page="../../include/footer.jsp"/>
