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
    /*
     * Creates new illness object with id
     * @param id identifier of illness
     * @param worker fin number associated with illness
     * @param job key associated with illness
     * @param problem key associated with illness
     * @param start of illness
     * @param when illenss is diagnosed 
     * @param who diagnosed illness
     * @param nature of illness
     * @param if illness is work related
     * @param cause of illness
     * @param remarks of illness
     */
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
    /*
     * Creates new illness object without id
     * @param worker fin number associated with illness
     * @param job key associated with illness
     * @param problem key associated with illness
     * @param start of illness
     * @param when illenss is diagnosed 
     * @param who diagnosed illness
     * @param nature of illness
     * @param if illness is work related
     * @param cause of illness
     * @param remarks of illness
     */
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

    
    /**
     * getter method for id of illness
     * @return id of illness
     */
    public int getId() {
        return id;
    }
    /**
     * setter method for id of illness
     * @param id 
     * sets current id of illness to new id
     */
    public void setId(int id) {
        this.id = id;
    }
    /**
     * getter method for worker fin number associated with illness
     * @return worker fin number associated with illness
     */
    public String getWorkerFinNumber() {
        return workerFinNumber;
    }
     /**
     * setter method for worker fin number associated illness
     * @param workerFinNumber 
     * sets current worker fin number associated with illness to new worker fin number
     */
    public void setWorkerFinNumber(String workerFinNumber) {
        this.workerFinNumber = workerFinNumber;
    }
    /**
     * getter method for job key associated with illness
     * @return job key associated with illness
     */
    public int getJobKey() {
        return jobKey;
    }
    /**
     * setter method for job key associated illness
     * @param jobKey 
     * sets current job key associated with illness to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }
    /**
     * getter method for problem key associated with illness
     * @return problem key associated with illness
     */
    public int getProblemKey() {
        return problemKey;
    }
    /**
     * setter method for problem key associated illness
     * @param problemKey 
     * sets current problem key associated with illness to new problem key
     */
    public void setProblemKey(int problemKey) {
        this.problemKey = problemKey;
    }
     /**
     * getter method for start of illness
     * @return start of illness
     */
    public String getIllnessStart() {
        return illnessStart;
    }
    /**
     * setter method for start of illness
     * @param illnessStart 
     * sets current start of illness to new start
     */
    public void setIllnessStart(String illnessStart) {
        this.illnessStart = illnessStart;
    }
     /**
     * getter method for when illness is diagnosed
     * @return when illness is diagnosed
     */
    public String getIllnessDiagWhen() {
        return illnessDiagWhen;
    }
    /**
     * setter method for when illness is diagnosed
     * @param illnessDiagWhen
     * sets current when illness is diagnosed to new when
     */
    public void setIllnessDiagWhen(String illnessDiagWhen) {
        this.illnessDiagWhen = illnessDiagWhen;
    }
    /**
     * getter method for who diagnosed illness
     * @return who diagnosed illness
     */
    public String getIllnessDiagWho() {
        return illnessDiagWho;
    }
    /**
     * setter method for who diagnosed illness
     * @param illnessDiagWho
     * sets current who diagnosed illness to new who diagnosed illness
     */
    public void setIllnessDiagWho(String illnessDiagWho) {
        this.illnessDiagWho = illnessDiagWho;
    }
    /**
     * getter method for nature of illness
     * @return nature of illness
     */
    public String getIllnessNature() {
        return illnessNature;
    }
    /**
     * setter method for nature of illness
     * @param illnessNature
     * sets current nature of illness to new nature
     */
    public void setIllnessNature(String illnessNature) {
        this.illnessNature = illnessNature;
    }
    /**
     * getter method for whether illness is work related
     * @return whether illness is work related
     */
    public String getIllnessWorkRelated() {
        return illnessWorkRelated;
    }
    /**
     * setter method for whether illness is work related
     * @param illnessWorkRelated 
     * sets current whether illness is work related to new whether illness is work related
     */
    public void setIllnessWorkRelated(String illnessWorkRelated) {
        this.illnessWorkRelated = illnessWorkRelated;
    }
    /**
     * getter method for cause of illness
     * @return cause of illness
     */
    public String getIllnessWhy() {
        return illnessWhy;
    }
    /**
     * setter method for cause of illness
     * @param illnessWhy 
     * sets current cause of illness to new cause
     */
    public void setIllnessWhy(String illnessWhy) {
        this.illnessWhy = illnessWhy;
    }
    /**
     * getter method for remarks of illness
     * @return remarks of illness
     */
    public String getIllnessRemark() {
        return illnessRemark;
    }
    /**
     * setter method for remarks of illness
     * @param illnessRemark 
     * sets current remarks of illness to new remarks
     */
    public void setIllnessRemark(String illnessRemark) {
        this.illnessRemark = illnessRemark;
    }
    /*
     * toString method for details of illness with id
     * @return details of illnes with id
     */
    @Override
    public String toString() {
        return "ProblemIllness{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + ", illnessStart=" + illnessStart + 
                ", illnessDiagWhen=" + illnessDiagWhen + ", illnessDiagWho=" + illnessDiagWho + 
                ", illnessNature=" + illnessNature + ", illnessWorkRelated=" + illnessWorkRelated + 
                ", illnessWhy=" + illnessWhy + ", illnessRemark=" + illnessRemark + '}';
    }
    /*
     * toString method for details of illness without id
     * @return details of illnes without id
     */
    public String toString2() {
        return "Illness [illnessStart=" + illnessStart + 
                ", illnessDiagWhen=" + illnessDiagWhen + ", illnessDiagWho=" + illnessDiagWho + 
                ", illnessNature=" + illnessNature + ", illnessWorkRelated=" + illnessWorkRelated + 
                ", illnessWhy=" + illnessWhy + ", illnessRemark=" + illnessRemark + ']';
    }    
    
}
