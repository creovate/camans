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
    
    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public String getMilesNCRem() {
        return MilesNCRem;
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

    public Date getMilesCRDate() {
        return MilesCRDate;
    }

    public void setMilesCRDate (Date MilesCRDate) {
        this.MilesCRDate = MilesCRDate;
    }

    public String getMilesCRReached() {
        return MilesCRReached;
    }

    public void setMilesCRReached(String MilesCRReached) {
        this.MilesCRReached = MilesCRReached;
    }

    public String getMilesCRReachedMore() {
        return MilesCRReachedMore;
    }

    public void setMilesCRReachedMore(String MilesCRReachedMore) {
        this.MilesCRReachedMore = MilesCRReachedMore;
    }
	
    public String getMilesCRCharges() {
        return MilesCRCharges;
    }

    public void setMilesCRCharges(String MilesCRCharges) {
        this.MilesCRCharges = MilesCRCharges;
    }
	
	public String getMilesCRSentence() {
        return MilesCRSentence;
    }

    public void setMilesCRSentence(String MilesCRSentence) {
        this.MilesCRSentence = MilesCRSentence;
    }
	
    public String getMilesCRRem() {
        return MilesNCRem;
    }

    public void setMilesCRRem(String MilesCRRem) {
        this.MilesNCRem = MilesCRRem;
    }
	 
	
    
    
}
