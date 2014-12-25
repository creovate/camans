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

    public WorkerLanguage(String workerFinNum, int id, String mainLanguage, String mainLangaugeMore, String spokenLanguageStandard, String remark) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.mainLanguage = mainLanguage;
        this.mainLangaugeMore = mainLangaugeMore;
        this.spokenLanguageStandard = spokenLanguageStandard;
        this.remark = remark;
    }

    public WorkerLanguage(String workerFinNum, String mainLanguage, String mainLangaugeMore, String spokenLanguageStandard, String remark) {
        this.workerFinNum = workerFinNum;
        this.mainLanguage = mainLanguage;
        this.mainLangaugeMore = mainLangaugeMore;
        this.spokenLanguageStandard = spokenLanguageStandard;
        this.remark = remark;
    }

    public String getWorkerFinNum() {
        return workerFinNum;
    }

    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMainLanguage() {
        return mainLanguage;
    }

    public void setMainLanguage(String mainLanguage) {
        this.mainLanguage = mainLanguage;
    }

    public String getMainLangaugeMore() {
        return mainLangaugeMore;
    }

    public void setMainLangaugeMore(String mainLangaugeMore) {
        this.mainLangaugeMore = mainLangaugeMore;
    }

    public String getSpokenLanguageStandard() {
        return spokenLanguageStandard;
    }

    public void setSpokenLanguageStandard(String spokenLanguageStandard) {
        this.spokenLanguageStandard = spokenLanguageStandard;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "WorkerLanguage{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", mainLanguage=" + mainLanguage + ", mainLangaugeMore=" + mainLangaugeMore + ", spokenLanguageStandard=" + spokenLanguageStandard + ", remark=" + remark + '}';
    }
    
    public String toString2() {
        return "WorkerLanguage{" + "workerFinNum=" + workerFinNum + ", mainLanguage=" + mainLanguage + ", mainLangaugeMore=" + mainLangaugeMore + ", spokenLanguageStandard=" + spokenLanguageStandard + ", remark=" + remark + '}';
    }    
}
