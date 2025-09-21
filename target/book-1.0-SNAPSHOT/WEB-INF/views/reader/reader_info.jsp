<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../include/readerheader.jsp"/>
<%--<jsp:include page="../include/sidebar.jsp"/>--%>

<div class="col-md-9 col-lg-10 main-content">
    <nav class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/reader/main">首页</a></li>
            <li class="breadcrumb-item active">个人信息</li>
        </ol>
    </nav>

    <div class="card shadow-sm mb-4">
        <div class="card-header bg-primary text-white">
            <h3 class="card-title mb-0"><i class="fas fa-user-circle me-2"></i>个人信息</h3>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4 text-center">
                    <div class="avatar-container mb-3">
                        <img src="${reader.avatarUrl}" alt="用户头像" class="rounded-circle"
                             onerror="this.src='/static/images/default-avatar.jpg'"
                             style="width: 150px; height: 150px; object-fit: cover;">
                        <button class="btn btn-sm btn-outline-primary mt-3" id="changeAvatarBtn">
                            <i class="fas fa-camera me-1"></i>更换头像
                        </button>
                        <input type="file" id="avatarInput" accept="image/*" style="display: none;">
                    </div>
                    <div class="card bg-light">
                        <div class="card-body">
                            <p><i class="fas fa-id-card me-2"></i>读者证号: <strong>${reader.readerId}</strong></p>
                            <p><i class="fas fa-calendar-alt me-2"></i>注册日期: <strong>${reader.registerDate}</strong></p>
                            <p><i class="fas fa-bolt me-2"></i>账户状态:
                                <span class="badge ${reader.status == '正常' ? 'bg-success' : 'bg-danger'}">
                                    ${reader.status}
                                </span>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="col-md-8">
                    <form id="infoForm">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">姓名</label>
                                <input type="text" class="form-control" name="name" value="${reader.name}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">性别</label>
                                <select class="form-select" name="gender">
                                    <option value="男" ${reader.gender == '男' ? 'selected' : ''}>男</option>
                                    <option value="女" ${reader.gender == '女' ? 'selected' : ''}>女</option>
                                    <option value="保密" ${reader.gender == '保密' ? 'selected' : ''}>保密</option>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">手机号码</label>
                                <input type="tel" class="form-control" name="phone" value="${reader.phone}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">电子邮件</label>
                                <input type="email" class="form-control" name="email" value="${reader.email}">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">联系地址</label>
                            <input type="text" class="form-control" name="address" value="${reader.address}">
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">出生日期</label>
                                <input type="date" class="form-control" name="birthday" value="${reader.birthday}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">学历</label>
                                <select class="form-select" name="education">
                                    <option value="">请选择</option>
                                    <option value="小学" ${reader.education == '小学' ? 'selected' : ''}>小学</option>
                                    <option value="初中" ${reader.education == '初中' ? 'selected' : ''}>初中</option>
                                    <option value="高中" ${reader.education == '高中' ? 'selected' : ''}>高中</option>
                                    <option value="大专" ${reader.education == '大专' ? 'selected' : ''}>大专</option>
                                    <option value="本科" ${reader.education == '本科' ? 'selected' : ''}>本科</option>
                                    <option value="硕士" ${reader.education == '硕士' ? 'selected' : ''}>硕士</option>
                                    <option value="博士" ${reader.education == '博士' ? 'selected' : ''}>博士</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">个人简介</label>
                            <textarea class="form-control" name="about" rows="3">${reader.about}</textarea>
                        </div>

                        <div class="d-flex justify-content-end">
                            <button type="button" class="btn btn-outline-secondary me-2" id="cancelBtn">取消</button>
                            <button type="submit" class="btn btn-primary">保存信息</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- 借阅统计 -->
            <div class="mt-5">
                <h5 class="section-title"><i class="fas fa-chart-bar me-2 text-primary"></i>借阅统计</h5>
                <div class="row g-3">
                    <div class="col-md-4">
                        <div class="card bg-light">
                            <div class="card-body text-center">
                                <h6 class="text-muted">当前借阅</h6>
                                <h3 class="text-primary">${stats.currentBorrow}</h3>
                                <a href="/borrow/current.html" class="btn btn-sm btn-outline-primary">查看详情</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card bg-light">
                            <div class="card-body text-center">
                                <h6 class="text-muted">历史借阅</h6>
                                <h3 class="text-primary">${stats.totalBorrow}</h3>
                                <a href="/borrow/history.html" class="btn btn-sm btn-outline-primary">查看详情</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card bg-light">
                            <div class="card-body text-center">
                                <h6 class="text-muted">累计超期</h6>
                                <h3 class="text-primary">${stats.totalOverdue}</h3>
                                <a href="/borrow/overdue.html" class="btn btn-sm btn-outline-primary">查看详情</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 头像上传模态框 -->
<div class="modal fade" id="avatarModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">更换头像</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center">
                <div class="image-crop-container mb-3">
                    <img src="${reader.avatarUrl}" id="cropImage"
                         onerror="this.src='/static/images/default-avatar.jpg'">
                </div>
                <div class="d-grid gap-2">
                    <button class="btn btn-secondary" id="chooseImageBtn">
                        <i class="fas fa-image me-1"></i> 选择新图片
                    </button>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="confirmAvatarBtn">确定</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // 点击更换头像按钮
        $('#changeAvatarBtn').click(function() {
            $('#avatarModal').modal('show');
        });

        // 选择图片
        $('#chooseImageBtn').click(function() {
            $('#avatarInput').click();
        });

        // 头像图片预览
        $('#avatarInput').change(function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(event) {
                    $('#cropImage').attr('src', event.target.result);
                    // 这里可以初始化图片裁剪插件
                    // initCropper();
                };
                reader.readAsDataURL(file);
            }
        });

        // 确认更换头像
        $('#confirmAvatarBtn').click(function() {
            const formData = new FormData();
            // 这里需要添加裁剪后的图片数据
            // formData.append('avatar', croppedImage);

            $.ajax({
                url: '/reader/uploadAvatar.html',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(data) {
                    if (data.success) {
                        alert('头像更新成功');
                        $('#avatarModal').modal('hide');
                        $('.avatar-container img').attr('src', data.avatarUrl);
                    } else {
                        alert(data.message || '头像更新失败');
                    }
                }
            });
        });

        // 保存个人信息
        $('#infoForm').submit(function(e) {
            e.preventDefault();

            const formData = $(this).serialize();

            $.ajax({
                url: '/reader/updateInfo.html',
                type: 'POST',
                data: formData,
                success: function(data) {
                    if (data.success) {
                        alert('个人信息更新成功');
                    } else {
                        alert(data.message || '更新失败');
                    }
                }
            });
        });

        // 取消按钮
        $('#cancelBtn').click(function() {
            location.reload(); // 重新加载页面，丢弃更改
        });
    });
</script>

<jsp:include page="../include/footer.jsp"/>
