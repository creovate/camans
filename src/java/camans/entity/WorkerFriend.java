/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

import java.sql.Date;

/**
 *
 * @author soeemyatmyat
 */
public class WorkerFriend {
    
    //attributes
    private String workerFinNum;
    private int id;
    private String name;
    private String phone;
    private String relation;
    private String remark;
    private Date obseleteDate;

    /**
     *
     * @param workerFinNum FIN
     * @param id id
     * @param name name
     * @param phone phone
     * @param relation relation
     * @param remark remark
     * @param obseleteDate obsolete Date
     */
    public WorkerFriend(String workerFinNum, int id, String name, String phone, String relation, String remark, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.relation = relation;
        this.remark = remark;
        this.obseleteDate = obseleteDate;
    }

    /**
     *
     * @param workerFinNum FIN
    * @param name name
     * @param phone phone
     * @param relation relation
     * @param remark remark
     * @param obseleteDate obsolete Date
     */
    public WorkerFriend(String workerFinNum, String name, String phone, String relation, String remark, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.name = name;
        this.phone = phone;
        this.relation = relation;
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
     * return name
     * @return name
     */
    public String getName() {
        return name;
    }

    /**
     * set name
     * @param name name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * return phone
     * @return phone
     */
    public String getPhone() {
        return phone;
    }

    /**
     * set phone
     * @param phone phone
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * return relation
     * @return relation
     */
    public String getRelation() {
        return relation;
    }

    /**
     * set relation
     * @param relation relation
     */
    public void setRelation(String relation) {
        this.relation = relation;
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
        return "WorkerFriend{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", name=" + name + ", phone=" + phone + ", relation=" + relation + ", remark=" + remark + ", obseleteDate=" + obseleteDate + '}';
    }
 
  
    public String toString2() {
        if (obseleteDate == null) {
            return "WorkerFriend [name=" + name + ", phone=" + phone + ", relation=" + relation + 
                ", remark=" + remark + ']';
        }
        return "WorkerFriend [name=" + name + ", phone=" + phone + ", relation=" + relation + 
                ", remark=" + remark + ", obseleteDate=" + obseleteDate + ']';
    }    
    
}
