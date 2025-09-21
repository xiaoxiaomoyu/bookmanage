# 图书管理系统

## 项目概述
该图书管理系统是一个基于Java Web技术栈开发的图书馆数字化管理平台，主要实现图书馆用户（读者与管理员）的信息管理、图书信息查询及借阅相关功能，旨在通过信息化手段提升图书馆运营效率与用户体验。


## 技术栈
### 后端技术
- 核心框架：Spring Framework（Spring Core、Spring MVC、Spring Tx、Spring JDBC）
- 持久层：MyBatis 3.5.9（搭配MyBatis-Spring整合）
- 编程语言：Java 8
- 数据库：MySQL 8.0.28（通过commons-dbcp2 2.9.0实现连接池管理）
- 构建工具：Maven
- AOP支持：AspectJ 1.9.7
- 测试框架：TestNG 7.5

### 前端技术
- 视图层：JSP、JSTL 1.2
- 样式框架：Bootstrap、font-awesome
- 脚本：JavaScript（ES6）
- 服务器：Tomcat 9.0.24、Jetty 9.4.44.v20210927

### 开发工具
- IDE：IntelliJ IDEA


## 核心功能
1. **用户角色与认证**  
   支持读者与管理员双角色，通过`ReaderCard`实现登录认证、会话管理及权限区分，保障系统访问安全性。

2. **读者信息管理**  
   - 读者信息CRUD：包括添加、查询、编辑（姓名、性别、生日等）、删除读者信息，通过`ReaderInfoService`与`ReaderInfoDao`实现数据交互。
   - 读者卡管理：关联读者信息创建读者卡，支持密码修改（`updatePasswd`）、姓名更新（`updateName`）等功能。

3. **图书信息相关**  
   支持图书详情查询（通过`BookController`实现读者端图书详情页展示），为借阅功能提供基础数据支持。


## 项目结构
 bookmanage  
 ├── src/main/java/com/book  
 │ ├── domain // 实体类（ReaderInfo、ReaderCard、Book 等）  
 │ ├── dao // 数据访问层接口（ReaderInfoDao 等，与 MyBatis 映射）  
 │ ├── service // 业务逻辑层接口及实现（ReaderInfoService、ReaderCardService 等）  
 │ ├── controller // 控制层（ReaderController、LoginController、BookController 等，处理 HTTP 请求）  
 │ └── command // 命令对象（如 BookAddCommand，用于数据转换）  
 ├── src/main/resources  
 │ └── mapper // MyBatis 映射文件（ReaderInfoMapper.xml 等）  
 ├── src/main/webapp // 前端资源（JSP 视图、静态资源等）  
 ├── pom.xml // Maven 依赖配置  
 └── 配置文件 // IDE 配置、编码配置等  


## 关键模块说明
1. **读者信息模块**  
   - 实体类`ReaderInfo`：封装读者基本信息（ID、姓名、性别、生日、联系方式等）及借阅额度（可借数量、已借数量）。
   - 服务层`ReaderInfoServiceImpl`：实现读者信息的增删改查业务逻辑，依赖`ReaderInfoDao`操作数据库。
   - 控制层`ReaderController`：处理读者信息相关HTTP请求（列表展示、添加、编辑、删除等），协调前端视图与后端数据交互，包含日期格式校验等逻辑。

2. **读者卡模块**  
   - 实体类`ReaderCard`：存储读者登录凭证（ID、密码、角色），关联读者基本信息。
   - 服务层`ReaderCardServiceImpl`：实现读者卡创建、密码修改、姓名同步等功能，确保读者信息与登录信息一致性。

3. **数据持久层**  
   通过MyBatis映射文件（如`ReaderInfoMapper.xml`）定义SQL语句，实现实体类与数据库表的映射，支持高效数据操作。
