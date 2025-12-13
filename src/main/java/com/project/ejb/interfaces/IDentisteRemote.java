package com.project.ejb.interfaces;

import jakarta.ejb.Remote;

import java.util.List;
import com.project.entities.Dentiste;


@Remote
public interface IDentisteRemote {
    void addDentiste(Dentiste d);
    void updateDentiste(Dentiste d);
    void deleteDentiste(int id);
    Dentiste getDentiste(int id);
    Dentiste authenticate(String email, String password);
    List<Dentiste> getAllDentistes();
}
