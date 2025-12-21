package com.project.servlets.ServiceMedical;

import java.io.IOException;
import java.math.BigDecimal;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IServiceMedicalLocal;
import com.project.entities.ServiceMedical;

@WebServlet("/servicesmedicaux/update")
public class UpdateServiceMedicalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IServiceMedicalLocal serviceMedicalService;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int numSM = Integer.parseInt(req.getParameter("numSM"));
        ServiceMedical service = serviceMedicalService.getServiceMedical(numSM);
        req.setAttribute("service", service);
        req.getRequestDispatcher("/WEB-INF/views/servicemedical/edit.jsp")
           .forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int numSM = Integer.parseInt(req.getParameter("numSM"));
        ServiceMedical service = serviceMedicalService.getServiceMedical(numSM);

        service.setNomSM(req.getParameter("nomSM"));
        service.setTypeSM(req.getParameter("typeSM"));
        service.setDescriptionSM(req.getParameter("descriptionSM"));
        
        String tarifStr = req.getParameter("tarifSM");
        if (tarifStr != null && !tarifStr.isEmpty()) {
            service.setTarifSM(new BigDecimal(tarifStr));
        }

        serviceMedicalService.updateServiceMedical(service);

        resp.sendRedirect(req.getContextPath() + "/servicesmedicaux");
    }
}