package com.project.servlets.auth;

import java.io.IOException;
import java.text.SimpleDateFormat;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IPatientLocal;
import com.project.ejb.interfaces.IAideSoignantLocal;
import com.project.entities.Patient;
import com.project.entities.AideSoignant;

@WebServlet("/inscription")
public class InscriptionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IPatientLocal patientService;
    
    @EJB
    private IAideSoignantLocal aideSoignantService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Afficher la page d'inscription
        req.getRequestDispatcher("/WEB-INF/views/patients/inscription.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String userType = req.getParameter("userType");
        
        try {
            if ("patient".equals(userType)) {
                // Création du patient
                Patient patient = new Patient();
                if ("patient".equals(userType)) {
                    String idPStr = req.getParameter("idP");
                    if (idPStr != null && !idPStr.isEmpty()) {
                        patient.setIdP(Integer.parseInt(idPStr));
                    }
                }

                patient.setNomP(req.getParameter("nomP"));
                patient.setPrenomP(req.getParameter("prenomP"));
                patient.setEmailP(req.getParameter("emailP"));
                patient.setMdpP(req.getParameter("mdpP"));
                patient.setSexeP(req.getParameter("sexeP"));
                patient.setGroupeSanguinP(req.getParameter("groupeSanguinP"));
                patient.setRecouvrementP(req.getParameter("recouvrementP"));
                
                // Parse de la date de naissance
                String dateStr = req.getParameter("dateNP");
                if (dateStr != null && !dateStr.isEmpty()) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    patient.setDateNP(sdf.parse(dateStr));
                }
                
                // Ajout du patient dans la DB
                patientService.addPatient(patient);
                
                // Message de succès stocké dans la session
                HttpSession session = req.getSession();
                session.setAttribute("successMessage", "Compte patient créé avec succès ! Vous pouvez maintenant vous connecter.");
                
                // Redirection vers la page de login
                resp.sendRedirect(req.getContextPath() + "/");
                
            } else if ("aidesoignant".equals(userType)) {
                // Création de l'aide-soignant
                AideSoignant as = new AideSoignant();
                as.setNom(req.getParameter("nom"));
                as.setPrénom(req.getParameter("prénom"));
                as.setEmailP(req.getParameter("emailP"));
                as.setMdpP(req.getParameter("mdpP"));
                as.setSexeP(req.getParameter("sexeP"));
                as.setDiplome(req.getParameter("diplome"));
                as.setAdresse(req.getParameter("adresse"));
                
                // Parse du téléphone
                String telStr = req.getParameter("telephone");
                if (telStr != null && !telStr.isEmpty()) {
                    as.setTelephone(Integer.parseInt(telStr));
                }
                
                // Parse de la date de naissance
                String dateStr = req.getParameter("dateNP");
                if (dateStr != null && !dateStr.isEmpty()) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    as.setDateNP(sdf.parse(dateStr));
                }
                
                // Ajout de l'aide-soignant dans la DB
                aideSoignantService.addAideSoignant(as);
                
                // Message de succès stocké dans la session
                HttpSession session = req.getSession();
                session.setAttribute("successMessage", "Compte aide-soignant créé avec succès ! Vous pouvez maintenant vous connecter.");
                
                // Redirection vers la page de login
                resp.sendRedirect(req.getContextPath() + "/");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            // En cas d'erreur, retour à la page d'inscription avec message d'erreur
            req.setAttribute("error", "Une erreur s'est produite lors de la création du compte : " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/patients/inscription.jsp").forward(req, resp);
        }
    }
}