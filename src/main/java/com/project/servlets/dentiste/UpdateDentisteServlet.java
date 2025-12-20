package com.project.servlets.dentiste;

import java.io.File;
import java.io.IOException;

import com.project.ejb.interfaces.IDentisteLocal;
import com.project.entities.Dentiste;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/dentiste/update")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,   // 1 MB
    maxFileSize = 5 * 1024 * 1024,     // 5 MB
    maxRequestSize = 10 * 1024 * 1024  // 10 MB
)
public class UpdateDentisteServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    @EJB
    private IDentisteLocal dentisteService;
    
    /**
     * Afficher le formulaire de modification
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        HttpSession session = req.getSession(false);
        
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        
        Dentiste dentiste = (Dentiste) session.getAttribute("dentiste");
        
        if (dentiste == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        
        // Recharger les données depuis la base pour avoir les infos à jour
        Dentiste dentisteFromDB = dentisteService.getDentiste(dentiste.getIdD());
        
        if (dentisteFromDB == null) {
            session.setAttribute("errorMessage", "Profil introuvable.");
            resp.sendRedirect(req.getContextPath() + "/dentiste/dashboard");
            return;
        }
        
        req.setAttribute("dentiste", dentisteFromDB);
        req.setAttribute("editMode", true);
        req.getRequestDispatcher("/WEB-INF/views/dentistes/edit.jsp").forward(req, resp);
    }
    
    /**
     * Traiter la mise à jour du dentiste
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        HttpSession session = req.getSession(false);
        
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        
        Dentiste dentiste = (Dentiste) session.getAttribute("dentiste");
        
        if (dentiste == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        
        try {
            // Récupérer le dentiste depuis la base
            Dentiste d = dentisteService.getDentiste(dentiste.getIdD());
            
            if (d == null) {
                session.setAttribute("errorMessage", "Dentiste introuvable.");
                resp.sendRedirect(req.getContextPath() + "/dentiste/dashboard");
                return;
            }
            
            // Mise à jour des champs texte
            String nom = req.getParameter("nomD");
            if (nom != null && !nom.trim().isEmpty()) {
                d.setNomD(nom.trim());
            }
            
            String prenom = req.getParameter("prenomD");
            if (prenom != null && !prenom.trim().isEmpty()) {
                d.setPrenomD(prenom.trim());
            }
            
            String email = req.getParameter("emailD");
            if (email != null && !email.trim().isEmpty()) {
                d.setEmailD(email.trim());
            }
            
            String tel = req.getParameter("telD");
            if (tel != null && !tel.trim().isEmpty()) {
                d.setTelD(tel.trim());
            }
            
            String sexe = req.getParameter("sexeD");
            if (sexe != null && !sexe.trim().isEmpty()) {
                d.setSexeD(sexe.trim());
            }
            
            String specialite = req.getParameter("specialiteD");
            if (specialite != null && !specialite.trim().isEmpty()) {
                d.setSpecialiteD(specialite.trim());
            }
            
            // Mise à jour du mot de passe (optionnel)
            String mdp = req.getParameter("mdpD");
            if (mdp != null && !mdp.trim().isEmpty()) {
                // TODO: Hacher le mot de passe avec BCrypt en production
                d.setMdpD(mdp);
            }
            
            // Gestion de la photo
            Part filePart = req.getPart("photoD");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                new File(uploadPath).mkdirs();
                filePart.write(uploadPath + File.separator + fileName);
                d.setPhotoD("uploads/" + fileName);
            }
            
            // Sauvegarder les modifications
            dentisteService.updateDentiste(d);
            
            // Mettre à jour la session
            session.setAttribute("dentiste", d);
            session.setAttribute("successMessage", "Profil mis à jour avec succès !");
            
            resp.sendRedirect(req.getContextPath() + "/dentiste/profile");
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur lors de la mise à jour : " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/dentiste/update");
        }
    }
}