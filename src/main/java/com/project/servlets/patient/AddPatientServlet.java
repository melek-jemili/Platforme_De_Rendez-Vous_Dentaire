package com.project.servlets.patient;

import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.implementation.PatientService;
import com.project.entities.Patient;

@WebServlet("/patients/add")
public class AddPatientServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EJB
    private PatientService patientService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Patient p = new Patient(
            Integer.parseInt(req.getParameter("idP")),
            req.getParameter("nomP"),
            req.getParameter("prenomP"),
            req.getParameter("emailP")
        );

        patientService.addPatient(p);

        resp.sendRedirect(req.getContextPath() + "/patients");
    }
}
