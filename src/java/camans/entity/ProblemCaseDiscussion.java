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
    /**
     * Constructor for ProblemCaseDiscussion class
     * @param id id
     * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problemKey problem key
     * @param caseDiscussionDate date of case discussion
     * @param caseDiscussionTime time of case discussion
     * @param caseDiscussionWhere location of case discussion
     * @param caseDiscussionWhereMore other location of case discussion
     * @param caseDiscussionWorkerPresent present worker who attend case discussion
     * @param caseDiscussionTWC2Person1 first TWC person who attend case discussion
     * @param caseDiscussionTWC2Person2 second TWC person who attend case discussion
     * @param caseDiscussionOtherPerson other TWC person who attend case discussion
     * @param caseDiscussionTranslator translator of case discussion
     * @param caseDiscussionTopic topic of case discussion
     * @param caseDiscussionGist gist of case discussion
     * @param caseDiscussionAssist assist of case discussion
     * @param caseDiscussionCalculate calculation of case discussion
     * @param caseDiscussionAction action of case discussion
     * @param caseDiscussionRemark remark of case discussion
     */
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
     /**
     * Constructor for ProblemCaseDiscussion class without id
     * @param workerFinNumber FIN
     * @param jobKey job key
     * @param problemKey problem key
     * @param caseDiscussionDate date of case discussion
     * @param caseDiscussionTime time of case discussion
     * @param caseDiscussionWhere location of case discussion
     * @param caseDiscussionWhereMore other location of case discussion
     * @param caseDiscussionWorkerPresent present worker who attend case discussion
     * @param caseDiscussionTWC2Person1 first TWC person who attend case discussion
     * @param caseDiscussionTWC2Person2 second TWC person who attend case discussion
     * @param caseDiscussionOtherPerson other TWC person who attend case discussion
     * @param caseDiscussionTranslator translator of case discussion
     * @param caseDiscussionTopic topic of case discussion
     * @param caseDiscussionGist gist of case discussion
     * @param caseDiscussionAssist assist of case discussion
     * @param caseDiscussionCalculate calculation of case discussion
     * @param caseDiscussionAction action of case discussion
     * @param caseDiscussionRemark remark of case discussion
     */
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
     * returns job key
     * @return job key
     */
    public int getJobKey() {
            return jobKey;
    }

    /**
     * returns problem key
     * @return problem key
     */
    public int getProblemKey() {
            return problemKey;
    }

    /**
     * returns date of case discussion
     * @return date of case discussion
     */
    public Date getCaseDiscussionDate() {
            return caseDiscussionDate;
    }

    /**
     * returns time of case discussion
     * @return time of case discussion
     */
    public String getCaseDiscussionTime() {
            return caseDiscussionTime;
    }

    /**
     * returns location of case discussion
     * @return location of case discussion
     */
    public String getCaseDiscussionWhere() {
            return caseDiscussionWhere;
    }

    /**
     * returns more location of case discussion
     * @return more location of case discussion
     */
    public String getCaseDiscussionWhereMore() {
            return caseDiscussionWhereMore;
    }

    /**
     * returns worker present
     * @return worker present
     */
    public String getCaseDiscussionWorkerPresent() {
            return caseDiscussionWorkerPresent;
    }

    /**
     * returns TWC2 person in case discussion
     * @return TWC2 person in case discussion
     */
    public String getCaseDiscussionTWC2Person1() {
            return caseDiscussionTWC2Person1;
    }

    /**
     * returns more TWC2 person in case discussion
     * @return more TWC2 person in case discussion
     */
    public String getCaseDiscussionTWC2Person2() {
            return caseDiscussionTWC2Person2;
    }

    /**
     * returns other person in case discussion
     * @return other person in case discussion
     */
    public String getCaseDiscussionOtherPerson() {
            return caseDiscussionOtherPerson;
    }

    /**
     * returns translator present
     * @return translator present
     */
    public String getCaseDiscussionTranslator() {
            return caseDiscussionTranslator;
    }

    /**
     * returns discussion topic
     * @return discussion topic
     */
    public String getCaseDiscussionTopic() {
            return caseDiscussionTopic;
    }

    /**
     * returns discussion gist
     * @return discussion gist
     */
    public String getCaseDiscussionGist() {
            return caseDiscussionGist;
    }

    /**
     * returns assistance or referral provided
     * @return assistance or referral provided
     */
    public String getCaseDiscussionAssist() {
            return caseDiscussionAssist;
    }

    /**
     * returns calculation of claim value
     * @return calculation of claim value
     */
    public String getCaseDiscussionCalculate() {
            return caseDiscussionCalculate;
    }

    /**
     * returns action to follow
     * @return action to follow
     */
    public String getCaseDiscussionAction() {
            return caseDiscussionAction;
    }

    /**
     * returns remark
     * @return remark
     */
    public String getCaseDiscussionRemark() {
            return caseDiscussionRemark;
    }

    /**
     * sets id 
     * @param id id
     */
    public void setId(int id) {
            this.id = id;
    }

    /**
     * sets worker FIN
     * @param workerFinNumber worker FIN
     */
    public void setWorkerFinNumber(String workerFinNumber) {
            this.workerFinNumber = workerFinNumber;
    }

    /**
     * sets job key
     * @param jobKey job key
     */
    public void setJobKey(int jobKey) {
            this.jobKey = jobKey;
    }

    /**
     * sets problem key
     * @param problemKey problem key
     */
    public void setProblemKey(int problemKey) {
            this.problemKey = problemKey;
    }

    /**
     * sets date of case discussion
     * @param caseDiscussionDate date of case discussion
     */
    public void setCaseDiscussionDate(Date caseDiscussionDate) {
            this.caseDiscussionDate = caseDiscussionDate;
    }

    /**
     * sets time of case discussion
     * @param caseDiscussionTime time of case discussion
     */
    public void setCaseDiscussionTime(String caseDiscussionTime) {
            this.caseDiscussionTime = caseDiscussionTime;
    }

    /**
     * sets location of case discussion
     * @param caseDiscussionWhere location of case discussion
     */
    public void setCaseDiscussionWhere(String caseDiscussionWhere) {
            this.caseDiscussionWhere = caseDiscussionWhere;
    }

    /**
     * sets more location of case discussion
     * @param caseDiscussionWhereMore more location of case discussion
     */
    public void setCaseDiscussionWhereMore(String caseDiscussionWhereMore) {
            this.caseDiscussionWhereMore = caseDiscussionWhereMore;
    }

    /**
     * sets worker present
     * @param caseDiscussionWorkerPresent worker present
     */
    public void setCaseDiscussionWorkerPresent(String caseDiscussionWorkerPresent) {
            this.caseDiscussionWorkerPresent = caseDiscussionWorkerPresent;
    }

    /**
     * sets TWC2 person in case discussion
     * @param caseDiscussionTWC2Person1 TWC2 person in case discussion
     */
    public void setCaseDiscussionTWC2Person1(String caseDiscussionTWC2Person1) {
            this.caseDiscussionTWC2Person1 = caseDiscussionTWC2Person1;
    }

    /**
     * sets more TWC2 person in case discussion
     * @param caseDiscussionTWC2Person2 more TWC2 person in case discussion
     */
    public void setCaseDiscussionTWC2Person2(String caseDiscussionTWC2Person2) {
            this.caseDiscussionTWC2Person2 = caseDiscussionTWC2Person2;
    }

    /**
     * sets other person in case discussion
     * @param caseDiscussionOtherPerson other person in case discussion
     */
    public void setCaseDiscussionOtherPerson(String caseDiscussionOtherPerson) {
            this.caseDiscussionOtherPerson = caseDiscussionOtherPerson;
    }

    /**
     * sets translator present
     * @param caseDiscussionTranslator translator present
     */
    public void setCaseDiscussionTranslator(String caseDiscussionTranslator) {
            this.caseDiscussionTranslator = caseDiscussionTranslator;
    }

    /**
     * sets discussion topic
     * @param caseDiscussionTopic discussion topic
     */
    public void setCaseDiscussionTopic(String caseDiscussionTopic) {
            this.caseDiscussionTopic = caseDiscussionTopic;
    }

    /**
     * sets discussion gist
     * @param caseDiscussionGist discussion gist
     */
    public void setCaseDiscussionGist(String caseDiscussionGist) {
            this.caseDiscussionGist = caseDiscussionGist;
    }

    /**
     * sets assistance or referral provided
     * @param caseDiscussionAssist assistance or referral provided
     */
    public void setCaseDiscussionAssist(String caseDiscussionAssist) {
            this.caseDiscussionAssist = caseDiscussionAssist;
    }

    /**
     * sets calculation of claim value
     * @param caseDiscussionCalculate calculation of claim value
     */
    public void setCaseDiscussionCalculate(String caseDiscussionCalculate) {
            this.caseDiscussionCalculate = caseDiscussionCalculate;
    }

    /**
     * sets action to follow
     * @param caseDiscussionAction action to follow
     */
    public void setCaseDiscussionAction(String caseDiscussionAction) {
            this.caseDiscussionAction = caseDiscussionAction;
    }

    /**
     * sets remark
     * @param caseDiscussionRemark remark
     */
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
