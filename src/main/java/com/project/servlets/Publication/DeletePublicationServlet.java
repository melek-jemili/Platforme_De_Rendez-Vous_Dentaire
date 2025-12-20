package com.project.servlets.Publication;

import java.io.IOException;

import com.project.ejb.interfaces.IPublicationLocal;
import com.project.entities.Publication;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/publication/delete")
public class DeletePublicationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @EJB
    private IPublicationLocal pubservice;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("aidesoignant") == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String idPubStr = req.getParameter("idPub");
        
        if (idPubStr == null || idPubStr.trim().isEmpty()) {
            session.setAttribute("errorMessage", "ID de publication manquant.");
            resp.sendRedirect(req.getContextPath() + "/publications");
            return;
        }

        try {
            int idPub = Integer.parseInt(idPubStr.trim());
            
            Publication pub = pubservice.getPublication(idPub);
            
            if (pub == null) {
                session.setAttribute("errorMessage", "Publication introuvable.");
                resp.sendRedirect(req.getContextPath() + "/publications");
                return;
            }
            
            pubservice.deletePublication(idPub);
            session.setAttribute("successMessage", "Publication supprimée avec succès !");
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "ID de publication invalide.");
            
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Erreur lors de la suppression: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/publications");
    }
}