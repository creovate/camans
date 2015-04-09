/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

/**
 *
 * @author soemyatmyat
 */
public class WorkerLanguage {
    
    
    //attributes
    private String workerFinNum;
    private int id;
    private String mainLanguage;
    private String mainLangaugeMore;
    private String spokenLanguageStandard;
    private String remark;

    /**
     *
     * @param workerFinNum FIN
     * @param id id
     * @param mainLanguage main language
     * @param mainLangaugeMore more main language
     * @param spokenLanguageStandard spoken language standard
     * @param remark remark
     */
    public WorkerLanguage(String workerFinNum, int id, String mainLanguage, String mainLangaugeMore, String spokenLanguageStandard, String remark) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.mainLanguage = mainLanguage;
        this.mainLangaugeMore = mainLangaugeMore;
        this.spokenLanguageStandard = spokenLanguageStandard;
        this.remark = remark;
    }

    /**
     *
     * @param workerFinNum FIN
    * @param mainLanguage main language
     * @param mainLangaugeMore more main language
     * @param spokenLanguageStandard spoken language standard
     * @param remark remark
     */
    public WorkerLanguage(String workerFinNum, String mainLanguage, String mainLangaugeMore, String spokenLanguageStandard, String remark) {
        this.workerFinNum = workerFinNum;
        this.mainLanguage = mainLanguage;
        this.mainLangaugeMore = mainLangaugeMore;
        this.spokenLanguageStandard = spokenLanguageStandard;
        this.remark = remark;
    }

    /**
     * return FIN
     * @return  FIN
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }

    /**
     * set FIN
     * @param workerFinNum FIN
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }

    /**
     * return id
     * @return id
     */
    public int getId() {
        return id;
    }

    /**
     * set id
     * @param id id
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * return main language
     * @return main language
     */
    public String getMainLanguage() {
        return mainLanguage;
    }

    /**
     * set main language
     * @param mainLanguage main language
     */
    public void setMainLanguage(String mainLanguage) {
        this.mainLanguage = mainLanguage;
    }

    /**
     * return more main language
     * @return more main language
     */
    public String getMainLangaugeMore() {
        return mainLangaugeMore;
    }

    /**
     * set more main language
     * @param mainLangaugeMore more main language
     */
    public void setMainLangaugeMore(String mainLangaugeMore) {
        this.mainLangaugeMore = mainLangaugeMore;
    }

    /**
     * get spoken language standard
     * @return spoken language standard
     */
    public String getSpokenLanguageStandard() {
        return spokenLanguageStandard;
    }

    /**
     * set spoken language standard
     * @param spokenLanguageStandard spoken language standard
     */
    public void setSpokenLanguageStandard(String spokenLanguageStandard) {
        this.spokenLanguageStandard = spokenLanguageStandard;
    }

    /**
     * return remark
     * @return remark
     */
    public String getRemark() {
        return remark;
    }

    /**
     * set remark
     * @param remark remark
     */
    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "WorkerLanguage{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", mainLanguage=" + mainLanguage + ", mainLangaugeMore=" + mainLangaugeMore + ", spokenLanguageStandard=" + spokenLanguageStandard + ", remark=" + remark + '}';
    }
    
    
    public String toString2() {
        return "WorkerLanguage [mainLanguage=" + mainLanguage + ", mainLangaugeMore=" + mainLangaugeMore + ", spokenLanguageStandard=" + spokenLanguageStandard + ", remark=" + remark + ']';
    }    
}
