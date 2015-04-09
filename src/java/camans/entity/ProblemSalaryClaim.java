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
public class ProblemSalaryClaim {
    //attribute
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private Date salaryClaimDate;
    private double salaryClaimLoss;
    private String salaryClaimBasis;

    //constructor with id

    /**
     *
     * @param id id
     * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problemKey problem key
     * @param salaryClaimDate salary claim date
     * @param salaryClaimLoss monetary loss
     * @param salaryClaimBasis claim basis
     */
        public ProblemSalaryClaim(int id, String workerFinNumber, int jobKey, int problemKey, Date salaryClaimDate, double salaryClaimLoss, String salaryClaimBasis) {
            this.id = id;
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.salaryClaimDate = salaryClaimDate;
            this.salaryClaimLoss = salaryClaimLoss;
            this.salaryClaimBasis = salaryClaimBasis;
    }

    //constructor without id

    /**
     *
    * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problemKey problem key
     * @param salaryClaimDate salary claim date
     * @param salaryClaimLoss monetary loss
     * @param salaryClaimBasis claim basis
     */
        public ProblemSalaryClaim(String workerFinNumber, int jobKey, int problemKey, Date salaryClaimDate, double salaryClaimLoss, String salaryClaimBasis) {
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.salaryClaimDate = salaryClaimDate;
            this.salaryClaimLoss = salaryClaimLoss;
            this.salaryClaimBasis = salaryClaimBasis;
    }

    /**
     * returns id
     * @return id
     */
    public int getId() {
            return id;
    }

    /**
     * returns FIN
     * @return FIN
     */
    public String getWorkerFinNumber() {
            return workerFinNumber;
    }

    /**
     * returns job key
     * @return job key
     */
    public int getJobKey() {
            return jobKey;
    }

    /**
     * returns problem key
     * @return problem key
     */
    public int getProblemKey() {
            return problemKey;
    }

    /**
     * returns salary claim date
     * @return salary claim date
     */
    public Date getSalaryClaimDate() {
            return salaryClaimDate;
    }

    /**
     * returns monetary loss
     * @return monetary loss
     */
    public double getSalaryClaimLoss() {
            return salaryClaimLoss;
    }

    /**
     * return salary claim basis
     * @return salary claim basis
     */
    public String getSalaryClaimBasis() {
            return salaryClaimBasis;
    }

    /**
     *
     * @param id
     */
    public void setId(int id) {
            this.id = id;
    }

    /**
     *
     * @param workerFinNumber
     */
    public void setWorkerFinNumber(String workerFinNumber) {
            this.workerFinNumber = workerFinNumber;
    }

    /**
     * set job key
     * @param jobKey job key
     */
    public void setJobKey(int jobKey) {
            this.jobKey = jobKey;
    }

    /**
     * set problem key
     * @param problemKey problem key
     */
    public void setProblemKey(int problemKey) {
            this.problemKey = problemKey;
    }

    /**
     * set salary claim date
     * @param salaryClaimDate salary claim date
     */
    public void setSalaryClaimDate(Date salaryClaimDate) {
            this.salaryClaimDate = salaryClaimDate;
    }

    /**
     * set monetary loss
     * @param salaryClaimLoss monetary loss
     */
    public void setSalaryClaimLoss(double salaryClaimLoss) {
            this.salaryClaimLoss = salaryClaimLoss;
    }

    /**
     * set salary claim basis
     * @param salaryClaimBasis salary claim basis
     */
    public void setSalaryClaimBasis(String salaryClaimBasis) {
            this.salaryClaimBasis = salaryClaimBasis;
    }				

    @Override
    public String toString() {
        return "ProblemSalaryClaim{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", salaryClaimDate=" + salaryClaimDate + ", salaryClaimLoss=" + salaryClaimLoss + 
                ", salaryClaimBasis=" + salaryClaimBasis + '}';
    }

    /**
     *
     * @return
     */
    public String toString2() {
        return "Salary Claim [salaryClaimDate=" + salaryClaimDate + ", salaryClaimLoss=" + salaryClaimLoss + 
                ", salaryClaimBasis=" + salaryClaimBasis + ']';
    }
    
}
	
	
