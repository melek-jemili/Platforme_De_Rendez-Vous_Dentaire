package com.project.ejb.interfaces;


import com.project.entities.ServiceMedical;
import java.util.List;
import jakarta.ejb.Remote;

@Remote
public interface IServiceMedicalRemote {
    void addServiceMedical(ServiceMedical s);
    void updateServiceMedical(ServiceMedical s);
    void deleteServiceMedical(int id);
    ServiceMedical getServiceMedical(int id);
    List<ServiceMedical> getAllServiceMedical();


}
