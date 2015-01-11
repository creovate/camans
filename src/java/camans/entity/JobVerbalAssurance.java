package camans.entity;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author soemyatmyat
 */
public class JobVerbalAssurance {
    
    //Attributes
    
    private int id;
    private String workerFinNum;
    private int jobKey;
    private String verbalName;
    private String VerbalRelationship;
    private String when;
    private String where;
    private String content;

    public JobVerbalAssurance(int id, String workerFinNum, int jobKey, String verbalName, String VerbalRelationship, String when, String where, String content) {
        this.id = id;
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.verbalName = verbalName;
        this.VerbalRelationship = VerbalRelationship;
        this.when = when;
        this.where = where;
        this.content = content;
    }

    public JobVerbalAssurance(String workerFinNum, int jobKey, String verbalName, String VerbalRelationship, String when, String where, String content) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.verbalName = verbalName;
        this.VerbalRelationship = VerbalRelationship;
        this.when = when;
        this.where = where;
        this.content = content;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getVerbalName() {
        return verbalName;
    }

    public void setVerbalName(String verbalName) {
        this.verbalName = verbalName;
    }

    public String getVerbalRelationship() {
        return VerbalRelationship;
    }

    public void setVerbalRelationship(String VerbalRelationship) {
        this.VerbalRelationship = VerbalRelationship;
    }

    public String getWhen() {
        return when;
    }

    public void setWhen(String when) {
        this.when = when;
    }

    public String getWhere() {
        return where;
    }

    public void setWhere(String where) {
        this.where = where;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getWorkerFinNum() {
        return workerFinNum;
    }

    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }

    public int getJobKey() {
        return jobKey;
    }

    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }

    @Override
    public String toString() {
        return "JobVerbalAssurance{" + "id=" + id + ", workerFinNum=" + workerFinNum + 
                ", jobKey=" + jobKey + ", verbalName=" + verbalName + 
                ", VerbalRelationship=" + VerbalRelationship + ", when=" + when + ", where=" + where + 
                ", content=" + content + '}';
    }
    
    public String toString2() {
        return "JobVerbalAssurance{" + "WorkerFinNum=" + workerFinNum + ", verbalName=" + verbalName + 
                ", VerbalRelationship=" + VerbalRelationship + ", when=" + when + ", where=" + where + 
                ", content=" + content + '}';
    }
    
            
}
