package com.project.ejb.interfaces;


import com.project.entities.ServiceMedical;
import java.util.List;
import jakarta.ejb.Local;

@Local
public interface IServiceMedicalLocal {
    void addServiceMedical(ServiceMedical s);
    void updateServiceMedical(ServiceMedical s);
    void deleteServiceMedical(int id);
    ServiceMedical getServiceMedical(int id);
    List<ServiceMedical> getAllServiceMedical();


}
