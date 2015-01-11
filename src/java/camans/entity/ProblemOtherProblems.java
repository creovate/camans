/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

/**
 *
 * @author soemyatmyat
 */
public class ProblemOtherProblems {
    
    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private String otherProblemDesc;
    private double otherProblemLoss;
    private String otherProblemRemark;

    public ProblemOtherProblems(int id, String workerFinNumber, int jobKey, int problemKey, 
            String otherProblemDesc, double otherProblemLoss, String otherProblemRemark) {
        this.id = id;
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.otherProblemDesc = otherProblemDesc;
        this.otherProblemLoss = otherProblemLoss;
        this.otherProblemRemark = otherProblemRemark;
    }

    public ProblemOtherProblems(String workerFinNumber, int jobKey, int problemKey, 
            String otherProblemDesc, double otherProblemLoss, String otherProblemRemark) {
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.otherProblemDesc = otherProblemDesc;
        this.otherProblemLoss = otherProblemLoss;
        this.otherProblemRemark = otherProblemRemark;
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

    public String getOtherProblemDesc() {
        return otherProblemDesc;
    }

    public void setOtherProblemDesc(String otherProblemDesc) {
        this.otherProblemDesc = otherProblemDesc;
    }

    public double getOtherProblemLoss() {
        return otherProblemLoss;
    }

    public void setOtherProblemLoss(double otherProblemLoss) {
        this.otherProblemLoss = otherProblemLoss;
    }

    public String getOtherProblemRemark() {
        return otherProblemRemark;
    }

    public void setOtherProblemRemark(String otherProblemRemark) {
        this.otherProblemRemark = otherProblemRemark;
    }

    @Override
    public String toString() {
        return "ProblemOtherProblems{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", otherProblemDesc=" + otherProblemDesc + ", otherProblemLoss=" + otherProblemLoss + 
                ", otherProblemRemark=" + otherProblemRemark + '}';
    }
    
    public String toString2() {
        return "ProblemOtherProblems{" + "WorkerFinNumber=" + workerFinNumber + 
                ", otherProblemDesc=" + otherProblemDesc + ", otherProblemLoss=" + otherProblemLoss + 
                ", otherProblemRemark=" + otherProblemRemark + '}';
    }    
    
}
