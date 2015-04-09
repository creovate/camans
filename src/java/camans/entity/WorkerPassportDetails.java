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
public class WorkerPassportDetails {
    
    //attributes
    private String workerFinNum;
    private int id;
    private String passportNumber;
    private String passportCountry;
    private Date passportIssueDate;
    private Date passportExpirtyDate;

    /**
     *
     * @param workerFinNum FIN
     * @param id id
     * @param passportNumber passport number
     * @param passportCountry  passport country
     * @param passportIssueDate passport issue date
     * @param passportExpirtyDate passport expiry date
     */
    public WorkerPassportDetails(String workerFinNum, int id, String passportNumber, String passportCountry, Date passportIssueDate, Date passportExpirtyDate) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.passportNumber = passportNumber;
        this.passportCountry = passportCountry;
        this.passportIssueDate = passportIssueDate;
        this.passportExpirtyDate = passportExpirtyDate;
    }

    /**
     *
     * @param workerFinNum FIN
    * @param passportNumber passport number
     * @param passportCountry  passport country
     * @param passportIssueDate passport issue date
     * @param passportExpirtyDate passport expiry date
     */
    public WorkerPassportDetails(String workerFinNum, String passportNumber, String passportCountry, Date passportIssueDate, Date passportExpirtyDate) {
        this.workerFinNum = workerFinNum;
        this.passportNumber = passportNumber;
        this.passportCountry = passportCountry;
        this.passportIssueDate = passportIssueDate;
        this.passportExpirtyDate = passportExpirtyDate;
    }

    /**
     *return FIN
     * @return FIN
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }

    /**
     *set FIN
     * @param workerFinNum FIN
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }

    /**
     *return id
     * @return id
     */
    public int getId() {
        return id;
    }

    /**
     *set id
     * @param id id
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     *return passport number
     * @return passport number
     */
    public String getPassportNumber() {
        return passportNumber;
    }

    /**
     *set passport number
     * @param passportNumber passport number
     */
    public void setPassportNumber(String passportNumber) {
        this.passportNumber = passportNumber;
    }

    /**
     *return passport country
     * @return passport country
     */ 
    public String getPassportCountry() {
        return passportCountry;
    }

    /**
     *set passport country
     * @param passportCountry passport country
     */
    public void setPassportCountry(String passportCountry) {
        this.passportCountry = passportCountry;
    }

    /**
     *return passport issue date
     * @return passport issue date
     */
    public Date getPassportIssueDate() {
        return passportIssueDate;
    }

    /**
     *set passport issue date
     * @param passportIssueDate passport issue date
     */
    public void setPassportIssueDate(Date passportIssueDate) {
        this.passportIssueDate = passportIssueDate;
    }

    /**
     *return passport expiry date
     * @return passport expiry date
     */
    public Date getPassportExpirtyDate() {
        return passportExpirtyDate;
    }

    /**
     *set passport expiry date
     * @param passportExpirtyDate passport expiry date
     */
    public void setPassportExpirtyDate(Date passportExpirtyDate) {
        this.passportExpirtyDate = passportExpirtyDate;
    }

    @Override
    public String toString() {
        return "WorkerPassportDetails{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", passportNumber=" + passportNumber + ", passportCountry=" + passportCountry + ", passportIssueDate=" + passportIssueDate + ", passportExpirtyDate=" + passportExpirtyDate + '}';
    }
    
    
    public String toString2() {
        if (passportIssueDate == null || passportExpirtyDate == null) {
            return "WorkerPassportDetails [passportNumber=" + passportNumber + ", passportCountry=" + passportCountry + ']';
        }
        
        return "WorkerPassportDetails [passportNumber=" + passportNumber + ", passportCountry=" + passportCountry + ", passportIssueDate=" + passportIssueDate + ", passportExpirtyDate=" + passportExpirtyDate + ']';
    }    
    
}
