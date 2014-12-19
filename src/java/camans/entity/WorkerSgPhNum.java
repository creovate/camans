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
public class WorkerSgPhNum {
   
    //attributes
    private String workerFinNum;
    private int id;
    private String phNumber;
    private Date obseleteDate;

    public WorkerSgPhNum(String workerFinNum, int id, String phNumber, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.phNumber = phNumber;
        this.obseleteDate = obseleteDate;
    }

    public WorkerSgPhNum(String workerFinNum, String phNumber,Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.phNumber = phNumber;
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

    public String getPhNumber() {
        return phNumber;
    }

    public void setPhNumber(String phNumber) {
        this.phNumber = phNumber;
    }


    public Date getObseleteDate() {
        return obseleteDate;
    }

    public void setObseleteDate(Date obseleteDate) {
        this.obseleteDate = obseleteDate;
    }

    @Override
    public String toString() {
        return "WorkerSgPhNum{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", phNumber=" + phNumber + ", obseleteDate=" + obseleteDate + '}';
    }
    
    
    
}
