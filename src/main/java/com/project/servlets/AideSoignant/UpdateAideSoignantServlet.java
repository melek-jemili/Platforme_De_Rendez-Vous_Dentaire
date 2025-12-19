package com.project.servlets.AideSoignant;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IAideSoignantLocal;
import com.project.entities.AideSoignant;

@WebServlet("/aidesoignants/update")
public class UpdateAideSoignantServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    @EJB
    private IAideSoignantLocal aideSoignantService;
    
    /**
     * Afficher le formulaire de modification
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        // Récupérer le paramètre idAS
        String idStr = req.getParameter("idAS");
        
        // Validation : vérifier que le paramètre existe
        if (idStr == null || idStr.trim().isEmpty()) {
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "ID de l'aide-soignant manquant.");
            resp.sendRedirect(req.getContextPath() + "/aidesoignants");
            return;
        }
        
        // Conversion sécurisée
        int id;
        try {
            id = Integer.parseInt(idStr.trim());
        } catch (NumberFormatException e) {
            e.printStackTrace();
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "ID invalide : " + idStr);
            resp.sendRedirect(req.getContextPath() + "/aidesoignants");
            return;
        }
        
        // Récupérer l'aide-soignant depuis la base de données
        AideSoignant as = aideSoignantService.getAideSoignant(id);
        
        if (as == null) {
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "Aide-soignant introuvable (ID: " + id + ")");
            resp.sendRedirect(req.getContextPath() + "/aidesoignants");
            return;
        }
        
        // Passer l'aide-soignant à la JSP
        req.setAttribute("aidesoignant", as);
        req.getRequestDispatcher("/WEB-INF/views/aidesoignants/edit.jsp").forward(req, resp);
    }
    
    /**
     * Traiter la mise à jour de l'aide-soignant
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        // Récupérer et valider l'ID
        String idStr = req.getParameter("idAS");
        
        if (idStr == null || idStr.trim().isEmpty()) {
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "ID manquant lors de la mise à jour.");
            resp.sendRedirect(req.getContextPath() + "/aidesoignants");
            return;
        }
        
        int id;
        try {
            id = Integer.parseInt(idStr.trim());
        } catch (NumberFormatException e) {
            e.printStackTrace();
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "ID invalide.");
            resp.sendRedirect(req.getContextPath() + "/aidesoignants");
            return;
        }
        
        // Récupérer l'aide-soignant existant
        AideSoignant as = aideSoignantService.getAideSoignant(id);
        
        if (as == null) {
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "Aide-soignant introuvable.");
            resp.sendRedirect(req.getContextPath() + "/aidesoignants");
            return;
        }
        
        try {
            // Mise à jour des champs texte
            String nom = req.getParameter("nom");
            if (nom != null && !nom.trim().isEmpty()) {
                as.setNom(nom.trim());
            }
            
            //String prenom = req.getParameter("prénom");
            String prenomSansAccent = req.getParameter("prenom");
            if (prenomSansAccent != null && !prenomSansAccent.trim().isEmpty()) {
                as.setPrenom(prenomSansAccent.trim());
            }
            
            // Mise à jour du téléphone
            String telephoneStr = req.getParameter("telephone");
            if (telephoneStr != null && !telephoneStr.trim().isEmpty()) {
                try {
                    int telephone = Integer.parseInt(telephoneStr.trim());
                    as.setTelephone(telephone);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    req.setAttribute("error", "Format de téléphone invalide.");
                }
            }
            
            // Mise à jour de l'adresse
            String adresse = req.getParameter("adresse");
            if (adresse != null && !adresse.trim().isEmpty()) {
                as.setAdresse(adresse.trim());
            }
            
            // Mise à jour de l'email
            String email = req.getParameter("emailP");
            if (email != null && !email.trim().isEmpty()) {
                as.setEmailP(email.trim());
            }
            
            // Mise à jour du mot de passe (optionnel)
            String mdp = req.getParameter("mdpP");
            if (mdp != null && !mdp.trim().isEmpty()) {
                // TODO: Hacher le mot de passe avec BCrypt
                // String hashedPassword = BCrypt.hashpw(mdp, BCrypt.gensalt());
                // as.setMdpP(hashedPassword);
                as.setMdpP(mdp); // Temporaire - à hacher en production
            }
            
            // Mise à jour de la date de naissance
            String dateNPStr = req.getParameter("dateNP");
            if (dateNPStr != null && !dateNPStr.trim().isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date dateNP = sdf.parse(dateNPStr);
                    as.setDateNP(dateNP);
                } catch (ParseException e) {
                    e.printStackTrace();
                    req.setAttribute("error", "Format de date invalide.");
                }
            }
            
            // Mise à jour du diplôme
            String diplome = req.getParameter("diplome");
            if (diplome != null && !diplome.trim().isEmpty()) {
                as.setDiplome(diplome.trim());
            }
            
            // Mise à jour de la photo (optionnel)
            String photo = req.getParameter("photoP");
            if (photo != null && !photo.trim().isEmpty()) {
                as.setPhotoP(photo.trim());
            }
            
            // Mise à jour du sexe
            String sexe = req.getParameter("sexeP");
            if (sexe != null && !sexe.trim().isEmpty()) {
                as.setSexeP(sexe.trim());
            }
            
            // Enregistrer les modifications dans la base de données
            aideSoignantService.updateAideSoignant(as);
            
            // Message de succès
            HttpSession session = req.getSession();
            session.setAttribute("successMessage", "Aide-soignant mis à jour avec succès !");
            
            // Redirection vers la liste
            resp.sendRedirect(req.getContextPath() + "/aidesoignants");
            
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = req.getSession();
            session.setAttribute("errorMessage", "Erreur lors de la mise à jour : " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/aidesoignants");
        }
    }
}