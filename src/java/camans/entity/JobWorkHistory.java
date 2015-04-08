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
    private String workHistDate;
    private String workHistFirst;
    private String workHistYearArrive;
    private String workHistPrevious;
    private String workHistPrevProblems;
    private String workHistRemarks;
    /*
     * Creates new job work history object with id
     * @param id identifier of work history
     * @param worker fin number of work history
     * @param how work history happened
     * @param more info of how work history
     * @param date of work history
     * @param first work history
     * @param year arrived of work history
     * @param previous work history
     * @param previous problems of work history
     * @param remarks of work history
     */
    public JobWorkHistory(int id, String workerFinNum, int jobKey, String workHistHow, String workHistHowMore, String workHistDate, String workHistFirst, String workHistYearArrive, String workHistPrevious, String workHistPrevProblems, String workHistRemarks) {
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
    /*
     * Creates new job work history object without id
     * @param worker fin number of work history
     * @param how work history happened
     * @param more info of how work history
     * @param date of work history
     * @param first work history
     * @param year arrived of work history
     * @param previous work history
     * @param previous problems of work history
     * @param remarks of work history
     */
    public JobWorkHistory(String workerFinNum, int jobKey, String workHistHow, String workHistHowMore, String workHistDate, String workHistFirst, String workHistYearArrive, String workHistPrevious, String workHistPrevProblems, String workHistRemarks) {
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

    /**
     * getter method for id for work history
     * @return id of work history
     */
    public int getId() {
        return id;
    }
    /**
     * setter method for id of work history
     * @param id 
     * sets current id of work history to new id
     */
    public void setId(int id) {
        this.id = id;
    }
    /**
     * getter method for worker fin number for work history
     * @return worker fin number of work history
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }
    /**
     * setter method for worker fin number of work history
     * @param workerFinNum 
     * sets current worker fin number of work history to new fin number
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }
    /**
     * getter method for job key for work history
     * @return job key of work history
     */
    public int getJobKey() {
        return jobKey;
    }
    /**
     * setter method for job key of work history
     * @param jobKey
     * sets current job key of work history to new job key
     */
    public void setJobKey(int jobKey) {
        this.jobKey = jobKey;
    }
    /**
     * getter method for how work history happened
     * @return how work history happened
     */
    public String getWorkHistHow() {
        return workHistHow;
    }
    /**
     * setter method for how work history happened
     * @param workHistHow 
     * sets current how work history happened to new how work history happened
     */
    public void setWorkHistHow(String workHistHow) {
        this.workHistHow = workHistHow;
    }
    /**
     * getter method for more info of how work history happened
     * @return more info of how work history happened
     */
    public String getWorkHistHowMore() {
        return workHistHowMore;
    }
    /**
     * setter method for id of work history
     * @param workHistHowMore 
     * sets current id of work history to new id
     */
    public void setWorkHistHowMore(String workHistHowMore) {
        this.workHistHowMore = workHistHowMore;
    }
    /**
     * getter method for date for work history
     * @return date of work history
     */

    public String getWorkHistDate() {
        return workHistDate;
    }
     /**
     * setter method for date of work history
     * @param workHistDate 
     * sets current date of work history to new date
     */
    public void setWorkHistDate(String workHistDate) {
        this.workHistDate = workHistDate;
    }
    
    /**
     * getter method for first work history
     * @return first work history
     */
    public String getWorkHistFirst() {
        return workHistFirst;
    }
    /**
     * setter method for first work history
     * @param workHistFirst
     * sets current first work history to new first work history
     */
    public void setWorkHistFirst(String workHistFirst) {
        this.workHistFirst = workHistFirst;
    }
    /**
     * getter method for year arrived for work history
     * @return year arrived of work history
     */
    public String getWorkHistYearArrive() {
        return workHistYearArrive;
    }
    /**
     * setter method for year arrived of work history
     * @param workHistYearArrive
     * sets current year arrived of work history to new year arrived
     */
    public void setWorkHistYearArrive(String workHistYearArrive) {
        this.workHistYearArrive = workHistYearArrive;
    }
    /**
     * getter method for previous work history
     * @return previous work history
     */
    public String getWorkHistPrevious() {
        return workHistPrevious;
    }
    /**
     * setter method for previous work history
     * @param workHistPrevious 
     * sets current previous work history to new previous work
     */
    public void setWorkHistPrevious(String workHistPrevious) {
        this.workHistPrevious = workHistPrevious;
    }
    /**
     * getter method for previous problems of work history
     * @return previous problems of work history
     */
    public String getWorkHistPrevProblems() {
        return workHistPrevProblems;
    }
    /**
     * setter method for previous problems of work history
     * @param workHistPrevProblems 
     * sets current previous problems of work history to new previous problems
     */
    public void setWorkHistPrevProblems(String workHistPrevProblems) {
        this.workHistPrevProblems = workHistPrevProblems;
    }
    /**
     * getter method for remarks for work history
     * @return remarks of work history
     */
    public String getWorkHistRemarks() {
        return workHistRemarks;
    }
    /**
     * setter method for remarks of work history
     * @param workHistRemarks
     * sets current remarks of work history to new remarks
     */
    public void setWorkHistRemarks(String workHistRemarks) {
        this.workHistRemarks = workHistRemarks;
    }
    /*
     * toString method for details of work history with id
     * @return details of work history with id
     */
    @Override
    public String toString() {
        return "JobWorkHistory{" + "id=" + id + ", workerFinNum=" + workerFinNum + 
                ", jobKey=" + jobKey + ", workHistHow=" + workHistHow + ", workHistHowMore=" + 
                workHistHowMore + ", workHistDate=" + workHistDate + ", workHistFirst=" + 
                workHistFirst + ", workHistYearArrive=" + workHistYearArrive + ", workHistPrevious=" + 
                workHistPrevious + ", workHistPrevProblems=" + workHistPrevProblems + ", workHistRemarks=" + 
                workHistRemarks + '}';
    }
    /*
     * toString method for details of work history without id
     * @return details of work history without id
     */
    public String toString2() {
        return "Work History [workHistHow=" + workHistHow + ", workHistHowMore=" + 
                workHistHowMore + ", workHistDate=" + workHistDate + ", workHistFirst=" + 
                workHistFirst + ", workHistYearArrive=" + workHistYearArrive + ", workHistPrevious=" + 
                workHistPrevious + ", workHistPrevProblems=" + workHistPrevProblems + ", workHistRemarks=" + 
                workHistRemarks + ']';
    }    
    
    
}
