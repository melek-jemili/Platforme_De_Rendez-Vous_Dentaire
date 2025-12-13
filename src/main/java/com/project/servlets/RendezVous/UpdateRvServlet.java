package com.project.servlets.RendezVous;
import java.io.IOException;

import com.project.ejb.interfaces.IRendezvousLocal;
import com.project.entities.Rendezvous;

import jakarta.ejb.EJB;
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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Rendezvous rv = rvService.getRendezvous(Integer.parseInt(req.getParameter("idRv")));

        rv.setDateRv(java.sql.Date.valueOf(req.getParameter("dateRv")));
        rv.setHeureRv(java.sql.Time.valueOf(req.getParameter("heureRv")));
        rv.setStatutRv(req.getParameter("statutRv"));
        rv.setDetailsRv(req.getParameter("detailsRv"));

        rvService.updateRendezvous(rv);

        resp.sendRedirect(req.getContextPath() + "/rendezvous");
    }
}
