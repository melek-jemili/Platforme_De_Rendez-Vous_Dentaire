package com.project.servlets.patient;

import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.implementation.*;

@WebServlet("/patients/delete")
public class DeletePatientServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EJB
    private PatientService patientService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        patientService.deletePatient(id);

        resp.sendRedirect(req.getContextPath() + "/patients");
    }
}
