/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

import java.sql.Date;

/**
 *
 * @author kyiLaiLaiShoon
 */
public class ProblemR2R {
    
    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private Date R2RDate;
    private String R2RTime;
    private String R2RHosp ;
    private String R2RDept;
    private String R2R1;
    private String R2R2;
    private String R2RPurpose;
    private String R2RPreApptNotes;
    private String R2RPostApptNotes;
    private String R2RFeedback;
    private double R2RMedCost;
    private double R2ROutlay;
	

    
    //constructor with id 
    public ProblemR2R(int id, String workerFinNumber, int jobKey, int problemKey , 
            Date R2RDate, String R2RTime, String R2RHosp, String R2RDept, String R2R1, 
            String R2R2, String R2RPurpose, String R2RPreApptNotes, String R2RPostApptNotes, 
            String R2RFeedback, double R2RMedCost, double R2ROutlay) {
                this.id = id;
                this.workerFinNumber = workerFinNumber;
                this.jobKey = jobKey;
                this.problemKey = problemKey;
                this.R2RDate = R2RDate;
                this.R2RTime = R2RTime;
                this.R2RHosp = R2RHosp;
                this.R2RDept = R2RDept;
                this.R2R1 = R2R1;
                this.R2R2 = R2R2;
                this.R2RPurpose = R2RPurpose;
                this.R2RPreApptNotes = R2RPreApptNotes;
                this.R2RPostApptNotes = R2RPostApptNotes;
                this.R2RFeedback = R2RFeedback;
                this.R2RMedCost = R2RMedCost;
                this.R2ROutlay = R2ROutlay;
    }

    //constructor without id
    public ProblemR2R(String workerFinNumber, int jobKey, int problemKey , Date R2RDate, 
            String R2RTime, String R2RHosp, String R2RDept, String R2R1, String R2R2, 
            String R2RPurpose, String R2RPreApptNotes, String R2RPostApptNotes, 
            String R2RFeedback, double R2RMedCost, double R2ROutlay) {

            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.R2RDate = R2RDate;
            this.R2RTime = R2RTime;
            this.R2RHosp = R2RHosp;
            this.R2RDept = R2RDept;
            this.R2R1 = R2R1;
            this.R2R2 = R2R2;
            this.R2RPurpose = R2RPurpose;
            this.R2RPreApptNotes = R2RPreApptNotes;
            this.R2RPostApptNotes = R2RPostApptNotes;
            this.R2RFeedback = R2RFeedback;
            this.R2RMedCost = R2RMedCost;
            this.R2ROutlay = R2ROutlay;
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

    public void setR2RHosp(String R2RHosp) {
        this.R2RHosp = R2RHosp;
    }

    public void setR2RMedCost(double R2RMedCost) {
        this.R2RMedCost = R2RMedCost;
    }

    public void setR2ROutlay(double R2ROutlay) {
        this.R2ROutlay = R2ROutlay;
    }

    public int getId() {
        return id;
    }

    public String getR2RDept() {
        return R2RDept;
    }

    public void setProblemKey(int problemKey) {
        this.problemKey = problemKey;
    }

    public Date getR2RDate() {
        return R2RDate;
    }

    public void setR2RDate(Date R2RDate) {
        this.R2RDate = R2RDate;
    }

    public String getR2RTime() {
        return R2RTime;
    }

    public void setR2RTime(String R2RTime) {
        this.R2RTime = R2RTime;
    }

    public String getR2RHosp() {
        return R2RHosp;
    }

    public void setR2RDept(String R2RDept) {
        this.R2RDept = R2RDept;
    }

    public String getR2R1() {
        return R2R1;
    }

    public void setR2R1(String R2R1) {
        this.R2R1 = R2R1;
    }
	
	public String getR2R2() {
        return R2R2;
    }

    public void setR2R2(String R2R2) {
        this.R2R2 = R2R2;
    }
	
	 public String getR2RPurpose() {
        return R2RPurpose;
    }

    public void setR2RPurpose (String R2RPurpose) {
        this.R2RPurpose = R2RPurpose;
    }
	
	public String getR2RPreApptNotes(){
        return R2RPreApptNotes;
    }

    public void setR2RPreApptNotes(String R2RPreApptNotes) {
        this.R2RPreApptNotes = R2RPreApptNotes;
    }
	
	public String getR2RPostApptNotes() {
        return R2RPostApptNotes;
    }

    public void setR2RPostApptNotes(String R2RPostApptNotes) {
        this.R2RPostApptNotes = R2RPostApptNotes;
    }
	
    public String getR2RFeedback() {
        return R2RFeedback;
    }

    public void setR2RFeedback(String R2RFeedback) {
        this.R2RFeedback = R2RFeedback;
    }
	
    public double getR2RMedCost() {
        return R2RMedCost;
    }

    public void setR2RMedCost(float R2RMedCost) {
        this.R2RMedCost = R2RMedCost;
    }
	
    public double getR2ROutlay() {
        return R2ROutlay;
    }

    public void setR2ROutlay(float R2ROutlay) {
        this.R2ROutlay = R2ROutlay;
    }
	 
}
