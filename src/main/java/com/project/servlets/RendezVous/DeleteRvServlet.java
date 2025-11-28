package com.project.servlets.RendezVous;
import java.io.IOException;

import com.project.ejb.interfaces.implementation.RendezvousService;
import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/rendezvous/delete")
public class DeleteRvServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EJB
    private RendezvousService rvService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        rvService.deleteRendezvous(Integer.parseInt(req.getParameter("id")));
        resp.sendRedirect(req.getContextPath() + "/rendezvous");
    }
}
