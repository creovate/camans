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
public class JobIntermediaryAgent {
    
    //attributes
    
    private int id;
    private String workerFinNum;
    private int jobKey;    
    private String agentCompany;
    private String agentPersonName;
    private String agentLocation;
    private String agentlocationMore;
    private String agentAddress;
    private String agentContact;
    private Double agentAmtPaid;
    private Double agentAmtOwed;
    private String agentFeeShared;
    private String agentFeeTraining;
    private String agentFeeAirfare;
    private String agentFeeWhere;
    private String agentFeeWhen;
    private String agentFeeRepay;
    private String agentEmployer;
    private String agentRemarks;

    public JobIntermediaryAgent(String workerFinNum, int jobKey, String agentCompany, String agentPersonName, String agentLocation, String agentlocationMore, String agentAddress, String agentContact, Double agentAmtPaid, Double agentAmtOwed, String agentFeeShared, String agentFeeTraining, String agentFeeAirfare, String agentFeeWhere, String agentFeeWhen, String agentFeeRepay, String agentEmployer, String agentRemarks) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.agentCompany = agentCompany;
        this.agentPersonName = agentPersonName;
        this.agentLocation = agentLocation;
        this.agentlocationMore = agentlocationMore;
        this.agentAddress = agentAddress;
        this.agentContact = agentContact;
        this.agentAmtPaid = agentAmtPaid;
        this.agentAmtOwed = agentAmtOwed;
        this.agentFeeShared = agentFeeShared;
        this.agentFeeTraining = agentFeeTraining;
        this.agentFeeAirfare = agentFeeAirfare;
        this.agentFeeWhere = agentFeeWhere;
        this.agentFeeWhen = agentFeeWhen;
        this.agentFeeRepay = agentFeeRepay;
        this.agentEmployer = agentEmployer;
        this.agentRemarks = agentRemarks;
    }
    

    public JobIntermediaryAgent(int id, String workerFinNum, int jobKey, String agentCompany, String agentPersonName, String agentLocation, String agentlocationMore, String agentAddress, String agentContact, Double agentAmtPaid, Double agentAmtOwed, String agentFeeShared, String agentFeeTraining, String agentFeeAirfare, String agentFeeWhere, String agentFeeWhen, String agentFeeRepay, String agentEmployer, String agentRemarks) {
        this.id = id;
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.agentCompany = agentCompany;
        this.agentPersonName = agentPersonName;
        this.agentLocation = agentLocation;
        this.agentlocationMore = agentlocationMore;
        this.agentAddress = agentAddress;
        this.agentContact = agentContact;
        this.agentAmtPaid = agentAmtPaid;
        this.agentAmtOwed = agentAmtOwed;
        this.agentFeeShared = agentFeeShared;
        this.agentFeeTraining = agentFeeTraining;
        this.agentFeeAirfare = agentFeeAirfare;
        this.agentFeeWhere = agentFeeWhere;
        this.agentFeeWhen = agentFeeWhen;
        this.agentFeeRepay = agentFeeRepay;
        this.agentEmployer = agentEmployer;
        this.agentRemarks = agentRemarks;
    }



    public int getID() {
        return id;
    }

    public void setID(int id) {
        this.id = id;
    }

    public String getAgentCompany() {
        return agentCompany;
    }

    public void setAgentCompany(String agentCompany) {
        this.agentCompany = agentCompany;
    }

    public String getAgentPersonName() {
        return agentPersonName;
    }

    public void setAgentPersonName(String agentPersonName) {
        this.agentPersonName = agentPersonName;
    }

    public String getAgentLocation() {
        return agentLocation;
    }

    public void setAgentLocation(String agentLocation) {
        this.agentLocation = agentLocation;
    }

    public String getAgentlocationMore() {
        return agentlocationMore;
    }

    public void setAgentlocationMore(String agentlocationMore) {
        this.agentlocationMore = agentlocationMore;
    }

    public String getAgentAddress() {
        return agentAddress;
    }

    public void setAgentAddress(String agentAddress) {
        this.agentAddress = agentAddress;
    }

    public String getAgentContact() {
        return agentContact;
    }

    public void setAgentContact(String agentContact) {
        this.agentContact = agentContact;
    }

    public Double getAgentAmtPaid() {
        return agentAmtPaid;
    }

    public void setAgentAmtPaid(Double agentAmtPaid) {
        this.agentAmtPaid = agentAmtPaid;
    }

    public Double getAgentAmtOwed() {
        return agentAmtOwed;
    }

    public void setAgentAmtOwed(Double agentAmtOwed) {
        this.agentAmtOwed = agentAmtOwed;
    }

    public String getAgentFeeShared() {
        return agentFeeShared;
    }

    public void setAgentFeeShared(String agentFeeShared) {
        this.agentFeeShared = agentFeeShared;
    }

    public String getAgentFeeTraining() {
        return agentFeeTraining;
    }

    public void setAgentFeeTraining(String agentFeeTraining) {
        this.agentFeeTraining = agentFeeTraining;
    }

    public String getAgentFeeAirfare() {
        return agentFeeAirfare;
    }

    public void setAgentFeeAirfare(String agentFeeAirfare) {
        this.agentFeeAirfare = agentFeeAirfare;
    }

    public String getAgentFeeWhere() {
        return agentFeeWhere;
    }

    public void setAgentFeeWhere(String agentFeeWhere) {
        this.agentFeeWhere = agentFeeWhere;
    }

    public String getAgentFeeWhen() {
        return agentFeeWhen;
    }

    public void setAgentFeeWhen(String agentFeeWhen) {
        this.agentFeeWhen = agentFeeWhen;
    }

    public String getAgentFeeRepay() {
        return agentFeeRepay;
    }

    public void setAgentFeeRepay(String agentFeeRepay) {
        this.agentFeeRepay = agentFeeRepay;
    }

    public String getAgentEmployer() {
        return agentEmployer;
    }

    public void setAgentEmployer(String agentEmployer) {
        this.agentEmployer = agentEmployer;
    }

    public String getAgentRemarks() {
        return agentRemarks;
    }

    public void setAgentRemarks(String agentRemarks) {
        this.agentRemarks = agentRemarks;
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
        return "JobIntermediaryAgent{" + "id=" + id + ", workerFinNum=" + workerFinNum + ", jobKey=" + jobKey + ", agentCompany=" + agentCompany + ", agentPersonName=" + agentPersonName + ", agentLocation=" + agentLocation + ", agentlocationMore=" + agentlocationMore + ", agentAddress=" + agentAddress + ", agentContact=" + agentContact + ", agentAmtPaid=" + agentAmtPaid + ", agentAmtOwed=" + agentAmtOwed + ", agentFeeShared=" + agentFeeShared + ", agentFeeTraining=" + agentFeeTraining + ", agentFeeAirfare=" + agentFeeAirfare + ", agentFeeWhere=" + agentFeeWhere + ", agentFeeWhen=" + agentFeeWhen + ", agentFeeRepay=" + agentFeeRepay + ", agentEmployer=" + agentEmployer + ", agentRemarks=" + agentRemarks + '}';
    }
    
    public String toString2() {
        return "JobIntermediaryAgent [agentCompany=" + agentCompany + ", agentPersonName=" + agentPersonName + 
                ", agentLocation=" + agentLocation + ", agentlocationMore=" + agentlocationMore + 
                ", agentAddress=" + agentAddress + ", agentContact=" + agentContact + 
                ", agentAmtPaid=" + agentAmtPaid + ", agentAmtOwed=" + agentAmtOwed + 
                ", agentFeeShared=" + agentFeeShared + ", agentFeeTraining=" + agentFeeTraining + 
                ", agentFeeAirfare=" + agentFeeAirfare + ", agentFeeWhere=" + agentFeeWhere + 
                ", agentFeeWhen=" + agentFeeWhen + ", agentFeeRepay=" + agentFeeRepay + 
                ", agentEmployer=" + agentEmployer + ", agentRemarks=" + agentRemarks + ']';
    }    
    
    
    
}
