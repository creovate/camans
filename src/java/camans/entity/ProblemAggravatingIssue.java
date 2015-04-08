/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

/**
 *
 * @author soemyatmyat
 */
public class ProblemAggravatingIssue {
    
    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private String AggravatingIssue;
    private String AggravatingIssueMore;
    private double AggravatingLoss;
    private String AggravatingRemark;

     /*
     * Creates new aggravating issue object with id
     * @param id identifier of aggravating issue
     * @param worker fin number of aggravating issue
     * @param job key of aggravating issue
     * @param problem key of aggravating issue
     * @param aggravating issue
     * @param more info of aggravating issue
     * @param aggravating loss
     * @param remarks for aggravating issue
     */
    //constructor with id 
    public ProblemAggravatingIssue(int id, String workerFinNumber, int jobKey, int problemKey, 
            String AggravatingIssue, String AggravatingIssueMore, 
            double AggravatingLoss, String AggravatingRemark) {
        this.id = id;
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.AggravatingIssue = AggravatingIssue;
        this.AggravatingIssueMore = AggravatingIssueMore;
        this.AggravatingLoss = AggravatingLoss;
        this.AggravatingRemark = AggravatingRemark;
    }
    /*
     * Creates new aggravating issue object without id
     * @param worker fin number of aggravating issue
     * @param job key of aggravating issue
     * @param problem key of aggravating issue
     * @param aggravating issue
     * @param more info of aggravating issue
     * @param aggravating loss
     * @param remarks for aggravating issue
     */
    //constructor without id
    public ProblemAggravatingIssue(String workerFinNumber, int jobKey, int problemKey, String AggravatingIssue, String AggravatingIssueMore, double AggravatingLoss, String AggravatingRemark) {
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.AggravatingIssue = AggravatingIssue;
        this.AggravatingIssueMore = AggravatingIssueMore;
        this.AggravatingLoss = AggravatingLoss;
        this.AggravatingRemark = AggravatingRemark;
    }

    
    /**
     * getter method for id of aggravating issue
     * @return id of aggravating issue
     */
    public int getId() {
        return id;
    }
    /**
     * setter method for id of aggravating issue
     * @param id 
     * sets current id of aggravating issue to new id
     */
    public void setId(int id) {
        this.id = id;
    }
    /**
     * getter method for worker fin number of aggravating issue
     * @return worker fin number of aggravating issue
     */
    public String getWorkerFinNumber() {
        return workerFinNumber;
    }
    /**
     * setter method for worker fin number of aggravating issue
     * @param workerFinNumber 
     * sets current worker fin number of aggravating issue to new worker fin number
     */
    public void setWorkerFinNumber(String workerFinNumber) {
        this.workerFinNumber = workerFinNumber;
    }
    /**
     * getter method for job key of aggravating issue
     * @return job key of aggravating issue
     */
    public int getJobKey() {
        return jobKey;
    }
    /**
     * setter method for job key of aggravating issue
     * @param jobKey
     * sets current job key of aggravating issue to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }
    /**
     * getter method for problem key of aggravating issue
     * @return problem key of aggravating issue
     */
    public int getProblemKey() {
        return problemKey;
    }
    /**
     * setter method for problem key of aggravating issue
     * @param problemKey 
     * sets current problem key of aggravating issue to new problem key
     */
    public void setProblemKey(int problemKey) {
        this.problemKey = problemKey;
    }
    /**
     * getter method for aggravating issue
     * @return aggravating issue
     */
    public String getAggravatingIssue() {
        return AggravatingIssue;
    }
    /**
     * setter method for aggravating issue
     * @param AggravatingIssue 
     * sets current aggravating issue to new aggravating issue
     */
    public void setAggravatingIssue(String AggravatingIssue) {
        this.AggravatingIssue = AggravatingIssue;
    }
    /**
     * getter method for more info of aggravating issue
     * @return more info of aggravating issue
     */
    public String getAggravatingIssueMore() {
        return AggravatingIssueMore;
    }
    /**
     * setter method for more info of aggravating issue
     * @param AggravatingIssueMore
     * sets current more info of aggravating issue to new more info of aggravating issue
     */
    public void setAggravatingIssueMore(String AggravatingIssueMore) {
        this.AggravatingIssueMore = AggravatingIssueMore;
    }
    /**
     * getter method for loss of aggravating issue
     * @return loss of aggravating issue
     */
    public double getAggravatingLoss() {
        return AggravatingLoss;
    }
    /**
     * setter method for loss of aggravating issue
     * @param AggravatingLoss
     * sets current loss of aggravating issue to new loss
     */
    public void setAggravatingLoss(double AggravatingLoss) {
        this.AggravatingLoss = AggravatingLoss;
    }
    /**
     * getter method for remarks of aggravating issue
     * @return remarks of aggravating issue
     */
    public String getAggravatingRemark() {
        return AggravatingRemark;
    }
    /**
     * setter method for remarks of aggravating issue
     * @param AggravatingRemark 
     * sets current remarks of aggravating issue to new remarks
     */
    public void setAggravatingRemark(String AggravatingRemark) {
        this.AggravatingRemark = AggravatingRemark;
    }
    /*
     * toString method for aggravating issue details with id
     * @return aggravating issue details with id
     */
    @Override
    public String toString() {
        return "ProblemAggravatingIssue{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", AggravatingIssue=" + AggravatingIssue + 
                ", AggravatingIssueMore=" + AggravatingIssueMore + 
                ", AggravatingLoss=" + AggravatingLoss + ", AggravatingRemark=" + AggravatingRemark + '}';
    }
    /*
     * toString method for aggravating issue details without id
     * @return aggravating issue details without id
     */
    public String toString2() {
        return "Aggravating Issue [AggravatingIssue=" + AggravatingIssue + 
                ", AggravatingIssueMore=" + AggravatingIssueMore + ", AggravatingLoss=" + AggravatingLoss + 
                ", AggravatingRemark=" + AggravatingRemark + ']';
    }
}
