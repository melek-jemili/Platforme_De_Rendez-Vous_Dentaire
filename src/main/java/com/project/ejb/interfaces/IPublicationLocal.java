package com.project.ejb.interfaces;

import jakarta.ejb.Local;

import java.util.List;
import com.project.entities.Publication;

@Local
public interface IPublicationLocal {

	void addPublication(Publication p);
    void updatePublication(Publication p);
    void deletePublication(int id);
    Publication getPublication(int id);
    List<Publication> getAllPublication();
}
