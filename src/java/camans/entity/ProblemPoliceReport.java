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

    /**
     *
     * @param id id
     * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problemKey problem key
     * @param policeReportDate police report date
     * @param policeReportStation police report station
     * @param policeReportPerson police report person
     * @param policeReportReferenceNumber police report reference number
     * @param policeReportDetails details of police report
     * @param policeReportRemark remark of police report
     */
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
 
    /**
     *
     * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problemKey problem key
     * @param policeReportDate police report date
     * @param policeReportStation police report station
     * @param policeReportPerson police report person
     * @param policeReportReferenceNumber police report reference number
     * @param policeReportDetails details of police report
     * @param policeReportRemark remark of police report
     */
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

    /**
     * returns id
     * @return id
     */
    public int getId() {
            return id;
    }

    /**
     * returns FIN
     * @return  FIN
     */
    public String getWorkerFinNumber() {
            return workerFinNumber;
    }

    /**
     * returns job key
     * @return job key
     */
    public int getJobKey() {
            return jobKey;
    }

    /**
     * returns problem key
     * @return problem key
     */
    public int getProblemKey() {
            return problemKey;
    }

    /**
     * returns date of police report
     * @return date of police report
     */
    public Date getPoliceReportDate() {
            return policeReportDate;
    }

    /**
     * returns police report station
     * @return police report station
     */
    public String getPoliceReportStation() {
            return policeReportStation;
    }

    /**
     * returns police report person
     * @return police report person
     */
    public String getPoliceReportPerson() {
            return policeReportPerson;
    }

    /**
     * returns police report reference number
     * @return police report reference number
     */
    public String getPoliceReportReferenceNumber() {
            return policeReportReferenceNumber;
    }

    /**
     * returns police report details
     * @return police report details
     */
    public String getPoliceReportDetails() {
            return policeReportDetails;
    }

    /**
     * returns police report remark
     * @return police report remark
     */
    public String getPoliceReportRemark() {
            return policeReportRemark;
    }

    /**
     * set id
     * @param id id
     */
    public void setId(int id) {
            this.id = id;
    }

    /**
     * set FIN
     * @param workerFinNumber FIN
     */
    public void setWorkerFinNumber(String workerFinNumber) {
            this.workerFinNumber = workerFinNumber;
    }

    /**
     * set job key
     * @param jobKey job key
     */
    public void setJobKey(int jobKey) {
            this.jobKey = jobKey;
    }

    /**
     * set problem key
     * @param problemKey problem key
     */
    public void setProblemKey(int problemKey) {
            this.problemKey = problemKey;
    }

    /**
     * set date of police report
     * @param policeReportDate date of police report
     */
    public void setPoliceReportDate(Date policeReportDate) {
            this.policeReportDate = policeReportDate;
    }

    /**
     * set police report station
     * @param policeReportStation police report station
     */
    public void setPoliceReportStation(String policeReportStation) {
            this.policeReportStation = policeReportStation;
    }

    /**
     * set police report person
     * @param policeReportPerson police report person
     */
    public void setPoliceReportPerson(String policeReportPerson) {
            this.policeReportPerson = policeReportPerson;
    }

    /**
     * set police report reference number
     * @param policeReportReferenceNumber police report reference number
     */
    public void setPoliceReportReferenceNumber(String policeReportReferenceNumber) {
            this.policeReportReferenceNumber = policeReportReferenceNumber;
    }

    /**
     * set police report details
     * @param policeReportDetails police report details
     */
    public void setPoliceReportDetails(String policeReportDetails) {
            this.policeReportDetails = policeReportDetails;
    }

    /**
     * set police report remark
     * @param policeReportRemark police report remark
     */
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

    /**
     *
     * @return
     */
    public String toString2() {
        return "Police Report [policeReportDate=" + policeReportDate + 
                ", policeReportStation=" + policeReportStation + 
                ", policeReportPerson=" + policeReportPerson + 
                ", policeReportReferenceNumber=" + policeReportReferenceNumber + 
                ", policeReportDetails=" + policeReportDetails + 
                ", policeReportRemark=" + policeReportRemark + ']';
    }    
}
