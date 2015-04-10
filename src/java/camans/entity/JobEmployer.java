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
public class JobEmployer {
    //attributes
    
    private int id;
    private String workerFinNum;
    private int jobKey;
    private String employerOfficialName;
    private String employerID;
    private String employerAddress;
    private String employerContacts;
    private String employerPersons;
    private String employerRemarks;

    /*
     * creates new job employer object with id
     * @param id identifier of employer of job
     * @param job key of the job which the employer offer
     * @param official name of employer
     * @param official of employer
     * @param address of employer
     * @param contacts of employer
     * @param person involved as employer
     * @param remarks for employer
     */
    public JobEmployer(int id, String workerFinNum, int jobKey, String employerOfficialName, 
            String employerID, String employerAddress, String employerContacts, String employerPersons,
            String employerRemarks) {
        this.id = id;
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.employerOfficialName = employerOfficialName;
        this.employerID = employerID;
        this.employerAddress = employerAddress;
        this.employerContacts = employerContacts;
        this.employerPersons = employerPersons;
        this.employerRemarks = employerRemarks;
    }
    /*
     * creates new job employer object with id
     * @param job key of the job which the employer offer
     * @param official name of employer
     * @param official of employer
     * @param address of employer
     * @param contacts of employer
     * @param person involved as employer
     * @param remarks for employer
     */
    public JobEmployer(String workerFinNum, int jobKey, String employerOfficialName, String employerID, String employerAddress, String employerContacts, String employerPersons, String employerRemarks) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.employerOfficialName = employerOfficialName;
        this.employerID = employerID;
        this.employerAddress = employerAddress;
        this.employerContacts = employerContacts;
        this.employerPersons = employerPersons;
        this.employerRemarks = employerRemarks;
    }
    /**
     * getter method for system id of employer
     * @return worker system id of employer
     */
    public int getId() {
        return id;
    }
    /**
     * setter method for system id of employer
     * @param id 
     * sets current system id of employer to new system id
     */
    public void setId(int id) {
        this.id = id;
    }
    /**
     * getter method for worker fin number
     * @return worker fin number of worker of the job which employer offer
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }
    /**
     * setter method for fin number of worker of employer
     * @param workerFinNum 
     * sets current fin number of worker to new fin number
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }
    /**
     * getter method for job key of job which employer offers
     * @return worker job key of job which employer offers
     */
    public int getJobKey() {
        return jobKey;
    }
    /**
     * setter method for job key of job that employer offers
     * @param jobKey
     * sets current job key of job that employer offers to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }
    /**
     * getter method for official name of employer
     * @return worker official name of employer
     */
    public String getEmployerOfficialName() {
        return employerOfficialName;
    }
    /**
     * setter method for official name of employer
     * @param employerOfficialName 
     * sets current official name of employer to new official name
     */
    public void setEmployerOfficialName(String employerOfficialName) {
        this.employerOfficialName = employerOfficialName;
    }
    /**
     * getter method for official id of employer
     * @return worker official id of employer
     */
    public String getEmployerID() {
        return employerID;
    }
    /**
     * setter method for official id of employer
     * @param employerID 
     * sets current official id of employer to new official id
     */
    public void setEmployerID(String employerID) {
        this.employerID = employerID;
    }
    /**
     * getter method for address of employer
     * @return worker address of employer
     */
    public String getEmployerAddress() {
        return employerAddress;
    }
    /**
     * setter method for address of employer
     * @param employerAddress 
     * sets current address of employer to new address
     */
    public void setEmployerAddress(String employerAddress) {
        this.employerAddress = employerAddress;
    }
    /**
     * getter method for contacts of employer
     * @return contacts of employer
     */
    public String getEmployerContacts() {
        return employerContacts;
    }
    /**
     * setter method for contacts of employer
     * @param employerContacts 
     * sets current contacts of employer to new contacts
     */
    public void setEmployerContacts(String employerContacts) {
        this.employerContacts = employerContacts;
    }
    /**
     * getter method for persons involved as employer
     * @return persons involved as employer
     */
    public String getEmployerPersons() {
        return employerPersons;
    }
    /**
     * setter method for persons involved in employer
     * @param employerPersons
     * sets current persons involved in employer to new persons
     */
    public void setEmployerPersons(String employerPersons) {
        this.employerPersons = employerPersons;
    }
     /**
     * getter method for remarks for employer
     * @return remarks for employer
     */
    public String getEmployerRemarks() {
        return employerRemarks;
    }
    /**
     * setter method for remarks for employer
     * @param employerRemarks 
     * sets current remarks for employer to new remarks
     */
    public void setEmployerRemarks(String employerRemarks) {
        this.employerRemarks = employerRemarks;
    }

    @Override
    /*
     * to string method for employer with id
     * returns details of employer with id
     */
    public String toString() {
        return "JobEmployer{" + "id=" + id + ", workerFinNum=" + workerFinNum + 
                ", jobKey=" + jobKey + ", employerOfficialName=" + employerOfficialName + 
                ", employerID=" + employerID + ", employerAddress=" + employerAddress + 
                ", employerContacts=" + employerContacts + ", employerPersons=" + employerPersons + 
                ", employerRemarks=" + employerRemarks + '}';
    }
    /*
     * to string method for employer without id
     * returns details of employer without id
     */
    public String toString2() {
        return "Employer [employerOfficialName=" + employerOfficialName + ", employerID=" + employerID + 
                ", employerAddress=" + employerAddress + ", employerContacts=" + employerContacts + 
                ", employerPersons=" + employerPersons + ", employerRemarks=" + employerRemarks + ']';
    } 
    
    
}
