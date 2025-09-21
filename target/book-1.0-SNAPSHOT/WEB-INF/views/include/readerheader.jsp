<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>XX图书馆</title>
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    .navbar-custom {
      background-color: #3498db;
    }
    .navbar-custom .navbar-brand, .navbar-custom .nav-link {
      color: white;
    }
    .sidebar {
      background-color: #f8f9fa;
      min-height: calc(100vh - 56px);
      padding-top: 1rem;
    }
    .main-content {
      padding: 20px;
    }
    .badge-available {
      background-color: #28a745;
    }
    .badge-unavailable {
      background-color: #dc3545;
    }
  </style>
</head>
<body>
<!-- 导航栏 -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/reader/main">
      <i class="fas fa-book"></i> XX图书馆
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/reader/reader_lend_list">我的借阅</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/reader/reader_info">个人信息</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/reader/reader_book_query">图书检索</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/reader/reader_book_detail">所有图书</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/reader/reader_repasswd">修改密码</a>
        </li>
      </ul>
      <div class="d-flex">
                <span class="navbar-text me-3">
                    <i class="fas fa-user"></i> ${reader.name}
                </span>
        <a class="btn btn-outline-light" href="/logout.jsp">
          <i class="fas fa-sign-out-alt"></i> 退出
        </a>
      </div>
    </div>
  </div>
</nav>

