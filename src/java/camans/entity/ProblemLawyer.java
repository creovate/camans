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
    /**
     * Constructor for ProblemLawyer class
     * @param id id
     * @param workerFinNumber FIN 
     * @param jobKey job key
     * @param problemKey problem key
     * @param LawyerUpdate date of update
     * @param LawyerFirm law firm
     * @param LawyerFirmMore more law firm
     * @param LawyerName name of lawyer
     * @param LawyerRemarks remarks of lawyer
     */
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
 
    /**
     * Constructor for ProblemLawyer class without id
     * @param workerFinNumber FIN 
     * @param jobKey job key
     * @param problemKey problem key
     * @param LawyerUpdate date of update
     * @param LawyerFirm law firm
     * @param LawyerFirmMore more law firm
     * @param LawyerName name of lawyer
     * @param LawyerRemarks remarks of lawyer
     */
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
    

    /**
     * returns current law firm
     * @return current law firm
     */
    public String getLawyerName() {
        return LawyerName;
    }

    /**
     * sets current law firm
     * @param LawyerName current law firm
     */
    public void setLawyerName(String LawyerName) {
        this.LawyerName = LawyerName;
    }

    /**
     * sets id
     * @param id id
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * returns id
     * @return id
     */
    public int getId() {
        return id;
    }

    /**
     * returns worker FIN
     * @return worker FIN
     */
    public String getWorkerFinNumber() {
        return workerFinNumber;
    }

    /**
     * sets worker FIN
     * @param workerFinNumber worker FIN
     */
    public void setWorkerFinNumber(String workerFinNumber) {
        this.workerFinNumber = workerFinNumber;
    }

    /**
     * returns job key
     * @return job key
     */
    public int getJobKey() {
        return jobKey;
    }

    /**
     * sets job key
     * @param jobKey job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }

    /**
     * returns problem key
     * @return problem key
     */
    public int getProblemKey() {
        return problemKey;
    }

    /**
     * sets problem key
     * @param problemKey problem key
     */
    public void setProblemKey(int problemKey) {
        this.problemKey = problemKey;
    }

    /**
     * returns date of update
     * @return date of update
     */
    public Date getLawyerUpdate() {
        return LawyerUpdate;
    }

    /**
     * sets date of update
     * @param LawyerUpdate date of update
     */
    public void setLawyerUpdate(Date LawyerUpdate) {
        this.LawyerUpdate = LawyerUpdate;
    }

    /**
     * returns more law firm
     * @return more law firm
     */
    public String getLawyerFirmMore() {
        return LawyerFirmMore;
    }

    /**
     * sets more law firm
     * @param LawyerFirmMore more law firm
     */
    public void setLLawyerFirmMore(String LawyerFirmMore) {
        this.LawyerFirmMore = LawyerFirmMore;
    }

    /**
     * returns lay firm
     * @return lay firm
     */
    public String getLawyerFirm() {
        return LawyerFirm;
    }

    /**
     * sets lay firm
     * @param LawyerFirm lay firm
     */
    public void setLawyerFirm(String LawyerFirm) {
        this.LawyerFirm = LawyerFirm;
    }

    /**
     * returns remark
     * @return remark
     */
    public String getLawyerRemarks() {
        return LawyerRemarks;
    }

    /**
     * sets remark
     * @param LawyerRemarks remark
     */
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
        return "Lawyer [LawyerUpdate=" + LawyerUpdate + 
                ", LawyerFirm=" + LawyerFirm + ", LawyerFirmMore=" + LawyerFirmMore + 
                ", LawyerName=" + LawyerName + ", LawyerRemarks=" + LawyerRemarks + ']';
    }	 
  
}
