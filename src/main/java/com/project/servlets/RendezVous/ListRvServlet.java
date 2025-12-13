package com.project.servlets.RendezVous;
import java.io.IOException;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.project.ejb.interfaces.IRendezvousLocal;

@WebServlet("/rendezvous")
public class ListRvServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EJB
    private IRendezvousLocal rvService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("rvList", rvService.getAllRendezvous());
        req.getRequestDispatcher("/pages/rendezvous/listRv.jsp").forward(req, resp);
    }
}
