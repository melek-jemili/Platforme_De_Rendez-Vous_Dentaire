package com.project.ejb.interfaces;

import jakarta.ejb.Local;
import java.util.List;
import com.project.entities.Patient;

@Local
public interface IPatientLocal {

    void addPatient(Patient p);
    void updatePatient(Patient p);
    void deletePatient(int id);
    Patient getPatient(int id);
    Patient authenticate(String email, String password);
    List<Patient> getAllPatients();
}
