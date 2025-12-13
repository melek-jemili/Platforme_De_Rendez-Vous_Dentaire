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

@WebServlet("/aidesoignants/add")
public class AddAideSoignantServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IAideSoignantLocal aideSoignantService;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        req.getRequestDispatcher("/WEB-INF/views/aidesoignants/add.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        AideSoignant as = new AideSoignant();
        String idASStr = req.getParameter("idAS");
        if (idASStr != null && !idASStr.isEmpty()) {
            as.setIdAS(Integer.parseInt(idASStr));
        }
        as.setNom(req.getParameter("nom"));
        as.setPrénom(req.getParameter("prénom"));
        String telephoneStr = req.getParameter("telephone");
        if (telephoneStr != null && !telephoneStr.isEmpty()) {
            as.setTelephone(Integer.parseInt(telephoneStr));
        }
        as.setAdresse(req.getParameter("adresse"));
        as.setEmailP(req.getParameter("emailP"));
        as.setMdpP(req.getParameter("mdpP"));
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
        as.setPhotoP(req.getParameter("photoP"));
        as.setSexeP(req.getParameter("sexeP"));
        aideSoignantService.addAideSoignant(as);
        resp.sendRedirect(req.getContextPath() + "/aidesoignants");
    }
}