package com.book.domain;

public class ReaderCard {
    private String ReaderId;     // 读者ID
    private String name;      // 姓名
    private String passwd;    // 密码
    private String role;      // 角色(reader/admin)

    // Getters and Setters
    public String getReaderId() {return ReaderId;}

    public void setReaderId(String readerId) {this.ReaderId = readerId;}

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
