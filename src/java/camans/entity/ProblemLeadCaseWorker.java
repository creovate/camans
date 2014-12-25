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
public class ProblemLeadCaseWorker {
    
//attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private String leadCaseWorker;
    private Date leadStart;
    private Date leadEnd;

    public ProblemLeadCaseWorker(int id, String workerFinNumber, int jobKey, int problemKey, String leadCaseWorker, Date leadStart, Date leadEnd) {
        this.id = id;
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.leadCaseWorker = leadCaseWorker;
        this.leadStart = leadStart;
        this.leadEnd = leadEnd;
    }

    public ProblemLeadCaseWorker(String workerFinNumber, int jobKey, int problemKey, 
            String leadCaseWorker, Date leadStart, Date leadEnd) {
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.leadCaseWorker = leadCaseWorker;
        this.leadStart = leadStart;
        this.leadEnd = leadEnd;
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

    public String getLeadCaseWorker() {
        return leadCaseWorker;
    }

    public void setLeadCaseWorker(String leadCaseWorker) {
        this.leadCaseWorker = leadCaseWorker;
    }

    public Date getLeadStart() {
        return leadStart;
    }

    public void setLeadStart(Date leadStart) {
        this.leadStart = leadStart;
    }

    public Date getLeadEnd() {
        return leadEnd;
    }

    public void setLeadEnd(Date leadEnd) {
        this.leadEnd = leadEnd;
    }

    @Override
    public String toString() {
        return "ProblemLeadCaseWorker{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", leadCaseWorker=" + leadCaseWorker + ", leadStart=" + leadStart + 
                ", leadEnd=" + leadEnd + '}';
    }
    
    public String toString2() {
        return "ProblemLeadCaseWorker{" + "WorkerFinNumber=" + workerFinNumber + 
                ", leadCaseWorker=" + leadCaseWorker + ", leadStart=" + leadStart + 
                ", leadEnd=" + leadEnd + '}';
    }

   
    
}
