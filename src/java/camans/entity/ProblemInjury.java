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
    /*
     * Creates new injury object with id
     * @param id identifier of injury
     * @param worker fin number associated with injury
     * @param job key associated with injury
     * @param problem key associated with injury
     * @param date of injury
     * @param time of injury   
     * @param location of injury
     * @param whether there is death
     * @param body parts of injury
     * @param how injury happen
     * @param ambulance of injury
     * @param treatment of injury
     * @param more info of treatment of injury
     * @param whether injury is work related
     * @param remarks of injury
     */
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
    /*
     * Creates new injury object without id
     * @param worker fin number associated with injury
     * @param job key associated with injury
     * @param problem key associated with injury
     * @param date of injury
     * @param time of injury   
     * @param location of injury
     * @param whether there is death
     * @param body parts of injury
     * @param how injury happen
     * @param ambulance of injury
     * @param treatment of injury
     * @param more info of treatment of injury
     * @param whether injury is work related
     * @param remarks of injury
     */
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

    /**
     * getter method for id of injury
     * @return id of injury
     */
    public int getId() {
        return id;
    }
    /**
     * setter method for id of injury
     * @param id 
     * sets current id of injury to new id
     */
    public void setId(int id) {
        this.id = id;
    }
    /**
     * getter method for worker fin number associated with injury
     * @return worker fin number associated with injury
     */
    public String getWorkerFinNumber() {
        return workerFinNumber;
    }
    /**
     * setter method for worker fin number associated with injury
     * @param workerFinNumber 
     * sets current worker fin number associated with injury to new worker fin number
     */
    public void setWorkerFinNumber(String workerFinNumber) {
        this.workerFinNumber = workerFinNumber;
    }
    /**
     * getter method for job key associated with injury
     * @return job key associated with injury
     */
    public int getJobKey() {
        return jobKey;
    }
     /**
     * setter method for job key associated with injury
     * @param jobKey 
     * sets current job key associated with injury to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }
    /**
     * getter method for problem key associated with injury
     * @return problem key associated with injury
     */
    public int getProblemKey() {
        return problemKey;
    }
    /**
     * setter method for problem key associated with injury
     * @param problemKey 
     * sets current problem key associated with injury to new problem key
     */
    public void setProblemKey(int problemKey) {
        this.problemKey = problemKey;
    }
    /**
     * getter method for date of injury
     * @return date of injury
     */
    public Date getInjuryDate() {
        return injuryDate;
    }
    /**
     * setter method for date of injury
     * @param injuryDate 
     * sets current date of injury to new date
     */
    public void setInjuryDate(Date injuryDate) {
        this.injuryDate = injuryDate;
    }
    /**
     * getter method for time of injury
     * @return time of injury
     */
    public String getInjuryTime() {
        return injuryTime;
    }
    /**
     * setter method for time of injury
     * @param injuryTime 
     * sets current time of injury to new time
     */
    public void setInjuryTime(String injuryTime) {
        this.injuryTime = injuryTime;
    }
    /**
     * getter method for location of injury
     * @return location of injury
     */
    public String getInjuryLocation() {
        return injuryLocation;
    }
    /**
     * setter method for location of injury
     * @param injuryLocation 
     * sets current location of injury to new location
     */
    public void setInjuryLocation(String injuryLocation) {
        this.injuryLocation = injuryLocation;
    }
    /**
     * getter method for whether death occur in injury
     * @return whether death occur in injury
     */
    public String getInjuryDeath() {
        return injuryDeath;
    }
    /**
     * setter method for whether death involved in injury
     * @param injuryDeath 
     * sets current whether death involved in injury to whether death involved
     */
    public void setInjuryDeath(String injuryDeath) {
        this.injuryDeath = injuryDeath;
    }
    /**
     * getter method for body parts of injury
     * @return body parts of injury
     */
    public String getInjuryBodyPart() {
        return injuryBodyPart;
    }
    /**
     * setter method for body parts of injury
     * @param injuryBodyPart 
     * sets current body parts of injury to new body parts
     */
    public void setInjuryBodyPart(String injuryBodyPart) {
        this.injuryBodyPart = injuryBodyPart;
    }
    /**
     * getter method for how injury happen
     * @return how injury happen
     */
    public String getInjuryHow() {
        return injuryHow;
    }
    /**
     * setter method for how injury happen
     * @param injuryHow 
     * sets current how injury happen to new how injury happen
     */
    public void setInjuryHow(String injuryHow) {
        this.injuryHow = injuryHow;
    }
    /**
     * getter method for ambulance of injury
     * @return ambulance of injury
     */
    public String getInjuryAmbulance() {
        return injuryAmbulance;
    }
    /**
     * setter method for ambulance of injury
     * @param injuryAmbulance
     * sets current ambulance of injury to new ambulance
     */
    public void setInjuryAmbulance(String injuryAmbulance) {
        this.injuryAmbulance = injuryAmbulance;
    }
    /**
     * getter method for initial treatment of injury
     * @return initial treatment of injury
     */
    public String getInitialTreatment() {
        return initialTreatment;
    }
    /**
     * setter method for initial treatment of injury
     * @param initialTreatment
     * sets current initial treatment of injury to new initial treatment
     */
    public void setInitialTreatment(String initialTreatment) {
        this.initialTreatment = initialTreatment;
    }
    /**
     * getter method for more info of initial treatment of injury
     * @return more info of initial treatment of injury
     */
    public String getInitialTreatmentMore() {
        return initialTreatmentMore;
    }
     /**
     * setter method for more info of initial treatment of injury
     * @param initialTreatmentMore
     * sets current more info of initial treatment of injury to new more info of initial treatment
     */
    public void setInitialTreatmentMore(String initialTreatmentMore) {
        this.initialTreatmentMore = initialTreatmentMore;
    }
    /**
     * getter method for whether injury is work related
     * @return whether injury is work related
     */
    public String getInjuryWorkRelated() {
        return injuryWorkRelated;
    }
     /**
     * setter method for whether injury is work related
     * @param injuryWorkRelated
     * sets current whether injury is work related to new whether injury is work related
     */
    public void setInjuryWorkRelated(String injuryWorkRelated) {
        this.injuryWorkRelated = injuryWorkRelated;
    }
    /**
     * getter method for remarks of injury
     * @return remarks of injury
     */
    public String getInjuryRemarks() {
        return injuryRemarks;
    }
    /**
     * setter method remarks of injury
     * @param initialRemarks
     * sets current remarks of injury to new remarks
     */
    public void setInjuryRemarks(String injuryRemarks) {
        this.injuryRemarks = injuryRemarks;
    }
    /*
     * toString method of details of injury with id
     * @return details of injury with id
     */
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
    /*
     * toString method of details of injury without id
     * @return details of injury without id
     */
    public String toString2() {
        return "Injury [ injuryDate=" + injuryDate + 
                ", injuryTime=" + injuryTime + ", injuryLocation=" + injuryLocation + 
                ", injuryDeath=" + injuryDeath + ", injuryBodyPart=" + injuryBodyPart + 
                ", injuryHow=" + injuryHow + ", injuryAmbulance=" + injuryAmbulance + 
                ", initialTreatment=" + initialTreatment + 
                ", injuryWorkRelated=" + injuryWorkRelated + ", injuryRemarks=" + injuryRemarks + ']';
    }
    
    
}
