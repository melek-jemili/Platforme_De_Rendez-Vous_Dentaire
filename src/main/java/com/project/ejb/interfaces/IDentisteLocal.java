package com.project.ejb.interfaces;

import jakarta.ejb.Local;

import java.util.List;
import com.project.entities.Dentiste;

@Local
public interface IDentisteLocal {
    void addDentiste(Dentiste d);
    void updateDentiste(Dentiste d);
    void deleteDentiste(int id);
    Dentiste getDentiste(int id);
    Dentiste authenticate(String email, String password);
    List<Dentiste> getAllDentistes();
}