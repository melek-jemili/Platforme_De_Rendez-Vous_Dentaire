package com.project.servlets.patient;

import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IPatientLocal;
import com.project.entities.Patient;

@WebServlet("/patients/update")
public class UpdatePatientServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EJB
    private IPatientLocal patientService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("idP"));
        Patient p = patientService.getPatient(id);

        p.setNomP(req.getParameter("nomP"));
        p.setPrenomP(req.getParameter("prenomP"));
        p.setEmailP(req.getParameter("emailP"));

        patientService.updatePatient(p);

        resp.sendRedirect(req.getContextPath() + "/patients");
    }
}
