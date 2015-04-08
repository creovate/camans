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
public class ProblemMCStatus {
    
    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private Date MCUpdate;
    private String MCStatus;
    private String MCStatusMore ;
    private Date MCExpDate;
    private int MCDaysCumul;
    private String MCRem;

    /*
     * Creates new MC status object with id
     * @param id identifier of MC status
     * @param worker fin number associated with MC status
     * @param job key associated with MC status
     * @param problem key associated with MC status
     * @param updated date of MC status
     * @param MC status
     * @param more info of MC status
     * @param expiry date of MC status
     * @param accumulated days of MC status
     * @param remarks of MC status
     */
    //constructor with id 
    public ProblemMCStatus(int id, String workerFinNumber, int jobKey, int problemKey , 
            Date MCUpdate, String MCStatus, String MCStatusMore, Date MCExpDate, 
            int MCDaysCumul, String MCRem) {
                this.id = id;
                this.workerFinNumber = workerFinNumber;
                this.jobKey = jobKey;
                this.problemKey = problemKey;
                this.MCUpdate = MCUpdate;
                this.MCStatus = MCStatus;
                this.MCStatusMore = MCStatusMore;
                this.MCExpDate = MCExpDate;
                this.MCDaysCumul = MCDaysCumul;
                this.MCRem = MCRem;
        }
/*
     * Creates new MC status object without id
     * @param worker fin number associated with MC status
     * @param job key associated with MC status
     * @param problem key associated with MC status
     * @param updated date of MC status
     * @param MC status
     * @param more info of MC status
     * @param expiry date of MC status
     * @param accumulated days of MC status
     * @param remarks of MC status
     */
    //constructor without id
    public ProblemMCStatus(String workerFinNumber, int jobKey, int problemKey , 
            Date MCUpdate, String MCStatus, String MCStatusMore, 
            Date MCExpDate, int MCDaysCumul, String MCRem) {

            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.MCUpdate = MCUpdate;
            this.MCStatus = MCStatus;
            this.MCStatusMore = MCStatusMore;
            this.MCExpDate = MCExpDate;
            this.MCDaysCumul = MCDaysCumul;
            this.MCRem = MCRem;
    }
	
    public int getId() {
    /**
     * getter method for id of MC status
     * @return id of MC status
     */
    public int getId() {
        return id;
    }
    /**
     * setter method for id of MC status
     * @param id 
     * sets current id of MC status to new id
     */
    public void setId(int id) {
        this.id = id;
    }
     /**
     * getter method for worker fin number associated with MC status
     * @return worker fin number associated with MC status
     */
    public String getWorkerFinNumber() {
        return workerFinNumber;
    }
    /**
     * setter method for worker fin number associated with MC status
     * @param workerFinNumber
     * sets current worker fin number associated with MC status to new worker fin number
     */
    public void setWorkerFinNumber(String workerFinNumber) {
        this.workerFinNumber = workerFinNumber;
    }
    /**
     * getter method for job key associated with MC status
     * @return job key associated with MC status
     */
    public int getJobKey() {
        return jobKey;
    }
    /**
     * setter method for job key associated with MC status
     * @param jobKey
     * sets current job key associated with MC status to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }
     /**
     * getter method for problem key associated with MC status
     * @return problem key associated with MC status
     */
    public int getProblemKey() {
        return problemKey;
    }
    /**
     * setter method for problem key associated with MC status
     * @param problemKey
     * sets current problem key associated with MC status to new problem key
     */
    public void setProblemKey(int problemKey) {
        this.problemKey = problemKey;
    }
     /**
     * getter method for updated date of MC status
     * @return updated date of MC status
     */
    public Date getMCUpdate() {
        return MCUpdate;
    }
    /**
     * setter method for updated date of MC status
     * @param MCUpdate
     * sets current updated date of MC status to new updated date
     */
    public void setMCUpdate(Date MCUpdate) {
        this.MCUpdate = MCUpdate;
    }
    /**
     * getter method for MC status
     * @return MC status
     */
    public String getMCStatus() {
        return MCStatus;
    }
    /**
     * setter method for MC status
     * @param MCStatus
     * sets current MC status to new MC status
     */
    public void setMCStatus(String MCStatus) {
        this.MCStatus = MCStatus;
    }
    /**
     * getter method for more info of MC status
     * @return more info of MC status
     */
    public String getMCStatusMore() {
        return MCStatusMore;
    }
    /**
     * setter method for more info of MC status
     * @param MCStatusMore
     * sets current more info of MC status to new more info of MC status
     */
    public void setMCStatusMore(String MCStatusMore) {
        this.MCStatusMore = MCStatusMore;
    }
    /**
     * getter method for expiry date of MC status
     * @return expiry date of MC status
     */
    public Date getMCExpDate() {
        return MCExpDate;
    }
    /**
     * setter method for expiry date of MC status
     * @param MCExpDate
     * sets current expiry date of MC status to new expiry date 
     */
    public void setMCExpDate(Date MCExpDate) {
        this.MCExpDate = MCExpDate;
    }
    /**
     * getter method for accumulated days of MC status
     * @return accumulated days of MC status
     */
    public int getMCDaysCumul() {
   return MCDaysCumul;
}
    /**
     * setter method for accumulated days of MC status
     * @param MCDaysCumul
     * sets current accumulated days of MC status to new accumulated days
     */
    public void setMCDaysCumul(int MCDaysCumul) {
        this.MCDaysCumul = MCDaysCumul;
    }
    /**
     * getter method for remarks of MC status
     * @return remarks of MC status
     */
    public String getMCRem() {
   return MCRem;
}
    /**
     * setter method for remarks of MC status
     * @param MCRem
     * sets current remarks of MC status to new remarks
     */
    public void setMCRem (String MCRem) {
        this.MCRem = MCRem;
    }
    /*
     * toString method for details of MC status with id
     * @return details of MC status with id
     */
    @Override
    public String toString() {
        return "ProblemMCStatus{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", MCUpdate=" + MCUpdate + ", MCStatus=" + MCStatus + 
                ", MCStatusMore=" + MCStatusMore + ", MCExpDate=" + MCExpDate + 
                ", MCDaysCumul=" + MCDaysCumul + ", MCRem=" + MCRem + '}';
    }
	/*
     * toString method for details of MC status without id
     * @return details of MC status without id
     */	
    public String toString2() {
        return "MC Status [MCUpdate=" + MCUpdate + ", MCStatus=" + MCStatus + 
                ", MCStatusMore=" + MCStatusMore + ", MCExpDate=" + MCExpDate + 
                ", MCDaysCumul=" + MCDaysCumul + ", MCRem=" + MCRem + ']';
    }    
    
}
