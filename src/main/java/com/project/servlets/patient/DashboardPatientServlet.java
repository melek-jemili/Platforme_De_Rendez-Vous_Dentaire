package com.project.servlets.patient;
import java.io.IOException;
import java.util.List;

import com.project.entities.*;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.project.ejb.interfaces.IRendezvousLocal;

@WebServlet("/patient/dashboard")
public class DashboardPatientServlet extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EJB
    private IRendezvousLocal rvService;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // patient connecté
        HttpSession session = req.getSession(false);
        Patient patient = (Patient) session.getAttribute("patient");

        if (patient == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        // liste des rendez-vous du patient
        List<Rendezvous> rdvs = rvService.findByPatient(patient);

        req.setAttribute("Rendezvous", rdvs);
        req.getRequestDispatcher("/WEB-INF/views/patients/dashboard.jsp").forward(req, resp);
    }
}
