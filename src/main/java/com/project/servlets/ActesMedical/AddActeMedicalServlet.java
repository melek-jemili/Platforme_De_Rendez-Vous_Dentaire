package com.project.servlets.ActesMedical;

import java.io.IOException;
import java.math.BigDecimal;
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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        ActeMedical acte = new ActeMedical();
        
        // Récupérer le rendez-vous
        int idRv = Integer.parseInt(req.getParameter("idRv"));
        Rendezvous rdv = rendezvousService.getRendezvous(idRv);
        acte.setRendezvous(rdv);
        
        // Récupérer le service médical
        int numSM = Integer.parseInt(req.getParameter("numSM"));
        ServiceMedical service = serviceMedicalService.getServiceMedical(numSM);
        acte.setServiceMedical(service);
        
        acte.setDescriptionAM(req.getParameter("descriptionAM"));
        
        String tarifStr = req.getParameter("tarifAM");
        if (tarifStr != null && !tarifStr.isEmpty()) {
            acte.setTarifAM(new BigDecimal(tarifStr));
        }

        acteMedicalService.addActeMedical(acte);

        resp.sendRedirect(req.getContextPath() + "/actesmedicaux");
    }
}