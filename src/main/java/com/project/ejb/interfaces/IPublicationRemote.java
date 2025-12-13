package com.project.ejb.interfaces;

import jakarta.ejb.Remote;

import java.util.List;
import com.project.entities.Publication;

@Remote
public interface IPublicationRemote {

	void addPublication(Publication p);
    void updatePublication(Publication p);
    void deletePublication(int id);
    Publication getPublication(int id);
    List<Publication> getAllPublication();
}
