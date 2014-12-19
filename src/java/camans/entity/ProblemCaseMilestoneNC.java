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
public class ProblemCaseMilestoneNC {
    
    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private Date MilesNCDate;
    private String MilesNCReached;
    private String MilesNCReachedMore;
    private String MilesNCRem;
	

    
    //constructor with id 
    public ProblemCaseMilestoneNC(int id, String workerFinNumber, int jobKey, int problemKey , 
            Date MilesNCDate, String MilesNCReached, String MilesNCReachedMore, String MilesNCRem) {
		this.id = id;
		this.workerFinNumber = workerFinNumber;
		this.jobKey = jobKey;
		this.problemKey = problemKey;
		this.MilesNCDate = MilesNCDate;
		this.MilesNCReached = MilesNCReached;
		this.MilesNCReachedMore = MilesNCReachedMore;
		this.MilesNCRem = MilesNCRem;
    }
	
    //constructor without id
    public ProblemCaseMilestoneNC(String workerFinNumber, int jobKey, int problemKey , 
            Date MilesNCDate, String MilesNCReached, String MilesNCReachedMore, String MilesNCRem) {

            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.MilesNCDate = MilesNCDate;
            this.MilesNCReached = MilesNCReached;
            this.MilesNCReachedMore = MilesNCReachedMore;
            this.MilesNCRem = MilesNCRem;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
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

    public Date getMilesNCDate() {
        return MilesNCDate;
    }

    public void setMilesNCDate(Date MilesNCDate) {
        this.MilesNCDate = MilesNCDate;
    }

    public String getMilesNCReached() {
        return MilesNCReached;
    }

    public void setMilesNCReached(String MilesNCReached) {
        this.MilesNCReached = MilesNCReached;
    }

    public String getMilesNCReachedMore() {
        return MilesNCReachedMore;
    }

    public void setMilesNCReachedMore(String MilesNCReachedMore) {
        this.MilesNCReachedMore = MilesNCReachedMore;
    }
	
	public String getMilesNCRem() {
        return MilesNCRem;
    }

    public void setMilesNCRem(String MilesNCRem) {
        this.MilesNCRem = MilesNCRem;
    }
	 
	
    
    
}
