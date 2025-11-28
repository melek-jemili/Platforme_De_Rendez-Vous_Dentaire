package com.project.ejb.interfaces;

import jakarta.ejb.Remote;

import java.util.List;
import com.project.entities.Rendezvous;

@Remote
public interface IRendezvousRemote {
    void addRendezvous(Rendezvous r);
    void updateRendezvous(Rendezvous r);
    void deleteRendezvous(int id);
    Rendezvous getRendezvous(int id);
    List<Rendezvous> getAllRendezvous();
}