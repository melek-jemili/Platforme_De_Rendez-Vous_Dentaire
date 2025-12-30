package com.project.servlets.AideSoignant;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IAideSoignantLocal;
import com.project.entities.AideSoignant;
//import com.project.entities.Patient;


@WebServlet("/aidesoignants/update")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024, // 1 MB
	    maxFileSize = 5 * 1024 * 1024,   // 5 MB
	    maxRequestSize = 10 * 1024 * 1024 // 10 MB
	    )
public class UpdateAideSoignantServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    @EJB
    private IAideSoignantLocal aideSoignantService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("aidesoignant") == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        AideSoignant aidesoignant = (AideSoignant) session.getAttribute("aidesoignant");
        req.setAttribute("aidesoignant", aidesoignant);

        req.getRequestDispatcher("/WEB-INF/views/aidesoignants/editProfile.jsp")
           .forward(req, resp);
    }
    

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("aidesoignant") == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        
        AideSoignant as = (AideSoignant) session.getAttribute("aidesoignant");
        
        if (as == null) {
     
            session.setAttribute("errorMessage", "Aide-soignant introuvable.");
            resp.sendRedirect(req.getContextPath() + "/aidesoignant/dashboard");
            return;
        }
        
        try {
            
            String nom = req.getParameter("nom");
            if (nom != null && !nom.trim().isEmpty()) {
                as.setNom(nom.trim());
            }
            
            
            String prenomSansAccent = req.getParameter("prenom");
            if (prenomSansAccent != null && !prenomSansAccent.trim().isEmpty()) {
                as.setPrenom(prenomSansAccent.trim());
            }
            
            
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
            
            
            String adresse = req.getParameter("adresse");
            if (adresse != null && !adresse.trim().isEmpty()) {
                as.setAdresse(adresse.trim());
            }
            
            
            String email = req.getParameter("emailP");
            if (email != null && !email.trim().isEmpty()) {
                as.setEmailP(email.trim());
            }
            
           
            String mdp = req.getParameter("mdpP");
            if (mdp != null && !mdp.trim().isEmpty()) {
                
                as.setMdpP(mdp); 
            }
            
            
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
            
            
            String diplome = req.getParameter("diplome");
            if (diplome != null && !diplome.trim().isEmpty()) {
                as.setDiplome(diplome.trim());
            }
            
            
            Part filePart = req.getPart("photoP");
            if (filePart != null && filePart.getSize() > 0) {
                
                String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                new File(uploadPath).mkdirs();
                filePart.write(uploadPath + File.separator + fileName);
                as.setPhotoP("uploads/" + fileName);
            }


            
            String sexe = req.getParameter("sexeP");
            if (sexe != null && !sexe.trim().isEmpty()) {
                as.setSexeP(sexe.trim());
            }
            
            
            aideSoignantService.updateAideSoignant(as);
            
          
            session.setAttribute("successMessage", "Aide-soignant mis à jour avec succès !");
            session.setAttribute("aidesoignant",as);

           
            resp.sendRedirect(req.getContextPath() + "/aidesoignants/profile");
            
        } catch (Exception e) {
            e.printStackTrace();
            
            session.setAttribute("errorMessage", "Erreur lors de la mise à jour : " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/aidesoignant/dashboard");
        }
    }
}