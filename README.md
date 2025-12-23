# Plateforme de Gestion de Rendez-vous Dentaires

## Description du Projet

Cette application web Java EE permet la gestion complète d'un cabinet dentaire, incluant la gestion des rendez-vous, des patients, des dentistes, des services médicaux et des actes médicaux.

## Technologies Utilisées

### Backend
- Java EE 8+
- Jakarta EE (Servlet API, EJB)
- JPA (Java Persistence API)
- WildFly Application Server

### Frontend
- JSP (JavaServer Pages)
- JSTL (JSP Standard Tag Library)
- HTML5/CSS3
- JavaScript
- Font Awesome 6.5.0

### Base de Données
- Système de gestion de base de données relationnel (MySQL/PostgreSQL/Oracle)

## Architecture du Projet

### Structure des Packages
```
com.project
├── entities/           # Entités JPA
│   ├── Patient
│   ├── Dentiste
│   ├── AideSoignant
│   ├── Rendezvous
│   ├── ServiceMedical
│   └── ActeMedical
├── ejb/
│   └── interfaces/     # Interfaces EJB Local
│       ├── IPatientLocal
│       ├── IDentisteLocal
│       ├── IAideSoignantLocal
│       ├── IRendezvousLocal
│       ├── IServiceMedicalLocal
│       └── IActeMedicalLocal
└── servlets/           # Contrôleurs Servlet
    ├── Patient/
    ├── Dentiste/
    ├── AideSoignant/
    ├── Rendezvous/
    ├── ServiceMedical/
    └── ActesMedical/
```

### Structure des Vues JSP
```
WEB-INF/views/
├── patient/
├── dentiste/
├── aidesoignant/
├── rendezvous/
├── service-medical/
│   ├── add-service-medical.jsp
│   ├── update-service-medical.jsp
│   └── list-services-medicaux.jsp
└── acte-medical/
    ├── add-acte-medical.jsp
    ├── edit-acte-medical.jsp
    └── list-actes-medicaux.jsp
```

## Fonctionnalités Principales

### Gestion des Services Médicaux
- Ajout de nouveaux services médicaux
- Modification des services existants
- Suppression de services
- Liste complète avec recherche et filtrage
- Types de services : Consultation, Chirurgie, Imagerie, Laboratoire, Urgence, Hospitalisation, Rééducation

### Gestion des Actes Médicaux
- Enregistrement d'actes médicaux liés à des rendez-vous
- Association avec des services médicaux
- Modification des tarifs et descriptions
- Suivi des actes par patient et dentiste
- Calcul automatique des montants totaux

### Gestion des Utilisateurs
- Authentification pour dentistes et aides-soignants
- Dashboards personnalisés selon le rôle
- Gestion des sessions utilisateur

### Recherche et Filtrage
- Recherche en temps réel sur les services et actes
- Filtres par type de service
- Filtres par patient ou dentiste

## Installation et Configuration

### Prérequis
- JDK 11 ou supérieur
- WildFly 26+ ou tout serveur d'application compatible Jakarta EE
- Système de gestion de base de données (MySQL recommandé)
- Maven 3.6+

### Étapes d'Installation

1. Cloner le repository
```bash
git clone [URL_DU_REPOSITORY]
cd PlateformeRendezVous
```

2. Configurer la base de données
- Créer une base de données nommée `plateforme_rdv`
- Mettre à jour le fichier `persistence.xml` avec vos paramètres de connexion

3. Configuration du DataSource dans WildFly
```xml
<datasource jndi-name="java:jboss/datasources/PlateformeDS" pool-name="PlateformeDS">
    <connection-url>jdbc:mysql://localhost:3306/plateforme_rdv</connection-url>
    <driver>mysql</driver>
    <security>
        <user-name>root</user-name>
        <password>votre_mot_de_passe</password>
    </security>
</datasource>
```

4. Compiler et déployer le projet
```bash
mvn clean package
# Copier le fichier WAR généré dans le dossier deployments de WildFly
cp target/PlateformeRendezVous.war $WILDFLY_HOME/standalone/deployments/
```

5. Démarrer WildFly
```bash
$WILDFLY_HOME/bin/standalone.sh
```

6. Accéder à l'application
```
http://localhost:8080/PlateformeRendezVous
```

## Utilisation

### Pour les Dentistes
1. Se connecter avec les identifiants dentiste
2. Accéder au dashboard dentiste
3. Consulter la liste des rendez-vous
4. Enregistrer des actes médicaux pour les consultations

### Pour les Aides-Soignants
1. Se connecter avec les identifiants aide-soignant
2. Accéder au dashboard aide-soignant
3. Gérer les services médicaux
4. Consulter et modifier les actes médicaux

### Gestion des Services Médicaux
1. Accéder à `/servicesmedicaux`
2. Cliquer sur "Ajouter un Service" pour créer un nouveau service
3. Utiliser la recherche et les filtres pour trouver des services
4. Cliquer sur "Modifier" pour mettre à jour un service
5. Cliquer sur "Supprimer" pour retirer un service (avec confirmation)

### Gestion des Actes Médicaux
1. Accéder à `/actesmedicaux`
2. Cliquer sur "Nouvel Acte" pour enregistrer un acte
3. Sélectionner le rendez-vous concerné
4. Choisir le service médical approprié
5. Ajuster le tarif si nécessaire
6. Ajouter des notes dans la description

## Sécurité

- Gestion des sessions utilisateur
- Vérification des autorisations par rôle
- Protection contre les injections SQL via JPA
- Validation des données côté serveur
- Gestion des erreurs avec messages informatifs

