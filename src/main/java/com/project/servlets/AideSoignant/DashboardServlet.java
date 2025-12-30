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
//import jakarta.servlet.http.Cookie;
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

        /*Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            System.out.println("Cookies reçus:");
            for (Cookie cookie : cookies) {
                System.out.println("  - " + cookie.getName() + " = " + cookie.getValue());
            }
        } else {
            System.out.println("❌ AUCUN COOKIE REÇU !");
        }*/
        
        HttpSession session = req.getSession(false);
        if (session == null) {
          
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        
       

        /*System.out.println("\nAttributs dans la session:");
        java.util.Enumeration<String> attributeNames = session.getAttributeNames();
        boolean hasAttributes = false;
        while (attributeNames.hasMoreElements()) {
            hasAttributes = true;
            String attrName = attributeNames.nextElement();
            Object attrValue = session.getAttribute(attrName);
            System.out.println("  - " + attrName + " = " + attrValue);
        }*/
        
        

        AideSoignant aidesoignant = (AideSoignant) session.getAttribute("aidesoignant");
        
        
        if (aidesoignant == null) {
            
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        List<Rendezvous> rendezvous = rvservice.getAllRendezvous();
        if (rendezvous == null) {
            rendezvous = new ArrayList<>();
        }

        Set<Patient> patientsSet = new HashSet<>();
        for (Rendezvous rdv : rendezvous) {
            if (rdv.getPatient() != null) {
                patientsSet.add(rdv.getPatient());
            }
        }
        List<Patient> patients = new ArrayList<>(patientsSet);

        List<Publication> publications = null;
        try {
            publications = publicationService.getAllPublication();
        } catch (Exception e) {
            
            publications = new ArrayList<>();
        }
        if (publications == null) {
            publications = new ArrayList<>();
        }

        


        List<ServiceMedical> services = null;
        try {
            services = serviceMedicalService.getAllServiceMedical();
        } catch (Exception e) {
            services = new ArrayList<>();
        }
        if (services == null) {
            services = new ArrayList<>();
        }

        
       
        req.setAttribute("rendezvous", rendezvous);
        req.setAttribute("patients", patients);
        req.setAttribute("publications", publications);
        req.setAttribute("services", services);
        
        
        req.getRequestDispatcher("/WEB-INF/views/aidesoignants/dashboard.jsp").forward(req, resp);
    }
}