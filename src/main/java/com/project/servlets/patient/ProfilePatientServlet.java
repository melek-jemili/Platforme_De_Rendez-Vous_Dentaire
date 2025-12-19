package com.project.servlets.patient;

import java.io.IOException;

import com.project.entities.Patient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/patient/profile")
public class ProfilePatientServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("patient") == null) {
            resp.sendRedirect(req.getContextPath() + "/"); 
            return;
        }

        Patient patient = (Patient) session.getAttribute("patient");

        req.setAttribute("patient", patient);

        req.getRequestDispatcher("/WEB-INF/views/patients/profile.jsp")
           .forward(req, resp);
    }
}
