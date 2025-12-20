package com.project.servlets.AideSoignant;
import java.io.IOException;
import java.util.List;

import com.project.entities.*;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.project.ejb.interfaces.IRendezvousLocal;

@WebServlet("/aidesoignant/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IRendezvousLocal rvservice;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("\n========================================");
        System.out.println("=== DASHBOARD AIDE-SOIGNANT - DEBUG ===");
        System.out.println("========================================");
        
        // Vérifier les cookies reçus
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            System.out.println("Cookies reçus:");
            for (Cookie cookie : cookies) {
                System.out.println("  - " + cookie.getName() + " = " + cookie.getValue());
            }
        } else {
            System.out.println("❌ AUCUN COOKIE REÇU !");
        }
        
        // Tenter de récupérer la session
        HttpSession session = req.getSession(false);
        
        System.out.println("\nSession:");
        if (session == null) {
            System.out.println("❌ Session NULL");
            System.out.println("Redirection vers login...");
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        
        System.out.println("✅ Session existe");
        System.out.println("  - Session ID: " + session.getId());
        System.out.println("  - Creation time: " + new java.util.Date(session.getCreationTime()));
        System.out.println("  - Last accessed: " + new java.util.Date(session.getLastAccessedTime()));
        System.out.println("  - Max inactive interval: " + session.getMaxInactiveInterval() + " secondes");
        
        // Lister TOUS les attributs de la session
        System.out.println("\nAttributs dans la session:");
        java.util.Enumeration<String> attributeNames = session.getAttributeNames();
        boolean hasAttributes = false;
        while (attributeNames.hasMoreElements()) {
            hasAttributes = true;
            String attrName = attributeNames.nextElement();
            Object attrValue = session.getAttribute(attrName);
            System.out.println("  - " + attrName + " = " + attrValue);
        }
        if (!hasAttributes) {
            System.out.println("  ⚠️ AUCUN ATTRIBUT DANS LA SESSION !");
        }
        
        // Vérifier l'attribut aide-soignant
        AideSoignant aidesoignant = (AideSoignant) session.getAttribute("aidesoignant");
        
        System.out.println("\nAide-Soignant:");
        if (aidesoignant == null) {
            System.out.println("❌ aidesoignant NULL");
            System.out.println("Redirection vers login...");
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        
        System.out.println("✅ AideSoignant trouvé");
        System.out.println("  - ID: " + aidesoignant.getIdAS());
        System.out.println("  - Nom: " + aidesoignant.getNom());
        System.out.println("  - Prénom: " + aidesoignant.getPrenom());

        // Charger les rendez-vous
        System.out.println("\nChargement des rendez-vous...");
        List<Rendezvous> rdvs = rvservice.getAllRendezvous();
        System.out.println("✅ " + (rdvs != null ? rdvs.size() : 0) + " rendez-vous trouvés");

        req.setAttribute("rendezvous", rdvs);
        
        System.out.println("\nForward vers JSP...");
        System.out.println("========================================\n");
        
        req.getRequestDispatcher("/WEB-INF/views/aidesoignants/dashboard.jsp").forward(req, resp);
    }
}