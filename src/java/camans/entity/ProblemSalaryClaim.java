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
    public ProblemSalaryClaim(String workerFinNumber, int jobKey, int problemKey, Date salaryClaimDate, double salaryClaimLoss, String salaryClaimBasis) {
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.salaryClaimDate = salaryClaimDate;
            this.salaryClaimLoss = salaryClaimLoss;
            this.salaryClaimBasis = salaryClaimBasis;
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

    public Date getSalaryClaimDate() {
            return salaryClaimDate;
    }

    public double getSalaryClaimLoss() {
            return salaryClaimLoss;
    }

    public String getSalaryClaimBasis() {
            return salaryClaimBasis;
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

    public void setSalaryClaimDate(Date salaryClaimDate) {
            this.salaryClaimDate = salaryClaimDate;
    }

    public void setSalaryClaimLoss(double salaryClaimLoss) {
            this.salaryClaimLoss = salaryClaimLoss;
    }

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

    public String toString2() {
        return "Salary Claim [salaryClaimDate=" + salaryClaimDate + ", salaryClaimLoss=" + salaryClaimLoss + 
                ", salaryClaimBasis=" + salaryClaimBasis + ']';
    }
    
}
	
	
