<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../include/readerheader.jsp"/>
<%--<jsp:include page="../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">我的借阅</h1>
        <div>
            <a href="/book/list.html" class="btn btn-sm btn-primary">
                <i class="fas fa-plus me-1"></i> 我要借书
            </a>
            <button class="btn btn-sm btn-outline-secondary ms-1" id="refreshBtn">
                <i class="fas fa-sync-alt me-1"></i> 刷新
            </button>
        </div>
    </div>

    <div class="alert alert-info">
        <i class="fas fa-info-circle me-2"></i>
        当前可借数量: <strong>${borrowableCount}</strong> 本 | 已借数量: <strong>${borrowedCount}</strong> 本
        <c:if test="${overdueCount > 0}">
            | 逾期: <span class="text-danger"><strong>${overdueCount}</strong> 本</span>
        </c:if>
    </div>

    <ul class="nav nav-tabs mb-3" id="lendTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="current-tab" data-bs-toggle="tab"
                    data-bs-target="#current" type="button">当前借阅(${borrowedCount})</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="history-tab" data-bs-toggle="tab"
                    data-bs-target="#history" type="button">历史记录</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="overdue-tab" data-bs-toggle="tab"
                    data-bs-target="#overdue" type="button">逾期记录(${overdueCount})</button>
        </li>
    </ul>

    <div class="tab-content" id="lendTabContent">
        <!-- 当前借阅标签页 -->
        <div class="tab-pane fade show active" id="current" role="tabpanel">
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th style="width: 50px">#</th>
                        <th>图书信息</th>
                        <th>借出日期</th>
                        <th>应还日期</th>
                        <th>剩余天数</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${currentLends}" var="lend" varStatus="status">
                        <tr>
                            <td>${status.index+1}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="${lend.bookCover}" alt="封面" width="40" height="50" class="me-2">
                                    <div>
                                        <strong>${lend.bookName}</strong><br>
                                        <small class="text-muted">${lend.bookAuthor}</small>
                                    </div>
                                </div>
                            </td>
                            <td><fmt:formatDate value="${lend.lendDate}" pattern="yyyy-MM-dd"/></td>
                            <td><fmt:formatDate value="${lend.dueDate}" pattern="yyyy-MM-dd"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${lend.isOverdue}">
                                        <span class="badge bg-danger">超期${lend.overdueDays}天</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success">剩${lend.remainingDays}天</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-outline-primary renew-btn"
                                        data-lendid="${lend.lendId}"
                                        data-bookname="${lend.bookName}"
                                    ${lend.renewed ? 'disabled' : ''}>
                                    <i class="fas fa-redo me-1"></i>
                                        ${lend.renewed ? '已续借' : '续借'}
                                </button>
                                <button class="btn btn-sm btn-outline-warning ms-1 return-btn"
                                        data-lendid="${lend.lendId}"
                                        data-bookname="${lend.bookName}">
                                    <i class="fas fa-book me-1"></i> 归还
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- 历史记录标签页 -->
        <div class="tab-pane fade" id="history" role="tabpanel">
            <c:if test="${empty historyLends}">
                <div class="alert alert-warning text-center">
                    <i class="fas fa-info-circle me-2"></i>暂无历史借阅记录
                </div>
            </c:if>
            <c:if test="${not empty historyLends}">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>图书信息</th>
                            <th>借出日期</th>
                            <th>归还日期</th>
                            <th>状态</th>
                            <th>详情</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${historyLends}" var="lend" varStatus="status">
                            <tr>
                                <td>${status.index+1}</td>
                                <td>
                                    <strong>${lend.bookName}</strong><br>
                                    <small class="text-muted">${lend.bookAuthor}</small>
                                </td>
                                <td><fmt:formatDate value="${lend.lendDate}" pattern="yyyy-MM-dd"/></td>
                                <td><fmt:formatDate value="${lend.returnDate}" pattern="yyyy-MM-dd"/></td>
                                <td>
                                    <span class="badge bg-secondary">已归还</span>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-outline-info"
                                            onclick="showDetail('${lend.lendId}')">
                                        <i class="fas fa-info-circle"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>

        <!-- 逾期记录标签页 -->
        <div class="tab-pane fade" id="overdue" role="tabpanel">
            <c:if test="${empty overdueLends}">
            <div class="alert alert-success text-center">
                <i class="fas fa-check-circle me-2"></i>没有逾期记录，继续保持！
            </div>
            </c:if>
            <c:if test="${not empty overdueLends}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-triangle me-2"></i>
                您有 <strong>${overdueCount}</strong> 本图书逾期未还，请尽快归还以避免影响信用！
            </div>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-danger">
                    <tr>
                        <th>#</th>
                        <th>图书信息</th>
                        <th>应还日期</th>
                        <th>超期天数</th>
                        <th>滞纳金</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${overdueLends}" var="lend" varStatus="status">
                    <tr>
                        <td>${status.index+1}</td>
                        <td>
                            <div class="d-flex">
                                <img src="${lend.bookCover}" alt="封面" width="40" height="50" class="me-2">
                                <div>
                                    <strong>${lend.bookName}</strong><br>
                                    <small class="text-muted">${lend.bookAuthor}</small>
                                </div>
                            </div>
                        </td>
                        <td><fmt:formatDate value="${lend.dueDate}" pattern="yyyy-MM-dd"/></td>
                        <td>
                            <span class="text-danger">${lend.overdueDays}天</span>
                        </td>
                        <td>
                            <span class="text-danger">¥${lend.fine}</span>
                        </td>
                        <td>
                            <button class="btn btn-sm btn-danger return-btn"
                                    data-lendid="${lend.lendId}"
                                    data-bookname="${lend.bookName}">
                                <i class="fas fa-book me-1"></i> 立即归还
                            </button>
                            <a href="/pay/fine.html" class="btn btn-sm btn-warning ms-1">
                                <i class="fas fa-coins me-1"></i> 缴纳
                                </c:forEach>
                    </tbody>
                </table>
            </div>
            </c:if>
        </div>
    </div>
</div>

<!-- 续借确认对话框 -->
<div class="modal fade" id="renewModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">书籍续借</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>确认要续借《<span id="renewBookName"></span>》吗？</p>
                <div class="alert alert-warning">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    注意：每本书只能续借1次，续借期限为15天
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="confirmRenew">确认续借</button>
            </div>
        </div>
    </div>
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
                <p>确认将《<span id="returnBookName"></span>》归还到图书馆？</p>
                <div class="form-group mb-3">
                    <label for="returnNotes" class="form-label">归还备注（可选）</label>
                    <textarea class="form-control" id="returnNotes" rows="2"
                              placeholder="可填写书籍状况或其他说明"></textarea>
                </div>
                <c:if test="${not empty overdueLends}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        您有逾期未还书籍，归还时可能需要缴纳滞纳金
                    </div>
                </c:if>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="confirmReturn">确认归还</button>
            </div>
        </div>
    </div>
</div>

<script>
    // 刷新按钮点击事件
    document.getElementById('refreshBtn').addEventListener('click', function() {
        location.reload();
    });

    // 续借按钮点击事件
    document.querySelectorAll('.renew-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            const bookName = this.getAttribute('data-bookname');
            const lendId = this.getAttribute('data-lendid');

            document.getElementById('renewBookName').textContent = bookName;
            const renewModal = new bootstrap.Modal(document.getElementById('renewModal'));

            document.getElementById('confirmRenew').onclick = function() {
                // 这里添加续借操作的AJAX请求
                console.log('续借记录ID:', lendId);

                // 模拟成功响应
                setTimeout(function() {
                    alert('《' + bookName + '》已成功续借15天!');
                    renewModal.hide();
                    location.reload(); // 刷新页面更新状态
                }, 500);
            };

            renewModal.show();
        });
    });

    // 归还按钮点击事件
    document.querySelectorAll('.return-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            const bookName = this.getAttribute('data-bookname');
            const lendId = this.getAttribute('data-lendid');

            document.getElementById('returnBookName').textContent = bookName;
            const returnModal = new bootstrap.Modal(document.getElementById('returnModal'));

            document.getElementById('confirmReturn').onclick = function() {
                const notes = document.getElementById('returnNotes').value;
                // 这里添加归还操作的AJAX请求
                console.log('归还记录ID:', lendId, '备注:', notes);

                // 模拟成功响应
                setTimeout(function() {
                    alert('《' + bookName + '》已成功归还!');
                    returnModal.hide();
                    location.reload(); // 刷新页面更新状态
                }, 500);
            };

            returnModal.show();
        });
    });

    // 显示借阅详情
    function showDetail(lendId) {
        // 这里可以跳转到详情页或者用AJAX加载详情
        alert('显示借阅记录ID: ' + lendId + ' 的详细信息');
    }
</script>

<jsp:include page="../include/footer.jsp"/>
