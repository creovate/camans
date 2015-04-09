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

    /**
     *
     * @param workerFinNum FIN
     * @param id id
     * @param phNumber phone number
     * @param obseleteDate obsolete date
     */
    public WorkerSgPhNum(String workerFinNum, int id, String phNumber, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.phNumber = phNumber;
        this.obseleteDate = obseleteDate;
    }

    /**
     *
     * @param workerFinNum FIN
     * @param phNumber phone number
     * @param obseleteDate obsolete date
     */
    public WorkerSgPhNum(String workerFinNum, String phNumber,Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.phNumber = phNumber;
        this.obseleteDate = obseleteDate;
    }

    /**
     * return FIN
     * @return  FIN
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
     *return phone number
     * @return phone number
     */
    public String getPhNumber() {
        return phNumber;
    }

    /**
     *set phone number
     * @param phNumber phone number
     */
    public void setPhNumber(String phNumber) {
        this.phNumber = phNumber;
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

    @Override
    public String toString() {
        return "WorkerSgPhNum{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", phNumber=" + phNumber + ", obseleteDate=" + obseleteDate + '}';
    }
    
   
    public String toString2() {
        if (obseleteDate == null) {
            return "Singapore PhNum [phNumber=" + phNumber + "]";
        }
        return "Singapore PhNum [phNumber=" + phNumber + ", obseleteDate=" + obseleteDate + ']';
    }    
    
}
