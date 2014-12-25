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
public class Benefit {
    
    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private Date issueDate;
    private String benefitGiver;
    private String benefitType;
    private String benefitTypeMore;
    private String benefitSerial;
    private String benefitPurpose;
    private String benefitRemark;
    private double benefitValue;

    //constructor with id 
    public Benefit(int id, String workerFinNumber, int jobKey, int problemKey, Date issueDate, 
            String benefitGiver, String benefitType, String benefitTypeMore, String benefitSerial, 
            String benefitPurpose, String benefitRemark, double benefitValue) {
        this.id = id;
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.issueDate = issueDate;
        this.benefitGiver = benefitGiver;
        this.benefitType = benefitType;
        this.benefitTypeMore = benefitTypeMore;
        this.benefitSerial = benefitSerial;
        this.benefitPurpose = benefitPurpose;
        this.benefitRemark = benefitRemark;
        this.benefitValue = benefitValue;
    }

    //constructor without id
    public Benefit(String workerFinNumber, int jobKey, int problemKey, Date issueDate, 
            String benefitGiver, String benefitType, String benefitTypeMore, String benefitSerial, 
            String benefitPurpose, String benefitRemark, double benefitValue) {
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.issueDate = issueDate;
        this.benefitGiver = benefitGiver;
        this.benefitType = benefitType;
        this.benefitTypeMore = benefitTypeMore;
        this.benefitSerial = benefitSerial;
        this.benefitPurpose = benefitPurpose;
        this.benefitRemark = benefitRemark;
        this.benefitValue = benefitValue;
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

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public String getBenefitGiver() {
        return benefitGiver;
    }

    public void setBenefitGiver(String benefitGiver) {
        this.benefitGiver = benefitGiver;
    }

    public String getBenefitType() {
        return benefitType;
    }

    public void setBenefitType(String benefitType) {
        this.benefitType = benefitType;
    }

    public String getBenefitTypeMore() {
        return benefitTypeMore;
    }

    public void setBenefitTypeMore(String benefitTypeMore) {
        this.benefitTypeMore = benefitTypeMore;
    }

    public String getBenefitSerial() {
        return benefitSerial;
    }

    public void setBenefitSerial(String benefitSerial) {
        this.benefitSerial = benefitSerial;
    }

    public String getBenefitPurpose() {
        return benefitPurpose;
    }

    public void setBenefitPurpose(String benefitPurpose) {
        this.benefitPurpose = benefitPurpose;
    }

    public String getBenefitRemark() {
        return benefitRemark;
    }

    public void setBenefitRemark(String benefitRemark) {
        this.benefitRemark = benefitRemark;
    }

    public double getBenefitValue() {
        return benefitValue;
    }

    public void setBenefitValue(double benefitValue) {
        this.benefitValue = benefitValue;
    }

    @Override
    public String toString() {
        return "Benefit{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", issueDate=" + issueDate + ", benefitGiver=" + benefitGiver + 
                ", benefitType=" + benefitType + ", benefitTypeMore=" + benefitTypeMore + 
                ", benefitSerial=" + benefitSerial + ", benefitPurpose=" + benefitPurpose + 
                ", benefitRemark=" + benefitRemark + ", benefitValue=" + benefitValue + '}';
    }
    
    public String toString2() {
        return "Benefit{" + "WorkerFinNumber=" + workerFinNumber + 
                ", issueDate=" + issueDate + ", benefitGiver=" + benefitGiver + 
                ", benefitType=" + benefitType + ", benefitTypeMore=" + benefitTypeMore + 
                ", benefitSerial=" + benefitSerial + ", benefitPurpose=" + benefitPurpose + 
                ", benefitRemark=" + benefitRemark + ", benefitValue=" + benefitValue + '}';
    }    
    
    
}
