package com.project.servlets.ActesMedical;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IActeMedicalLocal;
import com.project.ejb.interfaces.IRendezvousLocal;
import com.project.ejb.interfaces.IServiceMedicalLocal;
import com.project.entities.ActeMedical;
import com.project.entities.Rendezvous;
import com.project.entities.ServiceMedical;

@WebServlet("/actesmedicaux/add")
public class AddActeMedicalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @EJB
    private IActeMedicalLocal acteMedicalService;
    
    @EJB
    private IRendezvousLocal rendezvousService;
    
    @EJB
    private IServiceMedicalLocal serviceMedicalService;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        List<Rendezvous> rendezvousList = rendezvousService.getAllRendezvous();
        
        
        List<ServiceMedical> servicesList = serviceMedicalService.getAllServiceMedical();
        
        
        req.setAttribute("rendezvousList", rendezvousList);
        req.setAttribute("servicesList", servicesList);
        
        req.getRequestDispatcher("/WEB-INF/views/actemedical/add.jsp")
           .forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            ActeMedical acte = new ActeMedical();
            
            
            int idRv = Integer.parseInt(req.getParameter("idRv"));
            Rendezvous rdv = rendezvousService.getRendezvous(idRv);
            acte.setRendezvous(rdv);
            
            
            int numSM = Integer.parseInt(req.getParameter("numSM"));
            ServiceMedical service = serviceMedicalService.getServiceMedical(numSM);
            acte.setServiceMedical(service);
            
            acte.setDescriptionAM(req.getParameter("descriptionAM"));
            
            String tarifStr = req.getParameter("tarifAM");
            if (tarifStr != null && !tarifStr.isEmpty()) {
                acte.setTarifAM(new BigDecimal(tarifStr));
            }
            
            acteMedicalService.addActeMedical(acte);
            
            req.getSession().setAttribute("successMessage", "Acte médical ajouté avec succès !");
            resp.sendRedirect(req.getContextPath() + "/actesmedicaux");
            
        } catch (Exception e) {
           
            req.getSession().setAttribute("errorMessage", "Erreur lors de l'ajout de l'acte médical : " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/actesmedicaux/add");
        }
    }
}