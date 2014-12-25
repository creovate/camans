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
public class ProblemLawyer {
    
    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private Date LawyerUpdate;
    //private String LawyerHave;
    private String LawyerFirm ;
    private String LawyerFirmMore;
    private String LawyerName;
    private String LawyerRemarks;
	

    
    //constructor with id 
    public ProblemLawyer(int id, String workerFinNumber, int jobKey, int problemKey , 
            Date LawyerUpdate, String LawyerFirm, String LawyerFirmMore, String LawyerName,
            String LawyerRemarks) {
		this.id = id;
		this.workerFinNumber = workerFinNumber;
		this.jobKey = jobKey;
		this.problemKey = problemKey;
		this.LawyerUpdate = LawyerUpdate;
		//this.LawyerHave = LawyerHave;
		this.LawyerFirm = LawyerFirm;
                this.LawyerFirmMore = LawyerFirmMore;
                this.LawyerName = LawyerName;
		this.LawyerRemarks = LawyerRemarks;
	}
	
    //constructor without id
    public ProblemLawyer(String workerFinNumber, int jobKey, int problemKey , Date LawyerUpdate, 
            String LawyerFirm, String LawyerFirmMore, String LawyerName, String LawyerRemarks) {

            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.LawyerUpdate = LawyerUpdate;
            //this.LawyerHave = LawyerHave;
            this.LawyerFirm = LawyerFirm;
            this.LawyerFirmMore = LawyerFirmMore;
            this.LawyerName = LawyerName;
            this.LawyerRemarks = LawyerRemarks;
    }
    /*
    public String getLawyerFirmMore() {
        return LawyerFirmMore;
    }

    public void setLawyerFirmMore(String LawyerFirmMore) {
        this.LawyerFirmMore = LawyerFirmMore;
    }
    */

    public String getLawyerName() {
        return LawyerName;
    }

    public void setLawyerName(String LawyerName) {
        this.LawyerName = LawyerName;
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

    public Date getLawyerUpdate() {
        return LawyerUpdate;
    }

    public void setLawyerUpdate(Date LawyerUpdate) {
        this.LawyerUpdate = LawyerUpdate;
    }

    public String getLawyerFirmMore() {
        return LawyerFirmMore;
    }

    public void setLLawyerFirmMore(String LawyerFirmMore) {
        this.LawyerFirmMore = LawyerFirmMore;
    }

    public String getLawyerFirm() {
        return LawyerFirm;
    }

    public void setLawyerFirm(String LawyerFirm) {
        this.LawyerFirm = LawyerFirm;
    }

    public String getLawyerRemarks() {
        return LawyerRemarks;
    }

    public void setLawyerRemarks(String LawyerRemarks) {
        this.LawyerRemarks = LawyerRemarks;
    }

    @Override
    public String toString() {
        return "ProblemLawyer{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + ", LawyerUpdate=" + LawyerUpdate + 
                ", LawyerFirm=" + LawyerFirm + ", LawyerFirmMore=" + LawyerFirmMore + 
                ", LawyerName=" + LawyerName + ", LawyerRemarks=" + LawyerRemarks + '}';
    }
	
    public String toString2() {
        return "ProblemLawyer{" + "WorkerFinNumber=" + workerFinNumber + ", LawyerUpdate=" + LawyerUpdate + 
                ", LawyerFirm=" + LawyerFirm + ", LawyerFirmMore=" + LawyerFirmMore + 
                ", LawyerName=" + LawyerName + ", LawyerRemarks=" + LawyerRemarks + '}';
    }	 
	
    
    
}
