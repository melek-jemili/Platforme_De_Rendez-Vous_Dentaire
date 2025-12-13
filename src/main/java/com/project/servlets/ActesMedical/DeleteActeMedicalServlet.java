package com.project.servlets.ActesMedical;

import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IActeMedicalLocal;

@WebServlet("/actesmedicaux/delete")
public class DeleteActeMedicalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IActeMedicalLocal acteMedicalService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int idAM = Integer.parseInt(req.getParameter("idAM"));
        acteMedicalService.deleteActeMedical(idAM);

        resp.sendRedirect(req.getContextPath() + "/actesmedicaux");
    }
}