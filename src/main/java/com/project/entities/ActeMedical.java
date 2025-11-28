package com.project.entities;

import java.io.Serializable;
import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import com.project.entities.ActeMedical;


/**
 * Entity implementation class for Entity: ActeMedical
 *
 */
@Entity
@Table(name="ActeMedical")
public class ActeMedical implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="idAM")
	private int idAM;
	
	@ManyToOne
    @JoinColumn(name = "idRv", nullable = false)
    private Rendezvous rendezvous;
    
    @ManyToOne
    @JoinColumn(name = "numSM", nullable = false)
    private ServiceMedical serviceMedical;
    
    @Column(name = "descriptionAM", columnDefinition = "TEXT")
    private String descriptionAM;
    
    @Column(name = "tarifAM", precision = 6, scale = 2)
    private BigDecimal tarifAM;
    
	private static final long serialVersionUID = 1L;

	public ActeMedical() {
		super();
	}

	public ActeMedical(int idAM, Rendezvous rendezvous, ServiceMedical serviceMedical, String descriptionAM,
			BigDecimal tarifAM) {
		super();
		this.idAM = idAM;
		this.rendezvous = rendezvous;
		this.serviceMedical = serviceMedical;
		this.descriptionAM = descriptionAM;
		this.tarifAM = tarifAM;
	}

	public int getIdAM() {
		return idAM;
	}

	public void setIdAM(int idAM) {
		this.idAM = idAM;
	}

	public Rendezvous getRendezvous() {
		return rendezvous;
	}

	public void setRendezvous(Rendezvous rendezvous) {
		this.rendezvous = rendezvous;
	}

	public ServiceMedical getServiceMedical() {
		return serviceMedical;
	}

	public void setServiceMedical(ServiceMedical serviceMedical) {
		this.serviceMedical = serviceMedical;
	}

	public String getDescriptionAM() {
		return descriptionAM;
	}

	public void setDescriptionAM(String descriptionAM) {
		this.descriptionAM = descriptionAM;
	}

	public BigDecimal getTarifAM() {
		return tarifAM;
	}

	public void setTarifAM(BigDecimal tarifAM) {
		this.tarifAM = tarifAM;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
   
}
