package camans.entity;


import java.sql.Date;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author soemyatmyat
 */
public class JobEmploymentContract {
    //attributes
    
    private int id;
    private String workerFinNum;
    private int jobKey;    
    private String shortName;
    private Date contractDate;
    private String contractWhere;
    private String contractlanguage;
    private String contractOppName;
    private String contractOppRelationship;
    private String contractOccupation;
    private String contractBasicSalary;
    private String contractAllowances;
    private String contractDeductDetails;
    private String contractDuration;
    private String contractDuress;
    private String contractRemarks;

    public JobEmploymentContract(int id, String workerFinNum, int jobKey, String shortName, 
            Date contractDate, String contractWhere, String contractlanguage, 
            String contractOppName, String contractOppRelationship, String contractOccupation,
            String contractBasicSalary, String contractAllowances, String contractDeductDetails, 
            String contractDuration, String contractDuress, String contractRemarks) {
        this.id = id;
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.shortName = shortName;
        this.contractDate = contractDate;
        this.contractWhere = contractWhere;
        this.contractlanguage = contractlanguage;
        this.contractOppName = contractOppName;
        this.contractOppRelationship = contractOppRelationship;
        this.contractOccupation = contractOccupation;
        this.contractBasicSalary = contractBasicSalary;
        this.contractAllowances = contractAllowances;
        this.contractDeductDetails = contractDeductDetails;
        this.contractDuration = contractDuration;
        this.contractDuress = contractDuress;
        this.contractRemarks = contractRemarks;
    }

    public JobEmploymentContract(String workerFinNum, int jobKey, String shortName, Date contractDate, String contractWhere, String contractlanguage, String contractOppName, String contractOppRelationship, String contractOccupation, String contractBasicSalary, String contractAllowances, String contractDeductDetails, String contractDuration, String contractDuress, String contractRemarks) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.shortName = shortName;
        this.contractDate = contractDate;
        this.contractWhere = contractWhere;
        this.contractlanguage = contractlanguage;
        this.contractOppName = contractOppName;
        this.contractOppRelationship = contractOppRelationship;
        this.contractOccupation = contractOccupation;
        this.contractBasicSalary = contractBasicSalary;
        this.contractAllowances = contractAllowances;
        this.contractDeductDetails = contractDeductDetails;
        this.contractDuration = contractDuration;
        this.contractDuress = contractDuress;
        this.contractRemarks = contractRemarks;
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

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    public int getJobKey() {
        return jobKey;
    }

    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }

    public Date getContractDate() {
        return contractDate;
    }

    public void setContractDate(Date contractDate) {
        this.contractDate = contractDate;
    }

    public String getContractWhere() {
        return contractWhere;
    }

    public void setContractWhere(String contractWhere) {
        this.contractWhere = contractWhere;
    }

    public String getContractlanguage() {
        return contractlanguage;
    }

    public void setContractlanguage(String contractlanguage) {
        this.contractlanguage = contractlanguage;
    }

    public String getContractOppName() {
        return contractOppName;
    }

    public void setContractOppName(String contractOppName) {
        this.contractOppName = contractOppName;
    }

    public String getContractOppRelationship() {
        return contractOppRelationship;
    }

    public void setContractOppRelationship(String contractOppRelationship) {
        this.contractOppRelationship = contractOppRelationship;
    }

    public String getContractOccupation() {
        return contractOccupation;
    }

    public void setContractOccupation(String contractOccupation) {
        this.contractOccupation = contractOccupation;
    }

    public String getContractBasicSalary() {
        return contractBasicSalary;
    }

    public void setContractBasicSalary(String contractBasicSalary) {
        this.contractBasicSalary = contractBasicSalary;
    }

    public String getContractAllowances() {
        return contractAllowances;
    }

    public void setContractAllowances(String contractAllowances) {
        this.contractAllowances = contractAllowances;
    }

    public String getContractDeductDetails() {
        return contractDeductDetails;
    }

    public void setContractDeductDetails(String contractDeductDetails) {
        this.contractDeductDetails = contractDeductDetails;
    }

    public String getContractDuration() {
        return contractDuration;
    }

    public void setContractDuration(String contractDuration) {
        this.contractDuration = contractDuration;
    }

    public String getContractDuress() {
        return contractDuress;
    }

    public void setContractDuress(String contractDuress) {
        this.contractDuress = contractDuress;
    }

    public String getContractRemarks() {
        return contractRemarks;
    }

    public void setContractRemarks(String contractRemarks) {
        this.contractRemarks = contractRemarks;
    }

    @Override
    public String toString() {
        return "JobEmploymentContract{" + "id=" + id + ", workerFinNum=" + workerFinNum + 
                ", jobKey=" + jobKey + ", shortName=" + shortName + ", contractDate=" + contractDate + 
                ", contractWhere=" + contractWhere + ", contractlanguage=" + contractlanguage + 
                ", contractOppName=" + contractOppName + 
                ", contractOppRelationship=" + contractOppRelationship + 
                ", contractOccupation=" + contractOccupation + 
                ", contractBasicSalary=" + contractBasicSalary + 
                ", contractAllowances=" + contractAllowances + 
                ", contractDeductDetails=" + contractDeductDetails + 
                ", contractDuration=" + contractDuration + ", contractDuress=" + contractDuress + 
                ", contractRemarks=" + contractRemarks + '}';
    }
    
    public String toString2() {
        return "JobEmploymentContract{" + "WorkerFinNum=" + workerFinNum + ", shortName=" + shortName + 
                ", contractDate=" + contractDate + ", contractWhere=" + contractWhere + 
                ", contractlanguage=" + contractlanguage + ", contractOppName=" + contractOppName + 
                ", contractOppRelationship=" + contractOppRelationship + 
                ", contractOccupation=" + contractOccupation + 
                ", contractBasicSalary=" + contractBasicSalary + 
                ", contractAllowances=" + contractAllowances + 
                ", contractDeductDetails=" + contractDeductDetails + 
                ", contractDuration=" + contractDuration + 
                ", contractDuress=" + contractDuress + ", contractRemarks=" + contractRemarks + '}';
    }    
      
    
}
