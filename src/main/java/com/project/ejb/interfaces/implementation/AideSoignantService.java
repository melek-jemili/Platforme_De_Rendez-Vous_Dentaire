package com.project.ejb.interfaces.implementation;

import java.util.List;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

import com.project.entities.AideSoignant;
import com.project.ejb.interfaces.*;


@Stateless
public class AideSoignantService implements IAideSoignantLocal, IAideSoignantRemote {

    @PersistenceContext(unitName = "RendezVousPU")
    private EntityManager em;

    @Override
    public void addAideSoignant(AideSoignant as) {
        em.persist(as);
    }

    @Override
    public void updateAideSoignant(AideSoignant as) {
        em.merge(as);
    }

    @Override
    public void deleteAideSoignant(int id) {
    	AideSoignant p = em.find(AideSoignant.class, id);
        if (p != null) {
            em.remove(p);
        }
    }

    @Override
    public AideSoignant getAideSoignant(int id) {
        return em.find(AideSoignant.class, id);
    }

    @Override
    public List<AideSoignant> getAllAideSoignant() {
        return em.createQuery("SELECT as FROM AideSoignant as", AideSoignant.class).getResultList();
    }
    
    @Override
    public AideSoignant authenticate(String email, String password) {
        try {
            TypedQuery<AideSoignant> query = em.createQuery(
                "SELECT a FROM AideSoignant a WHERE a.emailP = :email AND a.mdpP = :password", 
                AideSoignant.class
            );
            query.setParameter("email", email);
            query.setParameter("password", password);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
}
