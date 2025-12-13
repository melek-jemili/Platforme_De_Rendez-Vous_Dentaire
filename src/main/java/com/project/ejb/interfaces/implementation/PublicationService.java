package com.project.ejb.interfaces.implementation;

import java.util.List;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import com.project.entities.Publication;
import com.project.ejb.interfaces.*;


@Stateless
public class PublicationService implements IPublicationLocal, IPublicationRemote {

    @PersistenceContext(unitName = "RendezVousPU")
    private EntityManager em;

    @Override
    public void addPublication(Publication p) {
        em.persist(p);
    }

    @Override
    public void updatePublication(Publication p) {
        em.merge(p);
    }

    @Override
    public void deletePublication(int id) {
    	Publication p = em.find(Publication.class, id);
        if (p != null) {
            em.remove(p);
        }
    }

    @Override
    public Publication getPublication(int id) {
        return em.find(Publication.class, id);
    }

    @Override
    public List<Publication> getAllPublication() {
        return em.createQuery("SELECT p FROM Publication p", Publication.class).getResultList();
    }
}
