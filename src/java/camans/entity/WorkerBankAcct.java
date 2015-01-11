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

    public String getBankAcctName() {
        return bankAcctName;
    }

    public void setBankAcctName(String bankAcctName) {
        this.bankAcctName = bankAcctName;
    }

    public String getBankAcctNumber() {
        return bankAcctNumber;
    }

    public void setBankAcctNumber(String bankAcctNumber) {
        this.bankAcctNumber = bankAcctNumber;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getBankBranchName() {
        return bankBranchName;
    }

    public void setBankBranchName(String bankBranchName) {
        this.bankBranchName = bankBranchName;
    }

    public String getBankBranchAddress() {
        return bankBranchAddress;
    }

    public void setBankBranchAddress(String bankBranchAddress) {
        this.bankBranchAddress = bankBranchAddress;
    }

    public String getBankBranchCode() {
        return bankBranchCode;
    }

    public void setBankBranchCode(String bankBranchCode) {
        this.bankBranchCode = bankBranchCode;
    }

    public String getBankSwiftCode() {
        return bankSwiftCode;
    }

    public void setBankSwiftCode(String bankSwiftCode) {
        this.bankSwiftCode = bankSwiftCode;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Date getObseleteDate() {
        return obseleteDate;
    }

    public void setObseleteDate(Date obseleteDate) {
        this.obseleteDate = obseleteDate;
    }

    @Override
    public String toString() {
        return "WorkerBankAcct{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", bankAcctName=" + bankAcctName + ", bankAcctNumber=" + bankAcctNumber + ", bankName=" + bankName + ", bankBranchName=" + bankBranchName + ", bankBranchAddress=" + bankBranchAddress + ", bankBranchCode=" + bankBranchCode + ", bankSwiftCode=" + bankSwiftCode + ", remark=" + remark + ", obseleteDate=" + obseleteDate + '}';
    }
 
    public String toString2() {
        return "WorkerBankAcct{" + "workerFinNum=" + workerFinNum + ", bankAcctName=" + bankAcctName + ", bankAcctNumber=" + bankAcctNumber + ", bankName=" + bankName + ", bankBranchName=" + bankBranchName + ", bankBranchAddress=" + bankBranchAddress + ", bankBranchCode=" + bankBranchCode + ", bankSwiftCode=" + bankSwiftCode + ", remark=" + remark + ", obseleteDate=" + obseleteDate + '}';
    }    
    
}
