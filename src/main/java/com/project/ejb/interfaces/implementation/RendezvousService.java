package com.project.ejb.interfaces.implementation;

import java.util.List;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import com.project.entities.Patient;
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
        return em.createQuery("SELECT r FROM Rendezvous r", Rendezvous.class).getResultList();
    }
    @Override
    public List<Rendezvous> findByPatient(Patient patient) {

        return em.createQuery(
            "SELECT r FROM Rendezvous r WHERE r.patient = :patient",
            Rendezvous.class
        )
        .setParameter("patient", patient)
        .getResultList();
    }
    @Override
    public List<Rendezvous> getRendezvousByDentiste(int idDentiste) {
        return em.createQuery("SELECT r FROM Rendezvous r WHERE r.dentiste.idD = :idD", Rendezvous.class)
                 .setParameter("idD", idDentiste)
                 .getResultList();
    }
}
