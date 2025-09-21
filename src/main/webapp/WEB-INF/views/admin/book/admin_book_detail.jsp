<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../../include/header.jsp"/>
<%--<jsp:include page="../../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
  <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">图书详情</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
      <a href="${pageContext.request.contextPath}/admin/main" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i> 返回列表
      </a>
    </div>
  </div>

  <div class="card mb-4">
    <div class="card-body">
      <div class="row">
        <div class="col-md-3 text-center">
          <div class="bg-light p-4 rounded mb-3">
            <i class="fas fa-book-open fa-5x text-primary mb-3"></i>
            <p class="fs-5">
                            <span class="badge ${book.state == 0 ? 'bg-success' : 'bg-danger'}">
                              ${book.state == 0 ? '可借' : '已借'}
                            </span>
            </p>
          </div>
        </div>
        <div class="col-md-9">
          <h3 class="mb-4">${book.name}</h3>
          <dl class="row">
            <dt class="col-sm-3">作者</dt>
            <dd class="col-sm-9">${book.author}</dd>

            <dt class="col-sm-3">出版社</dt>
            <dd class="col-sm-9">${book.publish}</dd>

            <dt class="col-sm-3">ISBN</dt>
            <dd class="col-sm-9">${book.isbn}</dd>

            <dt class="col-sm-3">价格</dt>
            <dd class="col-sm-9">${book.price}</dd>

            <dt class="col-sm-3">出版日期</dt>
            <dd class="col-sm-9">
              <fmt:formatDate value="${book.pubdate}" pattern="yyyy-MM-dd"/>
            </dd>

            <dt class="col-sm-3">分类ID</dt>
            <dd class="col-sm-9">${book.classId}</dd>

            <dt class="col-sm-3">书架号</dt>
            <dd class="col-sm-9">${book.pressmark}</dd>

            <dt class="col-sm-3">简介</dt>
            <dd class="col-sm-9">${book.introduction}</dd>

            <dt class="col-sm-3">语言</dt>
            <dd class="col-sm-9">${book.language}</dd>
          </dl>

          <div class="mt-4">
            <a href="/book/edit.html?bookId=${book.bookId}" class="btn btn-warning me-2">
              <i class="fas fa-edit me-1"></i> 编辑
            </a>
            <c:choose>
              <c:when test="${book.state == 0}">
                <a href="/lend/book.html?bookId=${book.bookId}" class="btn btn-primary me-2">
                  <i class="fas fa-book-reader me-1"></i> 借出
                </a>
              </c:when>
              <c:otherwise>
                <a href="/lend/return.html?bookId=${book.bookId}" class="btn btn-success me-2">
                  <i class="fas fa-book me-1"></i> 归还
                </a>
              </c:otherwise>
            </c:choose>
            <a href="/book/delete.html?bookId=${book.bookId}"
               class="btn btn-danger"
               onclick="return confirm('确定删除这本书吗？')">
              <i class="fas fa-trash-alt me-1"></i> 删除
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 借阅历史记录 -->
  <div class="card">
    <div class="card-header">
      <h5 class="mb-0">
        <i class="fas fa-history me-2"></i>借阅记录
      </h5>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-hover">
          <thead>
          <tr>
            <th>流水号</th>
            <th>读者ID</th>
            <th>借出日期</th>
            <th>归还日期</th>
            <th>状态</th>
          </tr>
          </thead>
          <tbody>
          <!-- 这里可以添加从控制器传递的借阅记录列表 -->
          <tr>
            <td colspan="5" class="text-center text-muted">暂无借阅记录</td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../../include/footer.jsp"/>
