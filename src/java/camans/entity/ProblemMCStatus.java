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

    public Date getMCUpdate() {
        return MCUpdate;
    }

    public void setMCUpdate(Date MCUpdate) {
        this.MCUpdate = MCUpdate;
    }

    public String getMCStatus() {
        return MCStatus;
    }

    public void setMCStatus(String MCStatus) {
        this.MCStatus = MCStatus;
    }

    public String getMCStatusMore() {
        return MCStatusMore;
    }

    public void setMCStatusMore(String MCStatusMore) {
        this.MCStatusMore = MCStatusMore;
    }

    public Date getMCExpDate() {
        return MCExpDate;
    }

    public void setMCExpDate(Date MCExpDate) {
        this.MCExpDate = MCExpDate;
    }
	
    public int getMCDaysCumul() {
   return MCDaysCumul;
}

    public void setMCDaysCumul(int MCDaysCumul) {
        this.MCDaysCumul = MCDaysCumul;
    }
	
    public String getMCRem() {
   return MCRem;
}

    public void setMCRem (String MCRem) {
        this.MCRem = MCRem;
    }

    @Override
    public String toString() {
        return "ProblemMCStatus{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", MCUpdate=" + MCUpdate + ", MCStatus=" + MCStatus + 
                ", MCStatusMore=" + MCStatusMore + ", MCExpDate=" + MCExpDate + 
                ", MCDaysCumul=" + MCDaysCumul + ", MCRem=" + MCRem + '}';
    }
	
    public String toString2() {
        return "MC Status [MCUpdate=" + MCUpdate + ", MCStatus=" + MCStatus + 
                ", MCStatusMore=" + MCStatusMore + ", MCExpDate=" + MCExpDate + 
                ", MCDaysCumul=" + MCDaysCumul + ", MCRem=" + MCRem + ']';
    }    
    
}
