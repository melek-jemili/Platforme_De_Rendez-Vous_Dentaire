package com.project.servlets.ActesMedical;

import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IActeMedicalLocal;
import com.project.entities.ActeMedical;

@WebServlet("/actesmedicaux/delete")
public class DeleteActeMedicalServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    @EJB
    private IActeMedicalLocal acteMedicalService;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        
        String idAMParam = req.getParameter("idAM");
        
        
        if (idAMParam == null || idAMParam.trim().isEmpty()) {
            session.setAttribute("errorMessage", "ID de l'acte médical manquant");
            resp.sendRedirect(req.getContextPath() + "/actesmedicaux");
            return;
        }
        
        try {
            int idAM = Integer.parseInt(idAMParam);
            
            
            ActeMedical acteMedical = acteMedicalService.getActeMedical(idAM);
            
            if (acteMedical == null) {
                session.setAttribute("errorMessage", "Acte médical introuvable");
                resp.sendRedirect(req.getContextPath() + "/actesmedicaux");
                return;
            }
            
            
            acteMedicalService.deleteActeMedical(idAM);
            session.setAttribute("successMessage", "Acte médical supprimé avec succès");
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "ID de l'acte médical invalide");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Erreur lors de la suppression: " + e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/actesmedicaux");
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}