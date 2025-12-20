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

@WebServlet("/publications/add")
public class AddPublicationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IPublicationLocal publicationService;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        req.getRequestDispatcher("/WEB-INF/views/publication/addpublication.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Publication pub = new Publication();
        String idPubStr = req.getParameter("idPub");
        if (idPubStr != null && !idPubStr.isEmpty()) {
            try {
                pub.setIdPub(Integer.parseInt(idPubStr));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
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
        pub.setFichier(req.getParameter("fichier"));
        pub.setAffiche(req.getParameter("affiche"));
        pub.setCategorie(req.getParameter("categorie"));
        pub.setResume(req.getParameter("resume"));
        publicationService.addPublication(pub);
        resp.sendRedirect(req.getContextPath() + "/publications");
    }
}