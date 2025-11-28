package com.project.servlets.dentiste;
import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.project.ejb.interfaces.implementation.*;


@WebServlet("/dentistes")
public class ListeDentisteServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EJB
    private DentisteService dentisteService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("dentistes", dentisteService.getAllDentistes());
        req.getRequestDispatcher("/pages/dentistes/listDentistes.jsp").forward(req, resp);
    }
}
