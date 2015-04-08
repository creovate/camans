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
    /**
     * Constructor for ProblemHospital class
     * @param id id 
     * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problemKey problem key
     * @param hospitalUpdate date of update
     * @param hospitalName hospital name
     * @param hospitalNameMore other hospital name
     * @param hospitalDoctor doctor within hospital
     * @param hospitalRemark remark of hospital
     */
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
 
    /**
     * Constructor for ProblemHospital class without id
     * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problemKey problem key
     * @param hospitalUpdate date of update
     * @param hospitalName hospital name
     * @param hospitalNameMore other hospital name
     * @param hospitalDoctor doctor within hospital
     * @param hospitalRemark remark of hospital
     */
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

    /**
     * returns remark
     * @return remark
     */
    public String getHospitalRemark() {
        return hospitalRemark;
    }

    /**
     * sets remark
     * @param hospitalRemark remark
     */
    public void setHospitalRemark(String hospitalRemark) {
        this.hospitalRemark = hospitalRemark;
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
    public Date getHospitalUpdate() {
        return hospitalUpdate;
    }

    /**
     * sets date of update
     * @param hospitalUpdate date of update
     */
    public void setHospitalUpdate(Date hospitalUpdate) {
        this.hospitalUpdate = hospitalUpdate;
    }

    /**
     * returns hospital name
     * @return hospital name
     */
    public String getHospitalName() {
        return hospitalName;
    }

    /**
     * sets hospital name
     * @param hospitalName hospital name
     */
    public void setHospitalName(String hospitalName) {
        this.hospitalName = hospitalName;
    }

    /**
     * returns more hospital name
     * @return more hospital name
     */
    public String getHospitalNameMore() {
        return hospitalNameMore;
    }

    /**
     * sets more hospital name
     * @param hospitalNameMore more hospital name
     */
    public void setHospitalNameMore(String hospitalNameMore) {
        this.hospitalNameMore = hospitalNameMore;
    }

    /**
     * returns department/doctor within hospital
     * @return department/doctor within hospital
     */
    public String getHospitalDoctor() {
        return hospitalDoctor;
    }

    /**
     * sets department/doctor within hospital
     * @param hospitalDoctor department/doctor within hospital
     */
    public void setHospitalDoctor(String hospitalDoctor) {
        this.hospitalDoctor = hospitalDoctor;
    }

    @Override
    public String toString() {
        return "ProblemHospital{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", hospitalUpdate=" + hospitalUpdate + ", hospitalName=" + hospitalName + 
                ", hospitalNameMore=" + hospitalNameMore + ", hospitalDoctor=" + hospitalDoctor + 
                ", hospitalRemark=" + hospitalRemark + '}';
    }
    
    public String toString2() {
        return "Hospital [ hospitalUpdate=" + hospitalUpdate + ", hospitalName=" + hospitalName + 
                ", hospitalNameMore=" + hospitalNameMore + ", hospitalDoctor=" + hospitalDoctor + 
                ", hospitalRemark=" + hospitalRemark + ']';
    }    
    
}
