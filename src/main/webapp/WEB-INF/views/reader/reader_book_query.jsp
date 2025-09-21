<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../include/readerheader.jsp"/>
<%--<jsp:include page="../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
  <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">图书检索</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
      <button class="btn btn-sm btn-outline-secondary me-2" id="advancedToggle">
        <i class="fas fa-sliders-h me-1"></i>高级检索
      </button>
      <a href="/book/query.html?type=hot" class="btn btn-sm btn-outline-primary">
        <i class="fas fa-fire me-1"></i>热门图书
      </a>
    </div>
  </div>

  <!-- 高级搜索面板 (默认隐藏) -->
  <div class="card mb-4 d-none" id="advancedSearch">
    <div class="card-body">
      <form id="advSearchForm">
        <div class="row g-3">
          <div class="col-md-6">
            <label for="bookName" class="form-label">图书名称</label>
            <input type="text" class="form-control" id="bookName" name="bookName" placeholder="支持模糊查询">
          </div>
          <div class="col-md-6">
            <label for="author" class="form-label">作者</label>
            <input type="text" class="form-control" id="author" name="author">
          </div>
          <div class="col-md-4">
            <label for="category" class="form-label">分类</label>
            <select class="form-select" id="category" name="category">
              <option value="">全部类别</option>
              <c:forEach items="${categories}" var="category">
                <option value="${category.id}">${category.name}</option>
              </c:forEach>
            </select>
          </div>
          <div class="col-md-4">
            <label for="publisher" class="form-label">出版社</label>
            <input type="text" class="form-control" id="publisher" name="publisher">
          </div>
          <div class="col-md-4">
            <label for="status" class="form-label">馆藏状态</label>
            <select class="form-select" id="status" name="status">
              <option value="">全部状态</option>
              <option value="available">可借阅</option>
              <option value="borrowed">已借出</option>
            </select>
          </div>
          <div class="col-md-12 d-flex justify-content-end">
            <button type="reset" class="btn btn-secondary me-2">
              <i class="fas fa-undo me-1"></i>重置
            </button>
            <button type="submit" class="btn btn-primary">
              <i class="fas fa-search me-1"></i>检索
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>

  <!-- 简单搜索 -->
  <div class="row mb-4">
    <div class="col-md-8 mx-auto">
      <form class="input-group" id="simpleSearch">
        <input type="text" class="form-control" placeholder="输入书名、作者或ISBN..."
               aria-label="Search" name="keyword" value="${param.keyword}">
        <button class="btn btn-primary" type="submit">
          <i class="fas fa-search"></i> 搜索
        </button>
      </form>
    </div>
  </div>

  <!-- 分类快速入口 -->
  <div class="mb-4">
    <h5 class="mb-3">热门分类快速入口</h5>
    <div class="d-flex flex-wrap gap-2">
      <c:forEach items="${hotCategories}" var="category">
        <a href="/book/query.html?categoryId=${category.id}"
           class="btn btn-sm btn-outline-primary">
            ${category.name} <span class="badge bg-info ms-1">${category.count}</span>
        </a>
      </c:forEach>
    </div>
  </div>

  <!-- 检索结果 -->
  <c:if test="${not empty keyword or not empty param.categoryId}">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h5 class="mb-0">
        检索结果 <small class="text-muted">共找到 ${totalCount} 条记录</small>
      </h5>
      <div class="dropdown">
        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button"
                id="sortDropdown" data-bs-toggle="dropdown">
          <i class="fas fa-sort me-1"></i>排序方式
        </button>
        <ul class="dropdown-menu" aria-labelledby="sortDropdown">
          <li><a class="dropdown-item" href="?${queryString}&sort=default">默认排序</a></li>
          <li><a class="dropdown-item" href="?${queryString}&sort=time">最新上架</a></li>
          <li><a class="dropdown-item" href="?${queryString}&sort=hot">借阅热度</a></li>
          <li><a class="dropdown-item" href="?${queryString}&sort=rating">读者评分</a></li>
        </ul>
      </div>
    </div>
  </c:if>

  <c:choose>
    <c:when test="${empty books}">
      <div class="alert alert-warning text-center">
        <i class="fas fa-book-open me-2"></i>没有找到相关图书，请尝试其他关键词
      </div>
    </c:when>
    <c:otherwise>
      <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <c:forEach items="${books}" var="book">
          <div class="col">
            <div class="card h-100">
              <div class="position-relative">
                <img src="${book.coverUrl}" class="card-img-top" alt="图书封面"
                     style="height: 200px; object-fit: cover;">
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    ${book.rating} <i class="fas fa-star"></i>
                                </span>
              </div>
              <div class="card-body">
                <h5 class="card-title text-truncate">${book.title}</h5>
                <p class="card-text text-muted small">
                  <i class="fas fa-user-edit me-1"></i>${book.author} / ${book.publisher}
                </p>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="badge bg-info">${book.categoryName}</span>
                  <c:choose>
                    <c:when test="${book.stock > 0}">
                                            <span class="text-success">
                                                <i class="fas fa-check-circle me-1"></i>可借阅
                                            </span>
                    </c:when>
                    <c:otherwise>
                                            <span class="text-danger">
                                                <i class="fas fa-times-circle me-1"></i>已借出
                                            </span>
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
              <div class="card-footer bg-transparent">
                <a href="/book/detail/${book.id}.html" class="btn btn-sm btn-primary w-100">
                  <i class="fas fa-info-circle me-1"></i> 查看详情
                </a>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>

      <!-- 分页 -->
      <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
          <li class="page-item ${page.current == 1 ? 'disabled' : ''}">
            <a class="page-link" href="?${queryString}&page=${page.current-1}">上一页</a>
          </li>
          <c:forEach begin="1" end="${page.total}" var="i">
            <li class="page-item ${page.current == i ? 'active' : ''}">
              <a class="page-link" href="?${queryString}&page=${i}">${i}</a>
            </li>
          </c:forEach>
          <li class="page-item ${page.current == page.total ? 'disabled' : ''}">
            <a class="page-link" href="?${queryString}&page=${page.current+1}">下一页</a>
          </li>
        </ul>
      </nav>
    </c:otherwise>
  </c:choose>
</div>

<script>
  // 高级搜索切换
  document.getElementById('advancedToggle').addEventListener('click', function() {
    const advancedPanel = document.getElementById('advancedSearch');
    advancedPanel.classList.toggle('d-none');
    this.innerHTML = advancedPanel.classList.contains('d-none')
            ? '<i class="fas fa-sliders-h me-1"></i>高级检索'
            : '<i class="fas fa-times me-1"></i>收起检索';
  });

  // 简单搜索表单提交
  document.getElementById('simpleSearch').addEventListener('submit', function(e) {
    if (this.querySelector('input').value.trim() === '') {
      e.preventDefault();
      alert('请输入搜索关键词');
    }
  });
</script>

<jsp:include page="../include/footer.jsp"/>
