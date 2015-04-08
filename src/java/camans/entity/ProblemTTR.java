/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

import java.sql.Date;

/**
 *
 * @author kyilailaishoon
 */
public class ProblemTTR {
    
    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private Date TTRUpdate;
    private String TTRStatus;
    private String TTRStatusMore ;
    private String departureDate;
    private String newEmployerName;
    private String newJob;
    private String TTRRem;
	
    
    //constructor with id 
     /**
    * Constructor for ProblemTTR class
    *
    * @param id - id
    * @param workerFinNumber - worker's FIN
    * @param jobKey - job key
    * @param problemKey - problem key
    * @param TTRUpdate - date of update
    * @param TTRStatus - Transfer, TJS or repatriation status
    * @param TTRStatusMore - more Transfer, TJS or repatriation status
    * @param departureDate - departure date from Singapore
    * @param newEmployerName - name of TJS or new employer
    * @param newJob - description of TJS or new job
    * @param TTRRem - remarks
    */
    public ProblemTTR(int id, String workerFinNumber, int jobKey, int problemKey , 
            Date TTRUpdate, String TTRStatus, String TTRStatusMore, String departureDate, 
            String newEmployerName, String newJob, String TTRRem) {
        this.id = id;
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.TTRUpdate = TTRUpdate;
        this.TTRStatus = TTRStatus;
        this.departureDate = departureDate;
        this.newEmployerName = newEmployerName;
        this.newJob = newJob;
        this.TTRRem = TTRRem;
    }
	
    //constructor without id
    /**
    * Constructor for ProblemTTR class without id
    *
    * @param workerFinNumber - worker's FIN
    * @param jobKey - job key
    * @param problemKey - problem key
    * @param TTRUpdate - date of update
    * @param TTRStatus - Transfer, TJS or repatriation status
    * @param TTRStatusMore - more Transfer, TJS or repatriation status
    * @param departureDate - departure date from Singapore
    * @param newEmployerName - name of TJS or new employer
    * @param newJob - description of TJS or new job
    * @param TTRRem - remarks
    */
    public ProblemTTR(String workerFinNumber, int jobKey, int problemKey , 
            Date TTRUpdate, String TTRStatus, String TTRStatusMore, String departureDate, 
            String newEmployerName, String newJob, String TTRRem) {

            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.TTRUpdate = TTRUpdate;
            this.TTRStatus = TTRStatus;
            this.departureDate = departureDate;
            this.newEmployerName = newEmployerName;
            this.newJob = newJob;
            this.TTRRem = TTRRem;
    }

    /**
    * Returns id
    *
    * @return id
    */
    public int getId() {
            return id;
    }

    /**
    * Returns worker FIN
    *
    * @return worker FIN
    */
    public String getWorkerFinNumber() {
            return workerFinNumber;
    }

    /**
    * Returns job key
    *
    * @return job key
    */
    public int getJobKey() {
            return jobKey;
    }

    /**
    * Returns problem key
    *
    * @return problem key
    */
    public int getProblemKey() {
            return problemKey;
    }
    
     /**
    * Sets id
    *
    * @param id  id
    */
    public void setId(int id) {
            this.id = id;
    }
    
    /**
    * Sets worker FIN
    *
    * @param workerFinNumber  worker FIN
    */
    public void setWorkerFinNumber(String workerFinNumber) {
            this.workerFinNumber = workerFinNumber;
    }
    
    /**
    * Sets job key
    *
    * @param jobKey  job key
    */
    public void setJobKey(int jobKey) {
            this.jobKey = jobKey;
    }

    /**
    * Sets problem key
    *
    * @param problemKey  problem key
    */
    public void setProblemKey(int problemKey) {
            this.problemKey = problemKey;
    }

     /**
    * Returns date of update
    *
    * @return date of update
    */
    public Date getTTRUpdate() {
        return TTRUpdate;
    }

    /**
    * Sets date of update
    *
    * @param TTRUpdate  date of update
    */
    public void setTTRUpdate(Date TTRUpdate) {
        this.TTRUpdate = TTRUpdate;
    }

     /**
    * Returns Transfer, TJS or repatriation status
    *
    * @return Transfer, TJS or repatriation status
    */
    public String getTTRStatus() {
        return TTRStatus;
    }


    /**
    * Sets Transfer, TJS or repatriation status
    *
    * @param TTRStatus  Transfer, TJS or repatriation status
    */
    public void setTTRStatus(String TTRStatus) {
        this.TTRStatus = TTRStatus;
    }

     /**
    * Returns more Transfer, TJS or repatriation status
    *
    * @return more Transfer, TJS or repatriation status
    */
    public String getTTRStatusMore() {
        return TTRStatusMore;
    }

    /**
    * Sets more Transfer, TJS or repatriation status
    *
    * @param TTRStatusMore  more Transfer, TJS or repatriation status
    */
    public void setTTRStatusMore(String TTRStatusMore) {
        this.TTRStatusMore = TTRStatusMore;
    }

     /**
    * Returns departure date from Singapore
    *
    * @return departure date from Singapore
    */
    public String getDepartureDate() {
        return departureDate;
    }

    /**
    * Sets departure date from Singapore
    *
    * @param MCExpDate  departure date from Singapore
    */
    public void setDepartureDate(String MCExpDate) {
        this.departureDate = departureDate;
    }
	
     /**
    * Returns name of TJS or new employer
    *
    * @return name of TJS or new employer
    */
    public String getNewEmployerName() {
        return newEmployerName;
    }

    /**
    * Sets name of TJS or new employer
    *
    * @param newEmployerName  name of TJS or new employer
    */
    public void setNewEmployerName(String newEmployerName) {
        this.newEmployerName = newEmployerName;
    }
	
     /**
    * Returns description of TJS or new job
    *
    * @return description of TJS or new job
    */
    public String getNewJob() {
   return newJob;
}

    /**
    * Sets description of TJS or new job
    *
    * @param newJob  description of TJS or new job
    */
    public void setNewJob (String newJob) {
        this.newJob = newJob;
    }
	
     /**
    * Returns remark
    *
    * @return remark
    */
    public String getTTRRem() {
   return TTRRem;
}

    /**
    * Sets remark
    *
    * @param TTRRem  remark
    */
    public void setTTRRem (String TTRRem) {
        this.TTRRem = TTRRem;
    }

    @Override
    public String toString() {
        return "ProblemTTR{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", TTRUpdate=" + TTRUpdate + ", TTRStatus=" + TTRStatus + 
                ", TTRStatusMore=" + TTRStatusMore + ", departureDate=" + departureDate + 
                ", newEmployerName=" + newEmployerName + ", newJob=" + newJob + ", TTRRem=" + TTRRem + '}';
    }
	
    public String toString2() {
        return "TTR [TTRUpdate=" + TTRUpdate + ", TTRStatus=" + TTRStatus + 
                ", TTRStatusMore=" + TTRStatusMore + ", departureDate=" + departureDate + 
                ", newEmployerName=" + newEmployerName + ", newJob=" + newJob + ", TTRRem=" + TTRRem + ']';
    }
    
}
