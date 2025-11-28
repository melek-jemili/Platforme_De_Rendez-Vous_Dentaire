package com.project.entities;

import java.io.Serializable;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

import java.util.Date;
import java.util.List;

@Entity
@Table(name = "Patient")
public class Patient implements Serializable {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
    @Column(name = "idP", length = 8)
    private int idP;
    
    @Column(name = "nomP", length = 100, nullable = false)
    private String nomP;
    
    @Column(name = "prenomP", length = 100, nullable = false)
    private String prenomP;
    
    @Column(name = "emailP", length = 100, nullable = false, unique = true)
    private String emailP;
    
    @Column(name = "groupeSanguinP", length = 2)
    private String groupeSanguinP;
    
    @Column(name = "photoP", length = 100)
    private String photoP;
    
    @Column(name = "sexeP", length = 1)
    private String sexeP; 
    
    @Temporal(TemporalType.DATE)
    @Column(name = "dateNP")
    private Date dateNP;
    
    @Column(name = "recouvrementP", length = 100)
    private String recouvrementP;
    
    @Column(name = "mdpP", length = 10)
    private String mdpP;
    
   @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
    private List<Rendezvous> rendezvousList;
    
    // Constructeurs
    public Patient() {
    }
    
    public Patient(int idP, String nomP, String prenomP, String emailP) {
        this.idP = idP;
        this.nomP = nomP;
        this.prenomP = prenomP;
        this.emailP = emailP;
    }
    
    // Getters et Setters
    public int getIdP() {
        return idP;
    }
    
    public void setIdP(int idP) {
        this.idP = idP;
    }
    
    public String getNomP() {
        return nomP;
    }
    
    public void setNomP(String nomP) {
        this.nomP = nomP;
    }
    
    public String getPrenomP() {
        return prenomP;
    }
    
    public void setPrenomP(String prenomP) {
        this.prenomP = prenomP;
    }
    
    public String getEmailP() {
        return emailP;
    }
    
    public void setEmailP(String emailP) {
        this.emailP = emailP;
    }
    
    public String getGroupeSanguinP() {
        return groupeSanguinP;
    }
    
    public void setGroupeSanguinP(String groupeSanguinP) {
        this.groupeSanguinP = groupeSanguinP;
    }
    
    public String getPhotoP() {
        return photoP;
    }
    
    public void setPhotoP(String photoP) {
        this.photoP = photoP;
    }
    
    public String getSexeP() {
        return sexeP;
    }
    
    public void setSexeP(String sexeP) {
        this.sexeP = sexeP;
    }
    
    public Date getDateNP() {
        return dateNP;
    }
    
    public void setDateNP(Date dateNP) {
        this.dateNP = dateNP;
    }
    
    public String getRecouvrementP() {
        return recouvrementP;
    }
    
    public void setRecouvrementP(String recouvrementP) {
        this.recouvrementP = recouvrementP;
    }
    
    public String getMdpP() {
        return mdpP;
    }
    
    public void setMdpP(String mdpP) {
        this.mdpP = mdpP;
    }
    
    public List<Rendezvous> getRendezvousList() {
        return rendezvousList;
    }
    
    public void setRendezvousList(List<Rendezvous> rendezvousList) {
        this.rendezvousList = rendezvousList;
    }
}
