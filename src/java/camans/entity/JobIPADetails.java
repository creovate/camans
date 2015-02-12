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

    public String getIpaPassType() {
        return ipaPassType;
    }

    public void setIpaPassType(String ipaPassType) {
        this.ipaPassType = ipaPassType;
    }

    public String getIpaPassTypeMore() {
        return ipaPassTypeMore;
    }

    public void setIpaPassTypeMore(String ipaPassTypeMore) {
        this.ipaPassTypeMore = ipaPassTypeMore;
    }

    public Date getIpaApplicationDate() {
        return ipaApplicationDate;
    }

    public void setIpaApplicationDate(Date ipaApplicationDate) {
        this.ipaApplicationDate = ipaApplicationDate;
    }

    public String getIpaEmployerName() {
        return ipaEmployerName;
    }

    public void setIpaEmployerName(String ipaEmployerName) {
        this.ipaEmployerName = ipaEmployerName;
    }

    public String getIpaAgentName() {
        return ipaAgentName;
    }

    public void setIpaAgentName(String ipaAgentName) {
        this.ipaAgentName = ipaAgentName;
    }

    public String getIndustry() {
        return industry;
    }

    public void setIndustry(String industry) {
        this.industry = industry;
    }

    public String getOccuupation() {
        return occuupation;
    }

    public void setOccuupation(String occuupation) {
        this.occuupation = occuupation;
    }

    public double getPeriodYears() {
        return periodYears;
    }

    public void setPeriodYears(double periodYears) {
        this.periodYears = periodYears;
    }

    public double getBasicSalary() {
        return basicSalary;
    }

    public void setBasicSalary(double basicSalary) {
        this.basicSalary = basicSalary;
    }

    public double getIpaAllowances() {
        return ipaAllowances;
    }

    public void setIpaAllowances(double ipaAllowances) {
        this.ipaAllowances = ipaAllowances;
    }

    public String getIpaAllowancesDetails() {
        return ipaAllowancesDetails;
    }

    public void setIpaAllowancesDetails(String ipaAllowancesDetails) {
        this.ipaAllowancesDetails = ipaAllowancesDetails;
    }

    public double getIpaDeduction() {
        return ipaDeduction;
    }

    public void setIpaDeduction(double ipaDeduction) {
        this.ipaDeduction = ipaDeduction;
    }

    public String getIpaDeductionDetails() {
        return ipaDeductionDetails;
    }

    public void setIpaDeductionDetails(String ipaDeductionDetails) {
        this.ipaDeductionDetails = ipaDeductionDetails;
    }

    public String getHousingProvided() {
        return housingProvided;
    }

    public void setHousingProvided(String housingProvided) {
        this.housingProvided = housingProvided;
    }

    public String getIpaRemarks() {
        return ipaRemarks;
    }

    public void setIpaRemarks(String ipaRemarks) {
        this.ipaRemarks = ipaRemarks;
    }

    @Override
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
    
    public String toString2() {
        return "JobIPADetails{" + "WorkerFinNum=" + workerFinNum + ", ipaPassType=" + ipaPassType + 
                ", ipaPassTypeMore=" + ipaPassTypeMore + ", ipaApplicationDate=" + ipaApplicationDate + 
                ", ipaEmployerName=" + ipaEmployerName + ", ipaAgentName=" + ipaAgentName + 
                ", industry=" + industry + ", occuupation=" + occuupation + 
                ", periodYears=" + periodYears + ", basicSalary=" + basicSalary + 
                ", ipaAllowances=" + ipaAllowances + ", ipaAllowancesDetails=" + ipaAllowancesDetails + 
                ", ipaDeduction=" + ipaDeduction + ", ipaDeductionDetails=" + ipaDeductionDetails + 
                ", housingProvided=" + housingProvided + ", ipaRemarks=" + ipaRemarks + '}';
    }    
    
}
