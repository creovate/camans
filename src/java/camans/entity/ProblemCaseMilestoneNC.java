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
     /**
     *Constructor for ProblemCaseMilestoneNC class
     * @param id
     * @param workerFinNumber
     * @param jobKey
     * @param problemKey
     * @param MilesNCDate
     * @param MilesNCReached
     * @param MilesNCReachedMore
     * @param MilesNCRem
     */
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
 
    /**
     *Constructor for ProblemCaseMilestoneNC class without id
     * @param workerFinNumber
     * @param jobKey
     * @param problemKey
     * @param MilesNCDate
     * @param MilesNCReached
     * @param MilesNCReachedMore
     * @param MilesNCRem
     */
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
    public Date getMilesNCDate() {
        return MilesNCDate;
    }

    /**
     *sets date milestone reached
     * @param MilesNCDate date milestone reached
     */
    public void setMilesNCDate(Date MilesNCDate) {
        this.MilesNCDate = MilesNCDate;
    }

    /**
     *returns milestone reached
     * @return milestone reached
     */
    public String getMilesNCReached() {
        return MilesNCReached;
    }

    /**
     *sets milestone reached
     * @param MilesNCReached milestone reached
     */
    public void setMilesNCReached(String MilesNCReached) {
        this.MilesNCReached = MilesNCReached;
    }

    /**
     *returns more milestone reached
     * @return more milestone reached
     */
    public String getMilesNCReachedMore() {
        return MilesNCReachedMore;
    }

    /**
     *sets more milestone reached
     * @param MilesNCReachedMore more milestone reached
     */
    public void setMilesNCReachedMore(String MilesNCReachedMore) {
        this.MilesNCReachedMore = MilesNCReachedMore;
    }
	
    /**
     *returns remark
     * @return remark
     */
    public String getMilesNCRem() {
    return MilesNCRem;
}

    /**
     *sets remark
     * @param MilesNCRem remark
     */
    public void setMilesNCRem(String MilesNCRem) {
        this.MilesNCRem = MilesNCRem;
    }

    @Override
    public String toString() {
        return "ProblemCaseMilestoneNC{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + ", MilesNCDate=" + MilesNCDate + 
                ", MilesNCReached=" + MilesNCReached + ", MilesNCReachedMore=" + MilesNCReachedMore + 
                ", MilesNCRem=" + MilesNCRem + '}';
    }
    
    public String toString2() {
        return "Case Milestone Non-Criminal [MilesNCDate=" + MilesNCDate + 
                ", MilesNCReached=" + MilesNCReached + ", MilesNCReachedMore=" + MilesNCReachedMore + 
                ", MilesNCRem=" + MilesNCRem + ']';
    }	 

    
    
}
