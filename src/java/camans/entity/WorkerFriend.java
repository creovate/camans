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

    public WorkerFriend(String workerFinNum, int id, String name, String phone, String relation, String remark, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.relation = relation;
        this.remark = remark;
        this.obseleteDate = obseleteDate;
    }

    public WorkerFriend(String workerFinNum, String name, String phone, String relation, String remark, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.name = name;
        this.phone = phone;
        this.relation = relation;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRelation() {
        return relation;
    }

    public void setRelation(String relation) {
        this.relation = relation;
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
