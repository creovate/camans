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
public class ProblemOtherComplaint {
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private Date otherComplaintDate;
    private String otherComplaintAgency;
    private String otherComplaintWho;
    private String otherComplaintWhoMore;
    private String otherComplaintMode;
    private String otherComplaintModeMore;
    private String otherComplaintDetails;
    private String otherComplaintRemark;

    //constructor with id
     /**
    * Constructor for ProblemOtherComplaint class
    *
    * @param id - id
    * @param workerFinNumber - worker's FIN
    * @param jobKey - job key
    * @param problemKey - problem key
    * @param otherComplaintDate - date other complaint lodged
    * @param otherComplaintAgency - agency/authority to whom complaint addressed
    * @param otherComplaintWho - name of person lodging this complaint
    * @param otherComplaintWhoMore - name of person lodging complaint from TWC2 or third party
    * @param otherComplaintMode - mode of lodging complaint
    * @param otherComplaintModeMore - other mode
    * @param otherComplaintDetails - details of complaint lodged
    * @param otherComplaintRemark - remarks
    */
    public ProblemOtherComplaint(int id, String workerFinNumber, int jobKey, int problemKey, Date otherComplaintDate, String otherComplaintAgency, String otherComplaintWho, String otherComplaintWhoMore, String otherComplaintMode, String otherComplaintModeMore, String otherComplaintDetails, String otherComplaintRemark) {
            this.id = id;
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.otherComplaintDate = otherComplaintDate;
            this.otherComplaintAgency = otherComplaintAgency;
            this.otherComplaintWho = otherComplaintWho;
            this.otherComplaintWhoMore = otherComplaintWhoMore;
            this.otherComplaintMode = otherComplaintMode;
            this.otherComplaintModeMore = otherComplaintModeMore;
            this.otherComplaintDetails = otherComplaintDetails;
            this.otherComplaintRemark = otherComplaintRemark;
    }

    //constructor without id
     /**
    * Constructor for ProblemOtherComplaint class without id
    *
    * @param workerFinNumber - worker's FIN
    * @param jobKey - job key
    * @param problemKey - problem key
    * @param otherComplaintDate - date other complaint lodged
    * @param otherComplaintAgency - agency/authority to whom complaint addressed
    * @param otherComplaintWho - name of person lodging this complaint
    * @param otherComplaintWhoMore - name of person lodging complaint from TWC2 or third party
    * @param otherComplaintMode - mode of lodging complaint
    * @param otherComplaintModeMore - other mode
    * @param otherComplaintDetails - details of complaint lodged
    * @param otherComplaintRemark - remarks
    */
    public ProblemOtherComplaint(String workerFinNumber, int jobKey, int problemKey, Date otherComplaintDate, String otherComplaintAgency, String otherComplaintWho, String otherComplaintWhoMore, String otherComplaintMode, String otherComplaintModeMore, String otherComplaintDetails, String otherComplaintRemark) {
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.otherComplaintDate = otherComplaintDate;
            this.otherComplaintAgency = otherComplaintAgency;
            this.otherComplaintWho = otherComplaintWho;
            this.otherComplaintWhoMore = otherComplaintWhoMore;
            this.otherComplaintMode = otherComplaintMode;
            this.otherComplaintModeMore = otherComplaintModeMore;
            this.otherComplaintDetails = otherComplaintDetails;
            this.otherComplaintRemark = otherComplaintRemark;
    }

    /**
    * Returns id
    *
    * @return id
    */
    public int getId() {
            return id;
    }

    /**
    * Returns worker FIN
    *
    * @return worker FIN
    */
    public String getWorkerFinNumber() {
            return workerFinNumber;
    }

    /**
    * Returns job key
    *
    * @return job key
    */
    public int getJobKey() {
            return jobKey;
    }

   /**
    * Returns problem key
    *
    * @return problem key
    */
    public int getProblemKey() {
            return problemKey;
    }

    /**
    * Returns date of other complaint
    *
    * @return date of other complaint
    */
    public Date getOtherComplaintDate() {
            return otherComplaintDate;
    }

    /**
    * Returns agency of other complaint
    *
    * @return agency of other complaint
    */
    public String getOtherComplaintAgency() {
            return otherComplaintAgency;
    }

    /**
    * Returns person who lodged the complaint
    *
    * @return person who lodged the complaint
    */
    public String getOtherComplaintWho() {
            return otherComplaintWho;
    }

    /**
    * Returns person from TWC2 or third party who lodged the complaint
    *
    * @return person from TWC2 or third party who lodged the complaint
    */
    public String getOtherComplaintWhoMore() {
            return otherComplaintWhoMore;
    }

    /**
    * Returns other complaint mode
    *
    * @return other complaint mode
    */
    public String getOtherComplaintMode() {
            return otherComplaintMode;
    }

    /**
    * Returns more other complaint mode
    *
    * @return more other complaint mode
    */
    public String getOtherComplaintModeMore() {
            return otherComplaintModeMore;
    }

    /**
    * Returns other complaint details
    *
    * @return other complaint details
    */
    public String getOtherComplaintDetails() {
            return otherComplaintDetails;
    }

    /**
    * Returns other complaint remark
    *
    * @return other complaint remark
    */
    public String getOtherComplaintRemark() {
            return otherComplaintRemark;
    }
    
    /**
    * Sets id
    *
    * @param id  id
    */
    public void setId(int id) {
            this.id = id;
    }
    
    /**
    * Sets worker FIN
    *
    * @param workerFinNumber  worker FIN
    */
    public void setWorkerFinNumber(String workerFinNumber) {
            this.workerFinNumber = workerFinNumber;
    }
    
    /**
    * Sets job key
    *
    * @param jobKey  job key
    */
    public void setJobKey(int jobKey) {
            this.jobKey = jobKey;
    }

    /**
    * Sets problem key
    *
    * @param problemKey  problem key
    */
    public void setProblemKey(int problemKey) {
            this.problemKey = problemKey;
    }

    /**
    * Sets date of other complaint
    *
    * @param otherComplaintDate  date of other complaint
    */
    public void setOtherComplaintDate(Date otherComplaintDate) {
            this.otherComplaintDate = otherComplaintDate;
    }

    /**
    * Sets agency of other complaint
    *
    * @param otherComplaintAgency  agency of other complaint
    */
    public void setOtherComplaintAgency(String otherComplaintAgency) {
            this.otherComplaintAgency = otherComplaintAgency;
    }

    /**
    * Sets person who lodged the complaint
    *
    * @param otherComplaintWho  person who lodged the complaint
    */
    public void setOtherComplaintWho(String otherComplaintWho) {
            this.otherComplaintWho = otherComplaintWho;
    }

    /**
    * Sets person who lodged the complaint from TWC2 or third party
    *
    * @param otherComplaintWhoMore  person who lodged the complaint from TWC2 or third party
    */
    public void setOtherComplaintWhoMore(String otherComplaintWhoMore) {
            this.otherComplaintWhoMore = otherComplaintWhoMore;
    }

    /**
    * Sets lodging complaint mode
    *
    * @param otherComplaintMode  lodging complaint mode
    */
    public void setOtherComplaintMode(String otherComplaintMode) {
            this.otherComplaintMode = otherComplaintMode;
    }

    /**
    * Sets more lodging complaint mode
    *
    * @param otherComplaintModeMore  lodging complaint mode
    */
    public void setOtherComplaintModeMore(String otherComplaintModeMore) {
            this.otherComplaintModeMore = otherComplaintModeMore;
    }

    /**
    * Sets details of other complaint
    *
    * @param otherComplaintDetails  details of other complaint
    */
    public void setOtherComplaintDetails(String otherComplaintDetails) {
            this.otherComplaintDetails = otherComplaintDetails;
    }

    /**
    * Sets remarks
    *
    * @param otherComplaintRemark  remarks
    */
    public void setOtherComplaintRemark(String otherComplaintRemark) {
            this.otherComplaintRemark = otherComplaintRemark;
    }

    @Override
    public String toString() {
        return "ProblemOtherComplaint{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", otherComplaintDate=" + otherComplaintDate + 
                ", otherComplaintAgency=" + otherComplaintAgency + 
                ", otherComplaintWho=" + otherComplaintWho + 
                ", otherComplaintWhoMore=" + otherComplaintWhoMore + 
                ", otherComplaintMode=" + otherComplaintMode + 
                ", otherComplaintModeMore=" + otherComplaintModeMore + 
                ", otherComplaintDetails=" + otherComplaintDetails + 
                ", otherComplaintRemark=" + otherComplaintRemark + '}';
    }

    public String toString2() {
        return "Other Complaint [otherComplaintDate=" + otherComplaintDate + 
                ", otherComplaintAgency=" + otherComplaintAgency + 
                ", otherComplaintWho=" + otherComplaintWho + 
                ", otherComplaintWhoMore=" + otherComplaintWhoMore + 
                ", otherComplaintMode=" + otherComplaintMode + 
                ", otherComplaintModeMore=" + otherComplaintModeMore + 
                ", otherComplaintDetails=" + otherComplaintDetails + 
                ", otherComplaintRemark=" + otherComplaintRemark + ']';
    }    
    
}
