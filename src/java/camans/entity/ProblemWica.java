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

    public int getId() {
            return id;
    }

    public String getWorkerFinNumber() {
            return workerFinNumber;
    }

    public int getJobKey() {
            return jobKey;
    }

    public int getProblemKey() {
            return problemKey;
    }

    public Date getWicaMonthlyUpdate() {
            return wicaMonthlyUpdate;
    }

    public String getWicaMonthlyStatus() {
            return wicaMonthlyStatus;
    }

    public String getWicaMonthlyStatusMore() {
            return wicaMonthlyStatusMore;
    }

    public double getWicaMonthlyPoints() {
            return wicaMonthlyPoints;
    }

    public double getWicaMonthlyDollars() {
            return wicaMonthlyDollars;
    }

    public String getWicaMonthlyRemarks() {
            return wicaMonthlyRemarks;
    }

    public void setId(int id) {
            this.id = id;
    }

    public void setWorkerFinNumber(String workerFinNumber) {
            this.workerFinNumber = workerFinNumber;
    }

    public void setJobKey(int jobKey) {
            this.jobKey = jobKey;
    }

    public void setProblemKey(int problemKey) {
            this.problemKey = problemKey;
    }

    public void setWicaMonthlyUpdate(Date wicaMonthlyUpdate) {
            this.wicaMonthlyUpdate = wicaMonthlyUpdate;
    }

    public void setWicaMonthlyStatus(String wicaMonthlyStatus) {
            this.wicaMonthlyStatus = wicaMonthlyStatus;
    }

    public void setWicaMonthlyStatusMore(String wicaMonthlyStatusMore) {
            this.wicaMonthlyStatusMore = wicaMonthlyStatusMore;
    }

    public void setWicaMonthlyPoints(double wicaMonthlyPoints) {
            this.wicaMonthlyPoints = wicaMonthlyPoints;
    }

    public void setWicaMonthlyDollars(double wicaMonthlyDollars) {
            this.wicaMonthlyDollars = wicaMonthlyDollars;
    }

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
