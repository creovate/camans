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
public class Problem {
    
    //attributes
    private String workerFinNum;
    private int jobKey;
    private int probKey;
    private Date problemRegisteredDate;
    private String problem;
    private String problemMore;
    private String problemRemark;
    private static int COUNT = 200;

    public Problem(String workerFinNum, int jobKey, int probKey, Date problemRegisteredDate, String problem, String problemMore, String problemRemark) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.probKey = probKey;
        this.problemRegisteredDate = problemRegisteredDate;
        this.problem = problem;
        this.problemMore = problemMore;
        this.problemRemark = problemRemark;
    }

    public Problem(String workerFinNum, int jobKey, Date problemRegisteredDate, String problem, String problemMore, String problemRemark) {
        this.workerFinNum = workerFinNum;
        this.jobKey = jobKey;
        this.problemRegisteredDate = problemRegisteredDate;
        this.problem = problem;
        this.problemMore = problemMore;
        this.problemRemark = problemRemark;
        COUNT++;
        this.probKey = COUNT;
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



    public int getProbKey() {
        return probKey;
    }

    public void setProbKey(int probKey) {
        this.probKey = probKey;
    }

    public Date getProblemRegisteredDate() {
        return problemRegisteredDate;
    }

    public void setProblemRegisteredDate(Date problemRegisteredDate) {
        this.problemRegisteredDate = problemRegisteredDate;
    }

    public String getProblem() {
        return problem;
    }

    public void setProblem(String problem) {
        this.problem = problem;
    }

    public String getProblemMore() {
        return problemMore;
    }

    public void setProblemMore(String problemMore) {
        this.problemMore = problemMore;
    }

    public String getProblemRemark() {
        return problemRemark;
    }

    public void setProblemRemark(String problemRemark) {
        this.problemRemark = problemRemark;
    }

    @Override
    public String toString() {
        return "Problem{" + "workerFinNum=" + workerFinNum + ", jobKey=" + jobKey + ", probKey=" + probKey + ", problemRegisteredDate=" + problemRegisteredDate + ", problem=" + problem + ", problemMore=" + problemMore + ", problemRemark=" + problemRemark + '}';
    }
    
    

    
    
}
