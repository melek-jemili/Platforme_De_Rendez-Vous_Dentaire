package com.project.servlets.ServiceMedical;

import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IServiceMedicalLocal;

@WebServlet("/servicesmedicaux/delete")
public class DeleteServiceMedicalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IServiceMedicalLocal serviceMedicalService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int numSM = Integer.parseInt(req.getParameter("numSM"));
        serviceMedicalService.deleteServiceMedical(numSM);

        resp.sendRedirect(req.getContextPath() + "/servicesmedicaux");
    }
}