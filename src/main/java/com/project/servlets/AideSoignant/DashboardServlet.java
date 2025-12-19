package com.project.servlets.AideSoignant;

import java.io.IOException;
import java.util.List;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IRendezvousLocal;
import com.project.ejb.interfaces.IPublicationLocal;
import com.project.ejb.interfaces.IServiceMedicalLocal;
import com.project.entities.AideSoignant;
import com.project.entities.Rendezvous;
import com.project.entities.Publication;
import com.project.entities.ServiceMedical;

@WebServlet("/aidesoignants/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @EJB
    private IRendezvousLocal rendezvousService;

    @EJB
    private IPublicationLocal publicationService;

    @EJB
    private IServiceMedicalLocal serviceMedicalService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Vérifier la session
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        AideSoignant aideSoignant = (AideSoignant) session.getAttribute("user");

        try {
            // Récupérer tous les rendez-vous
            List<Rendezvous> rendezvousList = rendezvousService.getAllRendezvous();
            req.setAttribute("rendezvousList", rendezvousList);

            // Statistiques
            int totalRdv = rendezvousList != null ? rendezvousList.size() : 0;
            int rdvEnAttente = 0;
            if (rendezvousList != null) {
                for (Rendezvous rdv : rendezvousList) {
                    if ("En attente".equals(rdv.getStatutRv())) {
                        rdvEnAttente++;
                    }
                }
            }

            req.setAttribute("totalRdv", totalRdv);
            req.setAttribute("rdvEnAttente", rdvEnAttente);

            // Récupérer les publications
            List<Publication> publicationsList = publicationService.getAllPublication();
            req.setAttribute("publicationsList", publicationsList);
            req.setAttribute("totalPublications", publicationsList != null ? publicationsList.size() : 0);

            // Récupérer les services médicaux
            List<ServiceMedical> servicesList = serviceMedicalService.getAllServiceMedical();
            req.setAttribute("servicesList", servicesList);
            req.setAttribute("totalServices", servicesList != null ? servicesList.size() : 0);

            // ✅ CORRECTION : Forward vers la JSP (PAS sendRedirect)
            req.getRequestDispatcher("/WEB-INF/views/aidesoignants/dashboard.jsp")
               .forward(req, resp);
               
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur lors du chargement du dashboard : " + e.getMessage());
            
            // ✅ En cas d'erreur, rediriger vers la page de login
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }
}