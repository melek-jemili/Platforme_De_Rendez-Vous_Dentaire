package com.project.ejb.interfaces;

import jakarta.ejb.Local;

import java.util.List;
import com.project.entities.Rendezvous;

@Local
public interface IRendezvousLocal {
    void addRendezvous(Rendezvous r);
    void updateRendezvous(Rendezvous r);
    void deleteRendezvous(int id);
    Rendezvous getRendezvous(int id);
    List<Rendezvous> getAllRendezvous();
}