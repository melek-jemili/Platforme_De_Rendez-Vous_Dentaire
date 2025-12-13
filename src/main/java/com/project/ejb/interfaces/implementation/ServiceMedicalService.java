package com.project.ejb.interfaces.implementation;

import java.util.List;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import com.project.entities.ServiceMedical;
import com.project.ejb.interfaces.*;


@Stateless
public class ServiceMedicalService implements IServiceMedicalLocal, IServiceMedicalRemote{
    @PersistenceContext(unitName = "RendezVousPU")
    private EntityManager em;

    @Override
    public void addServiceMedical(ServiceMedical s) {
        em.persist(s);
    }

    @Override
    public void updateServiceMedical(ServiceMedical s) {
        em.merge(s);
    }

    @Override
    public void deleteServiceMedical(int id) {
        ServiceMedical s = em.find(ServiceMedical.class, id);
        if (s != null) em.remove(s);
    }

    @Override
    public ServiceMedical getServiceMedical(int id) {
        return em.find(ServiceMedical.class, id);
    }

    @Override
    public List<ServiceMedical> getAllServiceMedical() {
        return em.createQuery("SELECT s FROM ServiceMedical s", ServiceMedical.class).getResultList();
    }
}
