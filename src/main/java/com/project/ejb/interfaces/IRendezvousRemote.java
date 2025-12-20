package com.project.ejb.interfaces;

import jakarta.ejb.Remote;

import java.util.List;
import com.project.entities.Rendezvous;
import com.project.entities.*;

@Remote
public interface IRendezvousRemote {
    void addRendezvous(Rendezvous r);
    void updateRendezvous(Rendezvous r);
    void deleteRendezvous(int id);
    Rendezvous getRendezvous(int id);
    List<Rendezvous> getAllRendezvous();
    List<Rendezvous> findByPatient(Patient patient);
    List<Rendezvous> getRendezvousByDentiste(int idDentiste);
}