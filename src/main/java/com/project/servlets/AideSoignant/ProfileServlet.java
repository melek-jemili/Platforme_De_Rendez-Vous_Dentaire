package com.project.servlets.AideSoignant;

import java.io.IOException;

import com.project.entities.AideSoignant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/aidesoignants/profile")
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("aidesoignant") == null) {
            resp.sendRedirect(req.getContextPath() + "/"); 
            return;
        }

        AideSoignant aidesoignant = (AideSoignant) session.getAttribute("aidesoignant");

        req.setAttribute("aidesoignant", aidesoignant);

        req.getRequestDispatcher("/WEB-INF/views/aidesoignants/profile.jsp")
           .forward(req, resp);
    }
}
