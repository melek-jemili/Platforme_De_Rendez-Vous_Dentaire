package com.project.servlets.ActesMedical;

import java.io.IOException;
import java.util.List;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IActeMedicalLocal;
import com.project.entities.ActeMedical;

@WebServlet("/actesmedicaux")
public class ListeActeMedicalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IActeMedicalLocal acteMedicalService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<ActeMedical> actes = acteMedicalService.getAllActeMedical();
        req.setAttribute("actes", actes);
        req.getRequestDispatcher("/WEB-INF/views/actesmedicaux/list.jsp").forward(req, resp);
    }
}