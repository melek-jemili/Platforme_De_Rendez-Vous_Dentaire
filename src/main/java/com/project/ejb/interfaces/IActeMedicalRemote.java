package com.project.ejb.interfaces;

import jakarta.ejb.Remote;

import java.util.List;
import com.project.entities.ActeMedical;


@Remote
public interface IActeMedicalRemote {
    void addActeMedical(ActeMedical a);
    void updateActeMedical(ActeMedical a);
    void deleteActeMedical(int id);
    ActeMedical getActeMedical(int id);
    List<ActeMedical> getAllActeMedical();

}
