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
public class WorkerBankAcct {
    
    //attributes
    private String workerFinNum;
    private int id;
    private String bankAcctName;
    private String bankAcctNumber;
    private String bankName;
    private String bankBranchName;
    private String bankBranchAddress;
    private String bankBranchCode;
    private String bankSwiftCode;
    private String remark;
    private Date obseleteDate;

    /**
     *
     * @param workerFinNum FIN
     * @param id id
     * @param bankAcctName bank account name
     * @param bankAcctNumber bank account number
     * @param bankName bank name
     * @param bankBranchName bank branch name
     * @param bankBranchAddress bank branch address
     * @param bankBranchCode bank branch code
     * @param bankSwiftCode bank swith code
     * @param remark remark
     * @param obseleteDate obsolete date
     */
    public WorkerBankAcct(String workerFinNum, int id, String bankAcctName, String bankAcctNumber, String bankName, String bankBranchName, String bankBranchAddress, String bankBranchCode, String bankSwiftCode, String remark, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.bankAcctName = bankAcctName;
        this.bankAcctNumber = bankAcctNumber;
        this.bankName = bankName;
        this.bankBranchName = bankBranchName;
        this.bankBranchAddress = bankBranchAddress;
        this.bankBranchCode = bankBranchCode;
        this.bankSwiftCode = bankSwiftCode;
        this.remark = remark;
        this.obseleteDate = obseleteDate;
    }

    /**
     *
     * @param workerFinNum FIN
     * @param bankAcctName bank account name
     * @param bankAcctNumber bank account number
     * @param bankName bank name
     * @param bankBranchName bank branch name
     * @param bankBranchAddress bank branch address
     * @param bankBranchCode bank branch code
     * @param bankSwiftCode bank swith code
     * @param remark remark
     * @param obseleteDate obsolete date
     */
    public WorkerBankAcct(String workerFinNum, String bankAcctName, String bankAcctNumber, String bankName, String bankBranchName, String bankBranchAddress, String bankBranchCode, String bankSwiftCode, String remark, Date obseleteDate) {
        this.workerFinNum = workerFinNum;
        this.bankAcctName = bankAcctName;
        this.bankAcctNumber = bankAcctNumber;
        this.bankName = bankName;
        this.bankBranchName = bankBranchName;
        this.bankBranchAddress = bankBranchAddress;
        this.bankBranchCode = bankBranchCode;
        this.bankSwiftCode = bankSwiftCode;
        this.remark = remark;
        this.obseleteDate = obseleteDate;
    }

    /**
     * return FIN
     * @return FIN
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
     * return bank account name
     * @return bank account name
     */
    public String getBankAcctName() {
        return bankAcctName;
    }

    /**
     * set bank account name
     * @param bankAcctName bank account name
     */
    public void setBankAcctName(String bankAcctName) {
        this.bankAcctName = bankAcctName;
    }

    /**
     * return bank account number
     * @return bank account number
     */ 
    public String getBankAcctNumber() {
        return bankAcctNumber;
    }

    /**
     * set bank account number
     * @param bankAcctNumber bank account number
     */
    public void setBankAcctNumber(String bankAcctNumber) {
        this.bankAcctNumber = bankAcctNumber;
    }

    /**
     * return bank name
     * @return bank name
     */
    public String getBankName() {
        return bankName;
    }

    /**
     * set bank name
     * @param bankName bank name
     */
    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    /**
     * return bank branch name
     * @return bank branch name
     */ 
    public String getBankBranchName() {
        return bankBranchName;
    }

    /**
     * set bank branch name
     * @param bankBranchName bank branch name
     */
    public void setBankBranchName(String bankBranchName) {
        this.bankBranchName = bankBranchName;
    }

    /**
     * return bank branch address
     * @return bank branch address
     */
    public String getBankBranchAddress() {
        return bankBranchAddress;
    }

    /**
     * set bank branch address
     * @param bankBranchAddress bank branch address
     */
    public void setBankBranchAddress(String bankBranchAddress) {
        this.bankBranchAddress = bankBranchAddress;
    }

    /**
     * return bank branch code
     * @return  bank branch code
     */
    public String getBankBranchCode() {
        return bankBranchCode;
    }

    /**
     * set bank branch code
     * @param bankBranchCode bank branch code
     */
    public void setBankBranchCode(String bankBranchCode) {
        this.bankBranchCode = bankBranchCode;
    }

    /**
     * return bank swift code
     * @return bank swift code
     */
    public String getBankSwiftCode() {
        return bankSwiftCode;
    }

    /**
     * set bank swift code
     * @param bankSwiftCode bank swift code
     */
    public void setBankSwiftCode(String bankSwiftCode) {
        this.bankSwiftCode = bankSwiftCode;
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

    /**
     * return obsolete date
     * @return obsolete date
     */
    public Date getObseleteDate() {
        return obseleteDate;
    }

    /**
     * set obsolete date
     * @param obseleteDate obsolete date
     */
    public void setObseleteDate(Date obseleteDate) {
        this.obseleteDate = obseleteDate;
    }

    @Override
    public String toString() {
        return "WorkerBankAcct{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", bankAcctName=" + bankAcctName + ", bankAcctNumber=" + bankAcctNumber + ", bankName=" + bankName + ", bankBranchName=" + bankBranchName + ", bankBranchAddress=" + bankBranchAddress + ", bankBranchCode=" + bankBranchCode + ", bankSwiftCode=" + bankSwiftCode + ", remark=" + remark + ", obseleteDate=" + obseleteDate + '}';
    }
 
    
    public String toString2() {
        if (obseleteDate == null) {
            return "WorkerBankAcct [bankAcctName=" + bankAcctName + ", bankAcctNumber=" + bankAcctNumber + ", bankName=" + bankName + ", bankBranchName=" + bankBranchName + ", bankBranchAddress=" + bankBranchAddress + ", bankBranchCode=" + bankBranchCode + ", bankSwiftCode=" + bankSwiftCode + ", remark=" + remark + ']';
        }
        return "WorkerBankAcct [bankAcctName=" + bankAcctName + ", bankAcctNumber=" + bankAcctNumber + ", bankName=" + bankName + ", bankBranchName=" + bankBranchName + ", bankBranchAddress=" + bankBranchAddress + ", bankBranchCode=" + bankBranchCode + ", bankSwiftCode=" + bankSwiftCode + ", remark=" + remark + ", obseleteDate=" + obseleteDate + ']';
    }    
    
}
