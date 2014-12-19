/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

/**
 *
 * @author soemyatmyat
 */
public class ProblemIllness {

    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private String illnessStart;
    private String illnessDiagWhen;
    private String illnessDiagWho;
    private String illnessNature;
    private String illnessWorkRelated;
    private String illnessWhy;
    private String illnessRemark;

    public ProblemIllness(int id, String workerFinNumber, int jobKey, int problemKey, String illnessStart, String illnessDiagWhen, String illnessDiagWho, String illnessNature, String illnessWorkRelated, String illnessWhy, String illnessRemark) {
        this.id = id;
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.illnessStart = illnessStart;
        this.illnessDiagWhen = illnessDiagWhen;
        this.illnessDiagWho = illnessDiagWho;
        this.illnessNature = illnessNature;
        this.illnessWorkRelated = illnessWorkRelated;
        this.illnessWhy = illnessWhy;
        this.illnessRemark = illnessRemark;
    }

    public ProblemIllness(String workerFinNumber, int jobKey, int problemKey, String illnessStart, String illnessDiagWhen, String illnessDiagWho, String illnessNature, String illnessWorkRelated, String illnessWhy, String illnessRemark) {
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.illnessStart = illnessStart;
        this.illnessDiagWhen = illnessDiagWhen;
        this.illnessDiagWho = illnessDiagWho;
        this.illnessNature = illnessNature;
        this.illnessWorkRelated = illnessWorkRelated;
        this.illnessWhy = illnessWhy;
        this.illnessRemark = illnessRemark;
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

    public String getIllnessStart() {
        return illnessStart;
    }

    public void setIllnessStart(String illnessStart) {
        this.illnessStart = illnessStart;
    }

    public String getIllnessDiagWhen() {
        return illnessDiagWhen;
    }

    public void setIllnessDiagWhen(String illnessDiagWhen) {
        this.illnessDiagWhen = illnessDiagWhen;
    }

    public String getIllnessDiagWho() {
        return illnessDiagWho;
    }

    public void setIllnessDiagWho(String illnessDiagWho) {
        this.illnessDiagWho = illnessDiagWho;
    }

    public String getIllnessNature() {
        return illnessNature;
    }

    public void setIllnessNature(String illnessNature) {
        this.illnessNature = illnessNature;
    }

    public String getIllnessWorkRelated() {
        return illnessWorkRelated;
    }

    public void setIllnessWorkRelated(String illnessWorkRelated) {
        this.illnessWorkRelated = illnessWorkRelated;
    }

    public String getIllnessWhy() {
        return illnessWhy;
    }

    public void setIllnessWhy(String illnessWhy) {
        this.illnessWhy = illnessWhy;
    }

    public String getIllnessRemark() {
        return illnessRemark;
    }

    public void setIllnessRemark(String illnessRemark) {
        this.illnessRemark = illnessRemark;
    }
    
    
}
