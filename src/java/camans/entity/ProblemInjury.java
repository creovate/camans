/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

import java.sql.Date;

/**
 *
 * @author soemyatmyat
 */
public class ProblemInjury {
    
    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;    
    private Date injuryDate;
    private String injuryTime;
    private String injuryLocation;
    private String injuryDeath;
    private String injuryBodyPart;
    private String injuryHow;
    private String injuryAmbulance;
    private String initialTreatment;
    private String initialTreatmentMore;
    private String injuryWorkRelated;
    private String injuryRemarks;

    public ProblemInjury(int id, String workerFinNumber, int jobKey, int problemKey, Date injuryDate, String injuryTime, String injuryLocation, String injuryDeath, String injuryBodyPart, String injuryHow, String injuryAmbulance, String initialTreatment, String initialTreatmentMore, String injuryWorkRelated, String injuryRemarks) {
        this.id = id;
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.injuryDate = injuryDate;
        this.injuryTime = injuryTime;
        this.injuryLocation = injuryLocation;
        this.injuryDeath = injuryDeath;
        this.injuryBodyPart = injuryBodyPart;
        this.injuryHow = injuryHow;
        this.injuryAmbulance = injuryAmbulance;
        this.initialTreatment = initialTreatment;
        this.initialTreatmentMore = initialTreatmentMore;
        this.injuryWorkRelated = injuryWorkRelated;
        this.injuryRemarks = injuryRemarks;
    }

    public ProblemInjury(String workerFinNumber, int jobKey, int problemKey, Date injuryDate, String injuryTime, String injuryLocation, String injuryDeath, String injuryBodyPart, String injuryHow, String injuryAmbulance, String initialTreatment, String initialTreatmentMore, String injuryWorkRelated, String injuryRemarks) {
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.injuryDate = injuryDate;
        this.injuryTime = injuryTime;
        this.injuryLocation = injuryLocation;
        this.injuryDeath = injuryDeath;
        this.injuryBodyPart = injuryBodyPart;
        this.injuryHow = injuryHow;
        this.injuryAmbulance = injuryAmbulance;
        this.initialTreatment = initialTreatment;
        this.initialTreatmentMore = initialTreatmentMore;
        this.injuryWorkRelated = injuryWorkRelated;
        this.injuryRemarks = injuryRemarks;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getWorkerFinNumber() {
        return workerFinNumber;
    }

    public void setWorkerFinNumber(String workerFinNumber) {
        this.workerFinNumber = workerFinNumber;
    }

    public int getJobKey() {
        return jobKey;
    }

    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }

    public int getProblemKey() {
        return problemKey;
    }

    public void setProblemKey(int problemKey) {
        this.problemKey = problemKey;
    }

    public Date getInjuryDate() {
        return injuryDate;
    }

    public void setInjuryDate(Date injuryDate) {
        this.injuryDate = injuryDate;
    }

    public String getInjuryTime() {
        return injuryTime;
    }

    public void setInjuryTime(String injuryTime) {
        this.injuryTime = injuryTime;
    }

    public String getInjuryLocation() {
        return injuryLocation;
    }

    public void setInjuryLocation(String injuryLocation) {
        this.injuryLocation = injuryLocation;
    }

    public String getInjuryDeath() {
        return injuryDeath;
    }

    public void setInjuryDeath(String injuryDeath) {
        this.injuryDeath = injuryDeath;
    }

    public String getInjuryBodyPart() {
        return injuryBodyPart;
    }

    public void setInjuryBodyPart(String injuryBodyPart) {
        this.injuryBodyPart = injuryBodyPart;
    }

    public String getInjuryHow() {
        return injuryHow;
    }

    public void setInjuryHow(String injuryHow) {
        this.injuryHow = injuryHow;
    }

    public String getInjuryAmbulance() {
        return injuryAmbulance;
    }

    public void setInjuryAmbulance(String injuryAmbulance) {
        this.injuryAmbulance = injuryAmbulance;
    }

    public String getInitialTreatment() {
        return initialTreatment;
    }

    public void setInitialTreatment(String initialTreatment) {
        this.initialTreatment = initialTreatment;
    }

    public String getInitialTreatmentMore() {
        return initialTreatmentMore;
    }

    public void setInitialTreatmentMore(String initialTreatmentMore) {
        this.initialTreatmentMore = initialTreatmentMore;
    }

    public String getInjuryWorkRelated() {
        return injuryWorkRelated;
    }

    public void setInjuryWorkRelated(String injuryWorkRelated) {
        this.injuryWorkRelated = injuryWorkRelated;
    }

    public String getInjuryRemarks() {
        return injuryRemarks;
    }

    public void setInjuryRemarks(String injuryRemarks) {
        this.injuryRemarks = injuryRemarks;
    }

    @Override
    public String toString() {
        return "ProblemInjury{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + ", injuryDate=" + injuryDate + 
                ", injuryTime=" + injuryTime + ", injuryLocation=" + injuryLocation + 
                ", injuryDeath=" + injuryDeath + ", injuryBodyPart=" + injuryBodyPart + 
                ", injuryHow=" + injuryHow + ", injuryAmbulance=" + injuryAmbulance + 
                ", initialTreatment=" + initialTreatment + 
                ", initialTreatmentMore=" + initialTreatmentMore + 
                ", injuryWorkRelated=" + injuryWorkRelated + ", injuryRemarks=" + injuryRemarks + '}';
    }

    public String toString2() {
        return "Injury [ injuryDate=" + injuryDate + 
                ", injuryTime=" + injuryTime + ", injuryLocation=" + injuryLocation + 
                ", injuryDeath=" + injuryDeath + ", injuryBodyPart=" + injuryBodyPart + 
                ", injuryHow=" + injuryHow + ", injuryAmbulance=" + injuryAmbulance + 
                ", initialTreatment=" + initialTreatment + 
                ", initialTreatmentMore=" + initialTreatmentMore + 
                ", injuryWorkRelated=" + injuryWorkRelated + ", injuryRemarks=" + injuryRemarks + ']';
    }
    
    
}
