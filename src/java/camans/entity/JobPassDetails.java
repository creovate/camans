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
    /*
     * Creates new Pass Details object with id
     * @param id identifier of job pass
     * @param worker fin number holding job pass
     * @param job key of job with job pass
     * @param type of job pass
     * @param more infor of type of job pass
     * @param number of pass
     * @param application date of job pass
     * @param issue date of job pass
     * @param expiry date of job pass
     * @param issuer of job pass
     * @param remarks for job pass
     * @param obsoleteDate for job pass
     */
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
    /*
     * Creates new Pass Details object without id
     * @param worker fin number holding job pass
     * @param job key of job with job pass
     * @param type of job pass
     * @param more infor of type of job pass
     * @param number of pass
     * @param application date of job pass
     * @param issue date of job pass
     * @param expiry date of job pass
     * @param issuer of job pass
     * @param remarks for job pass
     * @param obsoleteDate for job pass
     */
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

    /**
     * getter method for id for job pass
     * @return id of job pass
     */
    public int getId() {
        return id;
    }
    /**
     * setter method for id of job pass
     * @param id 
     * sets current id of job pass to new id
     */
    public void setId(int id) {
        this.id = id;
    }
    /**
     * getter method for worker fin number of job pass
     * @return worker fin number of job pass
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }
    /**
     * setter method for worker fin number of job pass
     * @param workerFinNum 
     * sets current worker fin number of job pass to new worker fin number
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }
    /**
     * getter method for job key for job pass
     * @return job key of job pass
     */
    public int getJobKey() {
        return jobKey;
    }
    /**
     * setter method for job key of job pass
     * @param jobKey
     * sets current job key of job pass to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }
    /**
     * getter method for type of job pass
     * @return type of job pass
     */
    public String getPassType() {
        return passType;
    }
    /**
     * setter method for type of job pass
     * @param passType
     * sets current type of job pass to new type
     */
    public void setPassType(String passType) {
        this.passType = passType;
    }
    /**
     * getter method for more info of type of job pass
     * @return more info of type of job pass
     */
    public String getPassTypeMore() {
        return passTypeMore;
    }
    /**
     * setter method for more info of type of job pass
     * @param passTypeMore
     * sets current more info of type of job pass to new more info of type
     */
    public void setPassTypeMore(String passTypeMore) {
        this.passTypeMore = passTypeMore;
    }
     /**
     * getter method for number of job pass
     * @return number of job pass
     */
    public String getPassNum() {
        return passNum;
    }
    /**
     * setter method for number of job pass
     * @param passNum 
     * sets current number of job pass to new number
     */
    public void setPassNum(String passNum) {
        this.passNum = passNum;
    }
     /**
     * getter method for application date of job pass
     * @return application date of job pass
     */
    public Date getPassApplicationDate() {
        return passApplicationDate;
    }
    /**
     * setter method for application date of job pass
     * @param passApplicationDate 
     * sets current application date of job pass to new application date
     */
    public void setPassApplicationDate(Date passApplicationDate) {
        this.passApplicationDate = passApplicationDate;
    }
     /**
     * getter method for issue date of job pass
     * @return issue date of job pass
     */
    public Date getIssueDate() {
        return issueDate;
    }
    /**
     * setter method for issue date of job pass
     * @param issueDate
     * sets current issue date of job pass to new issue date
     */
    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }
     /**
     * getter method for expiry date of job pass
     * @return expiry date of job pass
     */
    public Date getExpiryDate() {
        return expiryDate;
    }
    /**
     * setter method for expiry date of job pass
     * @param expiryDate 
     * sets current expiry date of job pass to new expiry date
     */
    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }
     /**
     * getter method for issuer of job pass
     * @return issuer of job pass
     */
    public String getIssuer() {
        return issuer;
    }
    /**
     * setter method for issuer of job pass
     * @param issuer 
     * sets current issuer of job pass to new issuer
     */
    public void setIssuer(String issuer) {
        this.issuer = issuer;
    }
     /**
     * getter method for remarks of job pass
     * @return remarks of job pass
     */
    public String getRemarks() {
        return remarks;
    }
    /**
     * setter method for remarks of job pass
     * @param remarks 
     * sets current remarks of job pass to new remarks
     */
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
     /**
     * getter method for obsolete date of job pass
     * @return obsolete date of job pass
     */
    public Date getObsoleteDate() {
        return obsoleteDate;
    }
    /**
     * setter method for obsolete date of job pass
     * @param obsoleteDate 
     * sets current obsolete date of job pass to new obsolete date
     */
    public void setObsoleteDate(Date obsoleteDate) {
        this.obsoleteDate = obsoleteDate;
    }
    /*
     * toString method for details for job pass with id
     * @return details of job pass with id
     */
    @Override
    public String toString() {
        return "JobPassDetails{" + "id=" + id + ", workerFinNum=" + workerFinNum + ", jobKey=" + 
                jobKey + ", passType=" + passType + ", passTypeMore=" + passTypeMore + ", passNum=" + 
                passNum + ", passApplicationDate=" + passApplicationDate + ", issueDate=" 
                + issueDate + ", expiryDate=" + expiryDate + ", issuer=" + issuer + ", remarks=" + 
                remarks + ", obsoleteDate=" + obsoleteDate + '}';
    }
    /*
     * toString method for details for job pass without id
     * @return details of job pass without id
     */
    public String toString2() {
        if (obsoleteDate == null) {
            return "Pass Details [passType=" + passType + 
                ", passTypeMore=" + passTypeMore + ", passNum=" + passNum + ", passApplicationDate=" + 
                passApplicationDate + ", issueDate=" + issueDate + ", expiryDate=" + expiryDate + 
                ", issuer=" + issuer + ", remarks=" + remarks + ']';
        }
        
        if (passApplicationDate == null || expiryDate == null) {
            return "Pass Details [passType=" + passType + 
                ", passTypeMore=" + passTypeMore + ", passNum=" + passNum + ", passApplicationDate=" + 
                passApplicationDate + 
                ", issuer=" + issuer + ", remarks=" + remarks + ']';
        }
        
        return "Pass Details [passType=" + passType + 
                ", passTypeMore=" + passTypeMore + ", passNum=" + passNum + ", passApplicationDate=" + 
                passApplicationDate + ", issueDate=" + issueDate + ", expiryDate=" + expiryDate + 
                ", issuer=" + issuer + ", remarks=" + remarks + ", obsoleteDate=" + obsoleteDate + ']';
    }
    
    
    
}
