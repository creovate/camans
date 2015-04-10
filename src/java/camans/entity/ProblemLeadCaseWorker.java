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
    /*
     * Creates new lead case worker object with id
     * @param id identifier of lead case worker
     * @param worker fin number associated with lead case worker
     * @param job key associated with lead case worker
     * @param lead case worker
     * @param start of lead case worker
     * @param end of lead case worker
     */
    public ProblemLeadCaseWorker(int id, String workerFinNumber, int jobKey, int problemKey, String leadCaseWorker, Date leadStart, Date leadEnd) {
        this.id = id;
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.leadCaseWorker = leadCaseWorker;
        this.leadStart = leadStart;
        this.leadEnd = leadEnd;
    }
    /*
     * Creates new lead case worker object without id
     * @param worker fin number associated with lead case worker
     * @param job key associated with lead case worker
     * @param lead case worker
     * @param start of lead case worker
     * @param end of lead case worker
     */
    public ProblemLeadCaseWorker(String workerFinNumber, int jobKey, int problemKey, 
            String leadCaseWorker, Date leadStart, Date leadEnd) {
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.leadCaseWorker = leadCaseWorker;
        this.leadStart = leadStart;
        this.leadEnd = leadEnd;
    }

    /**
     * getter method for id of lead case worker
     * @return id of lead case worker
     */
    public int getId() {
        return id;
    }
    /**
     * setter method for id of lead case worker
     * @param id 
     * sets current id of lead case worker to new id
     */
    public void setId(int id) {
        this.id = id;
    }
    /**
     * getter method for worker fin number associated with lead case worker
     * @return worker fin number associated with lead case worker
     */
    public String getWorkerFinNumber() {
        return workerFinNumber;
    }
    /**
     * setter method for worker fin number associated with lead case worker
     * @param workerFinNumber
     * sets current worker fin number associated with lead case worker to new worker fin number 
     */
    public void setWorkerFinNumber(String workerFinNumber) {
        this.workerFinNumber = workerFinNumber;
    }
    /**
     * getter method for job key associated with lead case worker
     * @return job key associated with lead case worker
     */
    public int getJobKey() {
        return jobKey;
    }
    /**
     * setter method for job key associated with lead case worker
     * @param jobKey
     * sets current job key associated with lead case worker to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }
    /**
     * getter method for problem key associated with lead case worker
     * @return problem key associated with lead case worker
     */
    public int getProblemKey() {
        return problemKey;
    }
    /**
     * setter method for problem key associated with lead case worker
     * @param problemKey
     * sets current problem key associated with lead case worker to new problem key
     */
    public void setProblemKey(int problemKey) {
        this.problemKey = problemKey;
    }
    /**
     * getter method for lead case worker
     * @return lead case worker
     */
    public String getLeadCaseWorker() {
        return leadCaseWorker;
    }
    /**
     * setter method for lead case worker
     * @param leadCaseWorker
     * sets current lead case worker to new lead case worker
     */
    public void setLeadCaseWorker(String leadCaseWorker) {
        this.leadCaseWorker = leadCaseWorker;
    }
    /**
     * getter method for start of lead case worker
     * @return start of lead case worker
     */
    public Date getLeadStart() {
        return leadStart;
    }
    /**
     * setter method for start of lead case worker
     * @param leadStart
     * sets current start of lead case worker to new start
     */
    public void setLeadStart(Date leadStart) {
        this.leadStart = leadStart;
    }
    /**
     * getter method for end of lead case worker
     * @return end of lead case worker
     */
    public Date getLeadEnd() {
        return leadEnd;
    }
    /**
     * setter method for end of lead case worker
     * @param leadEnd
     * sets current end of lead case worker to new end
     */
    public void setLeadEnd(Date leadEnd) {
        this.leadEnd = leadEnd;
    }
    /*
     * toString method for details of lead case worker with id
     * @return details of lead case worker with id
     */
    @Override
    public String toString() {
        return "ProblemLeadCaseWorker{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", leadCaseWorker=" + leadCaseWorker + ", leadStart=" + leadStart + 
                ", leadEnd=" + leadEnd + '}';
    }
    /*
     * toString method for details of lead case worker without id
     * @return details of lead case worker without id
     */
    public String toString2() {
        if (leadEnd == null && leadStart == null) {
            return "Lead Case-worker [leadCaseWorker=" + leadCaseWorker + "]";
        } else if (leadStart == null) {
            return "Lead Case-worker [leadCaseWorker=" + leadCaseWorker + ", leadEnd=" + leadEnd + ']';
        } else if (leadEnd == null) {
            return "Lead Case-worker [leadCaseWorker=" + leadCaseWorker + ", leadStart=" + leadStart + 
                    ']';
        }
        return "Lead Case-worker [leadCaseWorker=" + leadCaseWorker + ", leadStart=" + leadStart + 
                ", leadEnd=" + leadEnd + ']';
    }

   
    
}
