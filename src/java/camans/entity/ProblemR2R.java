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
	

    
     /**
    * Constructor for ProblemR2R class
    *
    * @param id - id
    * @param workerFinNumber - worker's FIN
    * @param jobKey - job key
    * @param problemKey - problem key
    * @param R2RDate - date of appointment
    * @param R2RTime - time of appointment
    * @param R2RHosp - hospital for appointment
    * @param R2RDept - department/doctor for appointment
    * @param R2R1 - R2R first volunteer
    * @param R2R2 - R2R second volunteer
    * @param R2RPurpose - purpose of appointment
    * @param R2RPreApptNotes - pre-appointment notes
    * @param R2RPostApptNotes - post-appointment notes
    * @param R2RFeedback - feedback
    * @param R2RMedCost - medical cost of this appointment
    * @param R2ROutlay - how much paid by volunteer
    */
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
    /**
    * Constructor for ProblemR2R class without id
    *
    * @param workerFinNumber - worker's FIN
    * @param jobKey - job key
    * @param problemKey - problem key
    * @param R2RDate - date of appointment
    * @param R2RTime - time of appointment
    * @param R2RHosp - hospital for appointment
    * @param R2RDept - department/doctor for appointment
    * @param R2R1 - R2R first volunteer
    * @param R2R2 - R2R second volunteer
    * @param R2RPurpose - purpose of appointment
    * @param R2RPreApptNotes - pre-appointment notes
    * @param R2RPostApptNotes - post-appointment notes
    * @param R2RFeedback - feedback
    * @param R2RMedCost - medical cost of this appointment
    * @param R2ROutlay - how much paid by volunteer
    */
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
	

    /**
    * Sets id
    *
    * @param id  id
    */
    public void setId(int id) {
        this.id = id;
    }

    /**
    * Returns worker FIN
    *
    * @return worker FIN
    */
    public String getWorkerFinNumber() {
        return workerFinNumber;
    }

    /**
    * Sets worker FIN
    *
    * @param workerFinNumber  worker FIN
    */
    public void setWorkerFinNumber(String workerFinNumber) {
        this.workerFinNumber = workerFinNumber;
    }

    /**
    * Returns job key
    *
    * @return job key
    */
    public int getJobKey() {
        return jobKey;
    }

    /**
    * Sets job key
    *
    * @param jobKey  job key
    */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }

    /**
    * Returns problem key
    *
    * @return problem key
    */
    public int getProblemKey() {
        return problemKey;
    }

    /**
    * Sets hospital for appointment
    *
    * @param R2RHosp  hospital for appointment
    */
    public void setR2RHosp(String R2RHosp) {
        this.R2RHosp = R2RHosp;
    }

    /**
    * Sets medical cost of this appointment
    *
    * @param R2RMedCost  medical cost of this appointment
    */
    public void setR2RMedCost(double R2RMedCost) {
        this.R2RMedCost = R2RMedCost;
    }

    
    /**
    * Sets how much paid by volunteer
    *
    * @param R2ROutlay  how much paid by volunteer
    */
    public void setR2ROutlay(double R2ROutlay) {
        this.R2ROutlay = R2ROutlay;
    }

    /**
    * Returns id
    *
    * @return id
    */
    public int getId() {
        return id;
    }

    /**
    * Returns department/doctor for appointment
    *
    * @return department/doctor for appointment
    */
    public String getR2RDept() {
        return R2RDept;
    }

    
    /**
    * Sets problem key
    *
    * @param problemKey  problem key
    */
    public void setProblemKey(int problemKey) {
        this.problemKey = problemKey;
    }

    /**
    * Returns date of appointment
    *
    * @return date of appointment
    */
    public Date getR2RDate() {
        return R2RDate;
    }

    
    /**
    * Sets date of appointment
    *
    * @param R2RDate  date of appointment
    */
    public void setR2RDate(Date R2RDate) {
        this.R2RDate = R2RDate;
    }

    /**
    * Returns time of appointment
    *
    * @return time of appointment
    */
    public String getR2RTime() {
        return R2RTime;
    }

    
    /**
    * Sets time of appointment
    *
    * @param R2RTime  time of appointment
    */
    public void setR2RTime(String R2RTime) {
        this.R2RTime = R2RTime;
    }

    /**
    * Returns hospital for appointment
    *
    * @return hospital for appointment
    */
    public String getR2RHosp() {
        return R2RHosp;
    }

    
    /**
    * Sets department/doctor for appointment
    *
    * @param R2RDept  department/doctor for appointment
    */
    public void setR2RDept(String R2RDept) {
        this.R2RDept = R2RDept;
    }

    /**
    * Returns R2R first volunteer
    *
    * @return R2R first volunteer
    */
    public String getR2R1() {
        return R2R1;
    }

    
    /**
    * Sets R2R first volunteer
    *
    * @param R2R1  R2R first volunteer
    */
    public void setR2R1(String R2R1) {
        this.R2R1 = R2R1;
    }

    /**
    * Returns R2R second volunteer
    *
    * @return R2R second volunteer
    */
    public String getR2R2() {
    return R2R2;
}

    
    /**
    * Sets R2R second volunteer
    *
    * @param R2R2  R2R second volunteer
    */
    public void setR2R2(String R2R2) {
        this.R2R2 = R2R2;
    }
	
    /**
    * Returns purpose of appointment
    *
    * @return purpose of appointment
    */
    public String getR2RPurpose() {
   return R2RPurpose;
}

    
    /**
    * Sets purpose of appointment
    *
    * @param R2RPurpose  purpose of appointment
    */
    public void setR2RPurpose (String R2RPurpose) {
        this.R2RPurpose = R2RPurpose;
    }
	
    /**
    * Returns pre-appointment notes
    *
    * @return pre-appointment notes
    */
    public String getR2RPreApptNotes(){
    return R2RPreApptNotes;
}

    
    /**
    * Sets pre-appointment notes
    *
    * @param R2RPreApptNotes  pre-appointment notes
    */
    public void setR2RPreApptNotes(String R2RPreApptNotes) {
        this.R2RPreApptNotes = R2RPreApptNotes;
    }
	
    /**
    * Returns post-appointment notes
    *
    * @return post-appointment notes
    */
    public String getR2RPostApptNotes() {
    return R2RPostApptNotes;
}

    
    /**
    * Sets post-appointment notes
    *
    * @param R2RPostApptNotes  post-appointment notes
    */
    public void setR2RPostApptNotes(String R2RPostApptNotes) {
        this.R2RPostApptNotes = R2RPostApptNotes;
    }
	
    /**
    * Returns feedback
    *
    * @return feedback
    */
    public String getR2RFeedback() {
        return R2RFeedback;
    }

    
    /**
    * Sets feedback
    *
    * @param R2RFeedback  feedback
    */
    public void setR2RFeedback(String R2RFeedback) {
        this.R2RFeedback = R2RFeedback;
    }
	
    /**
    * Returns medical cost of this appointment
    *
    * @return medical cost of this appointment
    */
    public double getR2RMedCost() {
        return R2RMedCost;
    }

    
    /**
    * Sets medical cost of this appointment
    *
    * @param R2RMedCost  medical cost of this appointment
    */
    public void setR2RMedCost(float R2RMedCost) {
        this.R2RMedCost = R2RMedCost;
    }
	
    /**
    * Returns how much paid by volunteer
    *
    * @return how much paid by volunteer
    */
    public double getR2ROutlay() {
        return R2ROutlay;
    }

    
    /**
    * Sets how much paid by volunteer
    *
    * @param R2ROutlay  how much paid by volunteer
    */
    public void setR2ROutlay(float R2ROutlay) {
        this.R2ROutlay = R2ROutlay;
    }

    @Override
    public String toString() {
        return "ProblemR2R{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", R2RDate=" + R2RDate + ", R2RTime=" + R2RTime + 
                ", R2RHosp=" + R2RHosp + ", R2RDept=" + R2RDept + ", R2R1=" + R2R1 + ", R2R2=" + R2R2 + 
                ", R2RPurpose=" + R2RPurpose + ", R2RPreApptNotes=" + R2RPreApptNotes + 
                ", R2RPostApptNotes=" + R2RPostApptNotes + ", R2RFeedback=" + R2RFeedback + 
                ", R2RMedCost=" + R2RMedCost + ", R2ROutlay=" + R2ROutlay + '}';
    }
	
    public String toString2() {
        return "R2R [R2RDate=" + R2RDate + ", R2RTime=" + R2RTime + 
                ", R2RHosp=" + R2RHosp + ", R2RDept=" + R2RDept + ", R2R1=" + R2R1 + ", R2R2=" + R2R2 + 
                ", R2RPurpose=" + R2RPurpose + ", R2RPreApptNotes=" + R2RPreApptNotes + 
                ", R2RPostApptNotes=" + R2RPostApptNotes + ", R2RFeedback=" + R2RFeedback + 
                ", R2RMedCost=" + R2RMedCost + ", R2ROutlay=" + R2ROutlay + ']';
    }    
}
