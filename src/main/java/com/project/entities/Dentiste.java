package com.project.entities;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;


@Entity
@Table(name="Dentiste")
public class Dentiste implements Serializable {

	@Id
	@Column(name="idD", length=8)
	private int idD;
	
	@Column(name="nomD", length=100, nullable=false)
	private String nomD;
	
	@Column(name="prenomD", length=100, nullable=false)
	private String prenomD;
	
	@Column(name="emailD" , length=100, nullable=false, unique=true)
	private String emailD;
	
    @Column(name = "mdpD", length = 10)
    private String mdpD;
    
    @Column(name="specialiteD", length=100)
    private String specialiteD;
    
    @Column(name="sexeD", length=1)
    private String sexeD;
    
    @Column(name="telD", length=8)
    private String telD;
    
    @Column(name="photoD", length=100)
    private String photoD;
	
    @OneToMany(mappedBy = "dentiste", cascade = CascadeType.ALL)
    private List<Rendezvous> rendezvousList;
    
    
	private static final long serialVersionUID = 1L;

	public Dentiste() {
		super();
	}

	public Dentiste(int idD, String nomD, String prenomD, String emailD, String mdpD, String specialiteD, String sexeD,
			String telD, String photoD) {
		super();
		this.idD = idD;
		this.nomD = nomD;
		this.prenomD = prenomD;
		this.emailD = emailD;
		this.mdpD = mdpD;
		this.specialiteD = specialiteD;
		this.sexeD = sexeD;
		this.telD = telD;
		this.photoD = photoD;
	}

	public int getIdD() {
		return idD;
	}

	public void setIdD(int idD) {
		this.idD = idD;
	}

	public String getNomD() {
		return nomD;
	}

	public void setNomD(String nomD) {
		this.nomD = nomD;
	}

	public String getPrenomD() {
		return prenomD;
	}

	public void setPrenomD(String prenomD) {
		this.prenomD = prenomD;
	}

	public String getEmailD() {
		return emailD;
	}

	public void setEmailD(String emailD) {
		this.emailD = emailD;
	}

	public String getMdpD() {
		return mdpD;
	}
	
	public List<Rendezvous> getRendezvousList() {
		return rendezvousList;
	}

	public void setRendezvousList(List<Rendezvous> rendezvousList) {
		this.rendezvousList = rendezvousList;
	}

	public void setMdpD(String mdpD) {
		this.mdpD = mdpD;
	}

	public String getSpecialiteD() {
		return specialiteD;
	}

	public void setSpecialiteD(String specialiteD) {
		this.specialiteD = specialiteD;
	}

	public String getSexeD() {
		return sexeD;
	}

	public void setSexeD(String sexeD) {
		this.sexeD = sexeD;
	}

	public String getTelD() {
		return telD;
	}

	public void setTelD(String telD) {
		this.telD = telD;
	}

	public String getPhotoD() {
		return photoD;
	}

	public void setPhotoD(String photoD) {
		this.photoD = photoD;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
   
	
	
}
