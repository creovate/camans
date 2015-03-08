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

    public WorkerPassportDetails(String workerFinNum, int id, String passportNumber, String passportCountry, Date passportIssueDate, Date passportExpirtyDate) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.passportNumber = passportNumber;
        this.passportCountry = passportCountry;
        this.passportIssueDate = passportIssueDate;
        this.passportExpirtyDate = passportExpirtyDate;
    }

    public WorkerPassportDetails(String workerFinNum, String passportNumber, String passportCountry, Date passportIssueDate, Date passportExpirtyDate) {
        this.workerFinNum = workerFinNum;
        this.passportNumber = passportNumber;
        this.passportCountry = passportCountry;
        this.passportIssueDate = passportIssueDate;
        this.passportExpirtyDate = passportExpirtyDate;
    }

    public String getWorkerFinNum() {
        return workerFinNum;
    }

    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPassportNumber() {
        return passportNumber;
    }

    public void setPassportNumber(String passportNumber) {
        this.passportNumber = passportNumber;
    }

    public String getPassportCountry() {
        return passportCountry;
    }

    public void setPassportCountry(String passportCountry) {
        this.passportCountry = passportCountry;
    }

    public Date getPassportIssueDate() {
        return passportIssueDate;
    }

    public void setPassportIssueDate(Date passportIssueDate) {
        this.passportIssueDate = passportIssueDate;
    }

    public Date getPassportExpirtyDate() {
        return passportExpirtyDate;
    }

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
