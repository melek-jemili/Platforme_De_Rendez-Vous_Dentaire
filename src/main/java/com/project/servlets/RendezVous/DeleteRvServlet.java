package com.project.servlets.RendezVous;

import java.io.IOException;
import com.project.ejb.interfaces.IRendezvousLocal;
import com.project.entities.Rendezvous;
import com.project.entities.Patient;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/rendezvous/delete")
public class DeleteRvServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    @EJB
    private IRendezvousLocal rvService;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
      
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("patient") == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        
        Patient patient = (Patient) session.getAttribute("patient");
        String idRvParam = req.getParameter("idRv");
        
       
        if (idRvParam == null || idRvParam.trim().isEmpty()) {
            session.setAttribute("errorMessage", "ID du rendez-vous manquant");
            resp.sendRedirect(req.getContextPath() + "/patient/dashboard");
            return;
        }
        
        try {
            int idRv = Integer.parseInt(idRvParam);
            Rendezvous rv = rvService.getRendezvous(idRv);
            
            
            if (rv == null) {
                session.setAttribute("errorMessage", "Rendez-vous introuvable");
                resp.sendRedirect(req.getContextPath() + "/patient/dashboard");
                return;
            }
            
           
            if (rv.getPatient().getIdP() != patient.getIdP()) {
                session.setAttribute("errorMessage", "Vous n'êtes pas autorisé à supprimer ce rendez-vous");
                resp.sendRedirect(req.getContextPath() + "/patient/dashboard");
                return;
            }
            
            
            rvService.deleteRendezvous(idRv);
            session.setAttribute("successMessage", "Rendez-vous supprimé avec succès");
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "ID du rendez-vous invalide");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Erreur lors de la suppression: " + e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/patient/dashboard");
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}