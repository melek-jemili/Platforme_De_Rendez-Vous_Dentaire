package com.project.servlets.RendezVous;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import com.project.ejb.interfaces.IDentisteLocal;
import com.project.ejb.interfaces.IRendezvousLocal;
import com.project.entities.Dentiste;
import com.project.entities.Rendezvous;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/rendezvous/update")
public class UpdateRvServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EJB
    private IRendezvousLocal rvService;

    @EJB
    private IDentisteLocal dentisteService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // Récupérer l'id du rendez-vous
            String idRvStr = req.getParameter("idRv");
            if (idRvStr == null || idRvStr.trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/patients/dashboard");
                return;
            }

            int idRv = Integer.parseInt(idRvStr.trim());
            Rendezvous rv = rvService.getRendezvous(idRv);

            if (rv == null) {
                resp.sendRedirect(req.getContextPath() + "/patients/dashboard");
                return;
            }

            // Récupérer la liste des dentistes
            List<Dentiste> dentistes = dentisteService.getAllDentistes();
            req.setAttribute("dentistes", dentistes);
            req.setAttribute("rdv", rv);

            // Forward vers editRv.jsp
            req.getRequestDispatcher("/WEB-INF/views/rendezvous/editrv.jsp")
                .forward(req, resp);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/patients/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // Récupérer et valider l'id
            String idRvStr = req.getParameter("idRv");
            if (idRvStr == null || idRvStr.trim().isEmpty()) {
                req.setAttribute("error", "ID du rendez-vous manquant.");
                doGet(req, resp);
                return;
            }

            int idRv = Integer.parseInt(idRvStr.trim());
            Rendezvous rv = rvService.getRendezvous(idRv);
            if (rv == null) {
                req.setAttribute("error", "Rendez-vous introuvable.");
                doGet(req, resp);
                return;
            }

            // Mettre à jour les champs
            rv.setDateRv(Date.valueOf(req.getParameter("dateRv")));
            rv.setHeureRv(Time.valueOf(req.getParameter("heureRv")));
            rv.setStatutRv(req.getParameter("statutRv"));
            rv.setDetailsRv(req.getParameter("detailsRv"));

            // Gestion du dentiste
            String idDStr = req.getParameter("idD");
            if (idDStr != null && !idDStr.isEmpty()) {
                int idD = Integer.parseInt(idDStr);
                rv.setDentiste(dentisteService.getDentiste(idD));
            }

            // Enregistrer la mise à jour
            rvService.updateRendezvous(rv);

            // Redirection vers la liste
            resp.sendRedirect(req.getContextPath() + "/patient/dashboard");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de la mise à jour du rendez-vous : " + e.getMessage());
            doGet(req, resp);
        }
    }
}
