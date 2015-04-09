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
public class WorkerDigitalContact {
    
    //attributes
    private String workerFinNum;
    private int id;
    private String contactType;
    private String contactTypeMore;
    private String contactInfo;
    private String owner;
    private String remark;
    private Date obseleteDate;

    /**
     *
     * @param workerFinNum FIN
     * @param id id
     * @param contactType contact type
     * @param contactTypeMore more contact type
     * @param contactInfo contact information
     * @param owner owner
     * @param remark remark
     * @param obseleteDate obsolete date
     */
    public WorkerDigitalContact(String workerFinNum, int id, String contactType, String contactTypeMore, String contactInfo, String owner, String remark, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.contactType = contactType;
        this.contactTypeMore = contactTypeMore;
        this.contactInfo = contactInfo;
        this.owner = owner;
        this.remark = remark;
        this.obseleteDate = obseleteDate;
    }

    /**
     *
     * @param workerFinNum FIN
     * @param contactType contact type
     * @param contactTypeMore more contact type
     * @param contactInfo contact information
     * @param owner owner
     * @param remark remark
     * @param obseleteDate obsolete date
     */
    public WorkerDigitalContact(String workerFinNum, String contactType, String contactTypeMore, String contactInfo, String owner, String remark, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.contactType = contactType;
        this.contactTypeMore = contactTypeMore;
        this.contactInfo = contactInfo;
        this.owner = owner;
        this.remark = remark;
        this.obseleteDate = obseleteDate;
    }

    /**
     * return FIN
     * @return FIN
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }

    /**
     * set FIN
     * @param workerFinNum FIN
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }

    /**
     * return id
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
     * return contact type
     * @return contact type
     */
    public String getContactType() {
        return contactType;
    }

    /**
     * set contact type
     * @param contactType contact type
     */
    public void setContactType(String contactType) {
        this.contactType = contactType;
    }

    /**
     * return more contact type
     * @return more contact type
     */
    public String getContactTypeMore() {
        return contactTypeMore;
    }

    /**
     * set more contact type
     * @param contactTypeMore more contact type
     */
    public void setContactTypeMore(String contactTypeMore) {
        this.contactTypeMore = contactTypeMore;
    }

    /**
     * return contact information
     * @return contact information
     */
    public String getContactInfo() {
        return contactInfo;
    }

    /**
     * set contact information
     * @param contactInfo contact information
     */
    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo;
    }

    /**
     * return owner
     * @return owner
     */
    public String getOwner() {
        return owner;
    }

    /**
     * set owner
     * @param owner owner
     */
    public void setOwner(String owner) {
        this.owner = owner;
    }

    /**
     * return remark
     * @return remark
     */
    public String getRemark() {
        return remark;
    }

    /**
     * set remark
     * @param remark remark
     */
    public void setRemark(String remark) {
        this.remark = remark;
    }

    /**
     * return obsolete date
     * @return obsolete date
     */
    public Date getObseleteDate() {
        return obseleteDate;
    }

    /**
     * set obsolete date
     * @param obseleteDate obsolete date
     */
    public void setObseleteDate(Date obseleteDate) {
        this.obseleteDate = obseleteDate;
    }

    @Override
    public String toString() {
        return "WorkerDigitalContact{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", contactType=" + contactType + ", contactTypeMore=" + contactTypeMore + ", contactInfo=" + contactInfo + ", owner=" + owner + ", remark=" + remark + ", obseleteDate=" + obseleteDate + '}';
    }
    
    
    public String toString2() {
        if (obseleteDate == null) {
            return "Digital Contact [contactType=" + contactType + ", contactTypeMore=" + contactTypeMore + ", contactInfo=" + contactInfo + ", owner=" + owner + ", remark=" + remark + ']';
        }
        return "Digital Contact [contactType=" + contactType + ", contactTypeMore=" + contactTypeMore + ", contactInfo=" + contactInfo + ", owner=" + owner + ", remark=" + remark + ", obseleteDate=" + obseleteDate + ']';
    }
    
}
