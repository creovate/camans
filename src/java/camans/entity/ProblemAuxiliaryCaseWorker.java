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
public class ProblemAuxiliaryCaseWorker {
    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private String auxName;
    private Date auxStart;
    private Date auxEnd;

    public ProblemAuxiliaryCaseWorker(int id, String workerFinNumber, int jobKey, int problemKey, String auxName, Date auxStart, Date auxEnd) {
        this.id = id;
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.auxName = auxName;
        this.auxStart = auxStart;
        this.auxEnd = auxEnd;
    }

    public ProblemAuxiliaryCaseWorker(String workerFinNumber, int jobKey, int problemKey, String auxName, Date auxStart, Date auxEnd) {
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.auxName = auxName;
        this.auxStart = auxStart;
        this.auxEnd = auxEnd;
    }

    public int getId() {
        return id;
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

    public void setProblemKey(int problemKey) {
        this.problemKey = problemKey;
    }

    public String getAuxName() {
        return auxName;
    }

    public void setAuxName(String auxName) {
        this.auxName = auxName;
    }

    public Date getAuxStart() {
        return auxStart;
    }

    public void setAuxStart(Date auxStart) {
        this.auxStart = auxStart;
    }

    public Date getAuxEnd() {
        return auxEnd;
    }

    public void setAuxEnd(Date auxEnd) {
        this.auxEnd = auxEnd;
    }

    @Override
    public String toString() {
        return "ProblemAuxiliaryCaseWorker{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + ", jobKey=" + jobKey + ", problemKey=" + problemKey + ", auxName=" + auxName + ", auxStart=" + auxStart + ", auxEnd=" + auxEnd + '}';
    }

    public String toString2() {
        return "ProblemAuxiliaryCaseWorker{" + "WorkerFinNumber=" + workerFinNumber +
                ", auxName=" + auxName + ", auxStart=" + auxStart + ", auxEnd=" + auxEnd + '}';
    }    
    
}
