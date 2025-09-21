<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../include/header.jsp"/>
<%--<jsp:include page="../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
  <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">借阅记录管理</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
      <div class="btn-group me-2">
        <button type="button" class="btn btn-sm btn-outline-secondary">导出</button>
        <button type="button" class="btn btn-sm btn-outline-secondary">打印</button>
      </div>
      <div class="dropdown">
        <button class="btn btn-sm btn-outline-primary dropdown-toggle" type="button"
                id="dropdownMenuButton" data-bs-toggle="dropdown">
          <i class="fas fa-filter me-1"></i>筛选
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
          <li><a class="dropdown-item" href="#">全部记录</a></li>
          <li><a class="dropdown-item" href="#">未归还</a></li>
          <li><a class="dropdown-item" href="#">已逾期</a></li>
          <li><a class="dropdown-item" href="#">今日归还</a></li>
        </ul>
      </div>
    </div>
  </div>

  <div class="row mb-3">
    <div class="col-md-6">
      <form class="row g-2">
        <div class="col-md-8">
          <input type="text" class="form-control" placeholder="搜索读者或图书...">
        </div>
        <div class="col-md-4">
          <button type="submit" class="btn btn-primary w-100">搜索</button>
        </div>
      </form>
    </div>
    <div class="col-md-6">
      <div class="input-group">
        <input type="date" class="form-control" placeholder="开始日期">
        <span class="input-group-text">至</span>
        <input type="date" class="form-control" placeholder="结束日期">
        <button class="btn btn-outline-secondary" type="button">筛选</button>
      </div>
    </div>
  </div>

  <div class="table-responsive">
    <table class="table table-striped table-hover align-middle">
      <thead class="table-light">
      <tr>
        <th class="text-center">序号</th>
        <th>图书信息</th>
        <th>读者信息</th>
        <th>借出时间</th>
        <th>应还时间</th>
        <th>实际归还</th>
        <th>状态</th>
        <th class="text-center">操作</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach items="${lends}" var="lend" varStatus="status">
        <tr>
          <td class="text-center">${status.index+1}</td>
          <td>
            <div class="d-flex">
              <img src="${lend.bookCover}" alt="封面" width="40" height="50" class="me-2">
              <div>
                <strong>${lend.bookName}</strong><br>
                <small class="text-muted">${lend.bookAuthor}</small>
              </div>
            </div>
          </td>
          <td>
            <strong>${lend.readerName}</strong><br>
            <small class="text-muted">ID: ${lend.readerId}</small>
          </td>
          <td>
            <fmt:formatDate value="${lend.lendDate}" pattern="yyyy-MM-dd"/>
          </td>
          <td>
            <fmt:formatDate value="${lend.dueDate}" pattern="yyyy-MM-dd"/>
          </td>
          <td>
            <c:if test="${not empty lend.returnDate}">
              <fmt:formatDate value="${lend.returnDate}" pattern="yyyy-MM-dd"/>
            </c:if>
          </td>
          <td>
            <c:choose>
              <c:when test="${lend.status == '已归还'}">
                <span class="badge bg-success">${lend.status}</span>
              </c:when>
              <c:when test="${lend.isOverdue}">
                <span class="badge bg-danger">逾期</span><br>
                <small class="text-muted">超期${lend.overdueDays}天</small>
              </c:when>
              <c:otherwise>
                <span class="badge bg-warning">借出中</span>
              </c:otherwise>
            </c:choose>
          </td>
          <td class="text-center">
            <div class="btn-group btn-group-sm">
              <button class="btn btn-outline-info" title="详情"
                      onclick="showLendDetail('${lend.lendId}')">
                <i class="fas fa-info-circle"></i>
              </button>
              <c:if test="${lend.status != '已归还'}">
                <button class="btn btn-outline-primary" title="归还"
                        onclick="returnBook('${lend.lendId}', '${lend.bookName}')">
                  <i class="fas fa-book"></i>
                </button>
              </c:if>
            </div>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>

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

<!-- 归还确认对话框 -->
<div class="modal fade" id="returnModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">确认归还</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <p>确认将书籍《<span id="returnBookName"></span>》标记为已归还？</p>
        <div class="mb-3">
          <label for="returnNotes" class="form-label">备注信息（可选）</label>
          <textarea class="form-control" id="returnNotes" rows="2"></textarea>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" id="confirmReturn">确认归还</button>
      </div>
    </div>
  </div>
</div>

<script>
  function returnBook(lendId, bookName) {
    document.getElementById('returnBookName').textContent = bookName;
    const returnModal = new bootstrap.Modal(document.getElementById('returnModal'));
    document.getElementById('confirmReturn').onclick = function() {
      // 这里添加归还操作的AJAX请求
      alert('书籍' + bookName + '已成功归还!');
      returnModal.hide();
    };
    returnModal.show();
  }

  function showLendDetail(lendId) {
    // 这里添加显示详情的逻辑
    alert('显示借阅记录ID: ' + lendId + ' 的详细信息');
  }
</script>

<jsp:include page="../include/footer.jsp"/>
