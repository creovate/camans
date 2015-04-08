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

    /**
     * constructor
     * @param id identifier of benefit 
     * @param workerFinNumber to whom this benefit belongs to
     * @param jobKey to whom the benefit belongs to
     * @param problemKey to whom the problem belongs to
     * @param issueDate Date 
     * @param benefitGiver who gives the benefit
     * @param benefitType type 
     * @param benefitTypeMore  a desc if benefit type is selected as other
     * @param benefitSerial serial number
     * @param benefitPurpose purpose 
     * @param benefitRemark remark
     * @param benefitValue the amount given to the worker
     **/
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
    /**
    * @param workerFinNumber to whom this benefit belongs to
     * @param jobKey to whom the benefit belongs to
     * @param problemKey to whom the problem belongs to
     * @param issueDate Date 
     * @param benefitGiver who gives the benefit
     * @param benefitType type 
     * @param benefitTypeMore  a desc if benefit type is selected as other
     * @param benefitSerial serial number
     * @param benefitPurpose purpose 
     * @param benefitRemark remark
     * @param benefitValue the amount given to the worker
     * */
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

    /**
     * returns id
     * @return id
     */
    public int getId() {
        return id;
    }

    /**
     * set id
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
     * get FIN
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
     * returns issue date
     * @return issue date
     */
    public Date getIssueDate() {
        return issueDate;
    }

    /**
     * set issue date
     * @param issueDate issue date
     */
    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    /**
     * returns benefit giver
     * @return benefit giver
     */
    public String getBenefitGiver() {
        return benefitGiver;
    }

    /**
     * set benefit giver
     * @param benefitGiver benefit giver
     */
    public void setBenefitGiver(String benefitGiver) {
        this.benefitGiver = benefitGiver;
    }

    /**
     * returns benefit type
     * @return benefit type
     */
    public String getBenefitType() {
        return benefitType;
    }

    /**
     * set benefit type
     * @param benefitType benefit type
     */
    public void setBenefitType(String benefitType) {
        this.benefitType = benefitType;
    }

    /**
     * returns more benefit type
     * @return more benefit type
     */
    public String getBenefitTypeMore() {
        return benefitTypeMore;
    }

    /**
     * set more benefit type
     * @param benefitTypeMore more benefit type
     */
    public void setBenefitTypeMore(String benefitTypeMore) {
        this.benefitTypeMore = benefitTypeMore;
    }

    /**
     * returns benefit serial number
     * @return benefit serial number
     */
    public String getBenefitSerial() {
        return benefitSerial;
    }

    /**
     * set benefit serial number
     * @param benefitSerial benefit serial number
     */
    public void setBenefitSerial(String benefitSerial) {
        this.benefitSerial = benefitSerial;
    }

    /**
     * returns purpose of benefit
     * @return purpose of benefit
     */
    public String getBenefitPurpose() {
        return benefitPurpose;
    }

    /**
     * set purpose of benefit
     * @param benefitPurpose purpose of benefit
     */
    public void setBenefitPurpose(String benefitPurpose) {
        this.benefitPurpose = benefitPurpose;
    }

    /**
     * returns remark of benefit
     * @return remark of benefit
     */
    public String getBenefitRemark() {
        return benefitRemark;
    }

    /**
     * set remark of benefit
     * @param benefitRemark remark of benefit
     */
    public void setBenefitRemark(String benefitRemark) {
        this.benefitRemark = benefitRemark;
    }

    /**
     * returns benefit value
     * @return benefit value
     */
    public double getBenefitValue() {
        return benefitValue;
    }

    /**
     * set benefit value
     * @param benefitValue benefit value
     */
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
    
    /**
     *
     * @return
     */
    public String toString2() {
        return "Benefit [issueDate=" + issueDate + ", benefitGiver=" + benefitGiver + 
                ", benefitType=" + benefitType + ", benefitTypeMore=" + benefitTypeMore + 
                ", benefitSerial=" + benefitSerial + ", benefitPurpose=" + benefitPurpose + 
                ", benefitRemark=" + benefitRemark + ", benefitValue=" + benefitValue + ']';
    }    
    
    
}
