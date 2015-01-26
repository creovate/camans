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
    private static int COUNT = 200;
    
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

    public Job(String workerFinNum, String employerName, String workPassType, String workPassMore, 
            String jobSector, String jobSectorMore, String occupation, String jobStartDate, 
            String jobEndDate, String jobTJS, String jobRemark) {
        this.workerFinNum = workerFinNum;
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
        COUNT++;
        this.jobKey = COUNT;
    }

    public String getWorkerFinNum() {
        return workerFinNum;
    }

    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }
    
    public int getJobKey() {
        return jobKey;
    }

    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }

    public String getEmployerName() {
        return employerName;
    }

    public void setEmployerName(String employerName) {
        this.employerName = employerName;
    }

    public String getWorkPassType() {
        return workPassType;
    }

    public void setWorkPassType(String workPassType) {
        this.workPassType = workPassType;
    }

    public String getWorkPassMore() {
        return workPassMore;
    }

    public void setWorkPassMore(String workPassMore) {
        this.workPassMore = workPassMore;
    }

    public String getJobSector() {
        return jobSector;
    }

    public void setJobSector(String jobSector) {
        this.jobSector = jobSector;
    }

    public String getJobSectorMore() {
        return jobSectorMore;
    }

    public void setJobSectorMore(String jobSectorMore) {
        this.jobSectorMore = jobSectorMore;
    }

    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    public String getJobStartDate() {
        return jobStartDate;
    }

    public void setJobStartDate(String jobStartDate) {
        this.jobStartDate = jobStartDate;
    }

    public String getJobEndDate() {
        return jobEndDate;
    }

    public void setJobEndDate(String jobEndDate) {
        this.jobEndDate = jobEndDate;
    }

    public String getJobTJS() {
        return jobTJS;
    }

    public void setJobTJS(String jobTJS) {
        this.jobTJS = jobTJS;
    }

    public String getJobRemark() {
        return jobRemark;
    }

    public void setJobRemark(String jobRemark) {
        this.jobRemark = jobRemark;
    }

    @Override
    public String toString() {
        return "Job{" + "workerFinNum=" + workerFinNum + ", jobKey=" + jobKey + 
                ", employerName=" + employerName + ", workPassType=" + workPassType + 
                ", workPassMore=" + workPassMore + ", jobSector=" + jobSector + 
                ", jobSectorMore=" + jobSectorMore + ", occupation=" + occupation + 
                ", jobStartDate=" + jobStartDate + ", jobEndDate=" + jobEndDate + 
                ", jobTJS=" + jobTJS + ", jobRemark=" + jobRemark + '}';
    }

    public String toString2() {
        return "Job{" + "workerFinNum=" + workerFinNum + 
                ", employerName=" + employerName + ", workPassType=" + workPassType + 
                ", workPassMore=" + workPassMore + ", jobSector=" + jobSector + 
                ", jobSectorMore=" + jobSectorMore + ", occupation=" + occupation + 
                ", jobStartDate=" + jobStartDate + ", jobEndDate=" + jobEndDate + 
                ", jobTJS=" + jobTJS + ", jobRemark=" + jobRemark + '}';
    }
    
    
}
