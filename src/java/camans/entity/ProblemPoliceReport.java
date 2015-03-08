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
public class ProblemPoliceReport {
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private Date policeReportDate;
    private String policeReportStation;
    private String policeReportPerson;
    private String policeReportReferenceNumber;
    private String policeReportDetails;
    private String policeReportRemark;

    //constructor with id
    public ProblemPoliceReport(int id, String workerFinNumber, int jobKey, int problemKey, Date policeReportDate, String policeReportStation, String policeReportPerson, String policeReportReferenceNumber, String policeReportDetails, String policeReportRemark) {
            this.id = id;
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.policeReportDate = policeReportDate;
            this.policeReportStation = policeReportStation;
            this.policeReportPerson = policeReportPerson;
            this.policeReportReferenceNumber = policeReportReferenceNumber;
            this.policeReportDetails = policeReportDetails;
            this.policeReportRemark = policeReportRemark;
    }

    //constructor without id
    public ProblemPoliceReport(String workerFinNumber, int jobKey, int problemKey, 
            Date policeReportDate, String policeReportStation, String policeReportPerson, 
            String policeReportReferenceNumber, String policeReportDetails, String policeReportRemark) {
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.policeReportDate = policeReportDate;
            this.policeReportStation = policeReportStation;
            this.policeReportPerson = policeReportPerson;
            this.policeReportReferenceNumber = policeReportReferenceNumber;
            this.policeReportDetails = policeReportDetails;
            this.policeReportRemark = policeReportRemark;
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

    public Date getPoliceReportDate() {
            return policeReportDate;
    }

    public String getPoliceReportStation() {
            return policeReportStation;
    }

    public String getPoliceReportPerson() {
            return policeReportPerson;
    }

    public String getPoliceReportReferenceNumber() {
            return policeReportReferenceNumber;
    }

    public String getPoliceReportDetails() {
            return policeReportDetails;
    }

    public String getPoliceReportRemark() {
            return policeReportRemark;
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

    public void setPoliceReportDate(Date policeReportDate) {
            this.policeReportDate = policeReportDate;
    }

    public void setPoliceReportStation(String policeReportStation) {
            this.policeReportStation = policeReportStation;
    }

    public void setPoliceReportPerson(String policeReportPerson) {
            this.policeReportPerson = policeReportPerson;
    }

    public void setPoliceReportReferenceNumber(String policeReportReferenceNumber) {
            this.policeReportReferenceNumber = policeReportReferenceNumber;
    }

    public void setPoliceReportDetails(String policeReportDetails) {
            this.policeReportDetails = policeReportDetails;
    }

    public void setPoliceReportRemark(String policeReportRemark) {
            this.policeReportRemark = policeReportRemark;
    }

    @Override
    public String toString() {
        return "ProblemPoliceReport{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", policeReportDate=" + policeReportDate + 
                ", policeReportStation=" + policeReportStation + 
                ", policeReportPerson=" + policeReportPerson + 
                ", policeReportReferenceNumber=" + policeReportReferenceNumber + 
                ", policeReportDetails=" + policeReportDetails + 
                ", policeReportRemark=" + policeReportRemark + '}';
    }

    public String toString2() {
        return "Police Report [policeReportDate=" + policeReportDate + 
                ", policeReportStation=" + policeReportStation + 
                ", policeReportPerson=" + policeReportPerson + 
                ", policeReportReferenceNumber=" + policeReportReferenceNumber + 
                ", policeReportDetails=" + policeReportDetails + 
                ", policeReportRemark=" + policeReportRemark + ']';
    }    
}
