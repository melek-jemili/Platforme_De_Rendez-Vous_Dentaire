package com.project.servlets.auth;

import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IPatientLocal;
import com.project.ejb.interfaces.IDentisteLocal;
import com.project.ejb.interfaces.IAideSoignantLocal;
import com.project.entities.Patient;
import com.project.entities.Dentiste;
import com.project.entities.AideSoignant;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IPatientLocal patientService;
    
    @EJB
    private IDentisteLocal dentisteService;
    
    @EJB
    private IAideSoignantLocal aideSoignantService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String userType = req.getParameter("userType");
        
        HttpSession session = req.getSession();
        
        try {
            if ("patient".equals(userType)) {
                Patient patient = patientService.authenticate(email, password);
                if (patient != null) {
                    session.setAttribute("user", patient);
                    session.setAttribute("userType", "patient");
                    resp.sendRedirect(req.getContextPath() + "/patient/dashboard");
                } else {
                    req.setAttribute("error", "Email ou mot de passe incorrect");
                    req.getRequestDispatcher("/index.jsp").forward(req, resp);
                }
            } else if ("dentiste".equals(userType)) {
                Dentiste dentiste = dentisteService.authenticate(email, password);
                if (dentiste != null) {
                    session.setAttribute("user", dentiste);
                    session.setAttribute("userType", "dentiste");
                    resp.sendRedirect(req.getContextPath() + "/dentiste/dashboard");
                } else {
                    req.setAttribute("error", "Email ou mot de passe incorrect");
                    req.getRequestDispatcher("/index.jsp").forward(req, resp);
                }
            } else if ("aidesoignant".equals(userType)) {
                AideSoignant as = aideSoignantService.authenticate(email, password);
                if (as != null) {
                    session.setAttribute("user", as);
                    session.setAttribute("userType", "aidesoignant");
                    resp.sendRedirect(req.getContextPath() + "/aidesoignant/dashboard");
                } else {
                    req.setAttribute("error", "Email ou mot de passe incorrect");
                    req.getRequestDispatcher("/index.jsp").forward(req, resp);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Une erreur s'est produite. Veuillez réessayer.");
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        }
    }
}