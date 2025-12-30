package com.project.servlets.auth;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        handleLogout(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        handleLogout(req, resp);
    }

    private void handleLogout(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        
        HttpSession session = req.getSession(false);

        if (session != null) {
            
            session.invalidate();
        }

        
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                cookie.setValue("");
                cookie.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
                cookie.setMaxAge(0);
                resp.addCookie(cookie);
            }
        }

        
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);

       
        HttpSession newSession = req.getSession(true);
        newSession.setAttribute("successMessage", "Vous avez été déconnecté avec succès");

        
        resp.sendRedirect(req.getContextPath() + "/");
    }
}