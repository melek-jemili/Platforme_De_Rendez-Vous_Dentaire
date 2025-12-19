package com.project.servlets.RendezVous;

import java.io.IOException;
import java.util.List;

import com.project.ejb.interfaces.IDentisteLocal;
import com.project.ejb.interfaces.IPatientLocal;
import com.project.ejb.interfaces.IRendezvousLocal;
import com.project.entities.Dentiste;
import com.project.entities.Patient;
import com.project.entities.Rendezvous;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/rendezvous/add")
public class AddRvServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @EJB
    private IRendezvousLocal rvService;

    @EJB
    private IPatientLocal patientService;

    @EJB
    private IDentisteLocal dentisteService;

    // ===================== GET : afficher le formulaire =====================
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Dentiste> dentistes = dentisteService.getAllDentistes();
        req.setAttribute("dentistes", dentistes);

        req.getRequestDispatcher("/WEB-INF/views/rendezvous/addrv.jsp")
           .forward(req, resp);
    }

    // ===================== POST : créer le rendez-vous =====================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            HttpSession session = req.getSession(false);

            // Sécurité : patient connecté obligatoire
            if (session == null || session.getAttribute("patient") == null) { // ← CHANGÉ ICI
                resp.sendRedirect(req.getContextPath() + "/");
                return;
            }

            Patient patient = (Patient) session.getAttribute("patient"); // ← CHANGÉ ICI

            // Récupération des champs
            String idDStr = req.getParameter("idD");
            String dateRvStr = req.getParameter("dateRv");
            String heureRvStr = req.getParameter("heureRv");
            String statutRv = req.getParameter("statutRv");
            String detailsRv = req.getParameter("detailsRv");

            System.out.println(">>> Création rendez-vous pour patient: " + patient.getPrenomP());
            System.out.println(">>> Date: " + dateRvStr);
            System.out.println(">>> Heure: " + heureRvStr);
            System.out.println(">>> Dentiste ID: " + idDStr);

            // Validation
            if (idDStr == null || idDStr.isEmpty()
                || dateRvStr == null || dateRvStr.isEmpty()
                || heureRvStr == null || heureRvStr.isEmpty()) {

                req.setAttribute("error", "Tous les champs obligatoires doivent être remplis.");
                doGet(req, resp);
                return;
            }

            int idD = Integer.parseInt(idDStr);
            Dentiste dentiste = dentisteService.getDentiste(idD);

            if (dentiste == null) {
                req.setAttribute("error", "Dentiste introuvable.");
                doGet(req, resp);
                return;
            }

            // Création du rendez-vous
         // Création du rendez-vous
            Rendezvous rv = new Rendezvous();
            rv.setPatient(patient);
            rv.setDentiste(dentiste);

            // Convertir en java.util.Date
            java.sql.Date sqlDate = java.sql.Date.valueOf(dateRvStr);
            rv.setDateRv(new java.util.Date(sqlDate.getTime()));

            // Heure
            if (heureRvStr.split(":").length == 2) {
                heureRvStr += ":00";
            }
            java.sql.Time sqlTime = java.sql.Time.valueOf(heureRvStr);
            rv.setHeureRv(new java.util.Date(sqlTime.getTime()));

            rv.setStatutRv(
                statutRv != null && !statutRv.isEmpty() ? statutRv : "En attente"
            );

            rv.setDetailsRv(detailsRv != null ? detailsRv : "");

            // Enregistrement
            rvService.addRendezvous(rv);

            System.out.println(">>> Rendez-vous créé avec succès !");

            // Succès
            resp.sendRedirect(req.getContextPath() + "/patient/dashboard");

        } catch (Exception e) {
            System.out.println(">>> Erreur: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de la création du rendez-vous: " + e.getMessage());
            doGet(req, resp);
        }
    }
}