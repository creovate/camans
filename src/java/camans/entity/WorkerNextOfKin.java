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

    /**
     *
     * @param workerFinNum FIN
     * @param id id
     * @param name name
     * @param relation relation
     * @param document document
     * @param phoneNumber phone number
     * @param digital digital
     * @param address address
     * @param proof proof
     * @param remark remark
     * @param obseleteDate obsolete date
     */
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

    /**
     *
     * @param workerFinNum FIN
   * @param name name
     * @param relation relation
     * @param document document
     * @param phoneNumber phone number
     * @param digital digital
     * @param address address
     * @param proof proof
     * @param remark remark
     * @param obseleteDate obsolete date
     */
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

    /**
     * return FIN
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
     *return proof
     * @return proof
     */
    public String getProof() {
        return proof;
    }

    /**
     *set proof
     * @param proof proof
     */
    public void setProof(String proof) {
        this.proof = proof;
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
     *return name
     * @return name
     */
    public String getName() {
        return name;
    }

    /**
     *set name
     * @param name name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     *return relation
     * @return relation
     */
    public String getRelation() {
        return relation;
    }

    /**
     *set relation
     * @param relation relation
     */
    public void setRelation(String relation) {
        this.relation = relation;
    }

    /**
     *return document
     * @return document
     */
    public String getDocument() {
        return document;
    }

    /**
     *set document
     * @param document document
     */
    public void setDocument(String document) {
        this.document = document;
    }

    /**
     *return phone number
     * @return phone number
     */
    public String getPhoneNumber() {
        return phoneNumber;
    }

    /**
     *set phone number
     * @param phoneNumber phone number
     */
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    /**
     *return address
     * @return address
     */
    public String getAddress() {
        return address;
    }

    /**
     *set address
     * @param address address
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     *return remark
     * @return remark
     */
    public String getRemark() {
        return remark;
    }

    /**
     *set remark
     * @param remark remark
     */
    public void setRemark(String remark) {
        this.remark = remark;
    }

    /**
     *return obsolete date
     * @return obsolete date
     */
    public Date getObseleteDate() {
        return obseleteDate;
    }

    /**
     *set obsolete date
     * @param obseleteDate obsolete date
     */
    public void setObseleteDate(Date obseleteDate) {
        this.obseleteDate = obseleteDate;
    }

    /**
     *return digital
     * @return digital
     */
    public String getDigital() {
        return digital;
    }

    /**
     *set digital
     * @param digital digital
     */
    public void setDigital(String digital) {
        this.digital = digital;
    }

    @Override
    public String toString() {
        return "WorkerNextOfKin{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", name=" + name + ", relation=" + relation + ", document=" + document + ", phoneNumber=" + phoneNumber + ", digital=" + digital + ", address=" + address + ", proof=" + proof + ", remark=" + remark + ", obseleteDate=" + obseleteDate + '}';
    }    

    
    public String toString2() {
        if (obseleteDate == null) {
            return "WorkerNextOfKin [name=" + name + ", relation=" + relation + ", document=" + document + 
                ", phoneNumber=" + phoneNumber + ", digital=" + digital + ", address=" + address + 
                ", proof=" + proof + ", remark=" + remark + ']';
        }
        return "WorkerNextOfKin [name=" + name + ", relation=" + relation + ", document=" + document + 
                ", phoneNumber=" + phoneNumber + ", digital=" + digital + ", address=" + address + 
                ", proof=" + proof + ", remark=" + remark + ", obseleteDate=" + obseleteDate + ']';
    }  
    
}
