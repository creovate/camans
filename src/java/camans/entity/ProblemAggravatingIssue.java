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
    private String AggravatingLoss;
    private String AggravatingRemark;

    
    //constructor with id 
    public ProblemAggravatingIssue(int id, String workerFinNumber, int jobKey, int problemKey, 
            String AggravatingIssue, String AggravatingIssueMore, 
            String AggravatingLoss, String AggravatingRemark) {
        this.id = id;
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.AggravatingIssue = AggravatingIssue;
        this.AggravatingIssueMore = AggravatingIssueMore;
        this.AggravatingLoss = AggravatingLoss;
        this.AggravatingRemark = AggravatingRemark;
    }

    //constructor without id
    public ProblemAggravatingIssue(String workerFinNumber, int jobKey, int problemKey, String AggravatingIssue, String AggravatingIssueMore, String AggravatingLoss, String AggravatingRemark) {
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.AggravatingIssue = AggravatingIssue;
        this.AggravatingIssueMore = AggravatingIssueMore;
        this.AggravatingLoss = AggravatingLoss;
        this.AggravatingRemark = AggravatingRemark;
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

    public String getAggravatingIssue() {
        return AggravatingIssue;
    }

    public void setAggravatingIssue(String AggravatingIssue) {
        this.AggravatingIssue = AggravatingIssue;
    }

    public String getAggravatingIssueMore() {
        return AggravatingIssueMore;
    }

    public void setAggravatingIssueMore(String AggravatingIssueMore) {
        this.AggravatingIssueMore = AggravatingIssueMore;
    }

    public String getAggravatingLoss() {
        return AggravatingLoss;
    }

    public void setAggravatingLoss(String AggravatingLoss) {
        this.AggravatingLoss = AggravatingLoss;
    }

    public String getAggravatingRemark() {
        return AggravatingRemark;
    }

    public void setAggravatingRemark(String AggravatingRemark) {
        this.AggravatingRemark = AggravatingRemark;
    }
    
    
}
