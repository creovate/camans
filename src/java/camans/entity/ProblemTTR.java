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
    private Date departureDate;
    private String newEmployerName;
    private String newJob;
    private String TTRRem;
	
    
    //constructor with id 
    public ProblemTTR(int id, String workerFinNumber, int jobKey, int problemKey , 
            Date TTRUpdate, String TTRStatus, String TTRStatusMore, Date departureDate, 
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
    public ProblemTTR(String workerFinNumber, int jobKey, int problemKey , 
            Date TTRUpdate, String TTRStatus, String TTRStatusMore, Date departureDate, 
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

    public Date getTTRUpdate() {
        return TTRUpdate;
    }

    public void setTTRUpdate(Date TTRUpdate) {
        this.TTRUpdate = TTRUpdate;
    }

    public String getTTRStatus() {
        return TTRStatus;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTTRStatus(String TTRStatus) {
        this.TTRStatus = TTRStatus;
    }

    public String getTTRStatusMore() {
        return TTRStatusMore;
    }

    public void setTTRStatusMore(String TTRStatusMore) {
        this.TTRStatusMore = TTRStatusMore;
    }

    public Date getDepartureDate() {
        return departureDate;
    }

    public void setDepartureDate(Date MCExpDate) {
        this.departureDate = departureDate;
    }
	
    public String getNewEmployerName() {
        return newEmployerName;
    }

    public void setNewEmployerName(String newEmployerName) {
        this.newEmployerName = newEmployerName;
    }
	
    public String getNewJob() {
   return newJob;
}

    public void setNewJob (String newJob) {
        this.newJob = newJob;
    }
	
    public String getTTRRem() {
   return TTRRem;
}

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
        return "ProblemTTR{" + "WorkerFinNumber=" + workerFinNumber + 
                ", TTRUpdate=" + TTRUpdate + ", TTRStatus=" + TTRStatus + 
                ", TTRStatusMore=" + TTRStatusMore + ", departureDate=" + departureDate + 
                ", newEmployerName=" + newEmployerName + ", newJob=" + newJob + ", TTRRem=" + TTRRem + '}';
    }
    
}
