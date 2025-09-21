<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="include/header_no_sidebar.jsp"/>

<div class="container">
    <div class="row justify-content-center mt-5">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-lg">
                <div class="card-header bg-primary text-white text-center py-3">
                    <h3><i class="fas fa-book me-2"></i>图书管理系统</h3>
                    <p class="mb-0">欢迎登录</p>
                </div>
                <div class="card-body p-4">
<%--                    <c:if test="${not empty error}">--%>
<%--                        <div class="alert alert-danger alert-dismissible fade show" role="alert">--%>
<%--                                ${error}--%>
<%--                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>--%>
<%--                        </div>--%>
<%--                    </c:if>--%>

                    <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label for="username" class="form-label">用户名</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" class="form-control" id="username" name="username" required>
                                <div class="invalid-feedback">请输入用户名</div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="password" class="form-label">密码</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <input type="password" class="form-control" id="password" name="password" required>
                                <div class="invalid-feedback">请输入密码</div>
                            </div>
                        </div>

                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="remember" name="remember">
                            <label class="form-check-label" for="remember">记住我</label>
                        </div>

                        <button type="submit" class="btn btn-primary w-100 py-2 mb-3">
                            <i class="fas fa-sign-in-alt me-2"></i>登录
                        </button>

                        <div class="d-flex justify-content-between">
                            <a href="#" class="text-decoration-none">忘记密码?</a>
                            <a href="#" class="text-decoration-none">注册账号</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 表单验证示例
    (() => {
        'use strict'
        const forms = document.querySelectorAll('.needs-validation')
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>

<jsp:include page="include/footer.jsp"/>
