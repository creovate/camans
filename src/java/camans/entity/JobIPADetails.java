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
public class JobIPADetails {
 
  //attributes
    private int id;
    private String workerFinNum;
    private int jobKey;
    private String ipaPassType;
    private String ipaPassTypeMore;
    private Date ipaApplicationDate;
    private String ipaEmployerName;
    private String ipaAgentName;
    private String industry;
    private String occuupation;
    private double periodYears;
    private double basicSalary;
    private double ipaAllowances;
    private String ipaAllowancesDetails;
    private double ipaDeduction;
    private String ipaDeductionDetails;
    private String housingProvided;
    private String ipaRemarks;
    /*
     * creates new JobIPADetails object with id
     * @param id identifier of IPA details
     * @param fin number of worker with IPA details
     * @param job key of the job of worker with IPA details
     * @param type of IPA pass
     * @param more information on type of IPA pass
     * @param application date of IPA pass
     * @param employer name in IPA pass
     * @param agent name in IPA pass
     * @param industry in IPA pass
     * @param occupation of worker in IPA pass
     * @param period years of IPA pass
     * @param basic salary in IPA pass
     * @param allowances in IPA pass
     * @param details of allowances in IPA pass
     * @param amount of deduction in IPA pass
     * @param details of deduciton in IPA pass
     * @param housing provided in IPA pass
     * @param remarks for IPA pass
     */
    public JobIPADetails(int id, String workerFinNum, int jobKey, String ipaPassType, String ipaPassTypeMore, Date ipaApplicationDate, String ipaEmployerName, String ipaAgentName, String industry, String occuupation, double periodYears, double basicSalary, double ipaAllowances, String ipaAllowancesDetails, double ipaDeduction, String ipaDeductionDetails, String housingProvided, String ipaRemarks) {
        this.id = id;
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.ipaPassType = ipaPassType;
        this.ipaPassTypeMore = ipaPassTypeMore;
        this.ipaApplicationDate = ipaApplicationDate;
        this.ipaEmployerName = ipaEmployerName;
        this.ipaAgentName = ipaAgentName;
        this.industry = industry;
        this.occuupation = occuupation;
        this.periodYears = periodYears;
        this.basicSalary = basicSalary;
        this.ipaAllowances = ipaAllowances;
        this.ipaAllowancesDetails = ipaAllowancesDetails;
        this.ipaDeduction = ipaDeduction;
        this.ipaDeductionDetails = ipaDeductionDetails;
        this.housingProvided = housingProvided;
        this.ipaRemarks = ipaRemarks;
    }
    /*
     * creates new JobIPADetails object without id
     * @param fin number of worker with IPA details
     * @param job key of the job of worker with IPA details
     * @param type of IPA pass
     * @param more information on type of IPA pass
     * @param application date of IPA pass
     * @param employer name in IPA pass
     * @param agent name in IPA pass
     * @param industry in IPA pass
     * @param occupation of worker in IPA pass
     * @param period years of IPA pass
     * @param basic salary in IPA pass
     * @param allowances in IPA pass
     * @param details of allowances in IPA pass
     * @param amount of deduction in IPA pass
     * @param details of deduciton in IPA pass
     * @param housing provided in IPA pass
     * @param remarks for IPA pass
     */
    public JobIPADetails(String workerFinNum, int jobKey, String ipaPassType, String ipaPassTypeMore, Date ipaApplicationDate, String ipaEmployerName, String ipaAgentName, String industry, String occuupation, double periodYears, double basicSalary, double ipaAllowances, String ipaAllowancesDetails, double ipaDeduction, String ipaDeductionDetails, String housingProvided, String ipaRemarks) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.ipaPassType = ipaPassType;
        this.ipaPassTypeMore = ipaPassTypeMore;
        this.ipaApplicationDate = ipaApplicationDate;
        this.ipaEmployerName = ipaEmployerName;
        this.ipaAgentName = ipaAgentName;
        this.industry = industry;
        this.occuupation = occuupation;
        this.periodYears = periodYears;
        this.basicSalary = basicSalary;
        this.ipaAllowances = ipaAllowances;
        this.ipaAllowancesDetails = ipaAllowancesDetails;
        this.ipaDeduction = ipaDeduction;
        this.ipaDeductionDetails = ipaDeductionDetails;
        this.housingProvided = housingProvided;
        this.ipaRemarks = ipaRemarks;
    }

    /**
     * getter method for id of IPA Pass
     * @return id of IPA Pass
     */
    public int getId() {
        return id;
    }
    /**
     * setter method for id of IPA Pass
     * @param id 
     * sets current id of IPA Pass to new id
     */
    public void setId(int id) {
        this.id = id;
    }
    /**
     * getter method for fin number of worker with the IPA Pass
     * @return fin number of worker with the IPA Pass
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }
    /**
     * setter method for worker fin number in IPA Pass
     * @param workerFinNum 
     * sets current fin number of worker in IPA Pass to new fin number
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }
    /**
     * getter method for job key of worker with the IPA Pass
     * @return job key of worker with the IPA Pass
     */
    public int getJobKey() {
        return jobKey;
    }
    /**
     * setter method for job key of worker in IPA Pass
     * @param jobKey 
     * sets current job key of worker in IPA Pass to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }
    /**
     * getter method for type of the IPA Pass
     * @return type of the IPA Pass
     */
    public String getIpaPassType() {
        return ipaPassType;
    }
    /**
     * setter method for type of IPA Pass
     * @param ipaPassType 
     * sets current type of IPA Pass to new type
     */
    public void setIpaPassType(String ipaPassType) {
        this.ipaPassType = ipaPassType;
    }
    /**
     * getter method for more information of type of the IPA Pass
     * @return more information of type of the IPA Pass
     */
    public String getIpaPassTypeMore() {
        return ipaPassTypeMore;
    }
    /**
     * setter method for more information of type of IPA Pass
     * @param ipaPassTypeMore 
     * sets current more information of type of IPA Pass to new more information of type
     */
    public void setIpaPassTypeMore(String ipaPassTypeMore) {
        this.ipaPassTypeMore = ipaPassTypeMore;
    }
    /**
     * getter method for application date of the IPA Pass
     * @return application date of the IPA Pass
     */
    public Date getIpaApplicationDate() {
        return ipaApplicationDate;
    }
    /**
     * setter method for application date of IPA Pass
     * @param ipaApplicationDate 
     * sets current application date of IPA Pass to new application date
     */
    public void setIpaApplicationDate(Date ipaApplicationDate) {
        this.ipaApplicationDate = ipaApplicationDate;
    }
    /**
     * getter method for employer name in the IPA Pass
     * @return employer name in the IPA Pass
     */
    public String getIpaEmployerName() {
        return ipaEmployerName;
    }
    /**
     * setter method for employer name in IPA Pass
     * @param ipaEmployerName 
     * sets current employer name in IPA Pass to new employer name
     */
    public void setIpaEmployerName(String ipaEmployerName) {
        this.ipaEmployerName = ipaEmployerName;
    }
    /**
     * getter method for agent name in the IPA Pass
     * @return agent name in the IPA Pass
     */
    public String getIpaAgentName() {
        return ipaAgentName;
    }
    /**
     * setter method for agent name in IPA Pass
     * @param ipaAgentName 
     * sets current agent name in IPA Pass to new agent name
     */
    public void setIpaAgentName(String ipaAgentName) {
        this.ipaAgentName = ipaAgentName;
    }
    /**
     * getter method for industry in the IPA Pass
     * @return industry in the IPA Pass
     */
    public String getIndustry() {
        return industry;
    }
    /**
     * setter method for industry in IPA Pass
     * @param industry 
     * sets current industry in IPA Pass to new industry
     */
    public void setIndustry(String industry) {
        this.industry = industry;
    }
    /**
     * getter method for occupation in the IPA Pass
     * @return occupation in the IPA Pass
     */
    public String getOccuupation() {
        return occuupation;
    }
    /**
     * setter method for occupation in IPA Pass
     * @param occupation 
     * sets current occupation in IPA Pass to new occupation
     */
    public void setOccuupation(String occuupation) {
        this.occuupation = occuupation;
    }
    /**
     * getter method for period of the IPA Pass
     * @return period of the IPA Pass
     */
     public double getPeriodYears() {
        return periodYears;
    }
     /**
     * setter method for period in IPA Pass
     * @param periodYears 
     * sets current period in IPA Pass to new period
     */
    public void setPeriodYears(double periodYears) {
        this.periodYears = periodYears;
    }
    /**
     * getter method for basic salary in the IPA Pass
     * @return basic salary in the IPA Pass
     */
    public double getBasicSalary() {
        return basicSalary;
    }
    /**
     * setter method for basic salary in IPA Pass
     * @param basicSalary 
     * sets current basic salary in IPA Pass to new basic salary
     */
    public void setBasicSalary(double basicSalary) {
        this.basicSalary = basicSalary;
    }
    /**
     * getter method for amount of allowances in the IPA Pass
     * @return amount of allowances in the IPA Pass
     */
    public double getIpaAllowances() {
        return ipaAllowances;
    }
    /**
     * setter method for amount of allowances in IPA Pass
     * @param ipaAllowances 
     * sets current amount of allowances in IPA Pass to new amount of allowances
     */
    public void setIpaAllowances(double ipaAllowances) {
        this.ipaAllowances = ipaAllowances;
    }
    /**
     * getter method for details of allowances in the IPA Pass
     * @return details of allowances in the IPA Pass
     */
    public String getIpaAllowancesDetails() {
        return ipaAllowancesDetails;
    }
    /**
     * setter method for details of allowances in IPA Pass
     * @param ipaAllowancesDetails
     * sets current details of allowances in IPA Pass to new details of allowances
     */
    public void setIpaAllowancesDetails(String ipaAllowancesDetails) {
        this.ipaAllowancesDetails = ipaAllowancesDetails;
    }
    /**
     * getter method for amount of deduction in the IPA Pass
     * @return amount of deduction in the IPA Pass
     */
    public double getIpaDeduction() {
        return ipaDeduction;
    }
    /**
     * setter method for amount of deduction in IPA Pass
     * @param ipaDeduction 
     * sets current amount of deduction in IPA Pass to new amount of deduction
     */
    public void setIpaDeduction(double ipaDeduction) {
        this.ipaDeduction = ipaDeduction;
    }
    /**
     * getter method for detail of deduction in the IPA Pass
     * @return detail of deduction in the IPA Pass
     */
    public String getIpaDeductionDetails() {
        return ipaDeductionDetails;
    }
    /**
     * setter method for details of deduction in IPA Pass
     * @param ipaDeductionDetails 
     * sets current details of deduction in IPA Pass to new details of deduction
     */
    public void setIpaDeductionDetails(String ipaDeductionDetails) {
        this.ipaDeductionDetails = ipaDeductionDetails;
    }
    /**
     * getter method for housing provided in the IPA Pass
     * @return housing provided in the IPA Pass
     */
    public String getHousingProvided() {
        return housingProvided;
    }
    /**
     * setter method for housing provided in IPA Pass
     * @param housingProvided
     * sets current housing provided in IPA Pass to new housing provided
     */
    public void setHousingProvided(String housingProvided) {
        this.housingProvided = housingProvided;
    }
    /**
     * getter method for remarks in the IPA Pass
     * @return remarks in the IPA Pass
     */
    public String getIpaRemarks() {
        return ipaRemarks;
    }
    /**
     * setter method for remarks in IPA Pass
     * @param ipaRemarks 
     * sets current remarks in IPA Pass to new remarks
     */
    public void setIpaRemarks(String ipaRemarks) {
        this.ipaRemarks = ipaRemarks;
    }

    @Override
    /*
     * toString method for IPA details with id
     * @return IPA details with id
     */
    public String toString() {
        return "JobIPADetails{" + "id=" + id + ", workerFinNum=" + workerFinNum + ", jobKey=" + jobKey + 
                ", ipaPassType=" + ipaPassType + ", ipaPassTypeMore=" + ipaPassTypeMore + 
                ", ipaApplicationDate=" + ipaApplicationDate + ", ipaEmployerName=" + ipaEmployerName + 
                ", ipaAgentName=" + ipaAgentName + ", industry=" + industry + 
                ", occuupation=" + occuupation + ", periodYears=" + periodYears + 
                ", basicSalary=" + basicSalary + ", ipaAllowances=" + ipaAllowances + 
                ", ipaAllowancesDetails=" + ipaAllowancesDetails + ", ipaDeduction=" + ipaDeduction + 
                ", ipaDeductionDetails=" + ipaDeductionDetails + ", housingProvided=" + housingProvided + 
                ", ipaRemarks=" + ipaRemarks + '}';
    }
    /*
     * toString method for IPA details without id
     * @return IPA details without id
     */
    public String toString2() {
        return "IPA Details [ipaPassType=" + ipaPassType + 
                ", ipaPassTypeMore=" + ipaPassTypeMore + ", ipaApplicationDate=" + ipaApplicationDate + 
                ", ipaEmployerName=" + ipaEmployerName + ", ipaAgentName=" + ipaAgentName + 
                ", industry=" + industry + ", occuupation=" + occuupation + 
                ", periodYears=" + periodYears + ", basicSalary=" + basicSalary + 
                ", ipaAllowances=" + ipaAllowances + ", ipaAllowancesDetails=" + ipaAllowancesDetails + 
                ", ipaDeduction=" + ipaDeduction + ", ipaDeductionDetails=" + ipaDeductionDetails + 
                ", housingProvided=" + housingProvided + ", ipaRemarks=" + ipaRemarks + ']';
    }    
    
}
