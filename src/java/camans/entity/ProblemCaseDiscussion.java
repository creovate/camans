/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

import java.sql.Date;

/**
 *
 * @author Xiaomeng
 */
public class ProblemCaseDiscussion {
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private Date caseDiscussionDate;
    private String caseDiscussionTime;
    private String caseDiscussionWhere;
    private String caseDiscussionWhereMore;
    private String caseDiscussionWorkerPresent;
    private String caseDiscussionTWC2Person1;
    private String caseDiscussionTWC2Person2;
    private String caseDiscussionOtherPerson;
    private String caseDiscussionTranslator;
    private String caseDiscussionTopic;
    private String caseDiscussionGist;
    private String caseDiscussionAssist;
    private String caseDiscussionCalculate;
    private String caseDiscussionAction;
    private String caseDiscussionRemark;

    //constructor with id
    public ProblemCaseDiscussion(int id, String workerFinNumber, int jobKey, int problemKey, Date caseDiscussionDate, String caseDiscussionTime, String caseDiscussionWhere, String caseDiscussionWhereMore, String caseDiscussionWorkerPresent, String caseDiscussionTWC2Person1, String caseDiscussionTWC2Person2, String caseDiscussionOtherPerson, String caseDiscussionTranslator, String caseDiscussionTopic, String caseDiscussionGist, String caseDiscussionAssist, String caseDiscussionCalculate, String caseDiscussionAction, String caseDiscussionRemark) {
            this.id = id;
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.caseDiscussionDate = caseDiscussionDate;
            this.caseDiscussionTime = caseDiscussionTime;
            this.caseDiscussionWhere = caseDiscussionWhere;
            this.caseDiscussionWhereMore = caseDiscussionWhereMore;
            this.caseDiscussionWorkerPresent = caseDiscussionWorkerPresent;
            this.caseDiscussionTWC2Person1 = caseDiscussionTWC2Person1;
            this.caseDiscussionTWC2Person2 = caseDiscussionTWC2Person2;
            this.caseDiscussionOtherPerson = caseDiscussionOtherPerson;
            this.caseDiscussionTranslator = caseDiscussionTranslator;
            this.caseDiscussionTopic = caseDiscussionTopic;
            this.caseDiscussionGist = caseDiscussionGist;
            this.caseDiscussionAssist = caseDiscussionAssist;
            this.caseDiscussionCalculate = caseDiscussionCalculate;
            this.caseDiscussionAction = caseDiscussionAction;
            this.caseDiscussionRemark = caseDiscussionRemark;
    }

    //constructor without id
    public ProblemCaseDiscussion(String workerFinNumber, int jobKey, int problemKey, Date caseDiscussionDate, String caseDiscussionTime, String caseDiscussionWhere, String caseDiscussionWhereMore, String caseDiscussionWorkerPresent, String caseDiscussionTWC2Person1, String caseDiscussionTWC2Person2, String caseDiscussionOtherPerson, String caseDiscussionTranslator, String caseDiscussionTopic, String caseDiscussionGist, String caseDiscussionAssist, String caseDiscussionCalculate, String caseDiscussionAction, String caseDiscussionRemark) {
            this.workerFinNumber = workerFinNumber;
            this.jobKey = jobKey;
            this.problemKey = problemKey;
            this.caseDiscussionDate = caseDiscussionDate;
            this.caseDiscussionTime = caseDiscussionTime;
            this.caseDiscussionWhere = caseDiscussionWhere;
            this.caseDiscussionWhereMore = caseDiscussionWhereMore;
            this.caseDiscussionWorkerPresent = caseDiscussionWorkerPresent;
            this.caseDiscussionTWC2Person1 = caseDiscussionTWC2Person1;
            this.caseDiscussionTWC2Person2 = caseDiscussionTWC2Person2;
            this.caseDiscussionOtherPerson = caseDiscussionOtherPerson;
            this.caseDiscussionTranslator = caseDiscussionTranslator;
            this.caseDiscussionTopic = caseDiscussionTopic;
            this.caseDiscussionGist = caseDiscussionGist;
            this.caseDiscussionAssist = caseDiscussionAssist;
            this.caseDiscussionCalculate = caseDiscussionCalculate;
            this.caseDiscussionAction = caseDiscussionAction;
            this.caseDiscussionRemark = caseDiscussionRemark;
    }

    public int getId() {
            return id;
    }

    public String getWorkerFinNumber() {
            return workerFinNumber;
    }

    public int getJobKey() {
            return jobKey;
    }

    public int getProblemKey() {
            return problemKey;
    }

    public Date getCaseDiscussionDate() {
            return caseDiscussionDate;
    }

    public String getCaseDiscussionTime() {
            return caseDiscussionTime;
    }

    public String getCaseDiscussionWhere() {
            return caseDiscussionWhere;
    }

    public String getCaseDiscussionWhereMore() {
            return caseDiscussionWhereMore;
    }

    public String getCaseDiscussionWorkerPresent() {
            return caseDiscussionWorkerPresent;
    }

    public String getCaseDiscussionTWC2Person1() {
            return caseDiscussionTWC2Person1;
    }

    public String getCaseDiscussionTWC2Person2() {
            return caseDiscussionTWC2Person2;
    }

    public String getCaseDiscussionOtherPerson() {
            return caseDiscussionOtherPerson;
    }

    public String getCaseDiscussionTranslator() {
            return caseDiscussionTranslator;
    }

    public String getCaseDiscussionTopic() {
            return caseDiscussionTopic;
    }

    public String getCaseDiscussionGist() {
            return caseDiscussionGist;
    }

    public String getCaseDiscussionAssist() {
            return caseDiscussionAssist;
    }

    public String getCaseDiscussionCalculate() {
            return caseDiscussionCalculate;
    }

    public String getCaseDiscussionAction() {
            return caseDiscussionAction;
    }

    public String getCaseDiscussionRemark() {
            return caseDiscussionRemark;
    }

    public void setId(int id) {
            this.id = id;
    }

    public void setWorkerFinNumber(String workerFinNumber) {
            this.workerFinNumber = workerFinNumber;
    }

    public void setJobKey(int jobKey) {
            this.jobKey = jobKey;
    }

    public void setProblemKey(int problemKey) {
            this.problemKey = problemKey;
    }

    public void setCaseDiscussionDate(Date caseDiscussionDate) {
            this.caseDiscussionDate = caseDiscussionDate;
    }

    public void setCaseDiscussionTime(String caseDiscussionTime) {
            this.caseDiscussionTime = caseDiscussionTime;
    }

    public void setCaseDiscussionWhere(String caseDiscussionWhere) {
            this.caseDiscussionWhere = caseDiscussionWhere;
    }

    public void setCaseDiscussionWhereMore(String caseDiscussionWhereMore) {
            this.caseDiscussionWhereMore = caseDiscussionWhereMore;
    }

    public void setCaseDiscussionWorkerPresent(String caseDiscussionWorkerPresent) {
            this.caseDiscussionWorkerPresent = caseDiscussionWorkerPresent;
    }

    public void setCaseDiscussionTWC2Person1(String caseDiscussionTWC2Person1) {
            this.caseDiscussionTWC2Person1 = caseDiscussionTWC2Person1;
    }

    public void setCaseDiscussionTWC2Person2(String caseDiscussionTWC2Person2) {
            this.caseDiscussionTWC2Person2 = caseDiscussionTWC2Person2;
    }

    public void setCaseDiscussionOtherPerson(String caseDiscussionOtherPerson) {
            this.caseDiscussionOtherPerson = caseDiscussionOtherPerson;
    }

    public void setCaseDiscussionTranslator(String caseDiscussionTranslator) {
            this.caseDiscussionTranslator = caseDiscussionTranslator;
    }

    public void setCaseDiscussionTopic(String caseDiscussionTopic) {
            this.caseDiscussionTopic = caseDiscussionTopic;
    }

    public void setCaseDiscussionGist(String caseDiscussionGist) {
            this.caseDiscussionGist = caseDiscussionGist;
    }

    public void setCaseDiscussionAssist(String caseDiscussionAssist) {
            this.caseDiscussionAssist = caseDiscussionAssist;
    }

    public void setCaseDiscussionCalculate(String caseDiscussionCalculate) {
            this.caseDiscussionCalculate = caseDiscussionCalculate;
    }

    public void setCaseDiscussionAction(String caseDiscussionAction) {
            this.caseDiscussionAction = caseDiscussionAction;
    }

    public void setCaseDiscussionRemark(String caseDiscussionRemark) {
            this.caseDiscussionRemark = caseDiscussionRemark;
    }

    @Override
    public String toString() {
        return "ProblemCaseDiscussion{" + "id=" + id + ", workerFinNumber=" + workerFinNumber + 
                ", jobKey=" + jobKey + ", problemKey=" + problemKey + 
                ", caseDiscussionDate=" + caseDiscussionDate + 
                ", caseDiscussionTime=" + caseDiscussionTime + 
                ", caseDiscussionWhere=" + caseDiscussionWhere + 
                ", caseDiscussionWhereMore=" + caseDiscussionWhereMore + 
                ", caseDiscussionWorkerPresent=" + caseDiscussionWorkerPresent + 
                ", caseDiscussionTWC2Person1=" + caseDiscussionTWC2Person1 + 
                ", caseDiscussionTWC2Person2=" + caseDiscussionTWC2Person2 + 
                ", caseDiscussionOtherPerson=" + caseDiscussionOtherPerson + 
                ", caseDiscussionTranslator=" + caseDiscussionTranslator + 
                ", caseDiscussionTopic=" + caseDiscussionTopic + 
                ", caseDiscussionGist=" + caseDiscussionGist + 
                ", caseDiscussionAssist=" + caseDiscussionAssist + 
                ", caseDiscussionCalculate=" + caseDiscussionCalculate + 
                ", caseDiscussionAction=" + caseDiscussionAction + 
                ", caseDiscussionRemark=" + caseDiscussionRemark + '}';
    }
    
    public String toString2() {
        return "Case Discussion [caseDiscussionDate=" + caseDiscussionDate + 
                ", caseDiscussionTime=" + caseDiscussionTime + 
                ", caseDiscussionWhere=" + caseDiscussionWhere + 
                ", caseDiscussionWhereMore=" + caseDiscussionWhereMore + 
                ", caseDiscussionWorkerPresent=" + caseDiscussionWorkerPresent + 
                ", caseDiscussionTWC2Person1=" + caseDiscussionTWC2Person1 + 
                ", caseDiscussionTWC2Person2=" + caseDiscussionTWC2Person2 + 
                ", caseDiscussionOtherPerson=" + caseDiscussionOtherPerson + 
                ", caseDiscussionTranslator=" + caseDiscussionTranslator + 
                ", caseDiscussionTopic=" + caseDiscussionTopic + 
                ", caseDiscussionGist=" + caseDiscussionGist + 
                ", caseDiscussionAssist=" + caseDiscussionAssist + 
                ", caseDiscussionCalculate=" + caseDiscussionCalculate + 
                ", caseDiscussionAction=" + caseDiscussionAction + 
                ", caseDiscussionRemark=" + caseDiscussionRemark + ']';
    }    
}
