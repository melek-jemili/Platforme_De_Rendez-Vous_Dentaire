package com.project.entities;

import java.io.Serializable;
import java.math.BigDecimal;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

import java.util.List;

/**
 * Entity implementation class for Entity: ServiceMedical
 *
 */
@Entity
@Table(name="ServiceMedical")
public class ServiceMedical implements Serializable {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="numSM")
	private int numSM;
	
	@Column(name="nomSM", length=100, nullable=false)
	private String nomSM;
	
	@Column(name="typeSM", length=100, nullable=false)
	private String typeSM;
	
	@Column(name="descriptionSM", columnDefinition="TEXT")
	private String descriptionSM;
	
	@Column(name = "tarifSM", precision = 6, scale = 2)
    private BigDecimal tarifSM;
    
    @OneToMany(mappedBy = "serviceMedical", cascade = CascadeType.ALL)
    private List<ActeMedical> acteMedicalList;
    
	
	private static final long serialVersionUID = 1L;

	public ServiceMedical() {
		super();
	}

	public ServiceMedical(int numSM, String nomSM, String typeSM, String descriptionSM, BigDecimal tarifSM,
			List<ActeMedical> acteMedicalList) {
		super();
		this.numSM = numSM;
		this.nomSM = nomSM;
		this.typeSM = typeSM;
		this.descriptionSM = descriptionSM;
		this.tarifSM = tarifSM;
		this.acteMedicalList = acteMedicalList;
	}

	public int getNumSM() {
		return numSM;
	}

	public void setNumSM(int numSM) {
		this.numSM = numSM;
	}

	public String getNomSM() {
		return nomSM;
	}

	public void setNomSM(String nomSM) {
		this.nomSM = nomSM;
	}

	public String getTypeSM() {
		return typeSM;
	}

	public void setTypeSM(String typeSM) {
		this.typeSM = typeSM;
	}

	public String getDescriptionSM() {
		return descriptionSM;
	}

	public void setDescriptionSM(String descriptionSM) {
		this.descriptionSM = descriptionSM;
	}

	public BigDecimal getTarifSM() {
		return tarifSM;
	}

	public void setTarifSM(BigDecimal tarifSM) {
		this.tarifSM = tarifSM;
	}

	public List<ActeMedical> getActeMedicalList() {
		return acteMedicalList;
	}

	public void setActeMedicalList(List<ActeMedical> acteMedicalList) {
		this.acteMedicalList = acteMedicalList;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
   
}
