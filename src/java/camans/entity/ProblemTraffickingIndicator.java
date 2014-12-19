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
public class ProblemTraffickingIndicator {
    
    //attributes
    private int id;
    private String workerFinNumber;
    private int jobKey;
    private int problemKey;
    private Date TipiAssessDate;
    private String TipiAssessName;
    private String Tipi21;
    private String Tipi22;
    private String Tipi23;
    private String Tipi24;    
    private String Tipi25;
    private String Tipi26;
    private String Tipi27;
    private String Tipi28;      
    private String Tipi41;
    private String Tipi42;
    private String Tipi43;
    private String Tipi44;    
    private String Tipi45;
    private String Tipi46;
    private String Tipi47;
    private String Tipi48;   
    private String Tipi49;
    private String Tipi50;
    private String Tipi51;
    private String Tipi61;    
    private String Tipi62;
    private String Tipi63;
    private String Tipi64;    
    private String Tipi65;
    private String Tipi66;
    private String Tipi67;   
    private String Tipi81; 
    private String Tipi82; 

    public ProblemTraffickingIndicator(int id, String workerFinNumber, int jobKey, int problemKey, Date TipiAssessDate, String TipiAssessName, String Tipi21, String Tipi22, String Tipi23, String Tipi24, String Tipi25, String Tipi26, String Tipi27, String Tipi28, String Tipi41, String Tipi42, String Tipi43, String Tipi44, String Tipi45, String Tipi46, String Tipi47, String Tipi48, String Tipi49, String Tipi50, String Tipi51, String Tipi61, String Tipi62, String Tipi63, String Tipi64, String Tipi65, String Tipi66, String Tipi67, String Tipi81, String Tipi82) {
        this.id = id;
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.TipiAssessDate = TipiAssessDate;
        this.TipiAssessName = TipiAssessName;
        this.Tipi21 = Tipi21;
        this.Tipi22 = Tipi22;
        this.Tipi23 = Tipi23;
        this.Tipi24 = Tipi24;
        this.Tipi25 = Tipi25;
        this.Tipi26 = Tipi26;
        this.Tipi27 = Tipi27;
        this.Tipi28 = Tipi28;
        this.Tipi41 = Tipi41;
        this.Tipi42 = Tipi42;
        this.Tipi43 = Tipi43;
        this.Tipi44 = Tipi44;
        this.Tipi45 = Tipi45;
        this.Tipi46 = Tipi46;
        this.Tipi47 = Tipi47;
        this.Tipi48 = Tipi48;
        this.Tipi49 = Tipi49;
        this.Tipi50 = Tipi50;
        this.Tipi51 = Tipi51;
        this.Tipi61 = Tipi61;
        this.Tipi62 = Tipi62;
        this.Tipi63 = Tipi63;
        this.Tipi64 = Tipi64;
        this.Tipi65 = Tipi65;
        this.Tipi66 = Tipi66;
        this.Tipi67 = Tipi67;
        this.Tipi81 = Tipi81;
        this.Tipi82 = Tipi82;
    }

    public ProblemTraffickingIndicator(String workerFinNumber, int jobKey, int problemKey, Date TipiAssessDate, String TipiAssessName, String Tipi21, String Tipi22, String Tipi23, String Tipi24, String Tipi25, String Tipi26, String Tipi27, String Tipi28, String Tipi41, String Tipi42, String Tipi43, String Tipi44, String Tipi45, String Tipi46, String Tipi47, String Tipi48, String Tipi49, String Tipi50, String Tipi51, String Tipi61, String Tipi62, String Tipi63, String Tipi64, String Tipi65, String Tipi66, String Tipi67, String Tipi81, String Tipi82) {
        this.workerFinNumber = workerFinNumber;
        this.jobKey = jobKey;
        this.problemKey = problemKey;
        this.TipiAssessDate = TipiAssessDate;
        this.TipiAssessName = TipiAssessName;
        this.Tipi21 = Tipi21;
        this.Tipi22 = Tipi22;
        this.Tipi23 = Tipi23;
        this.Tipi24 = Tipi24;
        this.Tipi25 = Tipi25;
        this.Tipi26 = Tipi26;
        this.Tipi27 = Tipi27;
        this.Tipi28 = Tipi28;
        this.Tipi41 = Tipi41;
        this.Tipi42 = Tipi42;
        this.Tipi43 = Tipi43;
        this.Tipi44 = Tipi44;
        this.Tipi45 = Tipi45;
        this.Tipi46 = Tipi46;
        this.Tipi47 = Tipi47;
        this.Tipi48 = Tipi48;
        this.Tipi49 = Tipi49;
        this.Tipi50 = Tipi50;
        this.Tipi51 = Tipi51;
        this.Tipi61 = Tipi61;
        this.Tipi62 = Tipi62;
        this.Tipi63 = Tipi63;
        this.Tipi64 = Tipi64;
        this.Tipi65 = Tipi65;
        this.Tipi66 = Tipi66;
        this.Tipi67 = Tipi67;
        this.Tipi81 = Tipi81;
        this.Tipi82 = Tipi82;
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

    public Date getTipiAssessDate() {
        return TipiAssessDate;
    }

    public void setTipiAssessDate(Date TipiAssessDate) {
        this.TipiAssessDate = TipiAssessDate;
    }

    public String getTipiAssessName() {
        return TipiAssessName;
    }

    public void setTipiAssessName(String TipiAssessName) {
        this.TipiAssessName = TipiAssessName;
    }

    public String getTipi21() {
        return Tipi21;
    }

    public void setTipi21(String Tipi21) {
        this.Tipi21 = Tipi21;
    }

    public String getTipi22() {
        return Tipi22;
    }

    public void setTipi22(String Tipi22) {
        this.Tipi22 = Tipi22;
    }

    public String getTipi23() {
        return Tipi23;
    }

    public void setTipi23(String Tipi23) {
        this.Tipi23 = Tipi23;
    }

    public String getTipi24() {
        return Tipi24;
    }

    public void setTipi24(String Tipi24) {
        this.Tipi24 = Tipi24;
    }

    public String getTipi25() {
        return Tipi25;
    }

    public void setTipi25(String Tipi25) {
        this.Tipi25 = Tipi25;
    }

    public String getTipi26() {
        return Tipi26;
    }

    public void setTipi26(String Tipi26) {
        this.Tipi26 = Tipi26;
    }

    public String getTipi27() {
        return Tipi27;
    }

    public void setTipi27(String Tipi27) {
        this.Tipi27 = Tipi27;
    }

    public String getTipi28() {
        return Tipi28;
    }

    public void setTipi28(String Tipi28) {
        this.Tipi28 = Tipi28;
    }

    public String getTipi41() {
        return Tipi41;
    }

    public void setTipi41(String Tipi41) {
        this.Tipi41 = Tipi41;
    }

    public String getTipi42() {
        return Tipi42;
    }

    public void setTipi42(String Tipi42) {
        this.Tipi42 = Tipi42;
    }

    public String getTipi43() {
        return Tipi43;
    }

    public void setTipi43(String Tipi43) {
        this.Tipi43 = Tipi43;
    }

    public String getTipi44() {
        return Tipi44;
    }

    public void setTipi44(String Tipi44) {
        this.Tipi44 = Tipi44;
    }

    public String getTipi45() {
        return Tipi45;
    }

    public void setTipi45(String Tipi45) {
        this.Tipi45 = Tipi45;
    }

    public String getTipi46() {
        return Tipi46;
    }

    public void setTipi46(String Tipi46) {
        this.Tipi46 = Tipi46;
    }

    public String getTipi47() {
        return Tipi47;
    }

    public void setTipi47(String Tipi47) {
        this.Tipi47 = Tipi47;
    }

    public String getTipi48() {
        return Tipi48;
    }

    public void setTipi48(String Tipi48) {
        this.Tipi48 = Tipi48;
    }

    public String getTipi49() {
        return Tipi49;
    }

    public void setTipi49(String Tipi49) {
        this.Tipi49 = Tipi49;
    }

    public String getTipi50() {
        return Tipi50;
    }

    public void setTipi50(String Tipi50) {
        this.Tipi50 = Tipi50;
    }

    public String getTipi51() {
        return Tipi51;
    }

    public void setTipi51(String Tipi51) {
        this.Tipi51 = Tipi51;
    }

    public String getTipi61() {
        return Tipi61;
    }

    public void setTipi61(String Tipi61) {
        this.Tipi61 = Tipi61;
    }

    public String getTipi62() {
        return Tipi62;
    }

    public void setTipi62(String Tipi62) {
        this.Tipi62 = Tipi62;
    }

    public String getTipi63() {
        return Tipi63;
    }

    public void setTipi63(String Tipi63) {
        this.Tipi63 = Tipi63;
    }

    public String getTipi64() {
        return Tipi64;
    }

    public void setTipi64(String Tipi64) {
        this.Tipi64 = Tipi64;
    }

    public String getTipi65() {
        return Tipi65;
    }

    public void setTipi65(String Tipi65) {
        this.Tipi65 = Tipi65;
    }

    public String getTipi66() {
        return Tipi66;
    }

    public void setTipi66(String Tipi66) {
        this.Tipi66 = Tipi66;
    }

    public String getTipi67() {
        return Tipi67;
    }

    public void setTipi67(String Tipi67) {
        this.Tipi67 = Tipi67;
    }

    public String getTipi81() {
        return Tipi81;
    }

    public void setTipi81(String Tipi81) {
        this.Tipi81 = Tipi81;
    }

    public String getTipi82() {
        return Tipi82;
    }

    public void setTipi82(String Tipi82) {
        this.Tipi82 = Tipi82;
    }
    
    
    
}
