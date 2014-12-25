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

    public String getEmployerOfficialName() {
        return employerOfficialName;
    }

    public void setEmployerOfficialName(String employerOfficialName) {
        this.employerOfficialName = employerOfficialName;
    }

    public String getEmployerID() {
        return employerID;
    }

    public void setEmployerID(String employerID) {
        this.employerID = employerID;
    }

    public String getEmployerAddress() {
        return employerAddress;
    }

    public void setEmployerAddress(String employerAddress) {
        this.employerAddress = employerAddress;
    }

    public String getEmployerContacts() {
        return employerContacts;
    }

    public void setEmployerContacts(String employerContacts) {
        this.employerContacts = employerContacts;
    }

    public String getEmployerPersons() {
        return employerPersons;
    }

    public void setEmployerPersons(String employerPersons) {
        this.employerPersons = employerPersons;
    }

    public String getEmployerRemarks() {
        return employerRemarks;
    }

    public void setEmployerRemarks(String employerRemarks) {
        this.employerRemarks = employerRemarks;
    }

    @Override
    public String toString() {
        return "JobEmployer{" + "id=" + id + ", workerFinNum=" + workerFinNum + 
                ", jobKey=" + jobKey + ", employerOfficialName=" + employerOfficialName + 
                ", employerID=" + employerID + ", employerAddress=" + employerAddress + 
                ", employerContacts=" + employerContacts + ", employerPersons=" + employerPersons + 
                ", employerRemarks=" + employerRemarks + '}';
    }
    
    public String toString2() {
        return "JobEmployer{" + "WorkerFinNum=" + workerFinNum + 
                ", employerOfficialName=" + employerOfficialName + ", employerID=" + employerID + 
                ", employerAddress=" + employerAddress + ", employerContacts=" + employerContacts + 
                ", employerPersons=" + employerPersons + ", employerRemarks=" + employerRemarks + '}';
    }   
    
    
}
