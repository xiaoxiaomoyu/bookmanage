package com.book.controller;

import com.book.domain.Admin;
import com.book.domain.ReaderCard;
import com.book.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class LoginController {
    private LoginService loginService;

    @Autowired
    public void setLoginService(LoginService loginService) {
        this.loginService = loginService;
    }

    // 登录页（对应 login.jsp）
    @GetMapping(value = {"/", "/login"})
    public String toLogin(HttpServletRequest request) {
        request.getSession().invalidate();
        return "login";
    }

    // 登出（对应 logout.jsp）
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/login";
    }

    // 登录验证
    @PostMapping("/login")
    public String loginCheck(
            @RequestParam("username") String username,
            @RequestParam("password") String passwd,
            HttpSession session,
            RedirectAttributes redirectAttributes,
            HttpServletRequest request) {

        boolean isReader = loginService.hasMatchReader(username, passwd);
        boolean isAdmin = loginService.hasMatchAdmin(username, passwd);

        if (!isAdmin && !isReader) {
            redirectAttributes.addFlashAttribute("error", "账号或密码错误！");
            return "redirect:/login";
        } else if (isAdmin) {
            Admin admin = new Admin();
            admin.setAdminId(username);
            String ip = request.getRemoteAddr();
            loginService.recordAdminLogin(username, ip);
            session.setAttribute("admin", admin);
            return "redirect:/admin/main";
        } else{
            try {
                ReaderCard readerCard = new ReaderCard();
                readerCard.setReaderId(username);
                String ip = request.getRemoteAddr();
                loginService.recordReaderCardLogin(username, ip);
                if (readerCard != null) {
                    session.setAttribute("readercard", readerCard);
                    return "redirect:/reader/main";
                } else {
                    redirectAttributes.addFlashAttribute("error", "读者信息不存在！");
                    return "redirect:/login";
                }
            } catch (NumberFormatException e) {
                redirectAttributes.addFlashAttribute("error", "账号格式错误！请输入数字ID");
                return "redirect:/login";
            }
//            ReaderCard readerCard = loginService.findReaderCardByUserId(username);
//            session.setAttribute("readercard", readerCard);
//            return "redirect:/reader/main";
        }
    }

    @GetMapping("/admin/main")
    public String adminMain(HttpSession session) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/login";
        }
        return "admin/main";
    }

    @GetMapping("/reader/main")
    public String readerMain(HttpSession session) {
        if (session.getAttribute("readercard") == null) {
            return "redirect:/login";
        }
        return "reader/main";
    }

    // 管理员密码修改页
    @GetMapping("/admin/repassword")
    public String reAdminPasswd(HttpSession session) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/login";
        }
        return "admin/repasswd";
    }

    // 密码修改提交
    @PostMapping("/admin/repassword")
    public String reAdminPasswdDo(
            @RequestParam("oldPasswd") String oldPasswd,
            @RequestParam("newPasswd") String newPasswd,
            @RequestParam("reNewPasswd") String reNewPasswd,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/login";
        }

        if (!newPasswd.equals(reNewPasswd)) {
            redirectAttributes.addFlashAttribute("error", "两次输入的新密码不一致！");
            return "redirect:/admin/repassword";
        }

        boolean succ = loginService.adminRePasswd(admin.getAdminId(), newPasswd, oldPasswd);
        if (succ) {
            admin.setPassword(newPasswd);
            session.setAttribute("admin", admin);
            redirectAttributes.addFlashAttribute("success", "密码修改成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "旧密码不正确，修改失败！");
        }
        return "redirect:/admin/repassword";
    }

    // 404页面
    @RequestMapping("*")
    public String notFind() {
        return "404";
    }

    @Controller
    @RequestMapping("/admin/book")   //跳转admin文件book列表的jsp文件
    public class BookAdminController {

        @GetMapping("/admin_books")
        public String adminBooks(HttpSession session) {
            if (session.getAttribute("admin") == null) {
                return "redirect:/login";
            }
            return "admin/book/admin_books";
        }

        @GetMapping("/admin_book_detail")
        public String bookDetails(HttpSession session) {
            if (session.getAttribute("admin") == null) {
                return "redirect:/login";
            }
            return "/admin/book/admin_book_detail";
        }

    }

    @Controller
    @RequestMapping("/admin/reader")      //跳转到admin文件reader列表的jsp文件
    public class ReaderAdminController {

        @GetMapping("/admin_readers")
        public String adminReaders(HttpSession session) {
            if (session.getAttribute("admin") == null) {
                return "redirect:/login";
            }
            return "admin/reader/admin_readers";
        }
    }
    @Controller
    @RequestMapping("/reader")      //跳转到reader文件的jsp文件
    public class ReaderController {

        @GetMapping("/reader_info")
        public String readerInfos(HttpSession session) {
            if (session.getAttribute("readercard") == null) {
                return "redirect:/login";
            }
            return "reader/reader_info";
        }

        @GetMapping("/reader_lend_list")
        public String readerLendLists(HttpSession session) {
            if (session.getAttribute("readercard") == null) {
                return "redirect:/login";
            }
            return "reader/reader_lend_list";
        }

        @GetMapping("/reader_book_query")
        public String readerBookQuery(HttpSession session) {
            if (session.getAttribute("readercard") == null) {
                return "redirect:/login";
            }
            return "reader/reader_book_query";
        }

        @GetMapping("/reader_book_detail")
        public String readerBookDetail(HttpSession session) {
            if (session.getAttribute("readercard") == null) {
                return "redirect:/login";
            }
            return "reader/reader_book_detail";
        }

        @GetMapping("/reader_repasswd")
        public String readerRepasswd(HttpSession session) {
            if (session.getAttribute("readercard") == null) {
                return "redirect:/login";
            }
            return "reader/reader_repasswd";
        }
    }
}
