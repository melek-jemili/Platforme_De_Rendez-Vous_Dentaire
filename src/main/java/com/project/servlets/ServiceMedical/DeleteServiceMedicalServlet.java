package com.project.servlets.ServiceMedical;

import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IServiceMedicalLocal;
import com.project.entities.ServiceMedical;

@WebServlet("/servicesmedicaux/delete")
public class DeleteServiceMedicalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IServiceMedicalLocal serviceMedicalService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        
        String numSMParam = req.getParameter("numSM");
        
      
        if (numSMParam == null || numSMParam.trim().isEmpty()) {
            session.setAttribute("errorMessage", "ID du service médical manquant");
            resp.sendRedirect(req.getContextPath() + "/servicesmedicaux");
            return;
        }
        
        try {
            int numSM = Integer.parseInt(numSMParam);
            
            
            ServiceMedical service = serviceMedicalService.getServiceMedical(numSM);
            
            if (service == null) {
                session.setAttribute("errorMessage", "Service médical introuvable");
                resp.sendRedirect(req.getContextPath() + "/servicesmedicaux");
                return;
            }
            
           
            serviceMedicalService.deleteServiceMedical(numSM);
            session.setAttribute("successMessage", "Service médical supprimé avec succès");
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "ID du service médical invalide");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Erreur lors de la suppression: " + e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/servicesmedicaux");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}