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

    public WorkerDigitalContact(String workerFinNum, String contactType, String contactTypeMore, String contactInfo, String owner, String remark, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.contactType = contactType;
        this.contactTypeMore = contactTypeMore;
        this.contactInfo = contactInfo;
        this.owner = owner;
        this.remark = remark;
        this.obseleteDate = obseleteDate;
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

    public String getContactType() {
        return contactType;
    }

    public void setContactType(String contactType) {
        this.contactType = contactType;
    }

    public String getContactTypeMore() {
        return contactTypeMore;
    }

    public void setContactTypeMore(String contactTypeMore) {
        this.contactTypeMore = contactTypeMore;
    }

    public String getContactInfo() {
        return contactInfo;
    }

    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Date getObseleteDate() {
        return obseleteDate;
    }

    public void setObseleteDate(Date obseleteDate) {
        this.obseleteDate = obseleteDate;
    }

    @Override
    public String toString() {
        return "WorkerDigitalContact{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", contactType=" + contactType + ", contactTypeMore=" + contactTypeMore + ", contactInfo=" + contactInfo + ", owner=" + owner + ", remark=" + remark + ", obseleteDate=" + obseleteDate + '}';
    }
    
    public String toString2() {
        return "WorkerDigitalContact{" + "workerFinNum=" + workerFinNum + ", contactType=" + contactType + ", contactTypeMore=" + contactTypeMore + ", contactInfo=" + contactInfo + ", owner=" + owner + ", remark=" + remark + ", obseleteDate=" + obseleteDate + '}';
    }
    
}
