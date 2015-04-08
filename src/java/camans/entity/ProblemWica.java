/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

import java.sql.Date;

/**
 *
 * @author Xiaomeng
 */
public class ProblemWica {
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private Date wicaMonthlyUpdate;
    private String wicaMonthlyStatus;
    private String wicaMonthlyStatusMore;
    private double wicaMonthlyPoints;
    private double wicaMonthlyDollars;
    private String wicaMonthlyRemarks;

    //constructor with id
    /**
     * Constructor for ProblemWica class
     * @param id id
     * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problemKey problem key
     * @param wicaMonthlyUpdate date of update
     * @param wicaMonthlyStatus wica status
     * @param wicaMonthlyStatusMore more wica status
     * @param wicaMonthlyPoints wica points
     * @param wicaMonthlyDollars wica $ compensation 
     * @param wicaMonthlyRemarks remark of wica
     */
        public ProblemWica(int id, String workerFinNumber, int jobKey, int problemKey, 
            Date wicaMonthlyUpdate, String wicaMonthlyStatus, String wicaMonthlyStatusMore, 
            double wicaMonthlyPoints, double wicaMonthlyDollars, String wicaMonthlyRemarks) {
            this.id = id;
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.wicaMonthlyUpdate = wicaMonthlyUpdate;
            this.wicaMonthlyStatus = wicaMonthlyStatus;
            this.wicaMonthlyStatusMore = wicaMonthlyStatusMore;
            this.wicaMonthlyPoints = wicaMonthlyPoints;
            this.wicaMonthlyDollars = wicaMonthlyDollars;
            this.wicaMonthlyRemarks = wicaMonthlyRemarks;
    }

        
    //constructor without id
        /**
     * Constructor for ProblemWica class without id
     * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problemKey problem key
     * @param wicaMonthlyUpdate date of update
     * @param wicaMonthlyStatus wica status
     * @param wicaMonthlyStatusMore more wica status
     * @param wicaMonthlyPoints wica points
     * @param wicaMonthlyDollars wica $ compensation 
     * @param wicaMonthlyRemarks remark of wica
     */
    public ProblemWica(String workerFinNumber, int jobKey, int problemKey, Date wicaMonthlyUpdate, 
            String wicaMonthlyStatus, String wicaMonthlyStatusMore, double wicaMonthlyPoints, 
            double wicaMonthlyDollars, String wicaMonthlyRemarks) {
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.wicaMonthlyUpdate = wicaMonthlyUpdate;
            this.wicaMonthlyStatus = wicaMonthlyStatus;
            this.wicaMonthlyStatusMore = wicaMonthlyStatusMore;
            this.wicaMonthlyPoints = wicaMonthlyPoints;
            this.wicaMonthlyDollars = wicaMonthlyDollars;
            this.wicaMonthlyRemarks = wicaMonthlyRemarks;
    }

    /**
     * Returns id
     * @return id
     */
    public int getId() {
            return id;
    }

    /**
     * Returns worker FIN
     * @return worker FIN
     */
    public String getWorkerFinNumber() {
            return workerFinNumber;
    }

    /**
     * Returns job key
     * @return job key
     */
    public int getJobKey() {
            return jobKey;
    }

    /**
     * Returns problem key
     * @return problem key
     */
    public int getProblemKey() {
            return problemKey;
    }

    /**
     * Returns date of update
     * @return date of update
     */
    public Date getWicaMonthlyUpdate() {
            return wicaMonthlyUpdate;
    }

    /**
     * Returns WICA status
     * @return WICA status
     */
    public String getWicaMonthlyStatus() {
            return wicaMonthlyStatus;
    }

    /**
     * Returns more WICA status
     * @return more WICA status
     */
    public String getWicaMonthlyStatusMore() {
            return wicaMonthlyStatusMore;
    }

    /**
     * Return WICA points
     * @return WICA points
     */
    public double getWicaMonthlyPoints() {
            return wicaMonthlyPoints;
    }

    /**
     * Returns WICA compensation
     * @return WICA compensation
     */
    public double getWicaMonthlyDollars() {
            return wicaMonthlyDollars;
    }

    /**
     * Returns remarks
     * @return remarks
     */
    public String getWicaMonthlyRemarks() {
            return wicaMonthlyRemarks;
    }

    /**
     * Sets id
     * @param id id
     */
    public void setId(int id) {
            this.id = id;
    }

    /**
     * Sets worker FIN
     * @param workerFinNumber worker FIN
     */
    public void setWorkerFinNumber(String workerFinNumber) {
            this.workerFinNumber = workerFinNumber;
    }

    /**
     * Sets job key
     * @param jobKey job key
     */
    public void setJobKey(int jobKey) {
            this.jobKey = jobKey;
    }

    /**
     * Sets problem key
     * @param problemKey problem key
     */
    public void setProblemKey(int problemKey) {
            this.problemKey = problemKey;
    }

    /**
     * Sets date of update
     * @param wicaMonthlyUpdate date of update
     */
    public void setWicaMonthlyUpdate(Date wicaMonthlyUpdate) {
            this.wicaMonthlyUpdate = wicaMonthlyUpdate;
    }

    /** 
     * Sets WICA status
     * @param wicaMonthlyStatus WICA status
     */
    public void setWicaMonthlyStatus(String wicaMonthlyStatus) {
            this.wicaMonthlyStatus = wicaMonthlyStatus;
    }

    /**
     * Sets more WICA status
     * @param wicaMonthlyStatusMore more WICA status
     */
    public void setWicaMonthlyStatusMore(String wicaMonthlyStatusMore) {
            this.wicaMonthlyStatusMore = wicaMonthlyStatusMore;
    }

    /**
     * Sets WICA points
     * @param wicaMonthlyPoints WICA points
     */
    public void setWicaMonthlyPoints(double wicaMonthlyPoints) {
            this.wicaMonthlyPoints = wicaMonthlyPoints;
    }

    /**
     * Sets WICA compensation
     * @param wicaMonthlyDollars WICA compensation
     */
    public void setWicaMonthlyDollars(double wicaMonthlyDollars) {
            this.wicaMonthlyDollars = wicaMonthlyDollars;
    }

    /**
     * Sets remarks
     * @param wicaMonthlyRemarks remarks
     */
    public void setWicaMonthlyRemarks(String wicaMonthlyRemarks) {
            this.wicaMonthlyRemarks = wicaMonthlyRemarks;
    }

    @Override
    public String toString() {
        return "ProblemWica{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", wicaMonthlyUpdate=" + wicaMonthlyUpdate + ", wicaMonthlyStatus=" + wicaMonthlyStatus + 
                ", wicaMonthlyStatusMore=" + wicaMonthlyStatusMore + 
                ", wicaMonthlyPoints=" + wicaMonthlyPoints + ", wicaMonthlyDollars=" + wicaMonthlyDollars + 
                ", wicaMonthlyRemarks=" + wicaMonthlyRemarks + '}';
    }

    public String toString2() {
        return "WICA [wicaMonthlyUpdate=" + wicaMonthlyUpdate + ", wicaMonthlyStatus=" + wicaMonthlyStatus + 
                ", wicaMonthlyStatusMore=" + wicaMonthlyStatusMore + 
                ", wicaMonthlyPoints=" + wicaMonthlyPoints + ", wicaMonthlyDollars=" + wicaMonthlyDollars + 
                ", wicaMonthlyRemarks=" + wicaMonthlyRemarks + ']';
    }    
    
}
