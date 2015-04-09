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
public class WorkerHomeCountryPhNum {
    
    //attributes
    private String workerFinNum;
    private int id;
    private String phNumber;
    private String phOwner;
    private Date obseleteDate;

    /**
     *
     * @param workerFinNum FIN
     * @param id id
     * @param phNumber phone number
     * @param phOwner phone owner
     * @param obseleteDate obsolete date
     */
    public WorkerHomeCountryPhNum(String workerFinNum, int id, String phNumber, String phOwner, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.phNumber = phNumber;
        this.phOwner = phOwner;
        this.obseleteDate = obseleteDate;
    }

    /**
     *
     * @param workerFinNum FIN
     * @param phNumber phone number
     * @param phOwner phone owner
     * @param obseleteDate obsolete date
     */
    public WorkerHomeCountryPhNum(String workerFinNum, String phNumber, String phOwner, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.phNumber = phNumber;
        this.phOwner = phOwner;
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
     * return phone number
     * @return phone number
     */
    public String getPhNumber() {
        return phNumber;
    }

    /**
     * set phone number
     * @param phNumber phone number
     */
    public void setPhNumber(String phNumber) {
        this.phNumber = phNumber;
    }

    /**
     * return phone owner
     * @return phone owner
     */
    public String getPhOwner() {
        return phOwner;
    }

    /**
     * set phone owner
     * @param phOwner phone owner
     */
    public void setPhOwner(String phOwner) {
        this.phOwner = phOwner;
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
        return "WorkerHomeCountryPhNum{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", phNumber=" + phNumber + ", phOwner=" + phOwner + ", obseleteDate=" + obseleteDate + '}';
    }
    
   
    public String toString2() {
        if (obseleteDate == null) {
            return "Home Country PhNum [phNumber=" + phNumber + ", phOwner=" + phOwner + "]";
        }
        return "WorkerHomeCountryPhNum [phNumber=" + phNumber + ", phOwner=" + phOwner + ", obseleteDate=" + obseleteDate + ']';
    }    
}
