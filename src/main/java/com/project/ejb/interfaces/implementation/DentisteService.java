package com.project.ejb.interfaces.implementation;

import java.util.List;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import com.project.entities.Dentiste;
import com.project.ejb.interfaces.*;




@Stateless
public class DentisteService implements IDentisteLocal, IDentisteRemote {

    @PersistenceContext(unitName = "RendezVousPU")
    private EntityManager em;

    @Override
    public void addDentiste(Dentiste d) {
        em.persist(d);
    }

    @Override
    public void updateDentiste(Dentiste d) {
        em.merge(d);
    }

    @Override
    public void deleteDentiste(int id) {
        Dentiste d = em.find(Dentiste.class, id);
        if (d != null) em.remove(d);
    }

    @Override
    public Dentiste getDentiste(int id) {
        return em.find(Dentiste.class, id);
    }

    @Override
    public List<Dentiste> getAllDentistes() {
        return em.createQuery("SELECT d FROM Dentiste d", Dentiste.class).getResultList();
    }
}
