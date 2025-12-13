package com.project.ejb.interfaces;

import jakarta.ejb.Remote;

import java.util.List;
import com.project.entities.AideSoignant;


@Remote
public interface IAideSoignantRemote {

	void addAideSoignant(AideSoignant as);
    void updateAideSoignant(AideSoignant as);
    void deleteAideSoignant(int id);
    AideSoignant getAideSoignant(int id);
    AideSoignant authenticate(String email, String password);
    List<AideSoignant> getAllAideSoignant();
}
