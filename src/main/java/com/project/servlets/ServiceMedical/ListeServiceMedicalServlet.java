package com.project.servlets.ServiceMedical;

import java.io.IOException;
import java.util.List;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IServiceMedicalLocal;
import com.project.entities.ServiceMedical;

@WebServlet("/servicesmedicaux")
public class ListeServiceMedicalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IServiceMedicalLocal serviceMedicalService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<ServiceMedical> services = serviceMedicalService.getAllServiceMedical();
        req.setAttribute("services", services);
        req.getRequestDispatcher("/WEB-INF/views/servicemedical/liste.jsp").forward(req, resp);
    }
}