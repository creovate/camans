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
    /*
     * Creates new verbal assurance object with id
     * @param id identifier of vebal assurance
     * @param worker fin number of worker given assurance
     * @param job key of verbal assurance
     * @param name of verbal assurance
     * @param relationship of verbal assurance
     * @param when verbal assurance is given
     * @param where verbal assurance is given
     * @param content of verbal assurance
     */
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
    /*
     * Creates new verbal assurance object without id
     * @param worker fin number of worker given assurance
     * @param job key of verbal assurance
     * @param name of verbal assurance
     * @param relationship of verbal assurance
     * @param when verbal assurance is given
     * @param where verbal assurance is given
     * @param content of verbal assurance
     */
    public JobVerbalAssurance(String workerFinNum, int jobKey, String verbalName, String VerbalRelationship, String when, String where, String content) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.verbalName = verbalName;
        this.VerbalRelationship = VerbalRelationship;
        this.when = when;
        this.where = where;
        this.content = content;
    }
    
    /**
     * getter method for id for verbal assurance
     * @return id of verbal assurance
     */
    public int getId() {
        return id;
    }
    /**
     * setter method for id for verbal assurance
     * @param id 
     * sets current id of verbal assurance to new id
     */
    public void setId(int id) {
        this.id = id;
    }
    /**
     * getter method for name for verbal assurance
     * @return name of verbal assurance
     */
    public String getVerbalName() {
        return verbalName;
    }
    /**
     * setter method for name for verbal assurance
     * @param verbalName
     * sets current name of verbal assurance to new name
     */
    public void setVerbalName(String verbalName) {
        this.verbalName = verbalName;
    }
    /**
     * getter method for relationship for verbal assurance
     * @return relationship of verbal assurance
     */
    public String getVerbalRelationship() {
        return VerbalRelationship;
    }
    /**
     * setter method for relationship for verbal assurance
     * @param verbalRelationship
     * sets current relationship of verbal assurance to new relationship
     */
    public void setVerbalRelationship(String VerbalRelationship) {
        this.VerbalRelationship = VerbalRelationship;
    }
    /**
     * getter method for when verbal assurance is given
     * @return when verbal assurance is given
     */
    public String getWhen() {
        return when;
    }
    /**
     * setter method for when verbal assurance is given
     * @param when
     * sets current when verbal assurance is given to new when verbal assurance is given
     */
    public void setWhen(String when) {
        this.when = when;
    }
    /**
     * getter method for where verbal assurance is given
     * @return where verbal assurance is given
     */
    public String getWhere() {
        return where;
    }
    /**
     * setter method for where verbal assurance is given
     * @param where
     * sets current where verbal assurance is given to new where verbal assurance is given
     */
    public void setWhere(String where) {
        this.where = where;
    }
    /**
     * getter method for content for verbal assurance
     * @return content of verbal assurance
     */
    public String getContent() {
        return content;
    }
    /**
     * setter method for content for verbal assurance
     * @param content
     * sets current content of verbal assurance to new content
     */
    public void setContent(String content) {
        this.content = content;
    }
    /**
     * getter method for worker fin number for verbal assurance
     * @return worker fin number of verbal assurance
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }
    /**
     * setter method for worker fin number for verbal assurance
     * @param workerFinNumb
     * sets current worker fin number of verbal assurance to new worker fin number
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }
    /**
     * getter method for job key for verbal assurance
     * @return job key of verbal assurance
     */
    public int getJobKey() {
        return jobKey;
    }
    /**
     * setter method for job key for verbal assurance
     * @param jobKey
     * sets current job key of verbal assurance to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }

    @Override
    /*
     * toString method for details of verbal assurance with id
     * @return details of verbal assurance with id
     */
    public String toString() {
        return "JobVerbalAssurance{" + "id=" + id + ", workerFinNum=" + workerFinNum + 
                ", jobKey=" + jobKey + ", verbalName=" + verbalName + 
                ", VerbalRelationship=" + VerbalRelationship + ", when=" + when + ", where=" + where + 
                ", content=" + content + '}';
    }
    /*
     * toString method for details of verbal assurance without id
     * @return details of verbal assurance without id
     */
    public String toString2() {
        return "Verbal Assurance [verbalName=" + verbalName + 
                ", VerbalRelationship=" + VerbalRelationship + ", when=" + when + ", where=" + where + 
                ", content=" + content + ']';
    }
    
            
}
