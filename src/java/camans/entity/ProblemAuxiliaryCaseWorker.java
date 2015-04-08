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
public class ProblemAuxiliaryCaseWorker {
    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private String auxName;
    private Date auxStart;
    private Date auxEnd;
    /*
     * Creates new auxiliary case worker with id
     * @param id identifier of auxiliary case worker
     * @param worker fin number of auxiliary case worker
     * @param job key of auxiliary case worker
     * @param problem key of auxiliary case worker
     * @param name of auxiliary case worker
     * @param start of auxiliary case worker
     * @param end of auxiliary case worker
     */
    public ProblemAuxiliaryCaseWorker(int id, String workerFinNumber, int jobKey, int problemKey, String auxName, Date auxStart, Date auxEnd) {
        this.id = id;
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.auxName = auxName;
        this.auxStart = auxStart;
        this.auxEnd = auxEnd;
    }
    /*
     * Creates new auxiliary case worker without id
     * @param worker fin number of auxiliary case worker
     * @param job key of auxiliary case worker
     * @param problem key of auxiliary case worker
     * @param name of auxiliary case worker
     * @param start of auxiliary case worker
     * @param end of auxiliary case worker
     */
    public ProblemAuxiliaryCaseWorker(String workerFinNumber, int jobKey, int problemKey, String auxName, Date auxStart, Date auxEnd) {
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.auxName = auxName;
        this.auxStart = auxStart;
        this.auxEnd = auxEnd;
    }

    /**
     * getter method for id for auxiliary case worker
     * @return id of auxiliary case worker
     */
    public int getId() {
        return id;
    }
    /**
     * setter method for id of auxiliary case worker
     * @param id 
     * sets current id of auxiliary case worker to new id
     */
    public void setId(int id) {
        this.id = id;
    }
    /**
     * getter method for worker fin number for auxiliary case worker
     * @return worker fin number of auxiliary case worker
     */
    public String getWorkerFinNumber() {
        return workerFinNumber;
    }
     /**
     * setter method for worker fin number of auxiliary case worker
     * @param workerFinNumber 
     * sets current worker fin number of auxiliary case worker to new worker fin number
     */
    public void setWorkerFinNumber(String workerFinNumber) {
        this.workerFinNumber = workerFinNumber;
    }
    /**
     * getter method for job key for auxiliary case worker
     * @return job key of auxiliary case worker
     */
    public int getJobKey() {
        return jobKey;
    }
     /**
     * setter method for job key of auxiliary case worker
     * @param jobKey
     * sets current job key of auxiliary case worker to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }
    /**
     * getter method for problem key for auxiliary case worker
     * @return problem key of auxiliary case worker
     */
    public int getProblemKey() {
        return problemKey;
    }
     /**
     * setter method for problem key of auxiliary case worker
     * @param problemKey 
     * sets current problem key of auxiliary case worker to new problem key
     */
    public void setProblemKey(int problemKey) {
        this.problemKey = problemKey;
    }
    /**
     * getter method for name for auxiliary case worker
     * @return name of auxiliary case worker
     */
    public String getAuxName() {
        return auxName;
    }
     /**
     * setter method for name of auxiliary case worker
     * @param auxName
     * sets current name of auxiliary case worker to new name
     */
    public void setAuxName(String auxName) {
        this.auxName = auxName;
    }
    /**
     * getter method for start for auxiliary case worker
     * @return start of auxiliary case worker
     */
    public Date getAuxStart() {
        return auxStart;
    }
     /**
     * setter method for start of auxiliary case worker
     * @param auxStart 
     * sets current start of auxiliary case worker to new start
     */
    public void setAuxStart(Date auxStart) {
        this.auxStart = auxStart;
    }
    /**
     * getter method for end for auxiliary case worker
     * @return end of auxiliary case worker
     */
    public Date getAuxEnd() {
        return auxEnd;
    }
     /**
     * setter method for end of auxiliary case worker
     * @param auxEnd
     * sets current end of auxiliary case worker to new end
     */
    public void setAuxEnd(Date auxEnd) {
        this.auxEnd = auxEnd;
    }
    /*
     * toString method for auxiliary case worker with id
     * @return details of auxiliary case worker with id
     */
    @Override
    public String toString() {
        return "ProblemAuxiliaryCaseWorker{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + ", jobKey=" + jobKey + ", problemKey=" + problemKey + ", auxName=" + auxName + ", auxStart=" + auxStart + ", auxEnd=" + auxEnd + '}';
    }
    /*
     * toString method for auxiliary case worker without id
     * @return details of auxiliary case worker without id
     */
    public String toString2() {
        if (auxStart == null || auxEnd == null) {
            return "Auxiliary Caseworker [auxName=" + auxName + ']';
        }
        return "Auxiliary Caseworker [auxName=" + auxName + ", auxStart=" + auxStart + ", auxEnd=" + auxEnd + ']';
    }    
    
}
