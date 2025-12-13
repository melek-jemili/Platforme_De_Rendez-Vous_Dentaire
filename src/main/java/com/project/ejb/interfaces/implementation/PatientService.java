package com.project.ejb.interfaces.implementation;

import java.util.List;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

import com.project.entities.Patient;
import com.project.ejb.interfaces.*;


@Stateless
public class PatientService implements IPatientLocal, IPatientRemote {

    @PersistenceContext(unitName = "RendezVousPU")
    private EntityManager em;

    @Override
    public void addPatient(Patient p) {
        em.persist(p);
    }

    @Override
    public void updatePatient(Patient p) {
        em.merge(p);
    }

    @Override
    public void deletePatient(int id) {
        Patient p = em.find(Patient.class, id);
        if (p != null) {
            em.remove(p);
        }
    }

    @Override
    public Patient getPatient(int id) {
        return em.find(Patient.class, id);
    }

    @Override
    public List<Patient> getAllPatients() {
        return em.createQuery("SELECT p FROM Patient p", Patient.class).getResultList();
    }
    
    @Override
    public Patient authenticate(String email, String password) {
        try {
            TypedQuery<Patient> query = em.createQuery(
                "SELECT p FROM Patient p WHERE p.emailP = :email AND p.mdpP = :password", 
                Patient.class
            );
            query.setParameter("email", email);
            query.setParameter("password", password);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
}
