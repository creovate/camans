/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

import java.sql.Date;

/**
 *
 * @author kyilailaishoon
 */
public class ProblemCaseMilestoneCR {
    
    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private Date MilesCRDate;
    private String MilesCRReached;
    private String MilesCRReachedMore ;
    private String MilesCRCharges;
    private String MilesCRSentence;
    private String MilesNCRem;
	

    
    //constructor with id 
   /**
     *Constructor for ProblemCaseMilestoneCR class
     * @param id
     * @param workerFinNumber
     * @param jobKey
     * @param problemKey
     * @param MilesCRDate
     * @param MilesCRReached
     * @param MilesCRReachedMore
     * @param MilesCRCharges
     * @param MilesCRSentence
     * @param MilesCRRem
     */
        public ProblemCaseMilestoneCR(int id, String workerFinNumber, int jobKey, int problemKey , 
            Date MilesCRDate, String MilesCRReached, String MilesCRReachedMore, 
            String MilesCRCharges, String MilesCRSentence, String MilesCRRem) {
        this.id = id;
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.MilesCRDate = MilesCRDate;
        this.MilesCRReached = MilesCRReached;
        this.MilesCRReachedMore = MilesCRReachedMore;
        this.MilesCRCharges = MilesCRCharges;
        this.MilesCRSentence = MilesCRSentence;
        this.MilesNCRem = MilesCRRem;
    }
    
    //constructor without id
 
    /**
     *Constructor for ProblemCaseMilestoneCR class without id
     * @param workerFinNumber
     * @param jobKey
     * @param problemKey
     * @param MilesCRDate
     * @param MilesCRReached
     * @param MilesCRReachedMore
     * @param MilesCRCharges
     * @param MilesCRSentence
     * @param MilesCRRem
     */
        public ProblemCaseMilestoneCR(String workerFinNumber, int jobKey, int problemKey , 
            Date MilesCRDate, String MilesCRReached, String MilesCRReachedMore, 
            String MilesCRCharges, String MilesCRSentence, String MilesCRRem) {

        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.MilesCRDate = MilesCRDate;
        this.MilesCRReached = MilesCRReached;
        this.MilesCRReachedMore = MilesCRReachedMore;
        this.MilesCRCharges = MilesCRCharges;
        this.MilesCRSentence = MilesCRSentence;
        this.MilesNCRem = MilesCRRem;
    }
    
    /**
     * sets id
     * @param id id
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     *returns id
     * @return id
     */
    public int getId() {
        return id;
    }

    /**
     *returns remark
     * @return remark
     */
    public String getMilesNCRem() {
        return MilesNCRem;
    }

    /**
     *returns worker FIN
     * @return worker FIN
     */
    public String getWorkerFinNumber() {
        return workerFinNumber;
    }

    /**
     *sets worker FIN
     * @param workerFinNumber worker FIN
     */
    public void setWorkerFinNumber(String workerFinNumber) {
        this.workerFinNumber = workerFinNumber;
    }

    /**
     *returns job key
     * @return job key
     */
    public int getJobKey() {
        return jobKey;
    }

    /**
     *sets job key
     * @param jobKey job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }

    /**
     *returns problem key
     * @return problem key
     */
    public int getProblemKey() {
        return problemKey;
    }

    /**
     *sets problem key
     * @param problemKey problem key
     */
    public void setProblemKey(int problemKey) {
        this.problemKey = problemKey;
    }

    /**
     *returns date milestone reached
     * @return date milestone reached
     */
    public Date getMilesCRDate() {
        return MilesCRDate;
    }

    /**
     *sets date milestone reached
     * @param MilesCRDate date milestone reached
     */
    public void setMilesCRDate (Date MilesCRDate) {
        this.MilesCRDate = MilesCRDate;
    }

    /**
     *returns milestone reached
     * @return milestone reached
     */
    public String getMilesCRReached() {
        return MilesCRReached;
    }

    /**
     *sets milestone reached
     * @param MilesCRReached milestone reached
     */
    public void setMilesCRReached(String MilesCRReached) {
        this.MilesCRReached = MilesCRReached;
    }

    /**
     *returns more milestone reached
     * @return more milestone reached
     */
    public String getMilesCRReachedMore() {
        return MilesCRReachedMore;
    }

    /**
     *sets more milestone reached
     * @param MilesCRReachedMore more milestone reached
     */
    public void setMilesCRReachedMore(String MilesCRReachedMore) {
        this.MilesCRReachedMore = MilesCRReachedMore;
    }
	
    /**
     *returns details of charges
     * @return details of charges
     */
    public String getMilesCRCharges() {
        return MilesCRCharges;
    }

    /**
     *sets details of charges
     * @param MilesCRCharges details of charges
     */
    public void setMilesCRCharges(String MilesCRCharges) {
        this.MilesCRCharges = MilesCRCharges;
    }
	
    /**
     *returns details of sentence
     * @return details of sentence
     */
    public String getMilesCRSentence() {
    return MilesCRSentence;
}

    /**
     *sets details of sentence
     * @param MilesCRSentence details of sentence
     */
    public void setMilesCRSentence(String MilesCRSentence) {
        this.MilesCRSentence = MilesCRSentence;
    }
	
    /**
     *returns remark
     * @return remark
     */
    public String getMilesCRRem() {
        return MilesNCRem;
    }

    /**
     *sets remark
     * @param MilesCRRem remark
     */
    public void setMilesCRRem(String MilesCRRem) {
        this.MilesNCRem = MilesCRRem;
    }

    @Override
    public String toString() {
        return "ProblemCaseMilestoneCR{" + "WorkerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", MilesCRDate=" + MilesCRDate + ", MilesCRReached=" + MilesCRReached + 
                ", MilesCRReachedMore=" + MilesCRReachedMore + ", MilesCRCharges=" + MilesCRCharges + 
                ", MilesCRSentence=" + MilesCRSentence + ", MilesNCRem=" + MilesNCRem + '}';
    }
	 
    public String toString2() {
        return "CaseMilestone-Criminal [MilesCRDate=" + MilesCRDate + ", MilesCRReached=" + MilesCRReached + 
                ", MilesCRReachedMore=" + MilesCRReachedMore + ", MilesCRCharges=" + MilesCRCharges + 
                ", MilesCRSentence=" + MilesCRSentence + ", MilesNCRem=" + MilesNCRem + ']';
    }    
    
    
}
