package com.book.controller;

import com.book.domain.Book;
import com.book.domain.ReaderCard;
import com.book.service.BookService;
import com.book.service.LendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/lend") // 统一前缀
public class LendController {
    private LendService lendService;
    private BookService bookService;

    @Autowired
    public void setLendService(LendService lendService) {
        this.lendService = lendService;
    }

    @Autowired
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    // 图书借阅页（对应 admin_book_lend.jsp）
    @RequestMapping("/book.html")
    public ModelAndView bookLend(HttpServletRequest request) {
        long bookId = Long.parseLong(request.getParameter("bookId"));
        Book book = bookService.getBook(bookId);
        return new ModelAndView("admin_book_lend", "book", book);
    }

    // 图书借阅执行（对应 admin_book_lend.jsp）
    @RequestMapping("/book/do.html")
    public String bookLendDo(HttpServletRequest request, int readerId, RedirectAttributes redirectAttributes) {
        long bookId = Long.parseLong(request.getParameter("id"));
        boolean success = lendService.bookLend(bookId, readerId);
        if (success) {
            redirectAttributes.addFlashAttribute("success", "图书借阅成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "图书借阅失败！");
        }
        return "redirect:/book/list.html";
    }

    // 图书归还（对应 admin_book_lend.jsp）
    @RequestMapping("/return.html")
    public String bookReturn(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        long bookId = Long.parseLong(request.getParameter("bookId"));
        boolean success = lendService.bookReturn(bookId);
        if (success) {
            redirectAttributes.addFlashAttribute("success", "图书归还成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "图书归还失败！");
        }
        return "redirect:/book/list.html";
    }

    // 借阅列表（对应 admin_lend_list.jsp）
    @RequestMapping("/list.html")
    public ModelAndView lendList() {
        return new ModelAndView("admin_lend_list", "lendList", lendService.lendList());
    }

    // 我的借阅（对应 reader_lend_list.jsp）
    @RequestMapping("/my.html")
    public ModelAndView myLend(HttpServletRequest request) {
        HttpSession session = request.getSession();
        ReaderCard readerCard = (ReaderCard) session.getAttribute("readercard");
        if (readerCard == null) {
            return new ModelAndView("redirect:/login.jsp");
        }
        return new ModelAndView("reader/reader_lend_list", "lendList", lendService.myLendList(readerCard.getReaderId()));
    }
}