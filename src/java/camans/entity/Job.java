/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

/**
 *
 * @author soemyatmyat
 */
public class Job {
    
    //attributes
    private String workerFinNum;
    private int jobKey;
    private String employerName;
    private String workPassType;
    private String workPassMore;
    private String jobSector;
    private String jobSectorMore;
    private String occupation;
    private String jobStartDate;
    private String jobEndDate;
    private String jobTJS;
    private String jobRemark;
   /*
     * creates a new job with jobkey for first job
     * @param workerFinNumber fin number of worker 
     * @param job key of job
     * @param employer name of the job
     * @param work pass type of worker working this job
     * @param more info of work pass of worker working this job
     * @param sector of the job
     * @param occupation of worker at the job
     * @param start date of job
     * @param end date of job
     * @param whether job is TJS job
     * @param remark about job
     */ 
    public Job(String workerFinNum, int jobKey, String employerName, String workPassType, 
            String workPassMore, String jobSector, String jobSectorMore, String occupation, 
            String jobStartDate, String jobEndDate, String jobTJS, String jobRemark) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.employerName = employerName;
        this.workPassType = workPassType;
        this.workPassMore = workPassMore;
        this.jobSector = jobSector;
        this.jobSectorMore = jobSectorMore;
        this.occupation = occupation;
        this.jobStartDate = jobStartDate;
        this.jobEndDate = jobEndDate;
        this.jobTJS = jobTJS;
        this.jobRemark = jobRemark;
    }

    /**
     * getter method for worker fin number
     * @return worker fin number of worker of the job
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }
    /**
     * setter method for fin number of worker of the job
     * @param workerFinNumber 
     * sets current worker's fin number to new fin number
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }
    /**
     * getter method for job key of job
     * @return job key of the job
     */
    public int getJobKey() {
        return jobKey;
    }
    /**
     * setter method for job key of the job
     * @param jobKey 
     * sets current job key of the job to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }
    /**
     * getter method for employer name of job
     * @return employer name of the job
     */
    public String getEmployerName() {
        return employerName;
    }
    /**
     * setter method for employee name of the job
     * @param employerName 
     * sets current employer name of the job to new employer name
     */
    public void setEmployerName(String employerName) {
        this.employerName = employerName;
    }
    /**
     * getter method for work pass type of worker of job
     * @return work pass type of worker of the job
     */
    public String getWorkPassType() {
        return workPassType;
    }
    /**
     * setter method for work pass type of the job
     * @param workPassType 
     * sets current work pass type of the job to new work pass type
     */
    public void setWorkPassType(String workPassType) {
        this.workPassType = workPassType;
    }
    /**
     * getter method for more info of work pass of job
     * @return more info of work pass of the job
     */
    public String getWorkPassMore() {
        return workPassMore;
    }
    /**
     * setter method for more info of work pass of the job
     * @param workPassMore 
     * sets current more info of work pass of the job to new info of work pass
     */
    public void setWorkPassMore(String workPassMore) {
        this.workPassMore = workPassMore;
    }
    /**
     * getter method for sector of job
     * @return more sector of the job
     */
    public String getJobSector() {
        return jobSector;
    }
    /**
     * setter method for job sector of the job
     * @param jobSector 
     * sets current sector of the job to new job key
     */
    public void setJobSector(String jobSector) {
        this.jobSector = jobSector;
    }
    /**
     * getter method for more info of sector of job
     * @return more info of sector of the job
     */
    public String getJobSectorMore() {
        return jobSectorMore;
    }
    /**
     * setter method for more info of job sector of the job
     * @param jobSectorMore 
     * sets current more info of sector of the job to new info of sector
     */
    public void setJobSectorMore(String jobSectorMore) {
        this.jobSectorMore = jobSectorMore;
    }
    /**
     * getter method for occupation of job
     * @return occupation of the job
     */
    public String getOccupation() {
        return occupation;
    }
    /**
     * setter method for occupation for the job
     * @param occupation  
     * sets current occupation for the job to new occupation
     */
    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }
    /**
     * getter method for start date of job
     * @return start date of the job
     */
    public String getJobStartDate() {
        return jobStartDate;
    }
    /**
     * setter method for start date of the job
     * @param jobStartDate 
     * sets current start date of the job to new start date
     */
    public void setJobStartDate(String jobStartDate) {
        this.jobStartDate = jobStartDate;
    }
    /**
     * getter method for end date of job
     * @return end date of the job
     */
    public String getJobEndDate() {
        return jobEndDate;
    }
    /**
     * setter method for end date of the job
     * @param jobEndDate 
     * sets current end date of the job to new end date
     */
    public void setJobEndDate(String jobEndDate) {
        this.jobEndDate = jobEndDate;
    }
    /**
     * getter method for TJS of job
     * @return TJS of the job
     */
    public String getJobTJS() {
        return jobTJS;
    }
    /**
     * setter method for TJS of the job
     * @param jobTJS 
     * sets current TJS of the job to new TJS
     */
    public void setJobTJS(String jobTJS) {
        this.jobTJS = jobTJS;
    }
    /**
     * getter method for remark of job
     * @return remark of the job
     */
    public String getJobRemark() {
        return jobRemark;
    }
    /**
     * setter method for remark of the job
     * @param jobRemark 
     * sets current remark of the job to new remark
     */
    public void setJobRemark(String jobRemark) {
        this.jobRemark = jobRemark;
    }

    @Override
    /**
     * toString method of job with job key
     * @return string of job details with job key
     */
    public String toString() {
        return "Job{" + "workerFinNum=" + workerFinNum + ", jobKey=" + jobKey + 
                ", employerName=" + employerName + ", workPassType=" + workPassType + 
                ", workPassMore=" + workPassMore + ", jobSector=" + jobSector + 
                ", jobSectorMore=" + jobSectorMore + ", occupation=" + occupation + 
                ", jobStartDate=" + jobStartDate + ", jobEndDate=" + jobEndDate + 
                ", jobTJS=" + jobTJS + ", jobRemark=" + jobRemark + '}';
    }
    /**
     * toString method of job without job key 
     * @return string of job details without job key
     */
    public String toString2() {
        return "Job{" + "workerFinNum=" + workerFinNum + 
                ", employerName=" + employerName + ", workPassType=" + workPassType + 
                ", workPassMore=" + workPassMore + ", jobSector=" + jobSector + 
                ", jobSectorMore=" + jobSectorMore + ", occupation=" + occupation + 
                ", jobStartDate=" + jobStartDate + ", jobEndDate=" + jobEndDate + 
                ", jobTJS=" + jobTJS + ", jobRemark=" + jobRemark + '}';
    }
    
    
}
