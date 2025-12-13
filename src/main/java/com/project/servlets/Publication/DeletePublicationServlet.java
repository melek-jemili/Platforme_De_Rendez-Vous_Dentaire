package com.project.servlets.Publication;

import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IPublicationLocal;
import com.project.entities.Publication;

@WebServlet("/publications/delete")
public class DeletePublicationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IPublicationLocal publicationService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(req.getParameter("idPub"));
            Publication pub = publicationService.getPublication(id);
            if (pub != null) {
                publicationService.deletePublication(id);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        resp.sendRedirect(req.getContextPath() + "/publications");
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Publication pub = publicationService.getPublication(id);
            
            if (pub == null) {
                resp.sendRedirect(req.getContextPath() + "/publications");
                return;
            }
            
            req.setAttribute("publication", pub);
            req.getRequestDispatcher("/WEB-INF/views/publications/delete.jsp").forward(req, resp);
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/publications");
        }
    }
}