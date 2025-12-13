package com.project.entities;

import java.io.Serializable;
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
 * Entity implementation class for Entity: Publication
 *
 */
@Entity
@Table(name="publication")
public class Publication implements Serializable {

	
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="idPub", length=8)
	private int idPub;
	
	@Column(name="titre", length=100, nullable=false)
	private String titre;
	
	@Temporal(TemporalType.DATE)
	@Column(name = "dateNP")
	private Date dateNP;
	
	
	@Column(name = "fichier", length = 100)
    private String fichier;
	
	@Column(name = "affiche", length = 100)
    private String affiche;
	
	@Column(name = "categorie", length = 100)
    private String categorie;
	
	@Column(name = "resume", length = 100)
    private String resume;

	public Publication() {
		super();
	}

	public Publication(int idPub, String titre, Date dateNP, String fichier, String affiche, String categorie,
			String resume) {
		super();
		this.idPub = idPub;
		this.titre = titre;
		this.dateNP = dateNP;
		this.fichier = fichier;
		this.affiche = affiche;
		this.categorie = categorie;
		this.resume = resume;
	}

	public int getIdPub() {
		return idPub;
	}

	public void setIdPub(int idPub) {
		this.idPub = idPub;
	}

	public String getTitre() {
		return titre;
	}

	public void setTitre(String titre) {
		this.titre = titre;
	}

	public Date getDateNP() {
		return dateNP;
	}

	public void setDateNP(Date dateNP) {
		this.dateNP = dateNP;
	}

	public String getFichier() {
		return fichier;
	}

	public void setFichier(String fichier) {
		this.fichier = fichier;
	}

	public String getAffiche() {
		return affiche;
	}

	public void setAffiche(String affiche) {
		this.affiche = affiche;
	}

	public String getCategorie() {
		return categorie;
	}

	public void setCategorie(String categorie) {
		this.categorie = categorie;
	}

	public String getResume() {
		return resume;
	}

	public void setResume(String resume) {
		this.resume = resume;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
   
}
