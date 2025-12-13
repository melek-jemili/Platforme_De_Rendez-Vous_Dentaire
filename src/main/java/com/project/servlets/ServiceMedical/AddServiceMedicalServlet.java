package com.project.servlets.ServiceMedical;

import java.io.IOException;
import java.math.BigDecimal;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IServiceMedicalLocal;
import com.project.entities.ServiceMedical;

@WebServlet("/servicesmedicaux/add")
public class AddServiceMedicalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IServiceMedicalLocal serviceMedicalService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        ServiceMedical service = new ServiceMedical();
        service.setNomSM(req.getParameter("nomSM"));
        service.setTypeSM(req.getParameter("typeSM"));
        service.setDescriptionSM(req.getParameter("descriptionSM"));
        
        String tarifStr = req.getParameter("tarifSM");
        if (tarifStr != null && !tarifStr.isEmpty()) {
            service.setTarifSM(new BigDecimal(tarifStr));
        }

        serviceMedicalService.addServiceMedical(service);

        resp.sendRedirect(req.getContextPath() + "/servicesmedicaux");
    }
}