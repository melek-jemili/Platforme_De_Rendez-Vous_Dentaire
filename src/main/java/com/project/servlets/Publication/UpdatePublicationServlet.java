package com.project.servlets.Publication;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IPublicationLocal;
import com.project.entities.Publication;

@WebServlet("/publications/update")
public class UpdatePublicationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IPublicationLocal publicationService;
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
            req.getRequestDispatcher("/WEB-INF/views/publications/edit.jsp").forward(req, resp);
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/publications");
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(req.getParameter("idPub"));
            Publication pub = publicationService.getPublication(id);

            if (pub == null) {
                resp.sendRedirect(req.getContextPath() + "/publications");
                return;
            }
            pub.setTitre(req.getParameter("titre"));
            String dateNPStr = req.getParameter("dateNP");
            if (dateNPStr != null && !dateNPStr.isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date dateNP = sdf.parse(dateNPStr);
                    pub.setDateNP(dateNP);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
            String fichier = req.getParameter("fichier");
            if (fichier != null && !fichier.isEmpty()) {
                pub.setFichier(fichier);
            }
            String affiche = req.getParameter("affiche");
            if (affiche != null && !affiche.isEmpty()) {
                pub.setAffiche(affiche);
            }
            pub.setCategorie(req.getParameter("categorie"));
            pub.setResume(req.getParameter("resume"));
            publicationService.updatePublication(pub);
            resp.sendRedirect(req.getContextPath() + "/publications");
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/publications");
        }
    }
}