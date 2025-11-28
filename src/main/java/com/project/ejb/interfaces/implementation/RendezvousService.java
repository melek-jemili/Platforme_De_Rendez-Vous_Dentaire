package com.project.ejb.interfaces.implementation;

import java.util.List;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import com.project.entities.Rendezvous;
import com.project.ejb.interfaces.*;



@Stateless
public class RendezvousService implements IRendezvousLocal, IRendezvousRemote {

    @PersistenceContext(unitName = "RendezVousPU")
    private EntityManager em;

    @Override
    public void addRendezvous(Rendezvous r) {
        em.persist(r);
    }

    @Override
    public void updateRendezvous(Rendezvous r) {
        em.merge(r);
    }

    @Override
    public void deleteRendezvous(int id) {
        Rendezvous r = em.find(Rendezvous.class, id);
        if (r != null) em.remove(r);
    }

    @Override
    public Rendezvous getRendezvous(int id) {
        return em.find(Rendezvous.class, id);
    }

    @Override
    public List<Rendezvous> getAllRendezvous() {
        return em.createQuery("SELECT d FROM Dentiste d", Rendezvous.class).getResultList();
    }
}
