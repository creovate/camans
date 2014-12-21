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

    public WorkerHomeCountryAddress(String workerFinNum, int id, String address, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.address = address;
        this.obseleteDate = obseleteDate;
    }

    public WorkerHomeCountryAddress(String workerFinNum, String address, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.address = address;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getObseleteDate() {
        return obseleteDate;
    }

    public void setObseleteDate(Date obseleteDate) {
        this.obseleteDate = obseleteDate;
    }

    @Override
    public String toString() {
        return "WorkerHomeCountryAddress{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", address=" + address + ", obseleteDate=" + obseleteDate + '}';
    }
    
    
}