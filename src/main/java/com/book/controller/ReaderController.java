package com.book.controller;

import com.book.domain.ReaderCard;
import com.book.domain.ReaderInfo;
import com.book.service.LoginService;
import com.book.service.ReaderCardService;
import com.book.service.ReaderInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

@Controller
@RequestMapping("/reader")
public class ReaderController {
    private ReaderInfoService readerInfoService;
    private LoginService loginService;
    private ReaderCardService readerCardService;

    @Autowired
    public void setReaderInfoService(ReaderInfoService readerInfoService) {
        this.readerInfoService = readerInfoService;
    }

    @Autowired
    public void setLoginService(LoginService loginService) {
        this.loginService = loginService;
    }

    @Autowired
    public void setReaderCardService(ReaderCardService readerCardService) {
        this.readerCardService = readerCardService;
    }

    @RequestMapping("/list.html")
    public ModelAndView readerList() {
        ArrayList<ReaderInfo> readers = readerInfoService.readerInfos();
        return new ModelAndView("admin_readers", "readers", readers);
    }

    @RequestMapping("/delete.html")
    public String readerDelete(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        int readerId = Integer.parseInt(request.getParameter("readerId"));
        boolean success = readerInfoService.deleteReaderInfo(String.valueOf(readerId));
        if (success) {
            redirectAttributes.addFlashAttribute("success", "删除成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "删除失败！");
        }
        return "redirect:/reader/list.html";
    }

    @RequestMapping("/info.html")
    public ModelAndView readerInfo(HttpServletRequest request) {
        HttpSession session = request.getSession();
        ReaderCard readerCard = (ReaderCard) session.getAttribute("readercard");
        if (readerCard == null) {
            return new ModelAndView("redirect:/login.jsp");
        }
        ReaderInfo readerInfo = readerInfoService.getReaderInfo(readerCard.getReaderId());
        return new ModelAndView("reader_info", "readerInfo", readerInfo);
    }

    @RequestMapping("/edit.html")
    public ModelAndView readerEdit(HttpServletRequest request) {
        int readerId = Integer.parseInt(request.getParameter("readerId"));
        ReaderInfo readerInfo = readerInfoService.getReaderInfo(String.valueOf(readerId));
        return new ModelAndView("admin_reader_edit", "readerInfo", readerInfo);
    }

    @RequestMapping("/edit/do.html")
    public String readerEditDo(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        // 1. 获取参数并创建ReaderInfo对象
        ReaderInfo readerInfo = new ReaderInfo();
        readerInfo.setReaderId(Integer.parseInt(request.getParameter("id")));
        readerInfo.setName(request.getParameter("name"));
        readerInfo.setSex(request.getParameter("sex"));
        readerInfo.setAddress(request.getParameter("address"));
        readerInfo.setPhone(request.getParameter("phone"));
        readerInfo.setEmail(request.getParameter("email"));

        // 2. 处理出生日期
        String birthStr = request.getParameter("birth");
        if (birthStr != null && !birthStr.isEmpty()) {
            try {
                readerInfo.setBirth(new SimpleDateFormat("yyyy-MM-dd").parse(birthStr));
            } catch (ParseException e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("error", "日期格式错误！");
                return "redirect:/reader/edit.html?readerId=" + readerInfo.getReaderId();
            }
        }

        // 3. 检查姓名是否修改
        int readerId = readerInfo.getReaderId();
        ReaderCard readerCard = loginService.findReaderCardByUserId(String.valueOf(readerId));
        boolean nameChanged = !readerCard.getName().equals(readerInfo.getName());

        // 4. 更新数据
        if (nameChanged) {
            boolean updateNameSuccess = readerCardService.updateName(String.valueOf(readerId), readerInfo.getName());
            boolean updateInfoSuccess = readerInfoService.editReaderInfo(readerInfo);

            if (updateNameSuccess && updateInfoSuccess) {
                redirectAttributes.addFlashAttribute("success", "读者信息修改成功！");
            } else {
                redirectAttributes.addFlashAttribute("error", "读者信息修改失败！");
            }
        } else {
            boolean updateInfoSuccess = readerInfoService.editReaderInfo(readerInfo);

            if (updateInfoSuccess) {
                redirectAttributes.addFlashAttribute("success", "读者信息修改成功！");
            } else {
                redirectAttributes.addFlashAttribute("error", "读者信息修改失败！");
            }
        }
        return "redirect:/reader/list.html";
    }

    @RequestMapping("/add.html")
    public ModelAndView readerAdd() {
        return new ModelAndView("admin_reader_add");
    }

    @RequestMapping("/add/do.html")
    public String readerAddDo(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        // 1. 获取参数
        String name = request.getParameter("name");
        String sex = request.getParameter("sex");
        String birthStr = request.getParameter("birth");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        // 2. 解析日期
        Date birth = null;
        if (birthStr != null && !birthStr.isEmpty()) {
            try {
                birth = new SimpleDateFormat("yyyy-MM-dd").parse(birthStr);
            } catch (ParseException e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("error", "出生日期格式错误！");
                return "redirect:/reader/add.html";
            }
        }

        // 3. 创建ReaderInfo对象
        ReaderInfo readerInfo = new ReaderInfo();
        readerInfo.setName(name);
        readerInfo.setSex(sex);
        readerInfo.setBirth(birth);
        readerInfo.setAddress(address);
        readerInfo.setPhone(phone);
        readerInfo.setEmail(email);
        readerInfo.setBorrowQuantity(5);
        readerInfo.setBorrowed(0);

        // 4. 调用服务
        boolean addInfoSuccess = readerInfoService.addReaderInfo(readerInfo);
        boolean addCardSuccess = readerCardService.addReaderCard(readerInfo);

        if (addInfoSuccess && addCardSuccess) {
            redirectAttributes.addFlashAttribute("success", "添加读者信息成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "添加读者信息失败！");
        }
        return "redirect:/reader/list.html";
    }

    @RequestMapping("/repasswd.html")
    public ModelAndView readerRePasswd(HttpServletRequest request) {
        HttpSession session = request.getSession();
        ReaderCard readerCard = (ReaderCard) session.getAttribute("readercard");
        if (readerCard == null) {
            return new ModelAndView("redirect:/login.jsp");
        }
        return new ModelAndView("reader_repasswd");
    }

    @RequestMapping("/repasswd/do.html")
    public String readerRePasswdDo(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession();
        ReaderCard readerCard = (ReaderCard) session.getAttribute("readercard");
        if (readerCard == null) {
            return "redirect:/login.jsp";
        }

        String oldPasswd = request.getParameter("oldPasswd");
        String newPasswd = request.getParameter("newPasswd");
        String reNewPasswd = request.getParameter("reNewPasswd");

        if (!newPasswd.equals(reNewPasswd)) {
            redirectAttributes.addFlashAttribute("error", "两次输入的新密码不一致！");
            return "redirect:/reader/repasswd.html";
        }

        if (readerCard.getPasswd().equals(oldPasswd)) {
            boolean success = readerCardService.updatePasswd(readerCard.getReaderId(), newPasswd);
            if (success) {
                ReaderCard newReaderCard = loginService.findReaderCardByUserId(readerCard.getReaderId());
                session.setAttribute("readercard", newReaderCard);
                redirectAttributes.addFlashAttribute("success", "密码修改成功！");
            } else {
                redirectAttributes.addFlashAttribute("error", "密码修改失败！");
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "原密码错误，修改失败！");
        }
        return "redirect:/reader/repasswd.html";
    }
}
