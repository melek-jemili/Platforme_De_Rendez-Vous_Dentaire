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


/**
 * Entity implementation class for Entity: AideSoignant
 *
 */
@Entity
@Table(name="aideSoignant")
public class AideSoignant implements Serializable {

	
	private static final long serialVersionUID = 1L;
	

	@Id
	@Column(name="idAS", length=8)
	private int idAS;
	
	@Column(name="nom", length=50 , nullable = false)
	private String nom;
	
	@Column(name="prénom", length=50 , nullable = false)
	private String prenom;
	
	@Column(name="telephone", length=100, nullable=false)
	private int telephone;
	
	@Column(name="adresse", length=100 , nullable=false)
	private String adresse;
	
	@Column(name = "emailP", length = 100, nullable = false, unique = true)
    private String emailP;
	
	@Column(name = "mdpP", length = 10)
    private String mdpP;
	
	@Temporal(TemporalType.DATE)
	@Column(name = "dateNP")
	private Date dateNP;
	
	@Column(name="diplome", length=100 , nullable=false)
	private String diplome;
	
	@Column(name = "photoP", length = 100)
    private String photoP;
    
    @Column(name = "sexeP", length = 1)
    private String sexeP; 
    
   
	
	public AideSoignant() {
		super();
	}



	public AideSoignant(int idAS, String nom, String prénom, int telephone, String adresse, String emailP, String mdpP,
			Date dateNP, String diplome, String photoP, String sexeP) {
		super();
		this.idAS = idAS;
		this.nom = nom;
		this.prenom = prénom;
		this.telephone = telephone;
		this.adresse = adresse;
		this.emailP = emailP;
		this.mdpP = mdpP;
		this.dateNP = dateNP;
		this.diplome = diplome;
		this.photoP = photoP;
		this.sexeP = sexeP;
	}



	public int getIdAS() {
		return idAS;
	}



	public void setIdAS(int idAS) {
		this.idAS = idAS;
	}



	public String getNom() {
		return nom;
	}



	public void setNom(String nom) {
		this.nom = nom;
	}



	public String getPrenom() {
		return prenom;
	}



	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}



	public int getTelephone() {
		return telephone;
	}



	public void setTelephone(int telephone) {
		this.telephone = telephone;
	}



	public String getAdresse() {
		return adresse;
	}



	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}



	public String getEmailP() {
		return emailP;
	}



	public void setEmailP(String emailP) {
		this.emailP = emailP;
	}



	public String getMdpP() {
		return mdpP;
	}



	public void setMdpP(String mdpP) {
		this.mdpP = mdpP;
	}



	public Date getDateNP() {
		return dateNP;
	}



	public void setDateNP(Date dateNP) {
		this.dateNP = dateNP;
	}



	public String getDiplome() {
		return diplome;
	}



	public void setDiplome(String diplome) {
		this.diplome = diplome;
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



	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
   
}
