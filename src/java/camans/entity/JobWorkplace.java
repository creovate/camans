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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getWorkplaceType() {
        return workplaceType;
    }

    public void setWorkplaceType(String workplaceType) {
        this.workplaceType = workplaceType;
    }

    public String getWorkplaceTypeMore() {
        return workplaceTypeMore;
    }

    public void setWorkplaceTypeMore(String workplaceTypeMore) {
        this.workplaceTypeMore = workplaceTypeMore;
    }

    public String getWorkplaceWhose() {
        return workplaceWhose;
    }

    public void setWorkplaceWhose(String workplaceWhose) {
        this.workplaceWhose = workplaceWhose;
    }

    public String getWorkpladePersons() {
        return workpladePersons;
    }

    public void setWorkpladePersons(String workpladePersons) {
        this.workpladePersons = workpladePersons;
    }

    public String getWorkplaceEmployerRelationship() {
        return workplaceEmployerRelationship;
    }

    public void setWorkplaceEmployerRelationship(String workplaceEmployerRelationship) {
        this.workplaceEmployerRelationship = workplaceEmployerRelationship;
    }

    public String getWorkplaceDirect() {
        return workplaceDirect;
    }

    public void setWorkplaceDirect(String workplaceDirect) {
        this.workplaceDirect = workplaceDirect;
    }

    public String getWorkplaceDirectMore() {
        return workplaceDirectMore;
    }

    public void setWorkplaceDirectMore(String workplaceDirectMore) {
        this.workplaceDirectMore = workplaceDirectMore;
    }

    public String getWorkplaceStart() {
        return workplaceStart;
    }

    public void setWorkplaceStart(String workplaceStart) {
        this.workplaceStart = workplaceStart;
    }

    public String getWorkplaceEnd() {
        return workplaceEnd;
    }

    public void setWorkplaceEnd(String workplaceEnd) {
        this.workplaceEnd = workplaceEnd;
    }

    public String getWorkplaceCondition() {
        return workplaceCondition;
    }

    public void setWorkplaceCondition(String workplaceCondition) {
        this.workplaceCondition = workplaceCondition;
    }

    public String getWorkplaceSafety() {
        return workplaceSafety;
    }

    public void setWorkplaceSafety(String workplaceSafety) {
        this.workplaceSafety = workplaceSafety;
    }

    public String getWorkplaceRemarks() {
        return workplaceRemarks;
    }

    public void setWorkplaceRemarks(String workplaceRemarks) {
        this.workplaceRemarks = workplaceRemarks;
    }

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
