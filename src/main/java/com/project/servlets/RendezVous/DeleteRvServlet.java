package com.project.servlets.RendezVous;

import java.io.IOException;

import com.project.ejb.interfaces.IRendezvousLocal;
import com.project.entities.Rendezvous;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/rendezvous/delete")
public class DeleteRvServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @EJB
    private IRendezvousLocal rvService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("patient") == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        try {
            int idRv = Integer.parseInt(req.getParameter("idRv"));
            Rendezvous rv = rvService.getRendezvous(idRv);

            if (rv != null) {
                if (rv.getPatient().getIdP() == ((com.project.entities.Patient) session.getAttribute("patient")).getIdP()) {
                    rvService.deleteRendezvous(idRv);
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        resp.sendRedirect(req.getContextPath() + "/patient/dashboard");
    }
}
