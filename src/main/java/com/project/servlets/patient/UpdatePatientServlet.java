package com.project.servlets.patient;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.ejb.EJB;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IPatientLocal;
import com.project.entities.Patient;

@WebServlet("/patients/update")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024, // 1 MB
	    maxFileSize = 5 * 1024 * 1024,   // 5 MB
	    maxRequestSize = 10 * 1024 * 1024 // 10 MB
	)
public class UpdatePatientServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

    @EJB
    private IPatientLocal patientService;

    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("patient") == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        Patient patient = (Patient) session.getAttribute("patient");
        req.setAttribute("patient", patient);

        req.getRequestDispatcher("/WEB-INF/views/patients/editProfile.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("patient") == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        try {
            Patient patient = (Patient) session.getAttribute("patient");

            // Récupérer tous les champs depuis le formulaire
            String nom = req.getParameter("nomP");
            String prenom = req.getParameter("prenomP");
            String email = req.getParameter("emailP");
            String groupeSanguin = req.getParameter("groupeSanguinP");
            String photo = req.getParameter("photoP");
            String sexe = req.getParameter("sexeP");
            String dateNaissanceStr = req.getParameter("dateNP");
            String recouvrement = req.getParameter("recouvrementP");
            String motDePasse = req.getParameter("mdpP");

            // Mettre à jour les champs du patient
            patient.setNomP(nom);
            patient.setPrenomP(prenom);
            patient.setEmailP(email);
            patient.setGroupeSanguinP(groupeSanguin);
            patient.setPhotoP(photo);
            patient.setSexeP(sexe);
            patient.setRecouvrementP(recouvrement);
            patient.setMdpP(motDePasse);

            // Conversion de la date
            if (dateNaissanceStr != null && !dateNaissanceStr.isEmpty()) {
                Date dateNP = dateFormat.parse(dateNaissanceStr);
                patient.setDateNP(dateNP);
            }
            Part filePart = req.getPart("photoP");
            if (filePart != null && filePart.getSize() > 0) {
                // Nom unique pour éviter conflit
                String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                new File(uploadPath).mkdirs();
                filePart.write(uploadPath + File.separator + fileName);
                patient.setPhotoP("uploads/" + fileName);
            }


            // Sauvegarder les modifications via le service EJB
            patientService.updatePatient(patient);

            // Mettre à jour la session
            session.setAttribute("patient", patient);

            resp.sendRedirect(req.getContextPath() + "/patient/profile");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de la mise à jour du profil : " + e.getMessage());
            doGet(req, resp);
        }
    }
}

