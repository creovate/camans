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
public class Problem {
    
    //attributes
    private String workerFinNum;
    private int jobKey;
    private int probKey;
    private Date problemRegisteredDate;
    private String problem;
    private String problemMore;
    private String problemRemark;
    private String referredBy;
    private String currentLcw;
    private Date referredDate;
    private String referralDescription;
    /*
     * Creates new problem object with problem key
     * @param worker fin number of problem
     * @param job key of problem
     * @param problem key of problem
     * @param registration date of problem
     * @param problem
     * @param more info of problem
     * @param remarks for problem
     */
    public Problem(String workerFinNum, int jobKey, int probKey, Date problemRegisteredDate, String problem, String problemMore, String problemRemark) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.probKey = probKey;
        this.problemRegisteredDate = problemRegisteredDate;
        this.problem = problem;
        this.problemMore = problemMore;
        this.problemRemark = problemRemark;
    }
    /*
     * Creates new problem object without problem key
     * @param worker fin number of problem
     * @param job key of problem
     * @param registration date of problem
     * @param problem
     * @param more info of problem
     * @param remarks for problem
     */
    public Problem(String workerFinNum, int jobKey, Date problemRegisteredDate, String problem, String problemMore, String problemRemark) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.problemRegisteredDate = problemRegisteredDate;
        this.problem = problem;
        this.problemMore = problemMore;
        this.problemRemark = problemRemark;
    }
    /*
     * Creates new referred problem object with problem key
     * @param worker fin number of problem
     * @param job key of problem
     * @param problem key of problem
     * @param registration date of problem
     * @param problem
     * @param more info of problem
     * @param remarks for problem
     * @param referred by person of problem
     * @param current lead case worker problem
     * @param date referred of problem
     * @param referral description of problem
     */
    public Problem(String workerFinNum, int jobKey, int probKey, Date problemRegisteredDate, String problem, String problemMore, String problemRemark, String referredBy, String currentLcw, Date referredDate, String referralDescription) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.probKey = probKey;
        this.problemRegisteredDate = problemRegisteredDate;
        this.problem = problem;
        this.problemMore = problemMore;
        this.problemRemark = problemRemark;
        this.referredBy = referredBy;
        this.currentLcw = currentLcw;
        this.referredDate = referredDate;
        this.referralDescription = referralDescription;
    }
    /*
     * Creates new referred problem object without problem key
     * @param worker fin number of problem
     * @param job key of problem
     * @param registration date of problem
     * @param problem
     * @param more info of problem
     * @param remarks for problem
     * @param referred by person of problem
     * @param current lead case worker of problem
     * @param date referred of problem
     * @param referral description of problem
     */
    public Problem(String workerFinNum, int jobKey, Date problemRegisteredDate, String problem, String problemMore, String problemRemark, String referredBy, String currentLcw, Date referredDate, String referralDescription) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.problemRegisteredDate = problemRegisteredDate;
        this.problem = problem;
        this.problemMore = problemMore;
        this.problemRemark = problemRemark;
        this.referredBy = referredBy;
        this.currentLcw = currentLcw;
        this.referredDate = referredDate;
        this.referralDescription = referralDescription;
    }

    /**
     * getter method for worker fin number of problem
     * @return worker fin number of problem
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }
    /**
     * setter method for worker fin number of problem
     * @param workerFinNum 
     * sets current worker fin number of problem to new worker fin number
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }
    /**
     * getter method for job key of problem
     * @return job key of problem
     */
    public int getJobKey() {
        return jobKey;
    }
    /**
     * setter method for job key of problem
     * @param jobKey 
     * sets current job key of problem to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }
    /**
     * getter method for problem key of problem
     * @return problem key of problem
     */
    public int getProbKey() {
        return probKey;
    }
    /**
     * setter method for problem key of problem
     * @param probKey 
     * sets current problem key of problem to new problem key
     */
    public void setProbKey(int probKey) {
        this.probKey = probKey;
    }
    /**
     * getter method for registration date of problem
     * @return registration date of problem
     */
    public Date getProblemRegisteredDate() {
        return problemRegisteredDate;
    }
    /**
     * setter method for registration date of problem
     * @param problemRegisteredDate 
     * sets current registration date of problem to new registration date
     */
    public void setProblemRegisteredDate(Date problemRegisteredDate) {
        this.problemRegisteredDate = problemRegisteredDate;
    }
    /**
     * getter method for problem
     * @return problem
     */
    public String getProblem() {
        return problem;
    }
    /**
     * setter method for problem
     * @param problem 
     * sets current problem to new problem
     */
    public void setProblem(String problem) {
        this.problem = problem;
    }
    /**
     * getter method for more info of problem
     * @return more info of problem
     */
    public String getProblemMore() {
        return problemMore;
    }
    /**
     * setter method for more info of  problem
     * @param problemMore 
     * sets current more info of problem to new more info of problem
     */
    public void setProblemMore(String problemMore) {
        this.problemMore = problemMore;
    }
    /**
     * getter method for remarks of problem
     * @return remarks of problem
     */
    public String getProblemRemark() {
        return problemRemark;
    }
    /**
     * setter method for remark of problem
     * @param problemRemark
     * sets current remark of problem to new remark
     */
    public void setProblemRemark(String problemRemark) {
        this.problemRemark = problemRemark;
    }
    /**
     * getter method for referred by person of problem
     * @return referred by person of problem
     */
    public String getReferredBy() {
        return referredBy;
    }
    /**
     * setter method for referred by person of problem
     * @param referredBy
     * sets current referred by person of problem to new referred by person
     */
    public void setReferredBy(String referredBy) {
        this.referredBy = referredBy;
    }
    /**
     * getter method for current lead case worker of problem
     * @return current lead case worker of problem
     */
    public String getcurrentLeadCaseWorker() {
        return currentLcw;
    }
    /**
     * setter method for current lead case worker of problem
     * @param current lead case worker 
     * sets current lead case worker of problem to new current lead case worker
     */
    public void setcurrentLeadCaseWorker(String currentLcw) {
        this.currentLcw = currentLcw;
    }
    /**
     * getter method for referred date of problem
     * @return referred date of problem
     */
    public Date getReferredDate() {
        return referredDate;
    }
    /**
     * setter method for referred date of problem
     * @param referredDate 
     * sets current referred date of problem to new referred date
     */
    public void setReferredDate(Date referredDate) {
        this.referredDate = referredDate;
    }
    /**
     * getter method for referral description of problem
     * @return referral description of problem
     */
    public String getReferralDescription() {
        return referralDescription;
    }
    /**
     * setter method for referral description of problem
     * @param referralDescription  
     * sets current referral description of problem to new referral description 
     */
    public void setReferralDescription(String referralDescription) {
        this.referralDescription = referralDescription;
    }
    /*
     * toString method for problem details without problem key
     * @return problem details without problem key
     */
    @Override
    public String toString() {
        return "Problem{" + "workerFinNum=" + workerFinNum + ", jobKey=" + jobKey + 
                ", probKey=" + probKey + ", problemRegisteredDate=" + problemRegisteredDate + 
                ", problem=" + problem + ", problemMore=" + problemMore + 
                ", problemRemark=" + problemRemark + ", referredBy=" + referredBy + 
                ", currentLcw=" + currentLcw + ", referredDate=" + referredDate + 
                ", referralDescription=" + referralDescription + '}';
    }
    /*
     * toString method for problem details with problem key
     * @return problem details with problem key
     */
    public String toString2() {
        return "Problem{" + "workerFinNum=" + workerFinNum + ", problemRegisteredDate=" + problemRegisteredDate + 
                ", problem=" + problem + ", problemMore=" + problemMore + 
                ", problemRemark=" + problemRemark + ", referredBy=" + referredBy + 
                ", currentLcw=" + currentLcw + ", referredDate=" + referredDate + 
                ", referralDescription=" + referralDescription + '}';
    }
    

    
    
}
