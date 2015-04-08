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
    /*
     * creates new Job Accomodation object without id
     * @param worker fin number
     * @param job key of the job
     * @param accomodation provided
     * @param more info of accomodation provided
     * @param accomodation type
     * @param more info of accomodation provided
     * @param type of accomodation
     * @param more info of accomodation type
     * @param location of accomodation
     * @param condition of accomodation
     * @param charge of accomodation
     * @param amount of self paid for accomodation
     * @param meal of accomodation
     * @param start date of accomodation
     * @param end  date of accomodation
     * @param remark of accomodation
     */
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
    /*
     * creates new Job Accomodation object with id
     * @param id identifier of accomodation
     * @param worker fin number
     * @param job key of the job
     * @param accomodation provided
     * @param more info of accomodation provided
     * @param accomodation type
     * @param more info of accomodation provided
     * @param type of accomodation
     * @param more info of accomodation type
     * @param location of accomodation
     * @param condition of accomodation
     * @param charge of accomodation
     * @param amount of self paid for accomodation
     * @param meal of accomodation
     * @param start date of accomodation
     * @param end  date of accomodation
     * @param remark of accomodation
     */
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
     /**
     * getter method for id of the accommodation
     * @return id of accommodation
     */
    public int getId() {
        return id;
    }
     /**
     * setter method for id of accommodation
     * @param id 
     * sets current id of accommodation to new id
     */
    public void setId(int id) {
        this.id = id;
    }
    /**
     * getter method for provided accommodation
     * @return provided accommodation
     */
    public String getAccProvided() {
        return accProvided;
    }
    /**
     * setter method for provided accommodation
     * @param accProvided 
     * sets current provided accommodation to new provided accommodation
     */
    public void setAccProvided(String accProvided) {
        this.accProvided = accProvided;
    }
    /**
     * getter method for more info of provided accommodation
     * @return more info of provided accommodation
     */
    public String getAccProvidedMore() {
        return accProvidedMore;
    }
    /**
     * setter method for more info of provided accommodation
     * @param accProvidedMore 
     * sets current more info of accommodation to new info of provided accommodation
     */
    public void setAccProvidedMore(String accProvidedMore) {
        this.accProvidedMore = accProvidedMore;
    }
    /**
     * getter method for type of accommodation
     * @return type of accommodation
     */
    public String getAccType() {
        return accType;
    }
     /**
     * setter method for type of accommodation
     * @param accType 
     * sets current type of accommodation to new type
     */
    public void setAccType(String accType) {
        this.accType = accType;
    }
   /**
     * getter method for more info of type of accommodation
     * @return more info of type of accommodation
     */
    public String getAccTypeMore() {
        return accTypeMore;
    }
    /**
     * setter method for more info of type of accommodation
     * @param accTypeMore 
     * sets current more info of type of accommodation to new more info of type
     */
    public void setAccTypeMore(String accTypeMore) {
        this.accTypeMore = accTypeMore;
    }
    /**
     * getter method for location of accommodation
     * @return location of accommodation
     */
    public String getAccLocation() {
        return accLocation;
    }
    /**
     * setter method for location of accommodation
     * @param accLocation
     * sets current location of accommodation to new location
     */
    public void setAccLocation(String accLocation) {
        this.accLocation = accLocation;
    }
    /**
     * getter method for condition of accommodation
     * @return condition of accommodation
     */
    public String getAccCondition() {
        return accCondition;
    }
    /**
     * setter method for condition of accommodation
     * @param accCondition 
     * sets current condition of accommodation to new condition
     */
    public void setAccCondition(String accCondition) {
        this.accCondition = accCondition;
    }
    /**
     * getter method for charge of accommodation
     * @return charge of accommodation
     */
    public double getAccCharged() {
        return accCharged;
    }
    /**
     * setter method for charge of accommodation
     * @param accCharged 
     * sets current charge of accommodation to new charge
     */
    public void setAccCharged(double accCharged) {
        this.accCharged = accCharged;
    }
    /**
     * getter method for amount of self paid of accommodation
     * @return amount of self paid of accommodation
     */
    public double getAccSelfPaid() {
        return accSelfPaid;
    }
    /**
     * setter method for amount of self paid of accommodation
     * @param accSelfPaid 
     * sets current amount of self paid of accommodation to new amount self paid
     */
    public void setAccSelfPaid(double accSelfPaid) {
        this.accSelfPaid = accSelfPaid;
    }
    /**
     * getter method for meals of accommodation
     * @return meals of accommodation
     */
    public String getAccMeals() {
        return accMeals;
    }
    /**
     * setter method for meals of accommodation
     * @param accMeals 
     * sets current meals of accommodation to new meals
     */
    public void setAccMeals(String accMeals) {
        this.accMeals = accMeals;
    }
    /**
     * getter method for start date of accommodation
     * @return start date of accommodation
     */
    public String getAccStart() {
        return accStart;
    }
    /**
     * setter method for start date of accommodation
     * @param accStart
     * sets current start date of accommodation to start date
     */
    public void setAccStart(String accStart) {
        this.accStart = accStart;
    }
    /**
     * getter method for end date of accommodation
     * @return end date of accommodation
     */
    public String getAccEnd() {
        return accEnd;
    }
    /**
     * setter method for end date of accommodation
     * @param accEnd 
     * sets current end date of accommodation to new end date
     */
    public void setAccEnd(String accEnd) {
        this.accEnd = accEnd;
    }
    /**
     * getter method for remark of accommodation
     * @return remark of accommodation
     */
    public String getAccRemarks() {
        return accRemarks;
    }
    /**
     * setter method for remark of accommodation
     * @param accRemarks 
     * sets current remark of accommodation to new remark
     */
    public void setAccRemarks(String accRemarks) {
        this.accRemarks = accRemarks;
    }
    /**
     * getter method for fin number of the worker of accommodation
     * @return fin number of the worker of accommodation
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }
    /**
     * setter method for fin number of worker at accommodation
     * @param workerFinNum 
     * sets current fin number of worker at accommodation to new fin num
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }
    /**
     * getter method for job key of worker of accommodation
     * @return job key of worker of accommodation
     */
    public int getJobKey() {
        return jobKey;
    }
    /**
     * setter method for job key of worker at accommodation
     * @param jobKey
     * sets current job key of worker at accommodation to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }

    @Override
    /**
     * to string for accommodation with id
     * @return details of accommodation
     */
    public String toString() {
        return "JobAccomodation{" + "id=" + id + ", workerFinNum=" + workerFinNum + 
                ", jobKey=" + jobKey + ", accProvided=" + accProvided + 
                ", accProvidedMore=" + accProvidedMore + ", accType=" + accType + 
                ", accTypeMore=" + accTypeMore + ", accLocation=" + accLocation + 
                ", accCondition=" + accCondition + ", accCharged=" + accCharged + 
                ", accSelfPaid=" + accSelfPaid + ", accMeals=" + accMeals + ", accStart=" + accStart + 
                ", accEnd=" + accEnd + ", accRemarks=" + accRemarks + '}';
    }
     /**
     * to string for accommodation without id
     * @return details of accommodation
     */
    public String toString2() {
        return "JobAccomodation [accProvided=" + accProvided + 
                ", accProvidedMore=" + accProvidedMore + ", accType=" + accType + 
                ", accTypeMore=" + accTypeMore + ", accLocation=" + accLocation + 
                ", accCondition=" + accCondition + ", accCharged=" + accCharged + 
                ", accSelfPaid=" + accSelfPaid + ", accMeals=" + accMeals + ", accStart=" + accStart + 
                ", accEnd=" + accEnd + ", accRemarks=" + accRemarks + ']';
    }    
    
    
}
