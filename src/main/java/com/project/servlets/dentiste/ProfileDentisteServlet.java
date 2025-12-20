package com.project.servlets.dentiste;

import java.io.IOException;

import com.project.entities.Dentiste;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/dentiste/profile")
public class ProfileDentisteServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        Dentiste dentiste = (Dentiste) session.getAttribute("dentiste");

        if (dentiste == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        req.setAttribute("dentiste", dentiste);
        req.getRequestDispatcher("/WEB-INF/views/dentistes/Profile.jsp").forward(req, resp);
    }
}