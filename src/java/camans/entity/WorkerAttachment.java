/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

/**
 *
 * @author soemyatmyat
 */
public class WorkerAttachment {
    
    //attributes
    private String workerFinNum;
    private int id;
    private String documentName;
    private String filePath;
    private String submitBy;

    public WorkerAttachment(String workerFinNum, int id, String documentName, String filePath, String submitBy) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.documentName = documentName;
        this.filePath = filePath;
        this.submitBy = submitBy;
    }

    public WorkerAttachment(String workerFinNum, String documentName, String filePath, String submitBy) {
        this.workerFinNum = workerFinNum;
        this.documentName = documentName;
        this.filePath = filePath;
        this.submitBy = submitBy;
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

    public String getDocumentName() {
        return documentName;
    }

    public void setDocumentName(String documentName) {
        this.documentName = documentName;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getSubmitBy() {
        return submitBy;
    }

    public void setSubmitBy(String submitBy) {
        this.submitBy = submitBy;
    }

    @Override
    public String toString() {
        return "WorkerAttachment{" + "workerFinNum=" + workerFinNum + ", id=" + id + 
                ", documentName=" + documentName + ", filePath=" + filePath + 
                ", submitBy=" + submitBy + '}';
    }
    
    public String toString2() {
        return "Attachment [documentName=" + documentName + ']';
    }
    
}
