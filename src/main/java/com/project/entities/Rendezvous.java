package com.project.entities;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.*;

@Entity
@Table(name = "Rendezvous")
public class Rendezvous implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idRv")
    private int idRv;
    
    @ManyToOne
    @JoinColumn(name = "idP", nullable = false)
    private Patient patient;
    
    @ManyToOne
    @JoinColumn(name="idD", nullable = false)
    private Dentiste dentiste;
    
    @Temporal(TemporalType.DATE)
    @Column(name= "dateRv", nullable = false)
    private Date dateRv;
    
    @Temporal(TemporalType.TIME)
    @Column(name="heureRv" , nullable=false)
    private Date heureRv;
    
    @Column(name="statutRv", length = 100 , nullable=false)
    private String statutRv;
    
    @Column(name = "detailsRv", columnDefinition = "TEXT")
    private String detailsRv;

    // Constructeurs
    public Rendezvous() {}

    public Rendezvous(int idRv, Patient patient, Dentiste dentiste, Date dateRv, Date heureRv, String statutRv, String detailsRv) {
        this.idRv = idRv;
        this.patient = patient;
        this.dentiste = dentiste;
        this.dateRv = dateRv;
        this.heureRv = heureRv;
        this.statutRv = statutRv;
        this.detailsRv = detailsRv;
    }

    // Getters + Setters
    public int getIdRv() { return idRv; }
    public void setIdRv(int idRv) { this.idRv = idRv; }

    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }

    public Dentiste getDentiste() { return dentiste; }
    public void setDentiste(Dentiste dentiste) { this.dentiste = dentiste; }

    public Date getDateRv() { return dateRv; }
    public void setDateRv(Date dateRv) { this.dateRv = dateRv; }

    public Date getHeureRv() { return heureRv; }
    public void setHeureRv(Date heureRv) { this.heureRv = heureRv; }

    public String getStatutRv() { return statutRv; }
    public void setStatutRv(String statutRv) { this.statutRv = statutRv; }

    public String getDetailsRv() { return detailsRv; }
    public void setDetailsRv(String detailsRv) { this.detailsRv = detailsRv; }
}
