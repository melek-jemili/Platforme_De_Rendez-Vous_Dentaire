package com.project.servlets.dentiste;

import java.io.IOException;
import java.util.List;

import com.project.ejb.interfaces.IPatientLocal;
import com.project.ejb.interfaces.IRendezvousLocal;
import com.project.ejb.interfaces.IPublicationLocal;
import com.project.ejb.interfaces.IServiceMedicalLocal;
import com.project.entities.Dentiste;
import com.project.entities.Patient;
import com.project.entities.Rendezvous;
import com.project.entities.Publication;
import com.project.entities.ServiceMedical;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/dentiste/dashboard")
public class DentisteDashboard extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @EJB
    private IPatientLocal patientService;

    @EJB
    private IRendezvousLocal rendezvousService;

    @EJB
    private IPublicationLocal publicationService;

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

        Dentiste dentiste = (Dentiste) session.getAttribute("dentiste");

        if (dentiste == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        try {
            // Récupérer tous les patients
            List<Patient> patients = patientService.getAllPatients();

            // Récupérer les rendez-vous du dentiste
            List<Rendezvous> rendezvous = rendezvousService.getRendezvousByDentiste(dentiste.getIdD());

            // Récupérer toutes les publications
            List<Publication> publications = publicationService.getAllPublication();

            // Récupérer tous les services médicaux
            List<ServiceMedical> services = serviceMedicalService.getAllServiceMedical();

            // Passer les données au JSP
            req.setAttribute("patients", patients);
            req.setAttribute("rendezvous", rendezvous);
            req.setAttribute("publications", publications);
            req.setAttribute("services", services);

            req.getRequestDispatcher("/WEB-INF/views/dentistes/dashboard.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur lors du chargement du dashboard: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/dentistes/dashboard.jsp").forward(req, resp);
        }
    }
}