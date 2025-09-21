<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../include/header.jsp"/>
<%--<jsp:include page="../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">系统概览</h1>
        <div class="btn-toolbar mb-2 mb-md-0">
            <div class="btn-group me-2">
                <button type="button" class="btn btn-sm btn-outline-secondary">导出</button>
            </div>
        </div>
    </div>

    <!-- 统计卡片 -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-primary h-100">
                <div class="card-body">
                    <h6 class="card-title">图书总数</h6>
                    <h2 class="card-text">1,248</h2>
                    <i class="fas fa-book fa-2x float-end opacity-25"></i>
                </div>
                <div class="card-footer bg-transparent border-top-0">
                    <a href="${pageContext.request.contextPath}/admin/book/admin_book_detail" class="text-white text-decoration-none">
                        查看详情 <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-3 mb-3">
            <div class="card text-white bg-success h-100">
                <div class="card-body">
                    <h6 class="card-title">读者数量</h6>
                    <h2 class="card-text">358</h2>
                    <i class="fas fa-users fa-2x float-end opacity-25"></i>
                </div>
                <div class="card-footer bg-transparent border-top-0">
                    <a href="${pageContext.request.contextPath}/reader/list.html" class="text-white text-decoration-none">
                        查看详情 <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-3 mb-3">
            <div class="card text-white bg-warning h-100">
                <div class="card-body">
                    <h6 class="card-title">今日借阅</h6>
                    <h2 class="card-text">24</h2>
                    <i class="fas fa-book-reader fa-2x float-end opacity-25"></i>
                </div>
                <div class="card-footer bg-transparent border-top-0">
                    <a href="${pageContext.request.contextPath}/lend/list.html" class="text-white text-decoration-none">
                        查看详情 <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-3 mb-3">
            <div class="card text-white bg-danger h-100">
                <div class="card-body">
                    <h6 class="card-title">逾期未还</h6>
                    <h2 class="card-text">7</h2>
                    <i class="fas fa-clock fa-2x float-end opacity-25"></i>
                </div>
                <div class="card-footer bg-transparent border-top-0">
                    <a href="${pageContext.request.contextPath}/lend/overdue.html" class="text-white text-decoration-none">
                        查看详情 <i class="fas fa-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- 最近借阅记录 -->
    <div class="card mb-4">
        <div class="card-header">
            <i class="fas fa-table me-1"></i>
            最近借阅记录
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>流水号</th>
                    <th>图书名称</th>
                    <th>读者姓名</th>
                    <th>借出日期</th>
                    <th>应还日期</th>
                    <th>状态</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>L20230412</td>
                    <td>Java编程思想</td>
                    <td>张三</td>
                    <td>2023-04-01</td>
                    <td>2023-04-15</td>
                    <td><span class="badge bg-success">正常</span></td>
                </tr>
                <tr>
                    <td>L20230411</td>
                    <td>Spring实战</td>
                    <td>李四</td>
                    <td>2023-03-28</td>
                    <td>2023-04-11</td>
                    <td><span class="badge bg-danger">逾期</span></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="../include/footer.jsp"/>
