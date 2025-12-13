package com.project.servlets.dentiste;
import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.project.ejb.interfaces.IDentisteLocal;


@WebServlet("/dentistes/delete")
public class DeleteDentisteServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EJB
    private IDentisteLocal dentisteService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        dentisteService.deleteDentiste(Integer.parseInt(req.getParameter("id")));
        resp.sendRedirect(req.getContextPath() + "/dentistes");
    }
}

