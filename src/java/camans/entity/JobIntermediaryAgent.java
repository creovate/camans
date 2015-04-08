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
    /*
     * Creates new JobIntermediaryAgent without id
     * @param fin number of worker doing job
     * @param job key of the job with intermediary agent
     * @param agent company of the intermediary agent
     * @param person name of intermediary agent
     * @param location of intermediary agent
     * @param more location of intermediary agent
     * @param address of intermediary agent
     * @param contact of intermediary agent
     * @param amount paid to intermediary agent
     * @param amount owned by intermediary agent
     * @param fee shared by intermediary agent
     * @param training fee 
     * @param airfare fee
     * @param where the fee is given
     * @param when the fee is given
     * @param fee repayed by intermediary agent
     * @param employer associated with intermediary agent
     * @param remarks for intermediary agent
     */
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
    
    /*
     * Creates new JobIntermediaryAgent with id
     * @param id identifier of intermediary agent
     * @param fin number of worker doing job
     * @param job key of the job with intermediary agent
     * @param agent company of the intermediary agent
     * @param person name of intermediary agent
     * @param location of intermediary agent
     * @param more location of intermediary agent
     * @param address of intermediary agent
     * @param contact of intermediary agent
     * @param amount paid to intermediary agent
     * @param amount owned by intermediary agent
     * @param fee shared by intermediary agent
     * @param training fee 
     * @param airfare fee
     * @param where the fee is given
     * @param when the fee is given
     * @param fee repayed by intermediary agent
     * @param employer associated with intermediary agent
     * @param remarks for intermediary agent
     */
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



    /**
     * getter method for id for intermediary agent
     * @return id of intermediary agent
     */
    public int getID() {
        return id;
    }
    /**
     * setter method for id of intermediary agent
     * @param id 
     * sets current id of intermediary agent to new id
     */
    public void setID(int id) {
        this.id = id;
    }
    /**
     * getter method for company for intermediary agent
     * @return company of intermediary agent
     */
    public String getAgentCompany() {
        return agentCompany;
    }
    /**
     * setter method for company of intermediary agent
     * @param agentCompany 
     * sets current company of intermediary agent to new company
     */
    public void setAgentCompany(String agentCompany) {
        this.agentCompany = agentCompany;
    }
    /**
     * getter method for person name of intermediary agent
     * @return person name of intermediary agent
     */
    public String getAgentPersonName() {
        return agentPersonName;
    }
    /**
     * setter method for person name of intermediary agent
     * @param agentPersonName 
     * sets current person name of intermediary agent to new person name
     */
    public void setAgentPersonName(String agentPersonName) {
        this.agentPersonName = agentPersonName;
    }
    /**
     * getter method for location of intermediary agent
     * @return location of intermediary agent
     */
    public String getAgentLocation() {
        return agentLocation;
    }
    /**
     * setter method for location of intermediary agent
     * @param agentLocation 
     * sets current location of intermediary agent to new location
     */
    public void setAgentLocation(String agentLocation) {
        this.agentLocation = agentLocation;
    }
    /**
     * getter method for more information about location of intermediary agent
     * @return more information about location of intermediary agent
     */
    public String getAgentlocationMore() {
        return agentlocationMore;
    }
    /**
     * setter method for more information of location of intermediary agent
     * @param agentlocationMore 
     * sets current more information of location of intermediary agent to new more information of location
     */
    public void setAgentlocationMore(String agentlocationMore) {
        this.agentlocationMore = agentlocationMore;
    }
    /**
     * getter method for address of intermediary agent
     * @return address of intermediary agent
     */
    public String getAgentAddress() {
        return agentAddress;
    }
    /**
     * setter method for address of intermediary agent
     * @param agentAddress 
     * sets current address of intermediary agent to new address
     */
    public void setAgentAddress(String agentAddress) {
        this.agentAddress = agentAddress;
    }
    /**
     * getter method for contact of intermediary agent
     * @return contact of intermediary agent
     */
    public String getAgentContact() {
        return agentContact;
    }
    /**
     * setter method for contact of intermediary agent
     * @param contact 
     * sets current contact of intermediary agent to new contact
     */
    public void setAgentContact(String agentContact) {
        this.agentContact = agentContact;
    }
    /**
     * getter method for amount paid to intermediary agent
     * @return amount paid to intermediary agent
     */
    public Double getAgentAmtPaid() {
        return agentAmtPaid;
    }
    /**
     * setter method for amount paid to intermediary agent
     * @param agentAmtPaid 
     * sets current amount paid to intermediary agent to new amount paid
     */
    public void setAgentAmtPaid(Double agentAmtPaid) {
        this.agentAmtPaid = agentAmtPaid;
    }
    /**
     * getter method for amount owned to intermediary agent
     * @return amount owned to intermediary agent
     */
    public Double getAgentAmtOwed() {
        return agentAmtOwed;
    }
    /**
     * setter method for amount owned to intermediary agent
     * @param agentAmtOwned 
     * sets current amount owned to intermediary agent to new amount owned
     */
    public void setAgentAmtOwed(Double agentAmtOwed) {
        this.agentAmtOwed = agentAmtOwed;
    }
    /**
     * getter method for shared fee by intermediary agent
     * @return shared fee by intermediary agent
     */
    public String getAgentFeeShared() {
        return agentFeeShared;
    }
    /**
     * setter method for shared fee by intermediary agent
     * @param agentFeeShared 
     * sets current shared fee by intermediary agent to new shared fee
     */
    public void setAgentFeeShared(String agentFeeShared) {
        this.agentFeeShared = agentFeeShared;
    }
    /**
     * getter method for training fee to intermediary agent
     * @return training fee to intermediary agent
     */
    public String getAgentFeeTraining() {
        return agentFeeTraining;
    }
    /**
     * setter method for training fee by intermediary agent
     * @param agentFeeTraining 
     * sets current training fee of intermediary agent to new training fee
     */
    public void setAgentFeeTraining(String agentFeeTraining) {
        this.agentFeeTraining = agentFeeTraining;
    }
    /**
     * getter method for airfare fee of intermediary agent
     * @return airfare fee of intermediary agent
     */
    public String getAgentFeeAirfare() {
        return agentFeeAirfare;
    }
    /**
     * setter method for airfare fee of intermediary agent
     * @param agentFeeAirfare 
     * sets current airfare fee of intermediary agent to new airfare fee
     */
    public void setAgentFeeAirfare(String agentFeeAirfare) {
        this.agentFeeAirfare = agentFeeAirfare;
    }
    /**
     * getter method for where intermediary agent fee was paid
     * @return where intermediary agent fee was paid
     */
    public String getAgentFeeWhere() {
        return agentFeeWhere;
    }
    /**
     * setter method for where fee of intermediary agent is paid
     * @param agentFeeWhere 
     * sets current where fee of intermediary agent is paid to new where fee is paid
     */
    public void setAgentFeeWhere(String agentFeeWhere) {
        this.agentFeeWhere = agentFeeWhere;
    }
    /**
     * getter method for when intermediary agent fee was paid
     * @return when intermediary agent fee was paid
     */
    public String getAgentFeeWhen() {
        return agentFeeWhen;
    }
     /**
     * setter method for when fee of intermediary agent is paid
     * @param agentFeeWhen 
     * sets current when fee of intermediary agent is paid to new when fee is paid
     */
    public void setAgentFeeWhen(String agentFeeWhen) {
        this.agentFeeWhen = agentFeeWhen;
    }
    /**
     * getter method for repaid intermediary agent fee
     * @return repaid intermediary agent
     */
    public String getAgentFeeRepay() {
        return agentFeeRepay;
    }
     /**
     * setter method for repaid fee of intermediary agent
     * @param agentFeeRepay
     * sets current repaid fee of intermediary agent to new repaid fee 
     */
    public void setAgentFeeRepay(String agentFeeRepay) {
        this.agentFeeRepay = agentFeeRepay;
    }
    /**
     * getter method employer associated with intermediary agent
     * @return employer associated with intermediary agent
     */
    public String getAgentEmployer() {
        return agentEmployer;
    }
    /**
     * setter method for employer of intermediary agent
     * @param agentEmployer
     * sets current employer of intermediary agent to new employer 
     */
    public void setAgentEmployer(String agentEmployer) {
        this.agentEmployer = agentEmployer;
    }
    /**
     * getter method remarks for intermediary agent
     * @return remarks for intermediary agent
     */
    public String getAgentRemarks() {
        return agentRemarks;
    }
    /**
     * setter method for remarks of intermediary agent
     * @param agentRemarks
     * sets current remarks of intermediary agent to new remarks 
     */
    public void setAgentRemarks(String agentRemarks) {
        this.agentRemarks = agentRemarks;
    }
    /**
     * getter method for fin number of worker who is associated with intermediary agent
     * @return fin number of worker who is associated with intermediary agent
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }
    /**
     * setter method for fin number of worker of intermediary agent
     * @param workerFinNumber
     * sets current fin number of worker of intermediary agent to new fin number of worker
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }
    /**
     * getter method for job key of the job with intermediary agent
     * @return job key of the job with intermediary agent
     */
    public int getJobKey() {
        return jobKey;
    }
    /**
     * setter method for job key of job of intermediary agent
     * @param jobKey
     * sets current job key of job of intermediary agent to new job key of job
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }
    /*
     * toString method for jobIntermediaryAgent details with id
     * @return jobIntermediaryAgent details with id
     */
    @Override
    public String toString() {
        return "JobIntermediaryAgent{" + "id=" + id + ", workerFinNum=" + workerFinNum + ", jobKey=" + jobKey + ", agentCompany=" + agentCompany + ", agentPersonName=" + agentPersonName + ", agentLocation=" + agentLocation + ", agentlocationMore=" + agentlocationMore + ", agentAddress=" + agentAddress + ", agentContact=" + agentContact + ", agentAmtPaid=" + agentAmtPaid + ", agentAmtOwed=" + agentAmtOwed + ", agentFeeShared=" + agentFeeShared + ", agentFeeTraining=" + agentFeeTraining + ", agentFeeAirfare=" + agentFeeAirfare + ", agentFeeWhere=" + agentFeeWhere + ", agentFeeWhen=" + agentFeeWhen + ", agentFeeRepay=" + agentFeeRepay + ", agentEmployer=" + agentEmployer + ", agentRemarks=" + agentRemarks + '}';
    }
    /*
     * toString method for jobIntermediaryAgent details without id
     * @return jobIntermediaryAgent details without id
     */
    public String toString2() {
        return "JobIntermediaryAgent{" + "WorkerFinNum=" + workerFinNum +
                ", agentCompany=" + agentCompany + ", agentPersonName=" + agentPersonName + 
                ", agentLocation=" + agentLocation + ", agentlocationMore=" + agentlocationMore + 
                ", agentAddress=" + agentAddress + ", agentContact=" + agentContact + 
                ", agentAmtPaid=" + agentAmtPaid + ", agentAmtOwed=" + agentAmtOwed + 
                ", agentFeeShared=" + agentFeeShared + ", agentFeeTraining=" + agentFeeTraining + 
                ", agentFeeAirfare=" + agentFeeAirfare + ", agentFeeWhere=" + agentFeeWhere + 
                ", agentFeeWhen=" + agentFeeWhen + ", agentFeeRepay=" + agentFeeRepay + 
                ", agentEmployer=" + agentEmployer + ", agentRemarks=" + agentRemarks + '}';
    }    
    
    
    
}
