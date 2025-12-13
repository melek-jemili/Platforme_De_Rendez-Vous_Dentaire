package com.project.ejb.interfaces;

import jakarta.ejb.Remote;

import java.util.List;
import com.project.entities.Patient;

@Remote
public interface IPatientRemote {

    void addPatient(Patient p);
    void updatePatient(Patient p);
    void deletePatient(int id);
    Patient getPatient(int id);
    Patient authenticate(String email, String password);
    List<Patient> getAllPatients();
}
