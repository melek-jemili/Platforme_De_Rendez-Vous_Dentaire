package com.project.servlets.dentiste;

import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IDentisteLocal;
import com.project.entities.Dentiste;

@WebServlet("/dentistes/add")
public class AddDentisteServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IDentisteLocal dentisteService;


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        req.getRequestDispatcher("/WEB-INF/views/dentistes/add.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Dentiste d = new Dentiste();
        d.setNomD(req.getParameter("nomD"));
        d.setPrenomD(req.getParameter("prenomD"));
        d.setEmailD(req.getParameter("emailD"));

        dentisteService.addDentiste(d);

        resp.sendRedirect(req.getContextPath() + "/dentistes");
    }
}