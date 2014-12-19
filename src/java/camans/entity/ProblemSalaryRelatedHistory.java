/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

/**
 *
 * @author soemyatmyat
 */
public class ProblemSalaryRelatedHistory {
    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private String salHistBasic;
    private String salHistOt;
    private String salHistAllowances;
    private String salHistDeductions;
    private String salHistKickbacks;
    private String salHistOther;
    private String salMode;
    private String salModeMore;
    private double salLossTotal;
    private double salLoss1Year;
    private String salHisRemarks;

    public ProblemSalaryRelatedHistory(int id, String workerFinNumber, int jobKey, int problemKey, 
            String salHistBasic, String salHistOt, String salHistAllowances, 
            String salHistDeductions, String salHistKickbacks, String salHistOther, 
            String salMode, String salModeMore, double salLossTotal, double salLoss1Year, 
            String salHisRemarks) {
        this.id = id;
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.salHistBasic = salHistBasic;
        this.salHistOt = salHistOt;
        this.salHistAllowances = salHistAllowances;
        this.salHistDeductions = salHistDeductions;
        this.salHistKickbacks = salHistKickbacks;
        this.salHistOther = salHistOther;
        this.salMode = salMode;
        this.salModeMore = salModeMore;
        this.salLossTotal = salLossTotal;
        this.salLoss1Year = salLoss1Year;
        this.salHisRemarks = salHisRemarks;
    }

    public ProblemSalaryRelatedHistory(String workerFinNumber, int jobKey, int problemKey, 
            String salHistBasic, String salHistOt, String salHistAllowances, 
            String salHistDeductions, String salHistKickbacks, String salHistOther, 
            String salMode, String salModeMore, double salLossTotal, double salLoss1Year, 
            String salHisRemarks) {
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.salHistBasic = salHistBasic;
        this.salHistOt = salHistOt;
        this.salHistAllowances = salHistAllowances;
        this.salHistDeductions = salHistDeductions;
        this.salHistKickbacks = salHistKickbacks;
        this.salHistOther = salHistOther;
        this.salMode = salMode;
        this.salModeMore = salModeMore;
        this.salLossTotal = salLossTotal;
        this.salLoss1Year = salLoss1Year;
        this.salHisRemarks = salHisRemarks;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getWorkerFinNumber() {
        return workerFinNumber;
    }

    public void setWorkerFinNumber(String workerFinNumber) {
        this.workerFinNumber = workerFinNumber;
    }

    public int getJobKey() {
        return jobKey;
    }

    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }

    public int getProblemKey() {
        return problemKey;
    }

    public void setProblemKey(int problemKey) {
        this.problemKey = problemKey;
    }

    public String getSalHistBasic() {
        return salHistBasic;
    }

    public void setSalHistBasic(String salHistBasic) {
        this.salHistBasic = salHistBasic;
    }

    public String getSalHistOt() {
        return salHistOt;
    }

    public void setSalHistOt(String salHistOt) {
        this.salHistOt = salHistOt;
    }

    public String getSalHistAllowances() {
        return salHistAllowances;
    }

    public void setSalHistAllowances(String salHistAllowances) {
        this.salHistAllowances = salHistAllowances;
    }

    public String getSalHistDeductions() {
        return salHistDeductions;
    }

    public void setSalHistDeductions(String salHistDeductions) {
        this.salHistDeductions = salHistDeductions;
    }

    public String getSalHistKickbacks() {
        return salHistKickbacks;
    }

    public void setSalHistKickbacks(String salHistKickbacks) {
        this.salHistKickbacks = salHistKickbacks;
    }

    public String getSalHistOther() {
        return salHistOther;
    }

    public void setSalHistOther(String salHistOther) {
        this.salHistOther = salHistOther;
    }

    public String getSalMode() {
        return salMode;
    }

    public void setSalMode(String salMode) {
        this.salMode = salMode;
    }

    public String getSalModeMore() {
        return salModeMore;
    }

    public void setSalModeMore(String salModeMore) {
        this.salModeMore = salModeMore;
    }

    public double getSalLossTotal() {
        return salLossTotal;
    }

    public void setSalLossTotal(double salLossTotal) {
        this.salLossTotal = salLossTotal;
    }

    public double getSalLoss1Year() {
        return salLoss1Year;
    }

    public void setSalLoss1Year(double salLoss1Year) {
        this.salLoss1Year = salLoss1Year;
    }

    public String getSalHisRemarks() {
        return salHisRemarks;
    }

    public void setSalHisRemarks(String salHisRemarks) {
        this.salHisRemarks = salHisRemarks;
    }
    
    
}
