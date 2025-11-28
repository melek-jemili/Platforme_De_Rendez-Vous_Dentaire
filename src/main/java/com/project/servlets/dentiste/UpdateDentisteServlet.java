package com.project.servlets.dentiste;
import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.project.ejb.interfaces.implementation.*;
import com.project.entities.Dentiste;

@WebServlet("/dentistes/update")
public class UpdateDentisteServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EJB
    private DentisteService dentisteService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Dentiste d = dentisteService.getDentiste(Integer.parseInt(req.getParameter("idD")));
        d.setNomD(req.getParameter("nomD"));
        d.setPrenomD(req.getParameter("prenomD"));
        d.setEmailD(req.getParameter("emailD"));

        dentisteService.updateDentiste(d);

        resp.sendRedirect(req.getContextPath() + "/dentistes");
    }
}
