<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../include/readerheader.jsp"/>
<%--<jsp:include page="../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
    <nav class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/reader/index.html">首页</a></li>
            <li class="breadcrumb-item"><a href="/reader/info.html">个人信息</a></li>
            <li class="breadcrumb-item active">修改密码</li>
        </ol>
    </nav>

    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h3 class="card-title mb-0"><i class="fas fa-lock me-2"></i>修改密码</h3>
        </div>
        <div class="card-body">
            <form id="passwordForm" class="w-md-75 w-lg-50 mx-auto">
                <div class="mb-3">
                    <label for="currentPassword" class="form-label">当前密码</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="currentPassword"
                               name="currentPassword" required>
                        <button class="btn btn-outline-secondary toggle-password" type="button">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="newPassword" class="form-label">新密码</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="newPassword"
                               name="newPassword" minlength="6" required>
                        <button class="btn btn-outline-secondary toggle-password" type="button">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    <div class="form-text">
                        密码至少6个字符，建议包含字母、数字和特殊字符
                    </div>
                </div>

                <div class="mb-4">
                    <label for="confirmPassword" class="form-label">确认新密码</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="confirmPassword"
                               name="confirmPassword" required>
                        <button class="btn btn-outline-secondary toggle-password" type="button">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    <div id="passwordMatchError" class="invalid-feedback">
                        两次输入的密码不一致
                    </div>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">确认修改</button>
                    <button type="button" class="btn btn-outline-secondary" id="backBtn">返回</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 密码修改成功提示 -->
<div class="modal fade" id="successModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body text-center p-4">
                <div class="mb-3">
                    <i class="fas fa-check-circle text-success" style="font-size: 4rem;"></i>
                </div>
                <h4 class="mb-3">密码修改成功</h4>
                <p class="text-muted">下次登录请使用新密码</p>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // 显示/隐藏密码
        $('.toggle-password').click(function() {
            const input = $(this).prev('input');
            const icon = $(this).find('i');

            if (input.attr('type') === 'password') {
                input.attr('type', 'text');
                icon.removeClass('fa-eye').addClass('fa-eye-slash');
            } else {
                input.attr('type', 'password');
                icon.removeClass('fa-eye-slash').addClass('fa-eye');
            }
        });

        // 验证两次密码是否匹配
        $('#confirmPassword').on('input', function() {
            const newPassword = $('#newPassword').val();
            const confirmPassword = $(this).val();

            if (newPassword !== confirmPassword && confirmPassword.length > 0) {
                $(this).addClass('is-invalid');
                $('#passwordMatchError').show();
            } else {
                $(this).removeClass('is-invalid');
                $('#passwordMatchError').hide();
            }
        });

        // 表单提交
        $('#passwordForm').submit(function(e) {
            e.preventDefault();

            const currentPassword = $('#currentPassword').val();
            const newPassword = $('#newPassword').val();
            const confirmPassword = $('#confirmPassword').val();

            if (newPassword !== confirmPassword) {
                $('#confirmPassword').addClass('is-invalid');
                $('#passwordMatchError').show();
                return;
            }

            if (newPassword.length < 6) {
                alert('密码长度至少为6个字符');
                return;
            }

            $.ajax({
                url: '/reader/updatePassword.html',
                type: 'POST',
                data: {
                    currentPassword: currentPassword,
                    newPassword: newPassword,
                    confirmPassword: confirmPassword
                },
                success: function(data) {
                    if (data.success) {
                        $('#successModal').modal('show');
                        $('#passwordForm')[0].reset();
                    } else {
                        alert(data.message || '密码修改失败，请检查当前密码是否正确');
                    }
                }
            });
        });

        // 返回按钮
        $('#backBtn').click(function() {
            history.back();
        });

        // 成功模态框关闭后跳转
        $('#successModal').on('hidden.bs.modal', function () {
            location.href = '/reader/info.html';
        });
    });
</script>

<jsp:include page="../include/footer.jsp"/>
