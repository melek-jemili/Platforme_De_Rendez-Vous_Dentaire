package com.project.servlets.AideSoignant;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
import com.project.ejb.interfaces.IPatientLocal;
import com.project.ejb.interfaces.IPublicationLocal;
import com.project.ejb.interfaces.IServiceMedicalLocal;

@WebServlet("/aidesoignant/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IRendezvousLocal rvservice;
    
    @EJB
    private IPatientLocal patientService;
    
    @EJB
    private IPublicationLocal publicationService;
    
    @EJB
    private IServiceMedicalLocal serviceMedicalService;
    
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

        // ========================================
        // CHARGER TOUTES LES DONNÉES
        // ========================================
        
        // 1. Charger les rendez-vous
        System.out.println("\n--- Chargement des données ---");
        System.out.println("Chargement des rendez-vous...");
        List<Rendezvous> rendezvous = rvservice.getAllRendezvous();
        if (rendezvous == null) {
            rendezvous = new ArrayList<>();
        }
        System.out.println("✅ " + rendezvous.size() + " rendez-vous trouvés");

        // 2. Extraire les patients uniques depuis les rendez-vous
        System.out.println("\nExtraction des patients depuis les rendez-vous...");
        Set<Patient> patientsSet = new HashSet<>();
        for (Rendezvous rdv : rendezvous) {
            if (rdv.getPatient() != null) {
                patientsSet.add(rdv.getPatient());
            }
        }
        List<Patient> patients = new ArrayList<>(patientsSet);
        System.out.println("✅ " + patients.size() + " patients uniques trouvés");
        
        // Alternative: Si vous avez un service pour récupérer tous les patients
        // List<Patient> patients = patientService.getAllPatients();
        // if (patients == null) patients = new ArrayList<>();
        
        // 3. Charger les publications
        System.out.println("\nChargement des publications...");
        List<Publication> publications = null;
        try {
            publications = publicationService.getAllPublication();
        } catch (Exception e) {
            System.out.println("⚠️ Erreur lors du chargement des publications: " + e.getMessage());
            publications = new ArrayList<>();
        }
        if (publications == null) {
            publications = new ArrayList<>();
        }
        System.out.println("✅ " + publications.size() + " publications trouvées");
        
        // 4. Charger les services médicaux
        System.out.println("\nChargement des services médicaux...");
        List<ServiceMedical> services = null;
        try {
            services = serviceMedicalService.getAllServiceMedical();
        } catch (Exception e) {
            System.out.println("⚠️ Erreur lors du chargement des services: " + e.getMessage());
            services = new ArrayList<>();
        }
        if (services == null) {
            services = new ArrayList<>();
        }
        System.out.println("✅ " + services.size() + " services médicaux trouvés");
        
        // ========================================
        // PASSER LES DONNÉES À LA VUE
        // ========================================
        
        System.out.println("\n--- Passage des données à la JSP ---");
        req.setAttribute("rendezvous", rendezvous);
        req.setAttribute("patients", patients);
        req.setAttribute("publications", publications);
        req.setAttribute("services", services);
        
        System.out.println("✅ Toutes les données sont prêtes");
        System.out.println("  - Rendez-vous: " + rendezvous.size());
        System.out.println("  - Patients: " + patients.size());
        System.out.println("  - Publications: " + publications.size());
        System.out.println("  - Services: " + services.size());
        
        System.out.println("\nForward vers JSP...");
        System.out.println("========================================\n");
        
        req.getRequestDispatcher("/WEB-INF/views/aidesoignants/dashboard.jsp").forward(req, resp);
    }
}