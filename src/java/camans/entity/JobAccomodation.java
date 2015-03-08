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
public class JobAccomodation {
    //attributes
    
    private int id;
    private String workerFinNum;
    private int jobKey;    
    private String accProvided;
    private String accProvidedMore;
    private String accType;
    private String accTypeMore;
    private String accLocation;
    private String accCondition;
    private double accCharged;
    private double accSelfPaid;
    private String accMeals;
    private String accStart;
    private String accEnd;
    private String accRemarks;

    public JobAccomodation(String workerFinNum, int jobKey, String accProvided, String accProvidedMore, String accType, String accTypeMore, String accLocation, String accCondition, double accCharged, double accSelfPaid, String accMeals, String accStart, String accEnd, String accRemarks) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.accProvided = accProvided;
        this.accProvidedMore = accProvidedMore;
        this.accType = accType;
        this.accTypeMore = accTypeMore;
        this.accLocation = accLocation;
        this.accCondition = accCondition;
        this.accCharged = accCharged;
        this.accSelfPaid = accSelfPaid;
        this.accMeals = accMeals;
        this.accStart = accStart;
        this.accEnd = accEnd;
        this.accRemarks = accRemarks;
    }

    public JobAccomodation(int id, String workerFinNum, int jobKey, String accProvided, String accProvidedMore, String accType, String accTypeMore, String accLocation, String accCondition, double accCharged, double accSelfPaid, String accMeals, String accStart, String accEnd, String accRemarks) {
        this.id = id;
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.accProvided = accProvided;
        this.accProvidedMore = accProvidedMore;
        this.accType = accType;
        this.accTypeMore = accTypeMore;
        this.accLocation = accLocation;
        this.accCondition = accCondition;
        this.accCharged = accCharged;
        this.accSelfPaid = accSelfPaid;
        this.accMeals = accMeals;
        this.accStart = accStart;
        this.accEnd = accEnd;
        this.accRemarks = accRemarks;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAccProvided() {
        return accProvided;
    }

    public void setAccProvided(String accProvided) {
        this.accProvided = accProvided;
    }

    public String getAccProvidedMore() {
        return accProvidedMore;
    }

    public void setAccProvidedMore(String accProvidedMore) {
        this.accProvidedMore = accProvidedMore;
    }

    public String getAccType() {
        return accType;
    }

    public void setAccType(String accType) {
        this.accType = accType;
    }

    public String getAccTypeMore() {
        return accTypeMore;
    }

    public void setAccTypeMore(String accTypeMore) {
        this.accTypeMore = accTypeMore;
    }

    public String getAccLocation() {
        return accLocation;
    }

    public void setAccLocation(String accLocation) {
        this.accLocation = accLocation;
    }

    public String getAccCondition() {
        return accCondition;
    }

    public void setAccCondition(String accCondition) {
        this.accCondition = accCondition;
    }

    public double getAccCharged() {
        return accCharged;
    }

    public void setAccCharged(double accCharged) {
        this.accCharged = accCharged;
    }

    public double getAccSelfPaid() {
        return accSelfPaid;
    }

    public void setAccSelfPaid(double accSelfPaid) {
        this.accSelfPaid = accSelfPaid;
    }

    public String getAccMeals() {
        return accMeals;
    }

    public void setAccMeals(String accMeals) {
        this.accMeals = accMeals;
    }

    public String getAccStart() {
        return accStart;
    }

    public void setAccStart(String accStart) {
        this.accStart = accStart;
    }

    public String getAccEnd() {
        return accEnd;
    }

    public void setAccEnd(String accEnd) {
        this.accEnd = accEnd;
    }

    public String getAccRemarks() {
        return accRemarks;
    }

    public void setAccRemarks(String accRemarks) {
        this.accRemarks = accRemarks;
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
        return "JobAccomodation{" + "id=" + id + ", workerFinNum=" + workerFinNum + 
                ", jobKey=" + jobKey + ", accProvided=" + accProvided + 
                ", accProvidedMore=" + accProvidedMore + ", accType=" + accType + 
                ", accTypeMore=" + accTypeMore + ", accLocation=" + accLocation + 
                ", accCondition=" + accCondition + ", accCharged=" + accCharged + 
                ", accSelfPaid=" + accSelfPaid + ", accMeals=" + accMeals + ", accStart=" + accStart + 
                ", accEnd=" + accEnd + ", accRemarks=" + accRemarks + '}';
    }
    
    public String toString2() {
        return "JobAccomodation [accProvided=" + accProvided + 
                ", accProvidedMore=" + accProvidedMore + ", accType=" + accType + 
                ", accTypeMore=" + accTypeMore + ", accLocation=" + accLocation + 
                ", accCondition=" + accCondition + ", accCharged=" + accCharged + 
                ", accSelfPaid=" + accSelfPaid + ", accMeals=" + accMeals + ", accStart=" + accStart + 
                ", accEnd=" + accEnd + ", accRemarks=" + accRemarks + ']';
    }    
    
    
}