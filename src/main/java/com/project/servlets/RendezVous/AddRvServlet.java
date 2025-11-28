package com.project.servlets.RendezVous;
import java.io.IOException;

import com.project.ejb.interfaces.implementation.DentisteService;
import com.project.ejb.interfaces.implementation.PatientService;
import com.project.ejb.interfaces.implementation.RendezvousService;
import com.project.entities.Rendezvous;

import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/rendezvous/add")
public class AddRvServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@EJB
    private RendezvousService rvService;

    @EJB
    private PatientService patientService;

    @EJB
    private DentisteService dentisteService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Rendezvous rv = new Rendezvous();

        rv.setPatient(patientService.getPatient(Integer.parseInt(req.getParameter("idP"))));
        rv.setDentiste(dentisteService.getDentiste(Integer.parseInt(req.getParameter("idD"))));
        rv.setDateRv(java.sql.Date.valueOf(req.getParameter("dateRv")));
        rv.setHeureRv(java.sql.Time.valueOf(req.getParameter("heureRv")));
        rv.setStatutRv(req.getParameter("statutRv"));
        rv.setDetailsRv(req.getParameter("detailsRv"));

        rvService.addRendezvous(rv);

        resp.sendRedirect(req.getContextPath() + "/rendezvous");
    }
}
