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
public class WorkerHomeCountryAddress {
    
    
    //attributes
    private String workerFinNum;
    private int id;
    private String address;
    private Date obseleteDate;

    /**
     *
     * @param workerFinNum FIN
     * @param id id
     * @param address address
     * @param obseleteDate obsolete date
     */
    public WorkerHomeCountryAddress(String workerFinNum, int id, String address, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.address = address;
        this.obseleteDate = obseleteDate;
    }

    /**
     *
     * @param workerFinNum FIN
    * @param address address
     * @param obseleteDate obsolete date
     */
    public WorkerHomeCountryAddress(String workerFinNum, String address, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.address = address;
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
     * return address
     * @return address
     */
    public String getAddress() {
        return address;
    }

    /**
     * set address
     * @param address address
     */
    public void setAddress(String address) {
        this.address = address;
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
        return "WorkerHomeCountryAddress{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", address=" + address + ", obseleteDate=" + obseleteDate + '}';
    }
    
   
    public String toString2() {
        if (obseleteDate == null) {
           return "Home Country Address [address=" + address + ']'; 
        }
        return "Home Country Address [address=" + address + ", obseleteDate=" + obseleteDate + ']';
    }   
    
}
