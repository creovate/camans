package camans.entity;


import java.sql.Date;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author soemyatmyat
 */
public class JobPassDetails {
    //attributes 
    private int id;
    private String workerFinNum;
    private int jobKey;
    private String passType;
    private String passTypeMore;
    private String passNum;
    private Date passApplicationDate;
    private Date issueDate;
    private Date expiryDate;
    private String issuer;
    private String remarks;
    private Date obsoleteDate;

    public JobPassDetails(int id, String workerFinNum, int jobKey, String passType, String passTypeMore, String passNum, Date passApplicationDate, Date issueDate, Date expiryDate, String issuer, String remarks, Date obsoleteDate) {
        this.id = id;
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.passType = passType;
        this.passTypeMore = passTypeMore;
        this.passNum = passNum;
        this.passApplicationDate = passApplicationDate;
        this.issueDate = issueDate;
        this.expiryDate = expiryDate;
        this.issuer = issuer;
        this.remarks = remarks;
        this.obsoleteDate = obsoleteDate;
    }

    public JobPassDetails(String workerFinNum, int jobKey, String passType, String passTypeMore, 
            String passNum, Date passApplicationDate, Date issueDate, Date expiryDate, 
            String issuer, String remarks, Date obsoleteDate) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.passType = passType;
        this.passTypeMore = passTypeMore;
        this.passNum = passNum;
        this.passApplicationDate = passApplicationDate;
        this.issueDate = issueDate;
        this.expiryDate = expiryDate;
        this.issuer = issuer;
        this.remarks = remarks;
        this.obsoleteDate = obsoleteDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getWorkerFinNum() {
        return workerFinNum;
    }

    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }

    @Override
    public String toString() {
        return "JobPassDetails{" + "id=" + id + ", workerFinNum=" + workerFinNum + ", jobKey=" + jobKey + ", passType=" + passType + ", passTypeMore=" + passTypeMore + ", passNum=" + passNum + ", passApplicationDate=" + passApplicationDate + ", issueDate=" + issueDate + ", expiryDate=" + expiryDate + ", issuer=" + issuer + ", remarks=" + remarks + ", obsoleteDate=" + obsoleteDate + '}';
    }

    public int getJobKey() {
        return jobKey;
    }

    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }

    public String getPassType() {
        return passType;
    }

    public void setPassType(String passType) {
        this.passType = passType;
    }

    public String getPassTypeMore() {
        return passTypeMore;
    }

    public void setPassTypeMore(String passTypeMore) {
        this.passTypeMore = passTypeMore;
    }

    public String getPassNum() {
        return passNum;
    }

    public void setPassNum(String passNum) {
        this.passNum = passNum;
    }

    public Date getPassApplicationDate() {
        return passApplicationDate;
    }

    public void setPassApplicationDate(Date passApplicationDate) {
        this.passApplicationDate = passApplicationDate;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getIssuer() {
        return issuer;
    }

    public void setIssuer(String issuer) {
        this.issuer = issuer;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Date getObsoleteDate() {
        return obsoleteDate;
    }

    public void setObsoleteDate(Date obsoleteDate) {
        this.obsoleteDate = obsoleteDate;
    }
    
    
    
    
}
