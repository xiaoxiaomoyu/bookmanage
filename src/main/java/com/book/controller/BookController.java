package com.book.controller;

import com.book.command.BookAddCommand;
import com.book.domain.Book;
import com.book.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

@Controller
@RequestMapping("/book") // 统一前缀
public class BookController {
    private final BookService bookService;

    @Autowired
    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    // 图书列表（对应 admin_books.jsp）
    @RequestMapping("/list.html")
    public ModelAndView allBook() {
        ArrayList<Book> books = bookService.getAllBooks();
        return new ModelAndView("admin_books", "books", books);
    }

    // 图书查询（对应 admin_books.jsp）
    @RequestMapping("/query.html")
    public ModelAndView queryBookDo(HttpServletRequest request, String searchWord) {
        boolean exist = bookService.matchBook(searchWord);
        if (exist) {
            ArrayList<Book> books = bookService.queryBook(searchWord);
            return new ModelAndView("admin_books", "books", books);
        } else {
            return new ModelAndView("admin_books", "error", "没有匹配的图书");
        }
    }

    // 读者图书查询页（对应 reader_book_query.jsp）
    @RequestMapping("/reader/query.html")
    public ModelAndView readerQueryBook() {
        return new ModelAndView("reader_book_query");
    }

    // 读者图书查询执行（对应 reader_book_query.jsp）
    @RequestMapping("/reader/query/do.html")
    public String readerQueryBookDo(String searchWord, RedirectAttributes redirectAttributes) {
        boolean exist = bookService.matchBook(searchWord);
        if (exist) {
            ArrayList<Book> books = bookService.queryBook(searchWord);
            redirectAttributes.addFlashAttribute("books", books);
        } else {
            redirectAttributes.addFlashAttribute("error", "没有匹配的图书！");
        }
        return "redirect:/book/reader/query.html";
    }

    // 图书删除（对应 admin_books.jsp）
    @RequestMapping("/delete.html")
    public String deleteBook(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        long bookId = Long.parseLong(request.getParameter("bookId"));
        int res = bookService.deleteBook(bookId);
        if (res == 1) {
            redirectAttributes.addFlashAttribute("success", "图书删除成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "图书删除失败！");
        }
        return "redirect:/book/list.html";
    }

    // 图书添加页（对应 admin_book_add.jsp）
    @RequestMapping("/add.html")
    public ModelAndView addBook() {
        return new ModelAndView("admin_book_add");
    }

    // 图书添加执行（对应 admin_book_add.jsp）
    @RequestMapping("/add/do.html")
    public String addBookDo(BookAddCommand bookAddCommand, RedirectAttributes redirectAttributes) {
        Book book = bookAddCommand.toBook();
        boolean succ = bookService.addBook(book);
        if (succ) {
            redirectAttributes.addFlashAttribute("success", "图书添加成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "图书添加失败！");
        }
        return "redirect:/book/list.html";
    }

    // 图书编辑页（对应 admin_book_edit.jsp）
    @RequestMapping("/edit.html")
    public ModelAndView bookEdit(HttpServletRequest request) {
        long bookId = Long.parseLong(request.getParameter("bookId"));
        Book book = bookService.getBook(bookId);
        return new ModelAndView("admin_book_edit", "book", book);
    }

    // 图书编辑执行（对应 admin_book_edit.jsp）
    @RequestMapping("/edit/do.html")
    public String bookEditDo(BookAddCommand bookAddCommand, RedirectAttributes redirectAttributes) {
        Book book = bookAddCommand.toBook();
        boolean succ = bookService.editBook(book);
        if (succ) {
            redirectAttributes.addFlashAttribute("success", "图书修改成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "图书修改失败！");
        }
        return "redirect:/book/list.html";
    }

    // 图书详情页（对应 admin_book_detail.jsp）
    @RequestMapping("/detail.html")
    public ModelAndView bookDetail(HttpServletRequest request) {
        long bookId = Long.parseLong(request.getParameter("bookId"));
        Book book = bookService.getBook(bookId);
        return new ModelAndView("admin_book_detail", "book", book);
    }

    // 读者图书详情页（对应 reader_book_detail.jsp）
    @RequestMapping("/reader/detail.html")
    public ModelAndView readerBookDetail(HttpServletRequest request) {
        long bookId = Long.parseLong(request.getParameter("bookId"));
        Book book = bookService.getBook(bookId);
        return new ModelAndView("reader_book_detail", "book", book);
    }
}