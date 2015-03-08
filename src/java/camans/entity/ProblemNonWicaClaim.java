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
public class ProblemNonWicaClaim {
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private Date medicalClaimDate;
    private double medicalClaimLoss;
    private String medicalClaimInsurer;
    private String medicalClaimPolicyNumber;
    private String medicalClaimBasis;
    private String remark;

    //constructor with id
    public ProblemNonWicaClaim(int id, String workerFinNumber, int jobKey, int problemKey, Date medicalClaimDate, double medicalClaimLoss, String medicalClaimInsurer, String medicalClaimPolicyNumber, String medicalClaimBasis, String remark) {
            this.id = id;
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.medicalClaimDate = medicalClaimDate;
            this.medicalClaimLoss = medicalClaimLoss;
            this.medicalClaimInsurer = medicalClaimInsurer;
            this.medicalClaimPolicyNumber = medicalClaimPolicyNumber;
            this.medicalClaimBasis = medicalClaimBasis;
            this.remark = remark;
    }

    //constructor without id
    public ProblemNonWicaClaim(String workerFinNumber, int jobKey, int problemKey, Date medicalClaimDate, double medicalClaimLoss, String medicalClaimInsurer, String medicalClaimPolicyNumber, String medicalClaimBasis, String remark) {
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.medicalClaimDate = medicalClaimDate;
            this.medicalClaimLoss = medicalClaimLoss;
            this.medicalClaimInsurer = medicalClaimInsurer;
            this.medicalClaimPolicyNumber = medicalClaimPolicyNumber;
            this.medicalClaimBasis = medicalClaimBasis;
            this.remark = remark;
    }

    public int getId() {
            return id;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

    public Date getMedicalClaimDate() {
            return medicalClaimDate;
    }

    public double getMedicalClaimLoss() {
            return medicalClaimLoss;
    }

    public String getMedicalClaimInsurer() {
            return medicalClaimInsurer;
    }

    public String getMedicalClaimPolicyNumber() {
            return medicalClaimPolicyNumber;
    }

    public String getMedicalClaimBasis() {
            return medicalClaimBasis;
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

    public void setMedicalClaimDate(Date medicalClaimDate) {
            this.medicalClaimDate = medicalClaimDate;
    }

    public void setMedicalClaimLoss(double medicalClaimLoss) {
            this.medicalClaimLoss = medicalClaimLoss;
    }

    public void setMedicalClaimInsurer(String medicalClaimInsurer) {
            this.medicalClaimInsurer = medicalClaimInsurer;
    }

    public void setMedicalClaimPolicyNumber(String medicalClaimPolicyNumber) {
            this.medicalClaimPolicyNumber = medicalClaimPolicyNumber;
    }

    public void setMedicalClaimBasis(String medicalClaimBasis) {
            this.medicalClaimBasis = medicalClaimBasis;
    }

    @Override
    public String toString() {
        return "ProblemNonWicaClaim{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", medicalClaimDate=" + medicalClaimDate + ", medicalClaimLoss=" + medicalClaimLoss + 
                ", medicalClaimInsurer=" + medicalClaimInsurer + 
                ", medicalClaimPolicyNumber=" + medicalClaimPolicyNumber + 
                ", medicalClaimBasis=" + medicalClaimBasis + ", remark=" + remark + '}';
    }
    
    public String toString2() {
        return "NonWicaClaim [medicalClaimDate=" + medicalClaimDate + ", medicalClaimLoss=" + medicalClaimLoss + 
                ", medicalClaimInsurer=" + medicalClaimInsurer + 
                ", medicalClaimPolicyNumber=" + medicalClaimPolicyNumber + 
                ", medicalClaimBasis=" + medicalClaimBasis + ", remark=" + remark + ']';
    }
    
}
