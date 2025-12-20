package com.project.servlets.Publication;

import java.io.IOException;
import java.util.List;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IPublicationLocal;
import com.project.entities.Publication;

@WebServlet("/publications")
public class ListePublicationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IPublicationLocal publicationService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            List<Publication> publications = publicationService.getAllPublication();
            req.setAttribute("publications", publications);
            req.setAttribute("totalPublications", publications.size());
            req.getRequestDispatcher("/WEB-INF/views/publication/liste.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de la récupération des publications");
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }
}