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

    /*
     * creates new JobEmploymentContract object with id
     * @param id identifier of employment contract
     * @param fin number of worker involved in contract
     * @param job key of the job stated in contract
     * @param date of the contract
     * @param location of the contract was done
     * @param language of contract
     * @param opposition name of contract
     * @param relationship of opposition of contract
     * @param occupation in the contract
     * @param basic salary of contract
     * @param allowances of contract
     * @param amount of deduct details in contract
     * @param duration of contract
     * @param whether contract is under duress or not
     * @param remarks for contract
     */
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
    /*
     * creates new JobEmploymentContract object with id
     * @param fin number of worker involved in contract
     * @param job key of the job stated in contract
     * @param date of the contract
     * @param location of the contract was done
     * @param language of contract
     * @param opposition name of contract
     * @param relationship of opposition of contract
     * @param occupation in the contract
     * @param basic salary of contract
     * @param allowances of contract
     * @param amount of deduct details in contract
     * @param duration of contract
     * @param whether contract is under duress or not
     * @param remarks for contract
     */
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

    
    /**
     * getter method for id for employment contract
     * @return id of employment contract
     */
    public int getId() {
        return id;
    }
    /**
     * setter method for id of employment contract
     * @param id 
     * sets current id of employment contract to new id
     */
    public void setId(int id) {
        this.id = id;
    }
    /**
     * getter method fin number of worker in employment contract
     * @return fin number of worker in employment contract
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }
    /**
     * setter method for fin number of worker in employment contract
     * @param workerFinNum 
     * sets current fin number of worker in employment contract to new fin number
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }
    /**
     * getter method short name for employment contract
     * @return short name of employment contract
     */
    public String getShortName() {
        return shortName;
    }
    /**
     * setter method for short name of employment contract
     * @param shortName 
     * sets current short name of employment contract to new short name
     */
    public void setShortName(String shortName) {
        this.shortName = shortName;
    }
    /**
     * getter method for job key of job in employment contract
     * @return job key of job in employment contract
     */
    public int getJobKey() {
        return jobKey;
    }
    /**
     * setter method for job key of job in employment contract
     * @param jobKey 
     * sets current job key of job in employment contract to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }
    /**
     * getter method for id of employment contract
     * @return id of employment contract
     */
    public Date getContractDate() {
        return contractDate;
    }
    /**
     * setter method for date of employment contract
     * @param contractDate 
     * sets current date of employment contract to new date
     */
    public void setContractDate(Date contractDate) {
        this.contractDate = contractDate;
    }
    /**
     * getter method for location of employment contract
     * @return location of employment contract
     */
    public String getContractWhere() {
        return contractWhere;
    }
    /**
     * setter method for location of employment contract
     * @param contractWhere 
     * sets current location of employment contract to new location
     */
    public void setContractWhere(String contractWhere) {
        this.contractWhere = contractWhere;
    }
    /**
     * getter method for language of employment contract
     * @return language of employment contract
     */
    public String getContractlanguage() {
        return contractlanguage;
    }
    /**
     * setter method for language of employment contract
     * @param contractlanguage 
     * sets current language of employment contract to new language
     */
    public void setContractlanguage(String contractlanguage) {
        this.contractlanguage = contractlanguage;
    }
    /**
     * getter method for opposition name of employment contract
     * @return opposition name of employment contract
     */
    public String getContractOppName() {
        return contractOppName;
    }
    /**
     * setter method for opposition name of employment contract
     * @param contractOppName 
     * sets current opposition name of employment contract to new opposition name
     */
    public void setContractOppName(String contractOppName) {
        this.contractOppName = contractOppName;
    }
    /**
     * getter method for relationship of opposition of employment contract
     * @return relationship of opposition of employment contract
     */
    public String getContractOppRelationship() {
        return contractOppRelationship;
    }
    /**
     * setter method for relationship of opposition in employment contract
     * @param contractOppRelationship 
     * sets current relationship of opposition in employment contract to new relationship of opposition
     */
    public void setContractOppRelationship(String contractOppRelationship) {
        this.contractOppRelationship = contractOppRelationship;
    }
    /**
     * getter method for occupation of employment contract
     * @return occupation of employment contract
     */
    public String getContractOccupation() {
        return contractOccupation;
    }
    /**
     * setter method for occupation of employment contract
     * @param contractOccupation 
     * sets current occupation of employment contract to new occupation
     */
    public void setContractOccupation(String contractOccupation) {
        this.contractOccupation = contractOccupation;
    }
    /**
     * getter method for basic salary in employment contract
     * @return basic salary in employment contract
     */
    public String getContractBasicSalary() {
        return contractBasicSalary;
    }
    /**
     * setter method for basic salary of employment contract
     * @param contractBasicSalary 
     * sets current basic salary of employment contract to new basic salary
     */
    public void setContractBasicSalary(String contractBasicSalary) {
        this.contractBasicSalary = contractBasicSalary;
    }
    /**
     * getter method for allowances of employment contract
     * @return allowances of employment contract
     */
    public String getContractAllowances() {
        return contractAllowances;
    }
    /**
     * setter method for allowances of employment contract
     * @param contractAllowances 
     * sets current allowance of employment contract to new allowance
     */
    public void setContractAllowances(String contractAllowances) {
        this.contractAllowances = contractAllowances;
    }
    /**
     * getter method for deduct details of employment contract
     * @return deduct details of employment contract
     */
    public String getContractDeductDetails() {
        return contractDeductDetails;
    }
    /**
     * setter method for deduct detail of employment contract
     * @param id 
     * sets current id of employment contract to new id
     */
    public void setContractDeductDetails(String contractDeductDetails) {
        this.contractDeductDetails = contractDeductDetails;
    }
    /**
     * getter method for duration of employment contract
     * @return duration of employment contract
     */
    public String getContractDuration() {
        return contractDuration;
    }

    public void setContractDuration(String contractDuration) {
        this.contractDuration = contractDuration;
    }
    /**
     * getter method for duress of employment contract
     * @return duress of employment contract
     */
    public String getContractDuress() {
        return contractDuress;
    }

    public void setContractDuress(String contractDuress) {
        this.contractDuress = contractDuress;
    }
    /**
     * getter method for remarks of employment contract
     * @return remarks of employment contract
     */
    public String getContractRemarks() {
        return contractRemarks;
    }

    public void setContractRemarks(String contractRemarks) {
        this.contractRemarks = contractRemarks;
    }

    @Override
    /*
     * toString method for employment contract with id
     * @return details of employment contract with id
     */
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
    /*
     * toString method for employment contract without id
     * @return details of employment contract without id
     */
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
