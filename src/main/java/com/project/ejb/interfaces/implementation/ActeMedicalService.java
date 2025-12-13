package com.project.ejb.interfaces.implementation;

import java.util.List;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import com.project.entities.ActeMedical;

import com.project.ejb.interfaces.*;

@Stateless
public class ActeMedicalService implements IActeMedicalLocal,IActeMedicalRemote {
    @PersistenceContext(unitName = "RendezVousPU")
    private EntityManager em;
    
    @Override
    public void addActeMedical(ActeMedical a) {
    	em.persist(a);
    }
    
    @Override
    public void updateActeMedical(ActeMedical a){
    	em.merge(a);
    }
    
    @Override
    public void deleteActeMedical(int id) {
       ActeMedical s = em.find(ActeMedical.class, id);
        if (s != null) em.remove(s);
    }

    @Override
    public ActeMedical getActeMedical(int id) {
        return em.find(ActeMedical.class, id);
    }

    @Override
    public List<ActeMedical> getAllActeMedical() {
        return em.createQuery("SELECT a FROM ActeMedical a", ActeMedical.class).getResultList();
    }

}
