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
public class WorkerFamilyMember {
    
    //attributes
    private String workerFinNum;
    private int id;
    private String name;
    private String relation;
    private String address;
    private String phoneNumber;
    private String digital;
    private String remark;
    private Date obseleteDate;

    public WorkerFamilyMember(String workerFinNum, int id, String name, String relation, String address, String phoneNumber, String digital, String remark, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.name = name;
        this.relation = relation;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.digital = digital;
        this.remark = remark;
        this.obseleteDate = obseleteDate;
    }

    public WorkerFamilyMember(String workerFinNum, String name, String relation, String address, String phoneNumber, String digital, String remark, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.name = name;
        this.relation = relation;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.digital = digital;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRelation() {
        return relation;
    }

    public void setRelation(String relation) {
        this.relation = relation;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getDigital() {
        return digital;
    }

    public void setDigital(String digital) {
        this.digital = digital;
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
        return "WorkerFamilyMember{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", name=" + name + ", relation=" + relation + ", address=" + address + ", phoneNumber=" + phoneNumber + ", digital=" + digital + ", remark=" + remark + ", obseleteDate=" + obseleteDate + '}';
    }

    
}
