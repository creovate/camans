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
public class JobWorkplace {
    
    //attributes
    
    private int id;
    private String workerFinNum;
    private int jobKey;
    private String workplaceType;
    private String workplaceTypeMore;
    private String workplaceWhose;
    private String workpladePersons;
    private String workplaceEmployerRelationship;
    private String workplaceDirect;
    private String workplaceDirectMore;
    private String workplaceStart;
    private String workplaceEnd;
    private String workplaceCondition;
    private String workplaceSafety;
    private String workplaceRemarks;
    /*
     * Creates new workplace object with id
     * @param id identifier of workplace
     * @param worker fin number of workplace
     * @param job key of work place
     * @param type of workplace
     * @param more info of type of workplace
     * @param whose workplace it is
     * @param persons of workplace
     * @param employer relationship of workplace
     * @param direct workplace
     * @param more info of direct workplace
     * @param start of workplace
     * @param end of workplace
     * @param condition of workplace
     * @param safety of workplace
     * @param remarks for workplace
     */
    public JobWorkplace(int id, String workerFinNum, int jobKey, String workplaceType, String workplaceTypeMore, String workplaceWhose, String workpladePersons, String workplaceEmployerRelationship, String workplaceDirect, String workplaceDirectMore, String workplaceStart, String workplaceEnd, String workplaceCondition, String workplaceSafety, String workplaceRemarks) {
        this.id = id;
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.workplaceType = workplaceType;
        this.workplaceTypeMore = workplaceTypeMore;
        this.workplaceWhose = workplaceWhose;
        this.workpladePersons = workpladePersons;
        this.workplaceEmployerRelationship = workplaceEmployerRelationship;
        this.workplaceDirect = workplaceDirect;
        this.workplaceDirectMore = workplaceDirectMore;
        this.workplaceStart = workplaceStart;
        this.workplaceEnd = workplaceEnd;
        this.workplaceCondition = workplaceCondition;
        this.workplaceSafety = workplaceSafety;
        this.workplaceRemarks = workplaceRemarks;
    }
    /*
     * Creates new workplace object without id
     * @param worker fin number of workplace
     * @param job key of work place
     * @param type of workplace
     * @param more info of type of workplace
     * @param whose workplace it is
     * @param persons of workplace
     * @param employer relationship of workplace
     * @param direct workplace
     * @param more info of direct workplace
     * @param start of workplace
     * @param end of workplace
     * @param condition of workplace
     * @param safety of workplace
     * @param remarks for workplace
     */
    public JobWorkplace(String workerFinNum, int jobKey, String workplaceType, String workplaceTypeMore, String workplaceWhose, String workpladePersons, String workplaceEmployerRelationship, String workplaceDirect, String workplaceDirectMore, String workplaceStart, String workplaceEnd, String workplaceCondition, String workplaceSafety, String workplaceRemarks) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.workplaceType = workplaceType;
        this.workplaceTypeMore = workplaceTypeMore;
        this.workplaceWhose = workplaceWhose;
        this.workpladePersons = workpladePersons;
        this.workplaceEmployerRelationship = workplaceEmployerRelationship;
        this.workplaceDirect = workplaceDirect;
        this.workplaceDirectMore = workplaceDirectMore;
        this.workplaceStart = workplaceStart;
        this.workplaceEnd = workplaceEnd;
        this.workplaceCondition = workplaceCondition;
        this.workplaceSafety = workplaceSafety;
        this.workplaceRemarks = workplaceRemarks;
    }

    /**
     * getter method for id for workplace
     * @return id of workplace
     */
    public int getId() {
        return id;
    }
    /**
     * setter method for id of workplace
     * @param id 
     * sets current id of workplace to new id
     */
    public void setId(int id) {
        this.id = id;
    }
    /**
     * getter method for worker fin number for workplace
     * @return worker fin number of workplace
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }
    /**
     * setter method for work fin number of workplace
     * @param workerFinNum 
     * sets current worker fin number of workplace to new worker fin number
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }
    /**
     * getter method for job key for workplace
     * @return job key of workplace
     */
    public int getJobKey() {
        return jobKey;
    }
    /**
     * setter method for job key of workplace
     * @param jobKey
     * sets current job key of workplace to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }
    /**
     * getter method for type for workplace
     * @return type of workplace
     */
    public String getWorkplaceType() {
        return workplaceType;
    }
    /**
     * setter method for type of workplace
     * @param workplaceType
     * sets current type of workplace to new type
     */
    public void setWorkplaceType(String workplaceType) {
        this.workplaceType = workplaceType;
    }
    /**
     * getter method for more info of type for workplace
     * @return more info of type of workplace
     */
    public String getWorkplaceTypeMore() {
        return workplaceTypeMore;
    }
    /**
     * setter method for more info of type of workplace
     * @param workplaceTypeMore 
     * sets current more info of type of workplace to new more info of type
     */
    public void setWorkplaceTypeMore(String workplaceTypeMore) {
        this.workplaceTypeMore = workplaceTypeMore;
    }
    /**
     * getter method for whose workplace
     * @return whose workplace
     */
    public String getWorkplaceWhose() {
        return workplaceWhose;
    }
    /**
     * setter method for whose workplace
     * @param workplaceWhose
     * sets current whose workplace to new whose workplace
     */
    public void setWorkplaceWhose(String workplaceWhose) {
        this.workplaceWhose = workplaceWhose;
    }
    /**
     * getter method for persons for workplace
     * @return persons of workplace
     */
    public String getWorkpladePersons() {
        return workpladePersons;
    }
    /**
     * setter method for persons of workplace
     * @param persons
     * sets current persons of workplace to new persons
     */
    public void setWorkpladePersons(String workpladePersons) {
        this.workpladePersons = workpladePersons;
    }
    /**
     * getter method for employer relationship for workplace
     * @return employer relationship of workplace
     */
    public String getWorkplaceEmployerRelationship() {
        return workplaceEmployerRelationship;
    }
    /**
     * setter method for employer relationship of workplace
     * @param workplaceEmployerRelationship 
     * sets current employer relationship of workplace to new employer relationship
     */
    public void setWorkplaceEmployerRelationship(String workplaceEmployerRelationship) {
        this.workplaceEmployerRelationship = workplaceEmployerRelationship;
    }
    /**
     * getter method for direct workplace
     * @return direct workplace
     */
    public String getWorkplaceDirect() {
        return workplaceDirect;
    }
    /**
     * setter method for direct workplace
     * @param workplaceDirect 
     * sets current direct workplace to new direct workplace
     */
    public void setWorkplaceDirect(String workplaceDirect) {
        this.workplaceDirect = workplaceDirect;
    }
    /**
     * getter method for more info of direct workplace
     * @return more info of direct workplace
     */
    public String getWorkplaceDirectMore() {
        return workplaceDirectMore;
    }
    /**
     * setter method for more info of direct workplace
     * @param workplaceDirectMore
     * sets current more info of direct workplace to new more info of direct workplace
     */
    public void setWorkplaceDirectMore(String workplaceDirectMore) {
        this.workplaceDirectMore = workplaceDirectMore;
    }
    /**
     * getter method for start for workplace
     * @return start of workplace
     */
    public String getWorkplaceStart() {
        return workplaceStart;
    }
    /**
     * setter method for start of workplace
     * @param workplaceStart
     * sets current start of workplace to new start
     */
    public void setWorkplaceStart(String workplaceStart) {
        this.workplaceStart = workplaceStart;
    }
    /**
     * getter method for end for workplace
     * @return end of workplace
     */
    public String getWorkplaceEnd() {
        return workplaceEnd;
    }
    /**
     * setter method for end of workplace
     * @param workplaceEnd
     * sets current end of workplace to new end
     */
    public void setWorkplaceEnd(String workplaceEnd) {
        this.workplaceEnd = workplaceEnd;
    }
    /**
     * getter method for condition for workplace
     * @return condition of workplace
     */
    public String getWorkplaceCondition() {
        return workplaceCondition;
    }
    /**
     * setter method for condition of workplace
     * @param workplaceCondition 
     * sets current condition of workplace to new condition
     */
    public void setWorkplaceCondition(String workplaceCondition) {
        this.workplaceCondition = workplaceCondition;
    }
    /**
     * getter method for safety for workplace
     * @return safety of workplace
     */
    public String getWorkplaceSafety() {
        return workplaceSafety;
    }
    /**
     * setter method for safety of workplace
     * @param workplaceSafety 
     * sets current safety of workplace to new safety
     */
    public void setWorkplaceSafety(String workplaceSafety) {
        this.workplaceSafety = workplaceSafety;
    }
    /**
     * getter method for remarks for workplace
     * @return remarks of workplace
     */
    public String getWorkplaceRemarks() {
        return workplaceRemarks;
    }
    /**
     * setter method for remarks of workplace
     * @param workplaceRemarks
     * sets current remarks of workplace to new remarks
     */
    public void setWorkplaceRemarks(String workplaceRemarks) {
        this.workplaceRemarks = workplaceRemarks;
    }
    /*
     * toString method for workplace details with id
     * @return workplace details with id
     */
    @Override
    public String toString() {
        return "JobWorkplace{" + "id=" + id + ", workerFinNum=" + workerFinNum + ", jobKey=" + jobKey + 
                ", workplaceType=" + workplaceType + ", workplaceTypeMore=" + workplaceTypeMore + 
                ", workplaceWhose=" + workplaceWhose + ", workpladePersons=" + workpladePersons + 
                ", workplaceEmployerRelationship=" + workplaceEmployerRelationship + 
                ", workplaceDirect=" + workplaceDirect + ", workplaceDirectMore=" + workplaceDirectMore + 
                ", workplaceStart=" + workplaceStart + ", workplaceEnd=" + workplaceEnd + 
                ", workplaceCondition=" + workplaceCondition + ", workplaceSafety=" + workplaceSafety + 
                ", workplaceRemarks=" + workplaceRemarks + '}';
    }
    /*
     * toString method for work place details without id
     * @return workplace details without id
     */
    public String toString2() {
        return "Workplace [workplaceType=" + workplaceType + 
                ", workplaceTypeMore=" + workplaceTypeMore + ", workplaceWhose=" + workplaceWhose + 
                ", workpladePersons=" + workpladePersons + 
                ", workplaceEmployerRelationship=" + workplaceEmployerRelationship + 
                ", workplaceDirect=" + workplaceDirect + ", workplaceDirectMore=" + workplaceDirectMore + 
                ", workplaceStart=" + workplaceStart + ", workplaceEnd=" + workplaceEnd + 
                ", workplaceCondition=" + workplaceCondition + ", workplaceSafety=" + workplaceSafety + 
                ", workplaceRemarks=" + workplaceRemarks + ']';
    }
    
}
