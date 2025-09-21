<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../include/readerheader.jsp"/>
<%--<jsp:include page="../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
    <div class="row mb-4">
        <div class="col-md-8">
            <h1 class="h2">欢迎回来, ${readerName}!</h1>
            <p class="text-muted">以下是您的借阅信息和系统公告</p>
        </div>
        <div class="col-md-4 text-end">
            <div class="badge bg-primary p-2">
                <i class="fas fa-id-card me-1"></i> 读者ID: ${readerId}
            </div>
        </div>
    </div>

    <!-- 读者卡片 -->
    <div class="row mb-4">
        <div class="col-md-6 mb-3">
            <div class="card border-primary h-100">
                <div class="card-header bg-primary text-white">
                    <i class="fas fa-chart-pie me-1"></i> 借阅统计
                </div>
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-6 border-end">
                            <h3>${borrowCount}</h3>
                            <p class="text-muted mb-0">当前借阅</p>
                        </div>
                        <div class="col-6">
                            <h3>${canBorrowCount}</h3>
                            <p class="text-muted mb-0">可借数量</p>
                        </div>
                    </div>
                </div>
                <div class="card-footer bg-transparent">
                    <a href="${pageContext.request.contextPath}/reader/reader_lend_list" class="btn btn-sm btn-outline-primary">
                        <i class="fas fa-search me-1"></i> 查看详情
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-6 mb-3">
            <div class="card border-warning h-100">
                <div class="card-header bg-warning text-white">
                    <i class="fas fa-exclamation-triangle me-1"></i> 逾期提醒
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${overdueCount == 0}">
                            <div class="text-center text-success">
                                <i class="fas fa-check-circle fa-3x mb-3"></i>
                                <h4>没有逾期图书</h4>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                您有 <strong>${overdueCount}</strong> 本图书逾期未还
                            </div>
                            <p class="small text-muted">请尽快归还，逾期将产生滞纳金</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="card-footer bg-transparent">
                    <a href="${pageContext.request.contextPath}/reader/reader_lend_list" class="btn btn-sm btn-outline-warning">
                        <i class="fas fa-book me-1"></i> 去归还
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- 当前借阅 -->
    <div class="card mb-4">
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <i class="fas fa-book-open me-1"></i>
                    我的借阅
                </div>
                <a href="${pageContext.request.contextPath}/reader/reader_lend_list" class="btn btn-sm btn-primary">
                    <i class="fas fa-plus me-1"></i> 我要借书
                </a>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>图书封面</th>
                        <th>图书名称</th>
                        <th>借出日期</th>
                        <th>应还日期</th>
                        <th>剩余天数</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td><img src="/static/images/book1.jpg" alt="封面" width="40"></td>
                        <td>Java编程思想</td>
                        <td>2023-04-01</td>
                        <td>2023-04-15</td>
                        <td><span class="badge bg-success">5天</span></td>
                        <td>
                            <button class="btn btn-sm btn-outline-secondary">续借</button>
                        </td>
                    </tr>
                    <tr>
                        <td><img src="/static/images/book2.jpg" alt="封面" width="40"></td>
                        <td>Spring实战</td>
                        <td>2023-03-28</td>
                        <td>2023-04-11</td>
                        <td><span class="badge bg-danger">超期2天</span></td>
                        <td>
                            <button class="btn btn-sm btn-outline-danger">立即归还</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- 系统公告 -->
    <div class="card">
        <div class="card-header">
            <i class="fas fa-bullhorn me-1"></i>
            系统公告
        </div>
        <div class="card-body">
            <div class="list-group">
                <a href="#" class="list-group-item list-group-item-action">
                    <div class="d-flex w-100 justify-content-between">
                        <h6 class="mb-1">图书馆开放时间调整通知</h6>
                        <small class="text-muted">2023-03-28</small>
                    </div>
                    <p class="mb-1 small">五一假期期间，图书馆开放时间调整为9:00-17:00...</p>
                </a>
                <a href="#" class="list-group-item list-group-item-action">
                    <div class="d-flex w-100 justify-content-between">
                        <h6 class="mb-1">关于举办读书沙龙活动的通知</h6>
                        <small class="text-muted">2023-03-15</small>
                    </div>
                    <p class="mb-1 small">本周五下午3点将在图书馆三楼会议室举办"春日读书"沙龙活动...</p>
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../include/footer.jsp"/>
