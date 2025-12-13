package com.project.servlets.AideSoignant;

import java.io.IOException;
import java.util.List;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IAideSoignantLocal;
import com.project.entities.AideSoignant;

@WebServlet("/aidesoignants")
public class ListeAideSoignantServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IAideSoignantLocal aideSoignantService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            List<AideSoignant> aidesoignants = aideSoignantService.getAllAideSoignant();
            req.setAttribute("aidesoignants", aidesoignants);
            req.setAttribute("totalAidesoignants", aidesoignants.size());
            req.getRequestDispatcher("/WEB-INF/views/aidesoignants/list.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de la récupération des aides-soignants");
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }
}