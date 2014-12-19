/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

import java.sql.Date;

/**
 *
 * @author soemyatmyat
 */
public class ProblemHospital {
    
    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private Date hospitalUpdate;
    private String hospitalName;
    private String hospitalNameMore ;
    private String hospitalDoctor;
    private String hospitalRemark;

    
    //constructor with id 
    public ProblemHospital(int id, String workerFinNumber, int jobKey, int problemKey,
            Date hospitalUpdate, String hospitalName, String hospitalNameMore, 
            String hospitalDoctor, String hospitalRemark) {
		this.id = id;
		this.workerFinNumber = workerFinNumber;
		this.jobKey = jobKey;
		this.problemKey = problemKey;
		this.hospitalUpdate= hospitalUpdate;
		this.hospitalName =hospitalName;
		this.hospitalNameMore= hospitalNameMore;
		this.hospitalDoctor = hospitalDoctor;
                this.hospitalRemark = hospitalRemark;
	}
	
    //constructor without id
    public ProblemHospital(String workerFinNumber, int jobKey, int problemKey,Date hospitalUpdate, 
            String hospitalName, String hospitalNameMore, String hospitalDoctor, String hospitalRemark){
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.hospitalUpdate= hospitalUpdate;
            this.hospitalName =hospitalName;
            this.hospitalNameMore= hospitalNameMore;
            this.hospitalDoctor = hospitalDoctor;
            this.hospitalRemark = hospitalRemark;
    }

    public String getHospitalRemark() {
        return hospitalRemark;
    }

    public void setHospitalRemark(String hospitalRemark) {
        this.hospitalRemark = hospitalRemark;
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

    public Date getHospitalUpdate() {
        return hospitalUpdate;
    }

    public void setHospitalUpdate(Date hospitalUpdate) {
        this.hospitalUpdate = hospitalUpdate;
    }

    public String getHospitalName() {
        return hospitalName;
    }

    public void setHospitalName(String hospitalName) {
        this.hospitalName = hospitalName;
    }

    public String getHospitalNameMore() {
        return hospitalNameMore;
    }

    public void setHospitalNameMore(String hospitalNameMore) {
        this.hospitalNameMore = hospitalNameMore;
    }

    public String getHospitalDoctor() {
        return hospitalDoctor;
    }

    public void setHospitalDoctor(String hospitalDoctor) {
        this.hospitalDoctor = hospitalDoctor;
    }
    
    
}
