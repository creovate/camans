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
public class WorkerNextOfKin {
    
    //attributes
    private String workerFinNum;
    private int id;
    private String name;
    private String relation;
    private String document;
    private String phoneNumber;
    private String digital;
    private String address;
    private String proof;
    private String remark;
    private Date obseleteDate;

    public WorkerNextOfKin(String workerFinNum, int id, String name, String relation, 
            String document, String phoneNumber, String digital, String address, String proof, 
            String remark, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.name = name;
        this.relation = relation;
        this.document = document;
        this.phoneNumber = phoneNumber;
        this.digital = digital;
        this.address = address;
        this.proof = proof;
        this.remark = remark;
        this.obseleteDate = obseleteDate;
    }

    public WorkerNextOfKin(String workerFinNum, String name, String relation, 
            String document, String phoneNumber, String digital, String address, String proof,
            String remark, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.name = name;
        this.relation = relation;
        this.document = document;
        this.phoneNumber = phoneNumber;
        this.digital = digital;
        this.address = address;
        this.proof = proof;
        this.remark = remark;
        this.obseleteDate = obseleteDate;
    }

    public String getWorkerFinNum() {
        return workerFinNum;
    }

    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }

    public String getProof() {
        return proof;
    }

    public void setProof(String proof) {
        this.proof = proof;
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

    public String getDocument() {
        return document;
    }

    public void setDocument(String document) {
        this.document = document;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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

    public String getDigital() {
        return digital;
    }

    public void setDigital(String digital) {
        this.digital = digital;
    }

    @Override
    public String toString() {
        return "WorkerNextOfKin{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", name=" + name + ", relation=" + relation + ", document=" + document + ", phoneNumber=" + phoneNumber + ", digital=" + digital + ", address=" + address + ", proof=" + proof + ", remark=" + remark + ", obseleteDate=" + obseleteDate + '}';
    }    
    
    
}
