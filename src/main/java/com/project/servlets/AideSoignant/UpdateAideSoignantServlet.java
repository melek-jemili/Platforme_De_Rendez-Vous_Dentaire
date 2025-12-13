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
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        AideSoignant as = aideSoignantService.getAideSoignant(id);
        
        if (as == null) {
            resp.sendRedirect(req.getContextPath() + "/aidesoignants");
            return;
        }
        
        req.setAttribute("aidesoignant", as);
        req.getRequestDispatcher("/WEB-INF/views/aidesoignants/edit.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("idAS"));
        AideSoignant as = aideSoignantService.getAideSoignant(id);

        if (as == null) {
            resp.sendRedirect(req.getContextPath() + "/aidesoignants");
            return;
        }
        as.setNom(req.getParameter("nom"));
        as.setPrénom(req.getParameter("prénom"));
        String telephoneStr = req.getParameter("telephone");
        if (telephoneStr != null && !telephoneStr.isEmpty()) {
            try {
                as.setTelephone(Integer.parseInt(telephoneStr));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        as.setAdresse(req.getParameter("adresse"));
        as.setEmailP(req.getParameter("emailP"));
        
        String mdp = req.getParameter("mdpP");
        if (mdp != null && !mdp.isEmpty()) {
            as.setMdpP(mdp);
        }
        String dateNPStr = req.getParameter("dateNP");
        if (dateNPStr != null && !dateNPStr.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date dateNP = sdf.parse(dateNPStr);
                as.setDateNP(dateNP);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        as.setDiplome(req.getParameter("diplome"));
        String photo = req.getParameter("photoP");
        if (photo != null && !photo.isEmpty()) {
            as.setPhotoP(photo);
        }
        as.setSexeP(req.getParameter("sexeP"));
        aideSoignantService.updateAideSoignant(as);
        resp.sendRedirect(req.getContextPath() + "/aidesoignants");
    }
}