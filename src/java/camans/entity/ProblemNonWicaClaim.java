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
    /*
     * Creates new non wica claim object with id
     * @param id identifier of non wica claim
     * @param worker fin number associated with non wica claim
     * @param job key associated with non wica claim
     * @param problem key associated with non wica claim
     * @param date of non wica claim
     * @param loss of non wica claim
     * @param insurer of non wica claim
     * @param policy number of non wica claim
     * @param basis of non wica claim
     * @param remarks of non wica claim
     */
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
    /*
     * Creates new non wica claim object without id
     * @param worker fin number associated with non wica claim
     * @param job key associated with non wica claim
     * @param problem key associated with non wica claim
     * @param date of non wica claim
     * @param loss of non wica claim
     * @param insurer of non wica claim
     * @param policy number of non wica claim
     * @param basis of non wica claim
     * @param remarks of non wica claim
     */
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

    /**
     * getter method for id of non wica claim
     * @return id of non wica claim
     */
    public int getId() {
            return id;
    }
    /**
     * getter method for remarks of non wica claim
     * @return remarks of non wica claim
     */
    public String getRemark() {
        return remark;
    }
     /**
     * setter method for remarks of non wica claim
     * @param remark 
     * sets current remarks of non wica claim to new remarks
     */
    public void setRemark(String remark) {
        this.remark = remark;
    }
    /**
     * getter method for worker fin number associated with non wica claim
     * @return worker fin number associated with non wica claim
     */
    public String getWorkerFinNumber() {
            return workerFinNumber;
    }
    /**
     * getter method for job key associated with non wica claim
     * @return job key associated with non wica claim
     */
    public int getJobKey() {
            return jobKey;
    }
    /**
     * getter method for problem key associated with non wica claim
     * @return problem key associated with non wica claim
     */
    public int getProblemKey() {
            return problemKey;
    }
    /**
     * getter method for date of non wica claim
     * @return date of non wica claim
     */
    public Date getMedicalClaimDate() {
            return medicalClaimDate;
    }
    /**
     * getter method for loss of non wica claim
     * @return loss of non wica claim
     */
    public double getMedicalClaimLoss() {
            return medicalClaimLoss;
    }
    /**
     * getter method for insurer of non wica claim
     * @return insurer of non wica claim
     */
    public String getMedicalClaimInsurer() {
            return medicalClaimInsurer;
    }
    /**
     * getter method for policy number of non wica claim
     * @return policy number of non wica claim
     */
    public String getMedicalClaimPolicyNumber() {
            return medicalClaimPolicyNumber;
    }
    /**
     * getter method for basis of non wica claim
     * @return basis of non wica claim
     */
    public String getMedicalClaimBasis() {
            return medicalClaimBasis;
    }
    /**
     * setter method for id of non wica claim
     * @param id 
     * sets current id of non wica claim to new id
     */
    public void setId(int id) {
            this.id = id;
    }
    /**
     * setter method for worker fin number associated with non wica claim
     * @param workerFinNumber 
     * sets current worker fin number associated with non wica claim to new worker fin number
     */
    public void setWorkerFinNumber(String workerFinNumber) {
            this.workerFinNumber = workerFinNumber;
    }
    /**
     * setter method for job key associated with non wica claim
     * @param jobKey
     * sets current job key associated with non wica claim to new job key
     */
    public void setJobKey(int jobKey) {
            this.jobKey = jobKey;
    }
    /**
     * setter method for problem key associated with non wica claim
     * @param problemKey
     * sets current problem key associated with non wica claim to new problem key
     */
    public void setProblemKey(int problemKey) {
            this.problemKey = problemKey;
    }
    /**
     * setter method for date of non wica claim
     * @param mediclaClaimDate 
     * sets current date of non wica claim to new date
     */
    public void setMedicalClaimDate(Date medicalClaimDate) {
            this.medicalClaimDate = medicalClaimDate;
    }
    /**
     * setter method for loss of non wica claim
     * @param medicalClaimLoss 
     * sets current loss of non wica claim to new loss
     */
    public void setMedicalClaimLoss(double medicalClaimLoss) {
            this.medicalClaimLoss = medicalClaimLoss;
    }
    /**
     * setter method for insurer of non wica claim
     * @param medicalClaimInsurer
     * sets current insurer of non wica claim to new insurer
     */
    public void setMedicalClaimInsurer(String medicalClaimInsurer) {
            this.medicalClaimInsurer = medicalClaimInsurer;
    }
    /**
     * setter method for policy number of non wica claim
     * @param medicalClaimPolicyNumber
     * sets current policy number of non wica claim to new policy number
     */
    public void setMedicalClaimPolicyNumber(String medicalClaimPolicyNumber) {
            this.medicalClaimPolicyNumber = medicalClaimPolicyNumber;
    }
    /**
     * setter method for basis of non wica claim
     * @param medicalClaimBasis 
     * sets current basis of non wica claim to new basis
     */
    public void setMedicalClaimBasis(String medicalClaimBasis) {
            this.medicalClaimBasis = medicalClaimBasis;
    }
    /*
     * toString method for details of non wica claim with id
     * @return details of non wica claim with id
     */
    @Override
    public String toString() {
        return "ProblemNonWicaClaim{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", medicalClaimDate=" + medicalClaimDate + ", medicalClaimLoss=" + medicalClaimLoss + 
                ", medicalClaimInsurer=" + medicalClaimInsurer + 
                ", medicalClaimPolicyNumber=" + medicalClaimPolicyNumber + 
                ", medicalClaimBasis=" + medicalClaimBasis + ", remark=" + remark + '}';
    }
    /*
     * toString method for details of non wica claim without id
     * @return details of non wica claim without id
     */
    public String toString2() {
        return "NonWicaClaim [medicalClaimDate=" + medicalClaimDate + ", medicalClaimLoss=" + medicalClaimLoss + 
                ", medicalClaimInsurer=" + medicalClaimInsurer + 
                ", medicalClaimPolicyNumber=" + medicalClaimPolicyNumber + 
                ", medicalClaimBasis=" + medicalClaimBasis + ", remark=" + remark + ']';
    }
    
}
