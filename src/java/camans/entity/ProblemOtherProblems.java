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

    /**
     *
     * @param id id
     * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problemKey problem key
     * @param otherProblemDesc other problem description
     * @param otherProblemLoss other problem loss
     * @param otherProblemRemark remark of other problem
     */
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

    /**
     *
     * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problemKey problem key
     * @param otherProblemDesc other problem description
     * @param otherProblemLoss other problem loss
     * @param otherProblemRemark remark of other problem
     */
    public ProblemOtherProblems(String workerFinNumber, int jobKey, int problemKey, 
            String otherProblemDesc, double otherProblemLoss, String otherProblemRemark) {
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.otherProblemDesc = otherProblemDesc;
        this.otherProblemLoss = otherProblemLoss;
        this.otherProblemRemark = otherProblemRemark;
    }

    /**
     * returns id
     * @return id
     */
    public int getId() {
        return id;
    }

    /**
     * get id
     * @param id id
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * returns FIN
     * @return FIN
     */
    public String getWorkerFinNumber() {
        return workerFinNumber;
    }

    /**
     * set FIN
     * @param workerFinNumber FIN
     */
    public void setWorkerFinNumber(String workerFinNumber) {
        this.workerFinNumber = workerFinNumber;
    }

    /**
     * returns job key
     * @return job key
     */
    public int getJobKey() {
        return jobKey;
    }

    /**
     * set job key
     * @param jobKey job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }

    /**
     * returns problem key
     * @return problem key
     */
    public int getProblemKey() {
        return problemKey;
    }

    /**
     * set problem key
     * @param problemKey problem key
     */
    public void setProblemKey(int problemKey) {
        this.problemKey = problemKey;
    }

    /**
     * returns other problem description
     * @return other problem description
     */
    public String getOtherProblemDesc() {
        return otherProblemDesc;
    }

    /**
     * set other problem description
     * @param otherProblemDesc other problem description
     */
    public void setOtherProblemDesc(String otherProblemDesc) {
        this.otherProblemDesc = otherProblemDesc;
    }

    /**
     * returns loss of other problem
     * @return loss of other problem
     */
    public double getOtherProblemLoss() {
        return otherProblemLoss;
    }

    /**
     * set loss of other problem
     * @param otherProblemLoss loss of other problem
     */
    public void setOtherProblemLoss(double otherProblemLoss) {
        this.otherProblemLoss = otherProblemLoss;
    }

    /**
     * returns remark of other problem
     * @return remark of other problem
     */
    public String getOtherProblemRemark() {
        return otherProblemRemark;
    }

    /**
     * set remark of other problem
     * @param otherProblemRemark remark of other problem
     */
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
    
    /**
     *
     * @return
     */
    public String toString2() {
        return "Other Problem [otherProblemDesc=" + otherProblemDesc + ", otherProblemLoss=" + otherProblemLoss + 
                ", otherProblemRemark=" + otherProblemRemark + ']';
    }    
    
}
