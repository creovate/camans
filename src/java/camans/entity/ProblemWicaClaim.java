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
public class ProblemWicaClaim {
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problmeKey;
    private Date wicaClaimDate;
    private String wicaReferenceNumber;
    private String wicaInsurer;
    private String wicaPolicyNumber;
    private String wicaClaimReason;
    private String wicaClaimRemark;

    //constructor with id

    /**
     *
     * @param id id
     * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problmeKey problem key
     * @param wicaClaimDate wica claim date
     * @param wicaReferenceNumber wica claim reference number
     * @param wicaInsurer wica insurer
     * @param wicaPolicyNumber wica policy number
     * @param wicaClaimReason reason of wica claim
     * @param wicaClaimRemark remark of wica claim
     */
        public ProblemWicaClaim(int id, String workerFinNumber, int jobKey, int problmeKey, Date wicaClaimDate, String wicaReferenceNumber, String wicaInsurer, String wicaPolicyNumber, String wicaClaimReason, String wicaClaimRemark) {
            this.id = id;
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problmeKey = problmeKey;
            this.wicaClaimDate = wicaClaimDate;
            this.wicaReferenceNumber = wicaReferenceNumber;
            this.wicaInsurer = wicaInsurer;
            this.wicaPolicyNumber = wicaPolicyNumber;
            this.wicaClaimReason = wicaClaimReason;
            this.wicaClaimRemark = wicaClaimRemark;
    }

    //constructor without id

    /**
     *
     * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problmeKey problem key
     * @param wicaClaimDate wica claim date
     * @param wicaReferenceNumber wica claim reference number
     * @param wicaInsurer wica insurer
     * @param wicaPolicyNumber wica policy number
     * @param wicaClaimReason reason of wica claim
     * @param wicaClaimRemark remark of wica claim
     */
        public ProblemWicaClaim(String workerFinNumber, int jobKey, int problmeKey, Date wicaClaimDate, String wicaReferenceNumber, String wicaInsurer, String wicaPolicyNumber, String wicaClaimReason, String wicaClaimRemark) {
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problmeKey = problmeKey;
            this.wicaClaimDate = wicaClaimDate;
            this.wicaReferenceNumber = wicaReferenceNumber;
            this.wicaInsurer = wicaInsurer;
            this.wicaPolicyNumber = wicaPolicyNumber;
            this.wicaClaimReason = wicaClaimReason;
            this.wicaClaimRemark = wicaClaimRemark;
    }

    /**
     * return id
     * @return id
     */
    public int getId() {
            return id;
    }

    /**
     * return FIN
     * @return FIN
     */
    public String getWorkerFinNumber() {
            return workerFinNumber;
    }

    /**
     * return job key
     * @return job key
     */
    public int getJobKey() {
            return jobKey;
    }

    /**
     * return problem key
     * @return problem key
     */
    public int getProblmeKey() {
            return problmeKey;
    }

    /**
     * return  wica claim date
     * @return wica claim date
     */
    public Date getWicaClaimDate() {
            return wicaClaimDate;
    }

    /**
     * return  wica reference number
     * @return wica reference number
     */
    public String getWicaReferenceNumber() {
            return wicaReferenceNumber;
    }

    /**
     * return wica insurer
     * @return wica insurer
     */
    public String getWicaInsurer() {
            return wicaInsurer;
    }

    /**
     * return wica policy number
     * @return wica policy number
     */
    public String getWicaPolicyNumber() {
            return wicaPolicyNumber;
    }

    /**
     * return reason of wica claim 
     * @return reason of wica claim 
     */
    public String getWicaClaimReason() {
            return wicaClaimReason;
    }

    /**
     * return remark of wica claim
     * @return remark of wica claim
     */
    public String getWicaClaimRemark() {
            return wicaClaimRemark;
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
     * @param problmeKey problem key
     */
    public void setProblmeKey(int problmeKey) {
            this.problmeKey = problmeKey;
    }

    /**
     * set wica claim date
     * @param wicaClaimDate wica claim date
     */
    public void setWicaClaimDate(Date wicaClaimDate) {
            this.wicaClaimDate = wicaClaimDate;
    }

    /**
     * set wica reference number
     * @param wicaReferenceNumber wica reference number
     */
    public void setWicaReferenceNumber(String wicaReferenceNumber) {
            this.wicaReferenceNumber = wicaReferenceNumber;
    }

    /**
     * set wica insurer
     * @param wicaInsurer wica insurer
     */
    public void setWicaInsurer(String wicaInsurer) {
            this.wicaInsurer = wicaInsurer;
    }

    /**
     * set wica policy number
     * @param wicaPolicyNumber wica policy number
     */
    public void setWicaPolicyNumber(String wicaPolicyNumber) {
            this.wicaPolicyNumber = wicaPolicyNumber;
    }

    /**
     * set reason of wica claim 
     * @param wicaClaimReason reason of wica claim 
     */
    public void setWicaClaimReason(String wicaClaimReason) {
            this.wicaClaimReason = wicaClaimReason;
    }

    /**
     * set remark of wica claim
     * @param wicaClaimRemark remark of wica claim
     */
    public void setWicaClaimRemark(String wicaClaimRemark) {
            this.wicaClaimRemark = wicaClaimRemark;
    }

    @Override
    public String toString() {
        return "ProblemWicaClaim{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problmeKey=" + problmeKey + ", wicaClaimDate=" + wicaClaimDate + 
                ", wicaReferenceNumber=" + wicaReferenceNumber + ", wicaInsurer=" + wicaInsurer + 
                ", wicaPolicyNumber=" + wicaPolicyNumber + ", wicaClaimReason=" + wicaClaimReason + 
                ", wicaClaimRemark=" + wicaClaimRemark + '}';
    }

    /**
     *
     * @return
     */
    public String toString2() {
        return "Wica Claim[wicaClaimDate=" + wicaClaimDate + 
                ", wicaReferenceNumber=" + wicaReferenceNumber + ", wicaInsurer=" + wicaInsurer + 
                ", wicaPolicyNumber=" + wicaPolicyNumber + ", wicaClaimReason=" + wicaClaimReason + 
                ", wicaClaimRemark=" + wicaClaimRemark + ']';
    }    
    
}
