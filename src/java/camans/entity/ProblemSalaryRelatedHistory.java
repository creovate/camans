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

    /**
     *
     * @param id id
     * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problemKey problem key
     * @param salHistBasic salary history basis
     * @param salHistOt salary history overtime
     * @param salHistAllowances salary history allowances
     * @param salHistDeductions salary history deductions
     * @param salHistKickbacks salary history kickbacks
     * @param salHistOther other salary history
     * @param salMode mode of salary history
     * @param salModeMore more mode of salary history
     * @param salLossTotal total salary history loss
     * @param salLoss1Year salary history loss in one year
     * @param salHisRemarks remark of salary history
     */
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

    /**
     *
      * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problemKey problem key
     * @param salHistBasic salary history basis
     * @param salHistOt salary history overtime
     * @param salHistAllowances salary history allowances
     * @param salHistDeductions salary history deductions
     * @param salHistKickbacks salary history kickbacks
     * @param salHistOther other salary history
     * @param salMode mode of salary history
     * @param salModeMore more mode of salary history
     * @param salLossTotal total salary history loss
     * @param salLoss1Year salary history loss in one year
     * @param salHisRemarks remark of salary history
     */
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

    /**
     * return id
     * @return id
     */
    public int getId() {
        return id;
    }

    /**
     * set is
     * @param id id
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * return FIN
     * @return FIN
     */
    public String getWorkerFinNumber() {
        return workerFinNumber;
    }

    /**
     * set FIN
     * @param workerFinNumber FIN
     */
    public void setWorkerFinNumber(String workerFinNumber) {
        this.workerFinNumber = workerFinNumber;
    }

    /**
     * return job key
     * @return job key
     */
    public int getJobKey() {
        return jobKey;
    }

    /**
     * set job key
     * @param jobKey job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }

    /**
     * return problem key
     * @return problem key
     */
    public int getProblemKey() {
        return problemKey;
    }

    /**
     * set problem key
     * @param problemKey problem key
     */
    public void setProblemKey(int problemKey) {
        this.problemKey = problemKey;
    }

    /**
     * return salary history basic
     * @return salary history basic
     */
    public String getSalHistBasic() {
        return salHistBasic;
    }

    /**
     * set salary history basic
     * @param salHistBasic salary history basic
     */
    public void setSalHistBasic(String salHistBasic) {
        this.salHistBasic = salHistBasic;
    }

    /**
     * return salary history overtime
     * @return salary history overtime
     */
    public String getSalHistOt() {
        return salHistOt;
    }

    /**
     * set salary history overtime
     * @param salHistOt salary history overtime
     */
    public void setSalHistOt(String salHistOt) {
        this.salHistOt = salHistOt;
    }

    /**
     * return salary history allowances
     * @return salary history allowances
     */
    public String getSalHistAllowances() {
        return salHistAllowances;
    }

    /**
     * set salary history allowances
     * @param salHistAllowances salary history allowances
     */
    public void setSalHistAllowances(String salHistAllowances) {
        this.salHistAllowances = salHistAllowances;
    }

    /**
     * return salary history deductions
     * @return salary history deductions
     */
    public String getSalHistDeductions() {
        return salHistDeductions;
    }

    /**
     * set salary history deductions
     * @param salHistDeductions salary history deductions
     */
    public void setSalHistDeductions(String salHistDeductions) {
        this.salHistDeductions = salHistDeductions;
    }

    /**
     * return salary history kickbacks
     * @return salary history kickbacks
     */
    public String getSalHistKickbacks() {
        return salHistKickbacks;
    }

    /**
     * set salary history kickbacks
     * @param salHistKickbacks salary history kickbacks
     */
    public void setSalHistKickbacks(String salHistKickbacks) {
        this.salHistKickbacks = salHistKickbacks;
    }

    /**
     * return other salary history
     * @return other salary history
     */
    public String getSalHistOther() {
        return salHistOther;
    }

    /**
     * set other salary history
     * @param salHistOther other salary history
     */
    public void setSalHistOther(String salHistOther) {
        this.salHistOther = salHistOther;
    }

    /**
     * return salary mode
     * @return salary mode
     */
    public String getSalMode() {
        return salMode;
    }

    /**
     * set salary mode
     * @param salMode salary mode
     */
    public void setSalMode(String salMode) {
        this.salMode = salMode;
    }

    /**
     * return more salary mode
     * @return more salary mode
     */
    public String getSalModeMore() {
        return salModeMore;
    }

    /**
     * set more salary mode
     * @param salModeMore more salary mode
     */
    public void setSalModeMore(String salModeMore) {
        this.salModeMore = salModeMore;
    }

    /**
     * return total salary loss
     * @return total salary loss
     */
    public double getSalLossTotal() {
        return salLossTotal;
    }

    /**
     * set total salary loss
     * @param salLossTotal total salary loss
     */
    public void setSalLossTotal(double salLossTotal) {
        this.salLossTotal = salLossTotal;
    }

    /**
     * return salary loss in one year
     * @return salary loss in one year
     */
    public double getSalLoss1Year() {
        return salLoss1Year;
    }

    /**
     * set salary loss in one year
     * @param salLoss1Year salary loss in one year
     */
    public void setSalLoss1Year(double salLoss1Year) {
        this.salLoss1Year = salLoss1Year;
    }

    /**
     * return salary history remark
     * @return salary history remark
     */
    public String getSalHisRemarks() {
        return salHisRemarks;
    }

    /**
     * set salary history remark
     * @param salHisRemarks salary history remark
     */
    public void setSalHisRemarks(String salHisRemarks) {
        this.salHisRemarks = salHisRemarks;
    }

    @Override
    public String toString() {
        return "ProblemSalaryRelatedHistory{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + ", salHistBasic=" + salHistBasic + 
                ", salHistOt=" + salHistOt + ", salHistAllowances=" + salHistAllowances + 
                ", salHistDeductions=" + salHistDeductions + ", salHistKickbacks=" + salHistKickbacks + 
                ", salHistOther=" + salHistOther + ", salMode=" + salMode + 
                ", salModeMore=" + salModeMore + ", salLossTotal=" + salLossTotal + 
                ", salLoss1Year=" + salLoss1Year + ", salHisRemarks=" + salHisRemarks + '}';
    }
    
    /**
     *
     * @return
     */
    public String toString2() {
        return "Salary Related History [salHistBasic=" + salHistBasic + 
                ", salHistOt=" + salHistOt + ", salHistAllowances=" + salHistAllowances + 
                ", salHistDeductions=" + salHistDeductions + ", salHistKickbacks=" + salHistKickbacks + 
                ", salHistOther=" + salHistOther + ", salMode=" + salMode + 
                ", salModeMore=" + salModeMore + ", salLossTotal=" + salLossTotal + 
                ", salLoss1Year=" + salLoss1Year + ", salHisRemarks=" + salHisRemarks + ']';
    }    
}
