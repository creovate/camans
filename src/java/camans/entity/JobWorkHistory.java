package camans.entity;

import java.sql.Date;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author soemyatmyat
 */
public class JobWorkHistory {
    //attributes
    
    private int id;
    private String workerFinNum;
    private int jobKey;
    private String workHistHow;
    private String workHistHowMore;
    private Date workHistDate;
    private String workHistFirst;
    private String workHistYearArrive;
    private String workHistPrevious;
    private String workHistPrevProblems;
    private String workHistRemarks;

    public JobWorkHistory(int id, String workerFinNum, int jobKey, String workHistHow, String workHistHowMore, Date workHistDate, String workHistFirst, String workHistYearArrive, String workHistPrevious, String workHistPrevProblems, String workHistRemarks) {
        this.id = id;
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.workHistHow = workHistHow;
        this.workHistHowMore = workHistHowMore;
        this.workHistDate = workHistDate;
        this.workHistFirst = workHistFirst;
        this.workHistYearArrive = workHistYearArrive;
        this.workHistPrevious = workHistPrevious;
        this.workHistPrevProblems = workHistPrevProblems;
        this.workHistRemarks = workHistRemarks;
    }

    public JobWorkHistory(String workerFinNum, int jobKey, String workHistHow, String workHistHowMore, Date workHistDate, String workHistFirst, String workHistYearArrive, String workHistPrevious, String workHistPrevProblems, String workHistRemarks) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.workHistHow = workHistHow;
        this.workHistHowMore = workHistHowMore;
        this.workHistDate = workHistDate;
        this.workHistFirst = workHistFirst;
        this.workHistYearArrive = workHistYearArrive;
        this.workHistPrevious = workHistPrevious;
        this.workHistPrevProblems = workHistPrevProblems;
        this.workHistRemarks = workHistRemarks;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getWorkHistHow() {
        return workHistHow;
    }

    public void setWorkHistHow(String workHistHow) {
        this.workHistHow = workHistHow;
    }

    public String getWorkHistHowMore() {
        return workHistHowMore;
    }

    public void setWorkHistHowMore(String workHistHowMore) {
        this.workHistHowMore = workHistHowMore;
    }

    public Date getWorkHistDate() {
        return workHistDate;
    }

    public void setWorkHistDate(Date workHistDate) {
        this.workHistDate = workHistDate;
    }

    public String getWorkHistFirst() {
        return workHistFirst;
    }

    public void setWorkHistFirst(String workHistFirst) {
        this.workHistFirst = workHistFirst;
    }

    public String getWorkHistYearArrive() {
        return workHistYearArrive;
    }

    public void setWorkHistYearArrive(String workHistYearArrive) {
        this.workHistYearArrive = workHistYearArrive;
    }

    public String getWorkHistPrevious() {
        return workHistPrevious;
    }

    public void setWorkHistPrevious(String workHistPrevious) {
        this.workHistPrevious = workHistPrevious;
    }

    public String getWorkHistPrevProblems() {
        return workHistPrevProblems;
    }

    public void setWorkHistPrevProblems(String workHistPrevProblems) {
        this.workHistPrevProblems = workHistPrevProblems;
    }

    public String getWorkHistRemarks() {
        return workHistRemarks;
    }

    public void setWorkHistRemarks(String workHistRemarks) {
        this.workHistRemarks = workHistRemarks;
    }

    @Override
    public String toString() {
        return "JobWorkHistory{" + "id=" + id + ", workerFinNum=" + workerFinNum + 
                ", jobKey=" + jobKey + ", workHistHow=" + workHistHow + ", workHistHowMore=" + 
                workHistHowMore + ", workHistDate=" + workHistDate + ", workHistFirst=" + 
                workHistFirst + ", workHistYearArrive=" + workHistYearArrive + ", workHistPrevious=" + 
                workHistPrevious + ", workHistPrevProblems=" + workHistPrevProblems + ", workHistRemarks=" + 
                workHistRemarks + '}';
    }
    
    
    
    
}
