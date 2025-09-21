<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../include/readerheader.jsp"/>
<%--<jsp:include page="../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
  <!-- 返回按钮 -->
  <div class="mb-3">
    <a href="javascript:history.back()" class="btn btn-outline-secondary">
      <i class="fas fa-arrow-left me-1"></i>返回列表
    </a>
  </div>

  <div class="row g-4">
    <!-- 图书封面区 -->
    <div class="col-md-4">
      <div class="card">
        <img src="${book.coverUrl}" class="card-img-top" alt="图书封面" id="bookCover">
        <div class="card-body text-center">
          <!-- 收藏按钮 -->
          <button class="btn btn-outline-danger mb-2" id="collectBtn">
            <i class="far fa-heart me-1"></i>
            <span id="collectText">${isCollected ? '已收藏' : '加入收藏'}</span>
          </button>

          <!-- 图书状态 -->
          <div class="alert ${book.stock > 0 ? 'alert-success' : 'alert-warning'}">
            <c:choose>
              <c:when test="${book.stock > 0}">
                <i class="fas fa-check-circle me-1"></i>
                可借阅 (剩余 ${book.stock} 本)
              </c:when>
              <c:otherwise>
                <i class="fas fa-exclamation-triangle me-1"></i>
                暂时无货，<a href="#" class="alert-link">预定通知</a>
              </c:otherwise>
            </c:choose>
          </div>

          <!-- 借阅按钮 -->
          <button class="btn btn-primary w-100 mb-2"
                  id="borrowBtn" ${book.stock > 0 ? '' : 'disabled'}>
            <i class="fas fa-book-reader me-1"></i> 立即借阅
          </button>

          <!-- 其他操作 -->
          <div class="btn-group w-100">
            <button class="btn btn-outline-secondary">
              <i class="fas fa-share-alt"></i> 分享
            </button>
            <button class="btn btn-outline-secondary">
              <i class="fas fa-qrcode"></i> 二维码
            </button>
            <button class="btn btn-outline-secondary">
              <i class="fas fa-print"></i> 打印
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- 图书详细信息 -->
    <div class="col-md-8">
      <div class="card">
        <div class="card-header bg-light">
          <h3 class="card-title mb-0">${book.title}</h3>
        </div>
        <div class="card-body">
          <!-- 基本信息 -->
          <dl class="row mb-4">
            <dt class="col-sm-3">ISBN编号:</dt>
            <dd class="col-sm-9">${book.isbn}</dd>

            <dt class="col-sm-3">作者:</dt>
            <dd class="col-sm-9">${book.author}</dd>

            <dt class="col-sm-3">出版社:</dt>
            <dd class="col-sm-9">${book.publisher} / ${book.publishDate}</dd>

            <dt class="col-sm-3">分类:</dt>
            <dd class="col-sm-9">
              <span class="badge bg-info">${book.categoryName}</span>
            </dd>

            <dt class="col-sm-3">馆藏位置:</dt>
            <dd class="col-sm-9">${book.location}</dd>

            <dt class="col-sm-3">上架时间:</dt>
            <dd class="col-sm-9">${book.createTime}</dd>

            <dt class="col-sm-3">借阅次数:</dt>
            <dd class="col-sm-9">${book.borrowCount}</dd>

            <dt class="col-sm-3">评分:</dt>
            <dd class="col-sm-9">
              <div class="d-flex align-items-center">
                <div class="rating">
                  <c:forEach begin="1" end="5" var="i">
                    <i class="fas fa-star ${i <= book.rating ? 'text-warning' : 'text-secondary'}"></i>
                  </c:forEach>
                </div>
                <small class="text-muted ms-2">${book.rating}分 (${book.reviewCount}人评价)</small>
              </div>
            </dd>
          </dl>

          <!-- 图书简介 -->
          <div class="mb-4">
            <h5 class="border-bottom pb-2">内容简介</h5>
            <p class="text-justify">${book.description}</p>
          </div>

          <!-- 目录 -->
          <div class="mb-4">
            <h5 class="border-bottom pb-2">目录结构</h5>
            <p>${book.catalog}</p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 相关推荐 -->
  <div class="row mt-4">
    <div class="col">
      <div class="card">
        <div class="card-header bg-light">
          <h5 class="mb-0">相关推荐</h5>
        </div>
        <div class="card-body">
          <div class="row row-cols-2 row-cols-md-4 row-cols-lg-5 g-3">
            <c:forEach items="${recommendBooks}" var="book">
              <div class="col">
                <div class="card h-100 border-0">
                  <a href="/book/detail/${book.id}.html">
                    <img src="${book.coverUrl}" class="card-img-top" alt="推荐图书"
                         style="height: 120px; object-fit: cover;">
                  </a>
                  <div class="card-body p-2">
                    <a href="/book/detail/${book.id}.html" class="text-decoration-none">
                      <h6 class="card-title text-truncate mb-0">${book.title}</h6>
                    </a>
                    <small class="text-muted">${book.author}</small>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 读者评价 -->
  <div class="row mt-4">
    <div class="col">
      <div class="card">
        <div class="card-header bg-light d-flex justify-content-between align-items-center">
          <h5 class="mb-0">读者评价</h5>
          <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#reviewModal">
            <i class="fas fa-pencil-alt me-1"></i> 我要评价
          </button>
        </div>
        <div class="card-body">
          <c:forEach items="${reviews}" var="review">
          <div class="mb-3 pb-3 border-bottom">
            <div class="d-flex justify-content-between mb-2">
              <div>
                <strong>${review.readerName}</strong>
                <span class="ms-2">
                                        <c:forEach begin="1" end="5" var="i">
                                          <i class="fas fa-star ${i <= review.rating ? 'text-warning' : 'text-secondary'}"></i>
                                        </c:forEach>
                                    </span>
              </div>
              <small class="text-muted">${review.createTime}</small>
            </div>
            <p class="mb-0">${review.content}</p>
          </div>
          </c:forEach>

          <c:if test="${empty reviews}">
          <div class="text-center py-4">
            <i class="fas fa-comment-slash fa-2
                            <i class="fas fa-comment-slash fa-2x text-muted mb-3></i>
            <p class="text-muted">暂无读者评价，快来发表第一个评论吧！</p>
          </div>
          </c:if>

          <!-- 评价分页 -->
          <nav aria-label="Review pagination" class="mt-3">
            <ul class="pagination pagination-sm justify-content-center">
              <li class="page-item ${reviewPage.current == 1 ? 'disabled' : ''}">
                <a class="page-link" href="?page=${reviewPage.current-1}#reviews">上一页</a>
              </li>
              <c:forEach begin="1" end="${reviewPage.total}" var="i">
                <li class="page-item ${reviewPage.current == i ? 'active' : ''}">
                  <a class="page-link" href="?page=${i}#reviews">${i}</a>
                </li>
              </c:forEach>
              <li class="page-item ${reviewPage.current == reviewPage.total ? 'disabled' : ''}">
                <a class="page-link" href="?page=${reviewPage.current+1}#reviews">下一页</a>
              </li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- 借阅确认对话框 -->
<div class="modal fade" id="borrowModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">图书借阅</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <p>确认要借阅《${book.title}》吗？</p>
        <div class="alert alert-info">
          <i class="fas fa-info-circle me-2"></i> 借阅期限为30天，到期前可续借一次
        </div>
        <div class="form-group mb-3">
          <label for="borrowNotes" class="form-label">备注(可选)</label>
          <textarea class="form-control" id="borrowNotes" rows="2"
                    placeholder="可填写特殊需求或其他说明"></textarea>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" id="confirmBorrow">确认借阅</button>
      </div>
    </div>
  </div>
</div>

<!-- 评价对话框 -->
<div class="modal fade" id="reviewModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">图书评价</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <form id="reviewForm">
        <div class="modal-body">
          <div class="mb-3">
            <label class="form-label">评分</label>
            <div class="rating-input">
              <input type="hidden" name="rating" id="ratingValue" value="5">
              <div class="stars">
                <c:forEach begin="1" end="5" var="i">
                  <i class="fas fa-star fa-lg" data-value="${i}"
                     style="cursor:pointer; ${i <= 5 ? 'color:#ffc107' : 'color:#e4e5e9'}"></i>
                </c:forEach>
              </div>
            </div>
          </div>
          <div class="mb-3">
            <label for="reviewContent" class="form-label">评价内容</label>
            <textarea class="form-control" id="reviewContent" name="content" rows="4"
                      placeholder="请分享您对这本书的看法..." required></textarea>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
          <button type="submit" class="btn btn-primary">提交评价</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  // 收藏按钮点击事件
  document.getElementById('collectBtn').addEventListener('click', function() {
    const isCollected = ${isCollected};
    fetch('/book/collect/${book.id}.html?action=' + (isCollected ? 'remove' : 'add'), {
      method: 'POST'
    })
            .then(response => response.json())
            .then(data => {
              if (data.success) {
                const collectText = document.getElementById('collectText');
                if (isCollected) {
                  this.classList.remove('btn-danger');
                  this.classList.add('btn-outline-danger');
                  collectText.textContent = '加入收藏';
                } else {
                  this.classList.remove('btn-outline-danger');
                  this.classList.add('btn-danger');
                  collectText.textContent = '已收藏';
                }
              }
            });
  });

  // 借阅按钮点击事件
  document.getElementById('borrowBtn').addEventListener('click', function() {
    const borrowModal = new bootstrap.Modal(document.getElementById('borrowModal'));
    borrowModal.show();
  });

  // 确认借阅
  document.getElementById('confirmBorrow').addEventListener('click', function() {
    const notes = document.getElementById('borrowNotes').value;

    // 这里添加借阅操作的AJAX请求
    fetch('/book/borrow/${book.id}.html', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ notes: notes })
    })
            .then(response => response.json())
            .then(data => {
              if (data.success) {
                alert('《${book.title}》借阅成功！可在"我的借阅"中查看');
                document.getElementById('borrowModal').querySelector('.btn-close').click();
                location.reload();
              } else {
                alert(data.message || '借阅失败，请稍后再试');
              }
            });
  });

  // 评分选择
  document.querySelectorAll('.rating-input .stars i').forEach(star => {
    star.addEventListener('click', function() {
      const value = parseInt(this.getAttribute('data-value'));
      document.getElementById('ratingValue').value = value;

      // 更新星星显示
      document.querySelectorAll('.rating-input .stars i').forEach((s, i) => {
        s.style.color = i < value ? '#ffc107' : '#e4e5e9';
      });
    });
  });

  // 评价表单提交
  document.getElementById('reviewForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const formData = new FormData(this);

    fetch('/book/review/${book.id}.html', {
      method: 'POST',
      body: formData
    })
            .then(response => response.json())
            .then(data => {
              if (data.success) {
                alert('评价提交成功，感谢您的反馈！');
                document.getElementById('reviewModal').querySelector('.btn-close').click();
                location.reload();
              } else {
                alert(data.message || '评价提交失败，请稍后再试');
              }
            });
  });

  // 检查浏览器是否支持WebP图片格式
  function checkWebPSupport(callback) {
    const webP = new Image();
    webP.onload = webP.onerror = function() {
      callback && callback(webP.height === 2);
    };
    webP.src = 'data:image/webp;base64,UklGRjoAAABXRUJQVlA4IC4AAACyAgCdASoCAAIALmk0mk0iIiIiIgBoSygABc6WWgAA/veff/0PP8bA//LwYAAA';
  }

  // 优化封面图显示
  checkWebPSupport(function(isSupported) {
    const cover = document.getElementById('bookCover');
    if (isSupported && cover.src.indexOf('.jpg') > -1) {
      cover.src = cover.src.replace('.jpg', '.webp');
    }
  });
</script>

<jsp:include page="../include/footer.jsp"/>
