package com.project.ejb.interfaces;

import jakarta.ejb.Local;

import java.util.List;
import com.project.entities.ActeMedical;


@Local
public interface IActeMedicalLocal {
    void addActeMedical(ActeMedical a);
    void updateActeMedical(ActeMedical a);
    void deleteActeMedical(int id);
    ActeMedical getActeMedical(int id);
    List<ActeMedical> getAllActeMedical();

}
