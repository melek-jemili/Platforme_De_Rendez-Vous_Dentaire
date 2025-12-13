package com.project.servlets.patient;

import java.io.IOException;
import java.util.List;
import jakarta.ejb.EJB;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IPatientLocal;
import com.project.entities.Patient;

@WebServlet("/patients")
public class ListPatientServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EJB
    private IPatientLocal patientService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Patient> list = patientService.getAllPatients();
        req.setAttribute("patients", list);

        req.getRequestDispatcher("/pages/patients/listPatients.jsp").forward(req, resp);
    }
}
