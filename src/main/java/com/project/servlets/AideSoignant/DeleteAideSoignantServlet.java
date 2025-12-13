package com.project.servlets.AideSoignant;

import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.project.ejb.interfaces.IAideSoignantLocal;
import com.project.entities.AideSoignant;

@WebServlet("/aidesoignants/delete")
public class DeleteAideSoignantServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    @EJB
    private IAideSoignantLocal aideSoignantService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(req.getParameter("idAS"));
            if (aideSoignantService.getAideSoignant(id) != null) {
                aideSoignantService.deleteAideSoignant(id);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        resp.sendRedirect(req.getContextPath() + "/aidesoignants");
    }
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
        req.getRequestDispatcher("/WEB-INF/views/aidesoignants/delete.jsp").forward(req, resp);
    }
}